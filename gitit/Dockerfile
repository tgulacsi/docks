FROM debian:stable
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

RUN echo 'deb http://http.debian.net/debian stable main contrib non-free' > /etc/apt/sources.list
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y gitit

# Clean up APT when done.
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git config --global user.name 'gitit'; git config --global user.email 'gitit@unosoft.hu'
RUN gitit --print-default-config | sed -e 's/^cache: no$/cache: yes/' >/etc/gitit.conf

## LOCAL
EXPOSE 5001:5001
DIR /var/lib/gitit
CMD ["/usr/bin/gitit", "-f", "/etc/gitit.conf"]

# should run with -v="/var/lib/gitit:/var/lib/gitit" -w=/var/lib/dokuwiki -p 5001:5001
# and have the executable as /var/lib/giti/bin/giti
