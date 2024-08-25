#!/bin/bash
source /etc/os-release
VIMRC="$HOME/.vimrc"
VIM_FOLDER="$HOME/.vim"
BACKUP_SUFFIX="ct.old"

# dependencies that can be removed after uninstall
OPT_DEPS="npm neovim tmux fzf ripgrep"

# vital dependencies
DEPS="stow gawk vim git $OPT_DEPS"

# ROOT FUNCTIONS
install_deps(){
  [[ "$(whoami)" != "root" ]] && echo "run $0 as root" && exit 1
  case $ID in
    "arch")
      pacman -S $DEPS --noconfirm
      ;;
    "debian"|"ubuntu")
      apt install $DEPS -y
      ;;
  esac
}

uninstall_deps(){
  [[ "$(whoami)" != "root" ]] && echo "run $0 as root" && exit 1
  case $ID in
    "arch")
      pacman -Rns $OPT_DEPS --noconfirm
      ;;
    "debian"|"ubuntu")
      apt remove $OPT_DEPS -y
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
  mkdir -p "$VIM_FOLDER"
  # stow binaries and configurations
  stow --target="$HOME/.config/tmux" tmux
  stow --target="$HOME/.config/toolbox" toolbox
  stow --target="$HOME/.config/nvim" nvim
  stow --target="$HOME/.local/bin" bin
  # backup .vimrc than if stow fails backup .vim folder and try again
  if [[ -f "$VIMRC" ]]; then
    echo "backup vimrc file"
    mv "$VIMRC" "$VIMRC.$BACKUP_SUFFIX"
  fi
  if ! stow --target="$VIM_FOLDER" vim; then
    if [[ -d "$VIM_FOLDER" ]]; then
      echo "backup .vim directory"
      mv "$VIM_FOLDER" "$VIM_FOLDER.$BACKUP_SUFFIX"
    fi
    stow --target="$VIM_FOLDER" vim
  fi

  # editing PATH variable and sourcing shell integration
  if [[ "$(grep 'source $HOME/.config/toolbox/bash_integration.sh' "$HOME/.bashrc" )" == "" ]]; then
    echo "adding toolbox bash integration"
    echo 'source $HOME/.config/toolbox/bash_integration.sh' >> "$HOME/.bashrc"
  fi
  vim +PlugInstall +qall
  # clone tpm repo
  git clone "https://github.com/tmux-plugins/tpm" "~/.config/tmux/plugins/tpm"
}

function uninstall_toolbox(){
  echo "removing config with stow"
  rm -rf "$HOME/.vim/plugged"
  rm -rf "$HOME/.config/tmux/plugins"
  rm -rf "$HOME/.local/share/nvim"
  stow --target="$VIM_FOLDER" -D vim
  stow --target="$HOME/.config/tmux" -D tmux
  stow --target="$HOME/.config/toolbox" -D toolbox
  stow --target="$HOME/.config/nvim" -D nvim
  stow --target="$HOME/.local/bin" -D bin
  if [[ -f "$VIMRC.$BACKUP_SUFFIX" ]]; then
    echo "restoring old vimrc"
    mv "$VIMRC.$BACKUP_SUFFIX" "$VIMRC"
  fi
  if [[ -d "$VIM_FOLDER.$BACKUP_SUFFIX" ]]; then
    echo "restoring old .vim";
    mv "$VIM_FOLDER.$BACKUP_SUFFIX" "$VIM_FOLDER";
  fi
  echo "removing lines from bashrc"
  sed '/source \$HOME\/\.config\/toolbox\/bash_integration.sh/d' -i "$HOME/.bashrc"
}


COMMAND="$1"
case "$COMMAND" in
  "install_toolbox")
    install_toolbox
    ;;
  "uninstall_toolbox")
    uninstall_toolbox
    ;;
  "install_deps")
    install_deps
    ;;
  "uninstall_deps")
    uninstall_deps
    ;;
  "help"|"--help")
    echo "usage $0 [install_toolbox|uninstall_toolbox||install_deps|uninstall_deps]"
    echo "to install from scratch run:"
    echo "$0"
    ;;
  'uninstall')
    # if not running as root call deps nstallation with sudo
    if [[ "$(whoami)" != "root" ]]; then
      echo "installing deps and toolbox"
      sudo "$0" uninstall_deps && uninstall_toolbox
    else
      "$0" uninstall_deps && uninstall_toolbox
    fi
    ;;
  *)
    # if not running as root call deps installation with sudo
    if [[ "$(whoami)" != "root" ]]; then
      echo "installing deps and toolbox"
      sudo "$0" install_deps && install_toolbox
    else
      "$0" install_deps && install_toolbox
    fi
    ;;
esac
