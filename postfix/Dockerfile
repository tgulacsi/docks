# Postfix container.

FROM debian:testing
MAINTAINER Tamás Gulácsi <T.Gulacsi@unosoft.hu>

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install runit rsyslog

# Allow postfix to install without interaction.
RUN echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
RUN echo "postfix postfix/mailname string HOSTNAME.EXAMPLE.COM" | debconf-set-selections
RUN echo "postfix postfix/root_address string ROOTMAIL@EXAMPLE.COM" | debconf-set-selections
RUN echo "postfix postfix/mynetworks string 0.0.0.0/0" | debconf-set-selections

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postfix

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# /usr/sbin/rsyslogd -c5 -n

##
# runit
##
RUN DN=/etc/service/postfix/log ; mkdir -p $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >$DN/run && chmod 0755 $DN/run
RUN DN=/etc/service/rsyslog/log ; mkdir -p $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >$DN/run && chmod 0755 $DN/run
RUN DN=/etc/service/rsyslog ; mkdir -p $DN && echo -e '#!/bin/sh\nexec /usr/sbin/rsyslogd -c5 -n' >$DN/run && chmod 0755 $DN/run
ADD ./run /etc/service/postfix/run
RUN chmod 0755 /etc/service/postfix/run

EXPOSE 25

CMD ["/usr/bin/runsvdir", "/etc/service"]
