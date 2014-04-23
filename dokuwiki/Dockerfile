FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-cli 

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## LOCAL
EXPOSE 7999:7999
CMD ["/sbin/my_init"]

RUN mkdir -p /etc/service/dokuwiki && echo '#!/bin/sh -e\ncd /var/lib/dokuwiki\nexec php -S 0.0.0.0:7999 2>&1' >/etc/service/dokuwiki/run && chmod 0755 /etc/service/dokuwiki/run
RUN DN=/var/lib/dokuwiki/log ; mkdir -p /etc/service/dokuwiki/log $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >/etc/service/dokuwiki/log/run && chmod 0755 /etc/service/dokuwiki/log/run

ENV HOME /var/lib/dokuwiki

RUN curl -o /tmp/dokuwiki.tgz http://download.dokuwiki.org/out/dokuwiki-2b57bd009c63308b84c2f132747b1208.tgz \
	&& tar xaf /tmp/dokuwiki.tgz -C /var/lib

# should run with -v="/var/lib/dokuwiki/conf:/var/lib/dokuwiki/conf:ro" -v=/var/lib/dokuwiki/data:/var/lib/dokuwiki/data:rw -w=/var/lib/dokuwiki -p 7999:7999
# and have the executable as /var/lib/dokuwiki/bin/dokuwiki
