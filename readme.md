# TOOLBOX

<p align="center">
    <img   style="border-radius: 5%;" src="https://cdn.dribbble.com/users/795597/screenshots/3623896/media/a4211dcb3612530d8d91db5aede9520e.gif" width="300" />
</p>

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
to uninstall run the `make uninstall` command

## HOW IT WORKS

The toolbox consists on a minimal vim configuration and some usefull bash scripts. Deps for minimal functions are listed in the `./configure` script, other programs can be installed for additional functionalities:

- `wl-clipboard` for clipboard copypaste shortcuts (*remote servers not supported*)
- `vim-ale` for lsp features and code analisys
- `vim-ansible` for playbooks and role linting
- `pyright` for python stuff
- `gopls` for go programs

the `.configure` script install minimal dependencies and configure fzf vim plugin in debian and derivatives distros.
the makefile backups existing vim configurations for the current user and links in `$HOME/.vim` the `vim` directory
