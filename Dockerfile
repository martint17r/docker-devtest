FROM ubuntu:zesty

RUN apt-get update && apt-get install -y software-properties-common && add-apt-repository ppa:gophers/archive && add-apt-repository ppa:jonathonf/vim && apt-get update && apt-get install -y golang-1.9-go vim-nox yadm openssh-client git sudo && rm -rf /var/lib/apt/lists/*
RUN adduser --disabled-password --gecos '' martin && usermod -aG sudo martin && echo 'martin ALL=NOPASSWD: ALL' >> /etc/sudoers
RUN mkdir /src
RUN echo 'export PATH=$PATH:/usr/lib/go-1.9/bin:~/go/bin' >> /home/martin/.bashrc
USER martin
WORKDIR /home/martin
RUN mkdir -p /home/martin/.vim/tmp
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ADD .vimrc /home/martin/
RUN echo -ne '\n' | vim +PluginInstall '+PluginClean!' +qall

