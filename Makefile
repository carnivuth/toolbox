prefix = ~
name = .vim
deps="vim git tmux fzf"
distro=$(shell grep 'ID=' /etc/os-release| awk -F '=' '{print $2}')

SHELL= /bin/bash
all: install

clean:
	# check if conf is already installed and remove old link to vim configurations
	@if [[ -L $(prefix)/$(name) && -d $(prefix)/$(name) && '$(shell readlink -- $(prefix)/$(name))' == $(shell pwd) ]]; then\
		rm -f $(prefix)/$(name);\
	fi

install: clean
	# check for exsisting vim configurations and backup them before installation
	@if [[ -e $(prefix)/.vimrc ]]; then\
		mv $(prefix)/.vimrc $(prefix)/.vimrc.old;\
	fi
	@if [[ -e $(prefix)/$(name) ]]; then\
		mv $(prefix)/$(name) $(prefix)/$(name).old;\
	fi
	# add alias for project.sh script if not present
	@if [[ "$(shell grep 'alias j=' ~/.bashrc )" == "" ]]; then\
		echo "alias j=project.sh" >> ~/.bashrc;\
	fi
	
	# add bin to PATH variable if not present
	@if [[ "$(shell grep 'vim_cfg' ~/.bashrc )" == "" ]]; then\
		echo 'export PATH=$$PATH:$(shell pwd)/bin' >> ~/.bashrc;\
	fi
	
	# install vim configs
	ln -fs $(shell pwd) $(prefix)/$(name)
	@echo "install $(deps)"

uninstall: clean
	# restore old vim configs if present
	@if [[ -e $(prefix)/.vimrc.old ]]; then\
		mv $(prefix)/.vimrc.old $(prefix)/.vimrc;\
	fi
	@if [[ -e $(prefix)/$(name).old ]]; then\
		mv $(prefix)/$(name).old $(prefix)/$(name);\
	fi
	
	# remove project.sh alias
	sed -i 's/alias j=.*//g' ~/.bashrc
	# remove PATH exports
	sed -i 's/.*vim_cfg.*//g' ~/.bashrc


.PHONY: all install uninstall clean
