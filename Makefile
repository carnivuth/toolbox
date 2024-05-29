prefix = ~
name = .vim

all: install

install: 
	ln -s $(shell pwd) $(prefix)/$(name)


uninstall:
	rm -f $(prefix)/$(name)

.PHONY: all install uninstall
