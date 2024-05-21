# PERSONAL VIM CONFIGURATIONS 

These are my personal vim configurations, aimed at python and ansible programming.

## GOALS

- portability: these configurations are meant to be used in any possible environment, primarly arch, ubuntu and debian at the leatest versions
- plugin-less: avoid to depend on external plugins 

## DEPENDENCIES

for the base functionality, these programs are required

- `vim` main program
- `lazygit` for advanced git interaction
- `fzf` for quick file opening

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

- install configuration in the user directory or run vim with vimrc as configuration file

```bash
ln -s path/to/repo/ ~/.config/vim
```

### DEBIAN

for debian distros fzf main vim function need to be linked manually

```bash
mkdir -p /usr/share/vim/vimfiles/plugin/
ln -s /usr/share/doc/fzf/examples/plugin/fzf.vim /usr/share/vim/vimfiles/plugin/
```
