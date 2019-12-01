FROM phusion/baseimage:master-amd64

MAINTAINER Redhung <redhung@hung.red>

WORKDIR /root/

RUN dpkg --add-architecture i386 

RUN apt update
    
RUN apt install -y libc6:i386 libc6-dbg:i386 libc6-dbg lib32stdc++6 g++-multilib cmake ipython vim net-tools iputils-ping libffi-dev libssl-dev python-dev python3-dev python3-pip python3 build-essential ruby ruby-dev tmux strace ltrace nasm wget radare2 netcat socat git gdb zsh

RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

RUN chsh -s /bin/zsh

RUN cd /root && wget https://raw.githubusercontent.com/r3dhun9/PerfectZshrc/master/.zshrc && wget https://raw.githubusercontent.com/r3dhun9/PerfectTmuxConf/master/.tmux.conf && wget https://raw.githubusercontent.com/r3dhun9/PerfectVimrc/master/.vimrc

RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall

RUN cd ~/.vim/bundle/YouCompleteMe && python3 install.py

RUN python3 -m pip install --upgrade pip && python3 -m pip install --upgrade git+https://github.com/Gallopsled/pwntools.git@dev3

RUN pip install capstone && pip install ropgadget

RUN gem install one_gadget seccomp-tools

RUN git clone https://github.com/longld/peda.git /root/peda && echo "source ~/peda/peda.py" >> /root/.gdbinit

RUN git clone https://github.com/scwuaptx/Pwngdb.git

RUN git clone https://github.com/niklasb/libc-database.git libc-database && cd libc-database && ./get || echo "/libc-database/" > ~/.libcdb_path

COPY --from=skysider/glibc_builder64:2.19 /glibc/2.19/64 /glibc/2.19/64
COPY --from=skysider/glibc_builder32:2.19 /glibc/2.19/32 /glibc/2.19/32

COPY --from=skysider/glibc_builder64:2.23 /glibc/2.23/64 /glibc/2.23/64
COPY --from=skysider/glibc_builder32:2.23 /glibc/2.23/32 /glibc/2.23/32

COPY --from=skysider/glibc_builder64:2.24 /glibc/2.24/64 /glibc/2.24/64
COPY --from=skysider/glibc_builder32:2.24 /glibc/2.24/32 /glibc/2.24/32

COPY --from=skysider/glibc_builder64:2.28 /glibc/2.28/64 /glibc/2.28/64
COPY --from=skysider/glibc_builder32:2.28 /glibc/2.28/32 /glibc/2.28/32

COPY --from=skysider/glibc_builder64:2.29 /glibc/2.29/64 /glibc/2.29/64
COPY --from=skysider/glibc_builder32:2.29 /glibc/2.29/32 /glibc/2.29/32
