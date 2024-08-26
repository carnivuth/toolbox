#!/bin/bash
source /etc/os-release

if [[ "$(whoami)" != 'root' ]];then
  SUDO="sudo"
fi
install_packages(){
  case $ID in
    "arch")
      # check for aur flag and use yay to run command
      if [[ "$AUR" == "TRUE" ]] && [[ -x "$( which yay )" ]]; then
        yay -Slq | fzf  --preview "yay -Si {1}"  | xargs -ro yay -S
      else
        pacman -Slq | fzf  --preview "pacman -Si {1}"  | xargs -ro $SUDO pacman -S
      fi
      ;;
    "debian"|"ubuntu")
      # acky way to do the same as arch but with apt
      apt-cache -n search '.*' | awk -F ' - ' '{print $1}' | fzf  --preview "apt-cache show  {1}"  | xargs -ro $SUDO apt-get install
      ;;
  esac
}

remove_packages(){
  case $ID in
    "arch")
      # check for aur flag and use yay to run command
      if [[ "$AUR" == "TRUE" ]] && [[ -x "$( which yay )" ]]; then
        yay -Qq | fzf  --preview "yay -Qi {1}"  | xargs -ro yay -Rns
      else
        pacman -Qq | fzf  --preview "pacman -Qi {1}"  | xargs -ro $SUDO pacman -Rns
      fi
      ;;
    "debian"|"ubuntu")
      dpkg -l | grep '^ii' | awk -F ' ' '{print $2}' | fzf  --preview "apt-cache show  {1}"  | xargs -ro $SUDO apt-get remove
      ;;
  esac
}

COMMAND="$1"
shift

# get option parameters
while getopts u flag; do
  case "${flag}" in
    u) AUR="TRUE" ;;
    *) echo "${flag} is not supported"; exit 1 ;;
  esac
done

case "$COMMAND" in
  install)
    install_packages
    ;;
  remove)
    remove_packages
    ;;
  *)
    echo "usage: $0 [install/remove]"
esac
