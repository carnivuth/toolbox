#!/bin/bash
source /etc/os-release

install_packages(){
  case $ID in
          "arch")
                  pacman -Slq | fzf  --preview "pacman -Si {1}"  | xargs -ro sudo pacman -S
                  ;;
          "debian"|"ubuntu")
                  apt-cache -n search '.*' | awk -F ' - ' '{print $1}' | fzf  --preview "apt-cache show  {1}"  | xargs -ro sudo apt-get install 
                  ;;
  esac
}
remove_packages(){
  case $ID in
          "arch")
                  pacman -Qq | fzf  --preview "pacman -Qi {1}"  | xargs -ro sudo pacman -Rns
                  ;;
          "debian"|"ubuntu")
                  dpkg -l | grep '^ii' | awk -F ' ' '{print $2}' | fzf  --preview "apt-cache show  {1}"  | xargs -ro sudo apt-get remove
                  ;;
  esac
}

FZF_DEFAULT_OPTS='--cycle --bind "ctrl-j:down,ctrl-k:up,alt-j:preview-down,alt-k:preview-up,tab:toggle-up,btab:toggle-down"'
case "$1" in
  install)
      install_packages
      ;;
  remove)
      remove_packages
      ;;
  *)
      echo "usage: $0 [install/remove]"
esac
unset FZF_DEFAULT_OPTS
