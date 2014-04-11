FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rsync

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## LOCAL
EXPOSE 8181:8181
CMD ["/sbin/my_init"]

RUN mkdir -p /etc/service/log2db-load && echo '#!/bin/sh -e\ncd /var/lib/log2db\nexec ./bin/log2db-load.sh 2>&1' >/etc/service/log2db-load/run && chmod 0755 /etc/service/log2db-load/run
RUN DN=/var/lib/log2db-load/log ; mkdir -p /etc/service/log2db-load/log $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >/etc/service/log2db-load/log/run && chmod 0755 /etc/service/log2db-load/log/run
RUN mkdir -p /etc/service/log2db-serve && echo '#!/bin/sh -e\ncd /var/lib/log2db\nexec ./bin/log2db-serve.sh 2>&1' >/etc/service/log2db-serve/run && chmod 0755 /etc/service/log2db-serve/run
RUN DN=/var/lib/log2db-serve/log ; mkdir -p /etc/service/log2db-serve/log $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >/etc/service/log2db-serve/log/run && chmod 0755 /etc/service/log2db-serve/log/run

ENV HOME /var/lib/log2db

# should run with -v="/var/lib/log2db:/var/lib/log2db" -p 8181:8181
# and have the executables under /var/lib/log2db/bin/
