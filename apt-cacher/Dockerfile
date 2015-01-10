FROM debian:testing
MAINTAINER T.Gulacsi at unosoft dot hu

RUN DPKG_FRONTEND=noninteractive apt-get update -y
RUN DPKG_FRONTEND=noninteractive apt-get upgrade -y
RUN DPKG_FRONTEND=noninteractive apt-get install -y apt-cacher-ng

EXPOSE 3142
ENTRYPOINT ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng", "CacheDir=/data"]
CMD ["ForeGround=1"]
