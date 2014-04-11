#!/bin/sh
docker run -t -i --link=postgresql:db tgulacsi/psql /bin/sh -c '/usr/bin/psql --host=$DB_PORT_5432_TCP_ADDR -p $DB_PORT_5432_TCP_PORT -U docker'
