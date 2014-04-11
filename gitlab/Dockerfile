FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

#RUN curl -o /tmp/gitlab.rpm https://downloads-packages.s3.amazonaws.com/gitlab-6.6.5_omnibus-1.el6.x86_64.rpm
#RUN curl -o /tmp/gitlab.deb https://downloads-packages.s3.amazonaws.com/gitlab_6.6.5-omnibus-1.ubuntu.12.04_amd64.deb
ADD gitlab.deb /tmp/gitlab.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/gitlab.deb && rm /tmp/gitlab.deb

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## LOCAL
EXPOSE 80:80
EXPOSE 443:443
CMD ["/sbin/my_init"]

#RUN DN=/var/lib/ipthermo/log ; mkdir -p /etc/service/ipthermo/log $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >/etc/service/ipthermo/log/run && chmod 0755 /etc/service/ipthermo/log/run

# should run with -v="/var/lib/ipthermo:/var/lib/ipthermo" -p 25231:25231
# and have the executable as /var/lib/ipthermo/bin/ipthermo
