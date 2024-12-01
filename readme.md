# TOOLBOX

> personal tools for writing code and do sysadmin and devops stuff :)

![](./demo.gif)

## GOALS

The main objective is to have a simple, quick and efficient mini dev-environment that can run on a pletora of different systems without reling on some complex dependencies

## INSTALLATION

Toolbox support 2 installation procedures native (recommended) and as a docker container

### NATIVE INSTALLATION

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

### TERMUX INSTALLATION

In order to install toolbox on termux environment run the following

```bash
pkg update &&\
pkg upgrade &&\
pkg install git &&\
git clone  https://github.com/carnivuth/toolbox &&\
cd toolbox &&\
./toolbox.sh
```

### DOCKER ENVIRONMENT

toolbox can be installed also with docker

```bash
docker run  --pull=always --rm -u $UID:$UID -v "$(pwd)"/:/home/toolbox/"$(basename "$(pwd)")" --name toolbox -it carnivuth/toolbox bash
```

This command will download the docker image and run the container with the current working directory mounted

## FEATURES

The toolbox consists on a minimal vim configuration and some usefull bash scripts

- `toolmux.sh` to open project in a predefined tmux session (tmuxify style)
- `notify.sh` notify trough ntfy long running processes
- `store.sh` install packages quick and easy

vim comes preconfigured with some personal bindings and fzf integrations, basic ftplugin for some devops tools and languages (terraform, python, bash, yaml and others), vim-ale is also preinstalled and configured for some basic linting with other languages

Existing vim configuration are backupped and restored after uninstallation,
