#!/bin/sh -e
if ! [ -s gitlab.deb ]; then
	if which curl; then
		CMD=curl -o
	else
		CMD=wget -o
	fi
	$CMD gitlab.deb https://downloads-packages.s3.amazonaws.com/gitlab_6.6.5-omnibus-1.ubuntu.12.04_amd64.deb
fi
docker build -t tgulacsi/gitlab $(dirname $0)
set +e
docker rm gitlab
set -e
docker run -t -i --name=gitlab tgulacsi/gitlab gitlab-ctl reconfigure
docker commit gitlab tgulacsi/gitlab
