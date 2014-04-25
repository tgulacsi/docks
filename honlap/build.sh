#!/bin/sh -e
cd /tmp
if [ ! -d honlap/.git ]; then
	rm -rf honlap
	git clone gitolite@git.gthomas.eu:unosoft/honlap
else
	cd honlap
	git pull
fi
if [ $(docker images | grep tgulacsi/honlap | wc -l) -le 0 ]; then
	echo 'NO tgulacsi/honlap, building it'
	docker build -t tgulacsi/honlap $(dirname $0)/
fi
echo docker run -t -i -v /tmp/honlap:/tmp/honlap tgulacsi/honlap /bin/bash -c 'cd /tmp/honlap && ./gen.py'
docker run -t -i -v /tmp/honlap:/tmp/honlap tgulacsi/honlap /bin/bash -c 'cd /tmp/honlap && ./gen.py'
