#!/bin/bash
if [[ -f /etc/os-release ]]; then source /etc/os-release; fi
VIMRC="$HOME/.vimrc"
VIM_FOLDER="$HOME/.vim"
BACKUP_SUFFIX="ct.old"

# dependencies for full environment with neovim setup
FULL_ENV_DEPS="yq tealdeer ranger man wikiman sudo python unzip go curl tar lazygit starship openssh gcc npm neovim vim tmux fzf ripgrep ttf-jetbrains-mono-nerd stow gawk git"

# dependencies for minimal environment with vim setup
MINIMAL_ENV_DEPS="man ranger yq ripgrep git stow tmux fzf vim curl tar"

function minimal_env(){
  # always full env in archlinux
  if [[ "$ID" == "arch" ]]; then return 1; fi

  # check if user is root, in this case minimal setup
  if [[ "$(whoami)" == "root" ]]; then return 0; fi

  # check if installation runs in termux
  if command -v termux-setup-storage; then return 0; fi

  # check if is a tty spawned from the ssh daemon
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    return 0
    # many other tests omitted
  else
    case $(ps -o comm= -p "$PPID") in
      sshd|*/sshd) return 0;;
    esac
  fi

  # in other cases install full env
  return 1
}

function configure_hook(){
  # create default monitor configuration file if does not exists
  if [[ ! -e ".git/hooks/post-merge" ]]; then
    echo 'create post-merge hook'
    echo  -e "#!/bin/bash\n./toolbox.sh" > ".git/hooks/post-merge"
  fi
  chmod +x ".git/hooks/post-merge"
}


# wrapper around different package managers
install_deps(){
  if [[ "$(whoami)" != "root" ]]; then SUDO=sudo;fi
  case $ID in
    "arch")
      $SUDO pacman -S "$@" --noconfirm
      ;;
    "debian"|"ubuntu")
      $SUDO apt-get install "$@" -y
      ;;
    "")
      pkg install "$@" -y
      ;;
  esac
}

uninstall_deps(){
  if [[ "$(whoami)" != "root" ]]; then SUDO=sudo;fi
  case $ID in
    "arch")
      $SUDO pacman -Rns "$@" --noconfirm
      ;;
    "debian"|"ubuntu")
      $SUDO apt-get remove "$@" -y
      ;;
    "")
      pkg remove --purge "$@" -y
      ;;
  esac
}

# USER FUNCTIONS
function install_toolbox(){

  # create directories for stow, if they don't exist
  mkdir -p "$HOME/.config/tmux"
  mkdir -p "$HOME/.config/toolbox"
  mkdir -p "$HOME/.config/nvim"
  mkdir -p "$HOME/.local/bin"
  mkdir -p "$HOME/.local/lib"
  mkdir -p "$VIM_FOLDER"

  # backup .vimrc than if stow fails backup .vim folder and try again
  if [[ -f "$VIMRC" ]]; then
    echo "backup vimrc file"
    mv "$VIMRC" "$VIMRC.$BACKUP_SUFFIX"
  fi
  if [[ -d "$VIM_FOLDER" ]]; then
    echo "backup .vim directory"
    mv "$VIM_FOLDER" "$VIM_FOLDER.$BACKUP_SUFFIX"
  fi

  # stow configs
  stow --target="$HOME/.local/bin" bin
  stow --target="$HOME/.local/lib" lib
  stow --target="$HOME/.config" etc

  # create debian link for compatibility with older vim version
  if [[ "$1" == "minimal" ]]; then
    ln -s "$HOME/.config/vim" "$HOME/.vim"
  fi


  # clone tpm repo
  if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    git clone "https://github.com/tmux-plugins/tpm" "$HOME/.config/tmux/plugins/tpm"
  fi

  # install lazygit from github if config is minimal and no distro package can be downloaded
  if [[ "$1" == "minimal" ]]; then
    curl  -L "https://github.com/jesseduffield/lazygit/releases/download/v0.44.1/lazygit_0.44.1_Linux_x86_64.tar.gz" | tar -C "$HOME/.local/bin" -zxvf -
  fi

  # sourcing shell integration
  echo "adding toolbox bash integration"
  if [[ "$(grep 'source $HOME/.config/toolbox/bash_integration.sh' "$HOME/.bashrc" )" == "" ]]; then
    echo 'source $HOME/.config/toolbox/bash_integration.sh' >> "$HOME/.bashrc"
  fi
  echo "installing vim plugins"
  vim +PlugInstall +qall
  if [[ "$1" == "full" ]]; then
    echo "installing nvim plugins"
    nvim "+Lazy install" "+qall"
  fi

}

function uninstall_toolbox(){
  echo "removing config with stow"
  rm -rf "$HOME/.vim/plugged"
  rm -rf "$HOME/.config/tmux/plugins"
  rm -rf "$HOME/.local/share/nvim"
  if [[ -d "$VIM_FOLDER" ]];then stow --target="$VIM_FOLDER" -D vim; fi
  if [[ -d "$HOME/.config/tmux" ]];then stow --target="$HOME/.config/tmux" -D tmux; fi
  if [[ -d "$HOME/.config/toolbox" ]];then stow --target="$HOME/.config/toolbox" -D toolbox; fi
  if [[ -d "$HOME/.config/nvim" ]];then stow --target="$HOME/.config/nvim" -D nvim; fi
  if [[ -d "$HOME/.config" ]];then stow --target="$HOME/.config" -D starship; fi
  if [[ -d "$HOME/.local/bin" ]];then stow --target="$HOME/.local/bin" -D bin; fi
  if [[ -d "$HOME/.local/lib" ]];then stow --target="$HOME/.local/lib" -D lib; fi

  if [[ -f "$VIMRC.$BACKUP_SUFFIX" ]]; then
    echo "restoring old vimrc"
    mv "$VIMRC.$BACKUP_SUFFIX" "$VIMRC"
  fi
  if [[ -d "$VIM_FOLDER.$BACKUP_SUFFIX" ]]; then
    echo "restoring old .vim";
    mv "$VIM_FOLDER.$BACKUP_SUFFIX" "$VIM_FOLDER";
  fi
  echo "removing lines from bashrc"
  if [[ ! -f "$HOME/.bashrc" ]];then touch $HOME/.bashrc; fi
  sed '/source \$HOME\/\.config\/toolbox\/bash_integration.*/d' -i "$HOME/.bashrc"
}


COMMAND="$1"
case "$COMMAND" in
  "help"|"--help")
    echo "usage $0 [install|uninstall]"
    echo "to install from scratch run:"
    echo "$0"
    ;;
  'uninstall')
    uninstall_toolbox
    ;;
  *)
    if minimal_env; then
      install_deps $MINIMAL_ENV_DEPS && uninstall_toolbox && install_toolbox minimal

    else
      install_deps $FULL_ENV_DEPS && uninstall_toolbox && install_toolbox full
    fi
    configure_hook
    ;;
esac
