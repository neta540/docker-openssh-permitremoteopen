FROM alpine:3.7
LABEL maintainer="neta540@gmail.com"
RUN apk add --no-cache --virtual build-dependencies \ 
    g++ \ 
    zlib-dev \
    openssl-dev \
    make \
    automake \
    autoconf \
    git && \
    git clone https://github.com/antonyantony/openssh.git && \
    cd openssh && \
    git reset --hard 3b55f5f0db74bce2e71cf30ce253f26714cbd10f && \
    autoreconf configure.ac && \ 
    ./configure --sysconfdir=/etc/ssh && \
    make && \
    make install && \
    apk del build-dependencies && \
    rm /etc/ssh/ssh_host_* && cd .. && rm -rf openssh
CMD [ "/usr/local/sbin/sshd", "-D" ]