#!/bin/bash
source /etc/os-release
VIMRC="$HOME/.vimrc"
VIM_FOLDER="$HOME/.vim"
BACKUP_SUFFIX="ct.old"

# dependencies for full environment with neovim setup
FULL_ENV_DEPS="go git stow npm neovim tmux fzf ripgrep starship"

# dependencies for minimal environment with vim setup
MINIMAL_ENV_DEPS="git stow tmux fzf vim"

function minimal_env(){
  # always full env in archlinux
  if [[ "$ID" == "arch" ]]; then return 1; fi
  if [[ "$(whoami)" == "root" ]]; then return 0; fi
  if command -v termux-setup-storage; then return 0; fi
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    return 0
    # many other tests omitted
  else
    case $(ps -o comm= -p "$PPID") in
      sshd|*/sshd) return 0;;
    esac
  fi
  return 1
}

# ROOT FUNCTIONS
install_deps(){
  if [[ "$(whoami)" != "root" ]]; then SUDO=sudo;fi
  case $ID in
    "arch")
      $SUDO pacman -S "$@" --noconfirm
      ;;
    "debian"|"ubuntu")
      $SUDO apt-get install "$@" -y
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
  # stow binaries and configurations
  stow --target="$HOME/.config/tmux" tmux
  stow --target="$HOME/.config/toolbox" toolbox
  stow --target="$HOME/.config/nvim" nvim
  stow --target="$HOME/.config" starship
  stow --target="$HOME/.local/bin" bin
  stow --target="$HOME/.local/lib" lib
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

  # clone tpm repo
  if [[ ! -d "$HOME/.config/tmux/plugins/tpm" ]]; then
    git clone "https://github.com/tmux-plugins/tpm" "$HOME/.config/tmux/plugins/tpm"
  fi

  # sourcing shell integration
  echo "adding toolbox bash integration"
  if [[ "$1" == "minimal" ]]; then
    if [[ "$(grep 'source $HOME/.config/toolbox/bash_integration_minimal.sh' "$HOME/.bashrc" )" == "" ]]; then
      echo 'source $HOME/.config/toolbox/bash_integration_minimal.sh' >> "$HOME/.bashrc"
    fi
  elif [[ "$1" == "full" ]]; then
    if [[ "$(grep 'source $HOME/.config/toolbox/bash_integration_full.sh' "$HOME/.bashrc" )" == "" ]]; then
      echo 'source $HOME/.config/toolbox/bash_integration_full.sh' >> "$HOME/.bashrc"
    fi
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
  sed '/source \$HOME\/\.config\/toolbox\/bash_integration.*/d' -i "$HOME/.bashrc"
}


COMMAND="$1"
case "$COMMAND" in
  "help"|"--help")
    echo "usage $0 [install_toolbox|uninstall_toolbox]"
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
    ;;
esac
