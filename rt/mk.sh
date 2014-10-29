#!/bin/sh -e
set -x
docker build -t tgulacsi/rt-1 1
docker run -t -i tgulacsi/rt-1 /bin/bash -c 'apt-get install request-tracker4'
docker commit $(docker ps -a | fgrep tgulacsi/rt-1:latest | head -n 1 | cut '-d ' -f1) tgulacsi/rt-2
docker run -t -i -p 8080:8080 tgulacsi/rt-2 /usr/share/request-tracker4/libexec/rt-server --port 8080
