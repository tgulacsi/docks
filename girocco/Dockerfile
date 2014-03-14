FROM debian:testing
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

RUN sed -i -e 's/main$/main contrib non-free/' /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gitweb netcat-openbsd git-daemon-run liblwp-useragent-determined-perl librpc-xml-perl libjson-perl libhtml-tagcloud-perl libproc-processtable-perl build-essential libcurl3-openssl-dev runit sudo openssh-server

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN DN=/etc/service/taskd ; mkdir -p $DN && echo '#!/bin/sh -e\nexec sudo -u repo /home/repo/repomgr/taskd/taskd.pl' >$DN/run && chmod 0755 $DN/run
RUN DN=/etc/service/jobd ; mkdir -p $DN && echo '#!/bin/sh -e\nexec sudo -u repo /home/repo/repomgr/jobd/jobd.sh' >$DN/run && chmod 0755 $DN/run

CMD ["/usr/bin/runsvdir", "/etc/service"]

RUN adduser repo
ENV HOME /home/repo
RUN cd /home/repo && sudo -u repo git clone http://repo.or.cz/r/girocco.git upstream
ADD Config.pm /home/repo/upstream/Girocco/Config.pm
RUN mkdir -p /srv/git /srv/git-recyclebin && chown repo: /srv/git /srv/git-recyclebin
RUN cd /home/repo/upstream && sudo -u repo sh -c 'git submodule update --init && make'
#RUN sed -i -e '/^mknod/ s/^mknod/echo mknod/;/^rm/ s!rm -f dev/null dev/zero dev/random dev/urandom!echo rm -f dev/{null,zero,random,urandom}!' /home/repo/upstream/chrootsetup_linux.sh
RUN sed -i -e '/ld-linux.so/ s!^![ -e /lib/ld-linux.so.2 ] \&\& !;/lib64/ s!/lib64!/lib/x86_64-linux-gnu!g' /home/repo/upstream/chrootsetup_linux.sh

##
## surely this will error out with mknod
## start it with docker --privileged=true
##
##
RUN cd /home/repo/upstream && make install

RUN DN=/etc/service/apache ; mkdir -p $DN && echo '#!/bin/sh -e\n/etc/init.d/apache2 restart\npid=$(cat /run/apache2/apache2.pid)\nwhile [ -e /proc/$pid ]; do sleep 30; done' >$DN/run && chmod 0755 $DN/run

# run with -v=/var/lib/girocco:/srv/repo -p 2244:2244
