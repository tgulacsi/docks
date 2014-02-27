FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ejabberd

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

## LOCAL
EXPOSE 25231:25231
CMD ["/sbin/my_init"]

RUN DN=/etc/service/ejabber; mkdir -p $DN && echo '#!/bin/sh -e\ncd /var/lib/ejabberd\nexec /etc/init.d/ejabberd live 2>&1' >$DN/run && chmod 0755 $DN/run
RUN DN=/etc/service/ejabber/log; LD=/var/log/ejabber; mkdir -p $LD $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$LD/config && echo "#!/bin/sh -e\nexec svlogd $LD" >$DN/run && chmod 0755 $DN/run
