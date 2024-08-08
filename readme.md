# TOOLBOX

> personal tools for writing code and do sysadmin and devops stuff :)

![](./demo.gif)

## GOALS

The main objective is to have a simple, quick and efficient mini dev-environment that can run on a pletora of different systems without reling on some complex dependencies

## INSTALLATION

clone repository and run installation script

```bash
git clone https://github.com/carnivuth/toolbox
cd toolbox
./toolbox
```

to uninstall run:

```bash
cd toolbox
./toolbox uninstall
```

## FEATURES

The toolbox consists on a minimal vim configuration and some usefull bash scripts

- `project.sh` to open project in a predefined tmux session (tmuxify style)
- `notify.sh` notify trough ntfy long running processes
- `store.sh` install packages quick and easy

vim comes preconfigured with some personal bindings and fzf integrations, basic ftplugin for some devops tools and languages (terraform, python, bash, yaml and others), vim-ale is also preinstalled and configured for some basic linting with other languages

Existing vim configuration are backupped and restored after uninstallation,
