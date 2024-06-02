# PERSONAL VIM CONFIGURATIONS 

These are my personal vim configurations, aimed at python and ansible programming.

## GOALS

- **portability**: these configurations are meant to be used in any possible environment, primarly arch, ubuntu and debian at the leatest versions
- **plugin-less**: avoid to depend on external plugins 

## DEPENDENCIES

for the base functionality, these programs are required

- `vim` main program
- `lazygit` for advanced git interaction
- `fzf` for quick file opening

wayland specific:

- `wl-clipboard` for clipboard copypaste shortcuts

for lsp functionalities:

- `vim-ale` for lsp features and code analisys
- `vim-ansible` for playbooks and role linting
- `pyright` for python stuff
- `gopls` for go programs


## INSTALLATION

- clone repository

```bash
git clone https://github.com/carnivuth/vim_cfg
```

- run make

```
cd vim_cfg
make 
```

the makefile creates a link in `$HOME/.vim` to this directory, the installation can also be performed by creating manually the link:  

```bash
ln -s path/to/repo/ ~/.config/vim
```

or you can also don't install the configuration in the vim default folder and run vim by setting the configuration file

```bash
vim -u path/to/repo/vimrc
```

### DEBIAN

for debian distros fzf main vim function need to be linked manually

```bash
mkdir -p /usr/share/vim/vimfiles/plugin/
ln -s /usr/share/doc/fzf/examples/plugin/fzf.vim /usr/share/vim/vimfiles/plugin/
```
