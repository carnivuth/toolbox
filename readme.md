# Toolbox

> personal tools for writing code and do sysadmin and devops stuff :)

![](./demo.gif)

## Goals

The main objective is to have a simple, quick and efficient mini dev-environment that can run on a pletora of different systems without reling on some complex dependencies

## Features

The toolbox consists on a minimal vim configuration and some useful bash scripts

- `toolmux.sh` open project directory in a tmux session where panes and windows are created based on a config file `.tmux.conf` placed in the project directory (tmuxify style)
- `notify.sh` execute command and send notification trough [ntfy](https://ntfy.sh/), useful for long running processes
- `store.sh` tui for installing packages in arch and debian based distros using [fzf](https://github.com/junegunn/fzf)

Vim and neovim are configured with some default integration like fzf and lazygit for file management and git operations, basic `ftplugin` for some devops tools and languages (`terraform`, `python`, `bash`, `yaml` and others),

### Configure `tmm` alias

To avoid `tmm` alias default `$EDITOR` window create a configuration file in the `$HOME` directory

```bash
touch $HOME/.tmux.conf
```

## Installation

Toolbox support 2 installation procedures native (recommended) and as a docker container

### Native installation

toolbox can be installed in a fully setup configuration with neovim or in a minimal setup with vim (bot of them with some similar functionalities),
the installation scripts detect the full setup configuration based on the following parameters in order

- distribution (*arch -> full / debian & termux ->minimal*)
- remote ssh environment (*always minimal*)
- if installation is performed as root user (*always minimal*)

```bash
git clone https://github.com/carnivuth/toolbox
cd toolbox
./toolbox.sh
```

to uninstall run:

```bash
cd toolbox
./toolbox.sh uninstall
```

### Termux installation

In order to install toolbox on termux environment run the following

```bash
pkg update &&\
pkg upgrade &&\
pkg install git &&\
git clone  https://github.com/carnivuth/toolbox &&\
cd toolbox &&\
./toolbox.sh
```

### Docker environment

toolbox can be installed also with docker

```bash
docker run  --pull=always --rm -u $UID:$UID -v "$(pwd)"/:/home/toolbox/"$(basename "$(pwd)")" --name toolbox -it carnivuth/toolbox bash
```

This command will download the docker image and run the container with the current working directory mounted

### Install only `vimrc`

it's possible to install only the vimrc file for minimal configs and quick editing on remote machines, curl the lates release and put it in the `.vimrc` file

```bash
VERSION=1.0.1
cp $HOME/.vimrc $HOME/.vimrc.bak; curl -Ls https://github.com/carnivuth/toolbox/releases/download/vimrc-v$VERSION/vimrc > $HOME/.vimrc
```

To install on remote environment as application probes with ansible:

```yaml
---
- name: Install toolbox vimrc
  hosts: all
  vars:
    # change this for different versions
    version: 1.0.1
  tasks:
    - name: Ensure vim is installed
      become: true
      ansible.builtin.apt:
        - name: vim
        - state: present

    - name: Download vimrcfile
      ansible.builtin.get_url:
        url: https://github.com/carnivuth/toolbox/releases/download/vimrc-v{{ version }}/vimrc
        dest: ~/.vimrc
        # avoid deleting already present vimrc files
        backup: true
```
