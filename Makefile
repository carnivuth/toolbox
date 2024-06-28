prefix = ~
name = .vim

all: install

# check if conf is already installed and remove old link
clean:
	@if [[ -L $(prefix)/$(name) && -d $(prefix)/$(name) && '$(shell readlink -- $(prefix)/$(name))' == $(shell pwd) ]]; then\
		rm -f $(prefix)/$(name);\
	fi

# check for already configuration and backup them before installation
install: clean
	@if [[ -e $(prefix)/.vimrc ]]; then\
		mv $(prefix)/.vimrc $(prefix)/.vimrc.old;\
	fi
	@if [[ -e $(prefix)/$(name) ]]; then\
		mv $(prefix)/$(name) $(prefix)/$(name).old;\
	fi
	ln -fs $(shell pwd) $(prefix)/$(name)

# remove all configuration
uninstall: clean
	@if [[ -e $(prefix)/.vimrc.old ]]; then\
		mv $(prefix)/.vimrc.old $(prefix)/.vimrc;\
	fi
	@if [[ -e $(prefix)/$(name).old ]]; then\
		mv $(prefix)/$(name).old $(prefix)/$(name);\
	fi

.PHONY: all install uninstall
