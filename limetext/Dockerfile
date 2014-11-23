FROM debian:testing
MAINTAINER Tamás Gulácsi <tgulacsi78 at gmail dot com>

RUN DPKG_FRONTEND=noninteractive apt-get -y update
RUN DPKG_FRONTEND=noninteractive apt-get -y upgrade
RUN DPKG_FRONTEND=noninteractive apt-get -y install wget git-core mercurial build-essential libonig-dev python3.4-dev pkg-config

RUN DPKG_FRONTEND=noninteractive apt-get -y install qml-module-qtgraphicaleffects libqt5opengl5-dev qtbase5-private-dev qtdeclarative5-dev || true

ENV LIMETEXT_DIRECTORY /root/limetext
RUN export LIMETEXT_DIRECTORY=$LIMETEXT_DIRECTORY && \
    echo "export GOROOT=$LIMETEXT_DIRECTORY/go" >> ~/.bashrc && \
    echo "export GOPATH=$LIMETEXT_DIRECTORY" >> ~/.bashrc && \
    echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.bashrc

RUN mkdir -p $LIMETEXT_DIRECTORY && \
    cd $LIMETEXT_DIRECTORY && \
    wget http://golang.org/dl/go1.2.2.linux-amd64.tar.gz && \
    tar xf go1.2.2.linux-amd64.tar.gz

RUN . ~/.bashrc && \
    set -x ; \
    cd $LIMETEXT_DIRECTORY && \
    go get github.com/limetext/lime/backend && \
    go get github.com/limetext/lime/frontend/termbox && \
    cd $GOPATH/src/github.com/limetext/lime && \
    git submodule update --init && \
    go get github.com/limetext/lime/frontend/qml && \
    cd $GOPATH/src/github.com/limetext/lime/frontend/qml && \
    ls -lA $LIMETEXT_DIRECTORY/bin/qml && \
    ln -Lf $({ ldd termbox ; ldd qml; } | awk '/=>/{print $3}' | sort -u) $LIMETEXT_DIRECTORY/bin/

CMD ["tar", "czf", "-", "-C", "/root/limetext", "bin"]
