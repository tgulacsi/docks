FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y wget default-jre-headless

RUN mkdir /opt/gitblit && cd /opt/gitblit && wget -O- https://gitblit.googlecode.com/files/gitblit-1.3.2.tar.gz | tar xzf -

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive; apt-get purge wget && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## LOCAL
EXPOSE 9418:9418
EXPOSE 8443:8443
CMD ["/sbin/my_init"]

RUN DN=/etc/service/gitblit; mkdir -p $DN && echo '#!/bin/sh -e\ncd /opt/gitblit\nexec java -jar gitblit.jar -baseFolder data 2>&1' >$DN/run && chmod 0755 $DN/run
RUN DN=/etc/service/gitblit/log; LD=/var/log/gitblit; mkdir -p $LD $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$LD/config && echo "#!/bin/sh -e\nexec svlogd $LD" >$DN/run && chmod 0755 $DN/run

## should be called with -v=/var/lib/gitblit/data:/opt/gitblit/data -p 9418:9418 -p 8443:8443
