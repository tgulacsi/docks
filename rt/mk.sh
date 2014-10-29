#!/bin/sh -e
set -x
docker build -t tgulacsi/rt-1 1
docker run -t -i tgulacsi/rt-1 /bin/bash -c 'apt-get install request-tracker4'
docker commit $(docker ps -a | fgrep tgulacsi/rt-1:latest | head -n 1 | cut '-d ' -f1) tgulacsi/rt-2
docker run -t -i -p 8080:8080 -u rt tgulacsi/rt-2 /bin/bash -c '/usr/sbin/nginx -t && /usr/sbin/nginx && spawn-fcgi -u www-data -g www-data -a 127.0.0.1 -p 9000 -n -- /usr/share/request-tracker4/libexec/rt-server.fcgi'
