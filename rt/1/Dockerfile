FROM debian:testing
MAINTAINER Tamás Gulácsi

RUN DPKG_FRONTEND=noninteractive apt-get update -y && apt-get dist-upgrade -y
RUN DPKG_FRONTEND=noninteractive apt-get install -y rt4-db-sqlite rt4-standalone

CMD ["apt-get", "install", "request-tracker4"]
