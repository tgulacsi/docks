#!/bin/sh -e
dn=$(dirname $0)/freshplayerplugin
set -x
docker pull $(sed -n -e '/FROM/ s/^.* //p' $dn/Dockerfile)
docker build -t tgulacsi/freshplayerplugin $dn
mkdir -p /tmp/fpp
docker run -t -i -v /tmp/fpp:/tmp tgulacsi/freshplayerplugin
mkdir -p ~/.mozilla/plugins
cp -p /tmp/fpp/libfreshwrapper-pepperflash.so ~/.mozilla/plugins/
