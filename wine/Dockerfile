FROM debian:testing
MAINTAINER Tamás Gulácsi <tgulacsi78 dontspam gmail dot com>

RUN DPKG_FRONTEND=noninteractive dpkg --add-architecture i386
RUN echo -n 'nameserver 8.8.8.8\nnameserver 172.17.42.1' >/etc/resolv.conf; DPKG_FRONTEND=noninteractive apt-get update -y
RUN echo -n 'nameserver 8.8.8.8\nnameserver 172.17.42.1' >/etc/resolv.conf; DPKG_FRONTEND=noninteractive apt-get install -y wine tightvncserver lxterminal

RUN useradd -m -u 1000 tgulacsi

USER tgulacsi

RUN export HOME=/home/tgulacsi; mkdir -p $HOME/.vnc && echo "lxterminal" >$HOME/.vnc/xstartup

EXPOSE 5901
CMD ["/bin/sh", "-c", "set -e;export USER=$USER;/usr/bin/tightvncserver :1 -rfbport 5901; DISPLAY=:1 lxterminal; while pidof Xtightvnc >/dev/null; do sleep 10; done"]