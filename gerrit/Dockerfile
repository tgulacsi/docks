FROM phusion/baseimage

MAINTAINER Tamás Glácsi <T.Gulacsi@unosoft.hu>

LINK postgresql:db

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

ENV HOME /home/gerrit
ENV USER gerrit
ENV WAR /home/gerrit/gerrit.war

RUN useradd -m $USER

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jre-headless sudo git-core supervisor vim-tiny

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ADD http://gerrit-releases.storage.googleapis.com/gerrit-2.8.1.war /tmp/gerrit.war

RUN SD=/etc/service/gerrit; mkdir -p $SD && echo '#!/bin/sh -e\ncd '"$HOME"'\nexec ./gerrit/gerrit.sh live 2>&1 >/var/log/gerrit.log' >$SD/run && chmod 0755 $SD/run

RUN mkdir -p $HOME/gerrit
RUN chown ${USER}.${USER} $HOME/gerrit
RUN mv /tmp/gerrit.war $WAR
RUN chown -R ${USER}.${USER} $HOME/gerrit

USER gerrit
RUN java -jar $WAR init --batch -d $HOME/gerrit

# clobber the gerrit config. set the URL to localhost:8080
ADD gerrit.config /home/gerrit/gerrit/etc/gerrit.config

USER root
EXPOSE 8080 29418
CMD ["/sbin/my_init"]

