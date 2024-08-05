# TOOLBOX

> personal tools for writing code and do sysadmin and devops stuff :)

![](./demo.gif)

## GOALS

The main objective is to have a simple, quick and efficient mini dev-environment that can run on a pletora of different systems without reling on some complex dependencies

## INSTALLATION

clone repository and run configure and make

```bash
git clone https://github.com/carnivuth/toolbox
cd toolbox
# from root
./config
make
```
to uninstall run the `make uninstall` command, to uninstall dependencies run `./configure uninstall`

## HOW IT WORKS

The toolbox consists on a minimal vim configuration and some usefull bash scripts. Deps for minimal functions are listed in the `./configure` script, other programs can be installed for additional functionalities:

- `wl-clipboard` for clipboard copypaste shortcuts (*remote servers not supported*)
- `vim-ale` for lsp features and code analisys
- `vim-ansible` for playbooks and role linting
- `pyright` for python stuff
- `gopls` for go programs

the `.configure` script install minimal dependencies and configure fzf vim plugin in debian and derivatives distros.
the makefile backups existing vim configurations for the current user and links in `$HOME/.vim` the `vim` directory
