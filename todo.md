# TODO

## DEPLOYMENT REFACTOR

Rewark deployment in order to implement 3 principal deployment scenarios

- local installation with complete dev env using local environment configuration
- remote minimal setup (using vim instead of neovim) for simple configs and capable of operate in debian environments (original idea)
- docker container deployment, for quick and easy neovim configuration without reling in remote environment packets or installation

installation for the first 2 cases should uninstall precedent configs, to improve update procedures

the installation in remote environment should preserve and restore the existing vim configurations, usefull when logging as root

## GENERAL IMPROVEMENTS

- improvements of the TERM variable management for correct color rendering in some scenarios (ssh to debian machines with weird TERM settings)

- improvements to the project.sh script in order to detect if env is configured with vim or nvim and spawn the correct window, use tmux commands to detect if session exists and remove the needs of using which command

- add telescope functionality to cut paste inside file (eg `: r! cat /path/to/file`)

## TB_HAWKEYE


