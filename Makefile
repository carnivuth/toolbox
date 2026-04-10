.DEFAULT_GOAL := install
.PHONY: $(addprefix dep-, $(DEPS)) deps links tpm plugins hooks install clean $(HOME)/.bashrc

DEPS = parallel direnv rust mermaid-cli go-yq tealdeer ranger man wikiman sudo python unzip go curl tar lazygit starship openssh gcc npm neovim vim tmux fzf ripgrep ttf-jetbrains-mono-nerd stow gawk git tree-sitter-cli

define link_file
	mkdir -p "$@"
	stow --target="$@" $<
endef

.git/hooks/post-merge:
	echo -e '#!/bin/bash\nmake install' > $@
	chmod +x "$@"

$(HOME)/.local/bin: bin
	$(link_file)

$(HOME)/.local/lib: lib
	$(link_file)

$(HOME)/.config: etc
	$(link_file)

$(HOME)/.bashrc:
	touch $@
	grep -qxF 'source $$HOME/.config/toolbox/bash_integration.sh' $@ || echo '$$HOME/.config/toolbox/bash_integration.sh' >> $@

$(HOME)/.config/tmux/plugins/tpm:
	git clone "https://github.com/tmux-plugins/tpm" $@


deps: $(addprefix dep-, $(DEPS))

dep-%:
	pacman -Q $* > /dev/null 2>&1 || sudo pacman -S $* --noconfirm

links: $(HOME)/.local/bin $(HOME)/.local/lib $(HOME)/.config

tpm: $(HOME)/.config/tmux/plugins/tpm

plugins:
	vim +PlugInstall +qall
	nvim "+Lazy install" "+qall"

hooks: .git/hooks/post-merge

install: deps links tpm plugins $(HOME)/.bashrc hooks

clean:
	rm -rf "$(HOME)/.vim/plugged"
	rm -rf "$(HOME)/.config/tmux/plugins"
	rm -rf "$(HOME)/.local/share/nvim"
	test -d "$(HOME)/.config" && stow --target="$(HOME)/.config" -D etc
	test -d "$(HOME)/.local/bin" stow --target="$(HOME)/.local/bin" -D bin
	test -d "$(HOME)/.local/lib" stow --target="$(HOME)/.local/lib" -D lib
	sed '/source \$HOME\/\.config\/toolbox\/bash_integration.*/d' -i "$(HOME)/.bashrc"

