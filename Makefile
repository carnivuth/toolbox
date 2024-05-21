all: install

BASEDIR=~

install:
	rm -rf $(BASEDIR)/.vim
	ln -sf . $(BASEDIR)/.vim

clean:
	rm $(BASEDIR)/.vim
