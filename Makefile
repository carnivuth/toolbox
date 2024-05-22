all: install

BASEDIR=~

current_dir := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))
alias := $(shell cat ~/.bashrc | grep vml)

install:
		echo "alias vml='vim -u $(current_dir)/.vim/vimrc'">> ~/.bashrc

clean:
	sed '/vml=.*/d' ~/.bashrc
