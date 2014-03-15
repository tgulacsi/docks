#!/bin/sh -e
which docker || alias docker=docker.io
docker build -t tgulacsi/girocco $(dirname $0)
set +e
docker kill girocco; docker rm girocco
set -e
docker run --privileged -w /home/repo/upstream --name=girocco tgulacsi/girocco make install
docker commit --run='{"Cmd":["/usr/bin/runsvdir", "/etc/service"],"PortSpecs":["80"]}' girocco tgulacsi/girocco
#docker build
