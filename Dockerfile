FROM alpine
RUN apk update
RUN apk add --no-cache neovim 
RUN apk add --no-cache go 
RUN apk add --no-cache fzf  
RUN apk add --no-cache git  
RUN apk add --no-cache zsh  
RUN apk add --no-cache unzip  
RUN apk add --no-cache curl  
RUN apk add --no-cache ripgrep  
RUN apk add --no-cache tmux 
RUN apk add --no-cache openssh
RUN apk add --no-cache perl

# Install oh my zsh
RUN wget https://gitee.com/umico/ohmyzsh/raw/master/tools/install.sh -O - | zsh || true 

# Install nvim arm64
COPY ./nvim /usr/bin/nvim

# Downlaod dotfiles
#RUN cd $HOME
RUN mkdir -p $HOME/code/github \
    && cd $HOME/code/github && git clone https://github.com/RunningIkkyu/dotfiles.git 

# Config zsh
RUN cp $HOME/code/github/dotfiles/zsh/.zshrc $HOME/.zshrc

# Install plug.vim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://gitee.com/cyemeng/vim-plug/raw/master/plug.vim'
RUN mkdir -p $HOME/.config/nvim && cp $HOME/code/github/dotfiles/nvim_0.5_vim_plug/init.vim  $HOME/.config/nvim/init.vim
#RUN nvim -E -s -u "~/.config/nvim/init.vim" +PlugInstall +qall
RUN nvim --headless +PlugInstall +qall

WORKDIR /root

