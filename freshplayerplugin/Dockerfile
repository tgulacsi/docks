FROM debian:testing
MAINTAINER Tamás Gulácsi <tgulacsi78@gmail.com>

RUN sed -i -e '/ main/ s!main.*$!main contrib non-free!' /etc/apt/sources.list

RUN echo -n 'nameserver 8.8.8.8\nnameserver 172.17.42.1' >/etc/resolv.conf; DEBIAN_FRONTEND=noninteractive apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN echo -n 'nameserver 8.8.8.8\nnameserver 172.17.42.1' >/etc/resolv.conf; DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN echo -n 'nameserver 8.8.8.8\nnameserver 172.17.42.1' >/etc/resolv.conf; DEBIAN_FRONTEND=noninteractive apt-get -y install wget unzip build-essential cmake pkg-config ragel libasound2-dev libglib2.0-dev libconfig-dev libpango1.0-dev libxinerama-dev libegl1-mesa-dev libevent-dev libgtk+2.0-dev libgles2-mesa-dev

WORKDIR /tmp

ENTRYPOINT cd /tmp && \
    echo -n 'nameserver 8.8.8.8\nnameserver 172.17.42.1' >/etc/resolv.conf && \
	wget -O fpp.zip 'https://github.com/i-rinat/freshplayerplugin/archive/master.zip' && \
	unzip fpp.zip && \
	cd freshplayerplugin-master && mkdir build && cd build && \
	cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo .. && \
	make && \
	cp -a $(find . -name libfreshwrapper-pepperflash.so) /tmp/ && \
	echo "cp -p /tmp/libfreshwrapper-pepperflash.so /usr/lib/mozilla/plugins/"
