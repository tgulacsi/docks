#!/bin/sh -e
cd $(dirname $0)/..
DSN=$(bin/.dsn)
echo "DSN=$DSN"
if [ -z "$DSN" ]; then
	exit 2
fi
chpst -n 5 -l log2db.lock bin/log2db serve -db="$DSN"
