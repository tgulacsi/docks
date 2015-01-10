#!/bin/sh

if [ ! -d "$DIRECTORY" ]; then
    mkdir -p $GOGS_CUSTOM_CONF_PATH

echo "
[repository]
ROOT = /gogs-repositories

[database]
DB_TYPE = sqlite3
" >> $GOGS_CUSTOM_CONF
    
fi

exec "$@"
