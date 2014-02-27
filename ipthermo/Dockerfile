FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y librrd4

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## LOCAL
EXPOSE 25231:25231
CMD ["/sbin/my_init"]

RUN mkdir -p /etc/service/ipthermo && echo '#!/bin/sh -e\ncd /var/lib/ipthermo\nexec ./bin/ipthermo 2>&1' >/etc/service/ipthermo/run && chmod 0755 /etc/service/ipthermo/run
RUN DN=/var/lib/ipthermo/log ; mkdir -p /etc/service/ipthermo/log $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >/etc/service/ipthermo/log/run && chmod 0755 /etc/service/ipthermo/log/run

ENV HOME /var/lib/ipthermo
RUN mkdir -p /var/lib/ipthermo/bin
ADD ipthermo /var/lib/ipthermo/bin/

# should run with -v="/var/lib/ipthermo:/var/lib/ipthermo" -p 25231:25231
# and have the executable as /var/lib/ipthermo/bin/ipthermo
