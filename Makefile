prefix = ~
name = .vim
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
		echo "alias j='project.sh'" >> ~/.bashrc;\
	fi
	# add alias for store.sh script if not present
	@if [[ "$(shell grep 'alias si=' ~/.bashrc )" == "" ]]; then\
		echo "alias si='store.sh install'" >> ~/.bashrc;\
	fi
	@if [[ "$(shell grep 'alias sr=' ~/.bashrc )" == "" ]]; then\
		echo "alias sr='store.sh remove'" >> ~/.bashrc;\
	fi
	# add bin to PATH variable if not present
	@if [[ "$(shell grep 'toolbox' ~/.bashrc )" == "" ]]; then\
		echo 'export PATH=$$PATH:$(shell pwd)/bin' >> ~/.bashrc;\
	fi
	# install vim configs
	ln -fs $(shell pwd)/vim $(prefix)/$(name)

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
	sed -i 's/alias si=.*//g' ~/.bashrc
	sed -i 's/alias sr=.*//g' ~/.bashrc
	# remove PATH exports
	sed -i 's/.*toolbox.*//g' ~/.bashrc

.PHONY: all install uninstall clean update
