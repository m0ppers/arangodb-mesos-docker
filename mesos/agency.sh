#!/bin/bash
set -e

echo "starting Agency for ArangoDB"

# fix permissions
test -d /data/db || mkdir /data/db
test -d /data/logs || mkdir /data/logs

touch /data/logs/agency.log

chown arangodb:arangodb /data/db /data/logs /data/logs/agency.log

export ETCD_NONO_WAL_SYNC=1

env

arangosh --javascript.execute /scripts/init_agency.js &

# start server
exec sudo -u arangodb -g arangodb -- /usr/lib/arangodb/etcd-arango \
        --data-dir /data/db \
        --listen-client-urls 'http://0.0.0.0:4001' \
        --listen-peer-urls 'http://0.0.0.0:7001' \
	> /data/logs/agency.log \
	"$@"
