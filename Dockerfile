FROM archlinux:latest

# env settings for colors
ENV TERM=xterm-256color

# install deps
RUN pacman -Sy sudo python go curl tar lazygit starship openssh gcc npm neovim vim tmux fzf ripgrep ttf-jetbrains-mono-nerd stow gawk git --noconfirm

# user setup for fixuid
RUN groupadd toolbox -g 2000
RUN useradd -m toolbox -u 2000 -g 2000
ENV USER=toolbox
ENV GROUP=toolbox
RUN echo  "$USER ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.6.0/fixuid-0.6.0-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf -
RUN chown root:root /usr/local/bin/fixuid
RUN chmod 4755 /usr/local/bin/fixuid
RUN mkdir -p /etc/fixuid
RUN printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

WORKDIR /home/toolbox/toolbox
COPY . .
RUN chown -R $USER:$GROUP /home/toolbox/toolbox

USER $USER:$GROUP

RUN mkdir -p "/home/toolbox/.config/tmux"
RUN mkdir -p "/home/toolbox/.config/toolbox"
RUN mkdir -p "/home/toolbox/.config/nvim"
RUN mkdir -p "/home/toolbox/.config/vim"
RUN mkdir -p "/home/toolbox/.local/bin"
RUN mkdir -p "/home/toolbox/.local/lib"

RUN stow --target="/home/toolbox/.config/tmux" tmux
RUN stow --target="/home/toolbox/.config/toolbox" toolbox
RUN stow --target="/home/toolbox/.config/nvim" nvim
RUN stow --target="/home/toolbox/.config/vim" vim
RUN stow --target="/home/toolbox/.local/bin" bin
RUN stow --target="/home/toolbox/.local/lib" lib
RUN stow --target="/home/toolbox/.config" starship
RUN git clone "https://github.com/tmux-plugins/tpm" "/home/toolbox/.config/tmux/plugins/tpm"
RUN echo 'eval "$(starship init bash)"' >> "/home/toolbox/.bashrc"
RUN echo 'source /home/toolbox/.config/toolbox/bash_integration_full.sh' >> "/home/toolbox/.bashrc"
WORKDIR /home/toolbox
ENTRYPOINT ["fixuid"]
