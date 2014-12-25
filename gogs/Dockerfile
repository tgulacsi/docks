FROM debian:testing
MAINTAINER Tamás Gulácsi <tgulacsi78+docks at gmail dot com>

RUN DPKG_FRONTEND=noninteractive apt-get -y update
RUN DPKG_FRONTEND=noninteractive apt-get -y install git
#RUN DPKG_FRONTEND=noninteractive apt-get -y install openssh-server runit
RUN DPKG_FRONTEND=noninteractive apt-get -y install unzip curl

RUN useradd -m git

USER git
RUN cd /tmp && \
	curl -L -o /tmp/gogs.zip \
		https://github.com/gogits/gogs/releases/download/v0.5.9/linux_amd64.zip
RUN cd /tmp && \
	unzip /tmp/gogs.zip -x __MACOSX/; \
	mv /tmp/gogs/* /home/git/; \
	rm /tmp/gogs.zip

RUN git config --global user.name "GoGS"
ENV HOME /home/git
RUN ln -sf /data/custom $HOME/custom; ln -sf /data/repos $HOME/gogs-repositories; ln -sf /data $HOME/data
ENV USER git
ENV PATH $GOGS_PATH:$PATH

WORKDIR /home/git
USER root
RUN chown -R git: /home/git/custom
RUN touch /etc/inittab; DPKG_FRONTEND=noninteractive apt-get -y install runit
RUN DPKG_FRONTEND=noninteractive apt-get -y install openssh-server
RUN mkdir -p /etc/service/ssh && echo '#!/bin/sh\nmkdir -p /var/run/sshd\nexec /usr/sbin/sshd' >/etc/service/ssh/run && chmod 0755 /etc/service/ssh/run
RUN mkdir -p /etc/service/gogs && echo '#!/bin/sh\nUSER=git\nHOME=/home/$USER\nPATH=$HOME:$PATH\nexport HOME USER PATH\ncd $HOME && exec chpst -u $USER gogs web' >/etc/service/gogs/run && chmod 0755 /etc/service/gogs/run

CMD ["/usr/bin/runsvdir", "/etc/service"]
