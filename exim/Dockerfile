# Postfix container.

FROM debian:testing
MAINTAINER Tamás Gulácsi <T.Gulacsi@unosoft.hu>

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

#RUN DEBIAN_FRONTEND=noninteractive apt-get -y install runit rsyslog exim4
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install exim4

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# /usr/sbin/rsyslogd -c5 -n

##
# runit
##
#RUN DN=/etc/service/exim/log ; mkdir -p $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >$DN/run && chmod 0755 $DN/run
#RUN DN=/etc/service/rsyslog/log ; mkdir -p $DN && echo 's10485760\nn10\nt86400\n!gzip -9c -' >$DN/config && echo "#!/bin/sh -e\nexec svlogd $DN" >$DN/run && chmod 0755 $DN/run
#RUN DN=/etc/service/rsyslog ; mkdir -p $DN && echo -e '#!/bin/sh\nexec /usr/sbin/rsyslogd -c5 -n' >$DN/run && chmod 0755 $DN/run
#ADD ./run /etc/service/exim/run
#RUN chmod 0755 /etc/service/exim/run
ADD ./exim.conf /etc/exim.conf

EXPOSE 25

#CMD ["/usr/bin/runsvdir", "/etc/service"]
CMD ["/usr/sbin/exim", "-bdf", "-d", "-C", "/etc/exim.conf"]
