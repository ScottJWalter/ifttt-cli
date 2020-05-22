FROM gitpod/workspace-full-vnc
                    
USER gitpod

# Install custom tools, runtime, etc. using apt-get
# More information: https://www.gitpod.io/docs/config-docker/
#RUN sudo apt-get -q update && \
#    sudo apt-get install -yq chromium-browser && \
#    sudo rm -rf /var/lib/apt/lists/*

RUN sudo rm -rf /var/lib/apt/lists/* && \
    sudo apt-get -q update && \
    sudo apt-get -yq dist-upgrade

RUN sudo apt-get install -yq \
    libnspr4 \
    libnss3 \
    libnss3-nssdb \
    libnss3-tools

#RUN sudo apt-get install -yq \
#    chromium-browser \
#    && \
#    sudo rm -rf /var/lib/apt/lists/*

# Otherwise this outputs 'gitpod@ws-blah-blah-blah-blah-blah:/workspace/gitpod-tests1$'' in terminal
RUN printf '%s\n' \
	"export PS1='\[\e]0;\u \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\] \[\033[01;34m\]\w \$ \[\033[00m\]'" \
	>> "$HOME/.bashrc"
