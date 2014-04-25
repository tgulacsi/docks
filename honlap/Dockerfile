FROM phusion/baseimage
MAINTAINER Tamás Gulácsi <T.Gulacsi@unosoft.hu>

# Disable SSH
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-cli

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## LOCAL
CMD ["/bin/bash", "-c", "cd /var/www/www.unosoft.hu && ./gen.py"]

# should run with -v="/var/www/www.unosoft.hu:/var/www/www.unosoft.hu" 
