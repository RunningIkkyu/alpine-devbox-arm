
FROM alpine

WORKDIR /root

RUN apk update

# Requirements to build neovim 
RUN apk update \
  && apk add --no-cache git build-base cmake automake autoconf libtool pkgconf coreutils curl unzip gettext-tiny-dev 
#RUN git clone https://github.com/neovim/neovim.git
RUN wget https://github.com/neovim/neovim/archive/refs/heads/master.zip && unzip master.zip

RUN curl https://gitee.com/RunningIkkyu/retry/raw/master/retry -o /usr/local/bin/retry && chmod +x /usr/local/bin/retry

RUN cd neovim-master && retry -s 1 -t 10 make CMAKE_BUILD_TYPE=Release

