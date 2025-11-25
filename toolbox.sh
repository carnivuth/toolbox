#!/bin/bash
# dependencies for full environment with neovim setup
DEPS="rust mermaid-cli yq tealdeer ranger man wikiman sudo python unzip go curl tar lazygit starship openssh gcc npm neovim vim tmux fzf ripgrep ttf-jetbrains-mono-nerd stow gawk git"

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
  $SUDO pacman -S "$@" --noconfirm
}

uninstall_deps(){
  if [[ "$(whoami)" != "root" ]]; then SUDO=sudo;fi
  $SUDO pacman -Rns "$@" --noconfirm
}

# USER FUNCTIONS
function install_toolbox(){

  # create directories for stow, if they don't exist
  mkdir -p "$HOME/.config/tmux"
  mkdir -p "$HOME/.config/toolbox"
  mkdir -p "$HOME/.config/nvim"
  mkdir -p "$HOME/.local/bin"
  mkdir -p "$HOME/.local/lib"

  # stow configs
  stow --target="$HOME/.local/bin" bin
  stow --target="$HOME/.local/lib" lib
  stow --target="$HOME/.config" etc

  # clone tpm repo
  if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    git clone "https://github.com/tmux-plugins/tpm" "$HOME/.config/tmux/plugins/tpm"
  fi

  # sourcing shell integration
  echo "adding toolbox bash integration"
  if [[ "$(grep 'source $HOME/.config/toolbox/bash_integration.sh' "$HOME/.bashrc" )" == "" ]]; then
    echo 'source $HOME/.config/toolbox/bash_integration.sh' >> "$HOME/.bashrc"
  fi

  echo "installing vim plugins"
  vim +PlugInstall +qall

  echo "installing nvim plugins"
  nvim "+Lazy install" "+qall"

}

function uninstall_toolbox(){
  echo "removing config with stow"
  rm -rf "$HOME/.vim/plugged"
  rm -rf "$HOME/.config/tmux/plugins"
  rm -rf "$HOME/.local/share/nvim"
  if [[ -d "$HOME/.config" ]];then stow --target="$HOME/.config" -D etc; fi
  if [[ -d "$HOME/.local/bin" ]];then stow --target="$HOME/.local/bin" -D bin; fi
  if [[ -d "$HOME/.local/lib" ]];then stow --target="$HOME/.local/lib" -D lib; fi

  echo "removing lines from bashrc"
  if [[ -f "$HOME/.bashrc" ]];then sed '/source \$HOME\/\.config\/toolbox\/bash_integration.*/d' -i "$HOME/.bashrc"; fi
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
    install_deps $DEPS && install_toolbox full
    configure_hook
    ;;
esac
