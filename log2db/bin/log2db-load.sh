#!/bin/sh
cd $(dirname $0)/.. || exit 1
DSN=$(bin/.dsn)
echo "DSN=$DSN"
if [ -z "$DSN" ]; then
	exit 2
fi
l2db () {
	echo bin/log2db log2db -db='$DSN' "$@"
	bin/log2db log2db -db="$DSN" "$@"
}

nm=cig
echo $nm
rsync -avz --bwlimit=500 tgulacsi@$nm-brprod.unosoft.local:/home/$nm/prd/data/mai/log/ $nm-prd/
set -e
l2db server $nm-prd
l2db -prefix=bm_mqs_server igfb $nm-prd
l2db -prefix=srv_aodb_wsgi aodb $nm-prd
l2db -prefix=aodb_upload_email aodb_upload_email $nm-prd
l2db -prefix=aodb_upload_file aodb_upload_file $nm-prd
l2db ktny $nm-prd
l2db nginx $nm-prd
l2db -prefix=web ws $nm-prd

sleep 7201
