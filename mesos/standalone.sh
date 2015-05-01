#!/bin/bash
set -e

echo "starting ArangoDB in stand-alone mode"

# fix permissions
test -d /data/db || mkdir /data/db
test -d /data/apps || mkdir /data/apps
test -d /data/logs || mkdir /data/logs

touch /data/logs/arangodb.log
rm -rf /tmp/arangodb
mkdir /tmp/arangodb

chown arangodb:arangodb /data/db /data/apps /data/logs /data/logs/arangodb.log /tmp/arangodb

# start server
exec /usr/sbin/arangod \
	--uid arangodb \
	--gid arangodb \
        --database.directory /data/db \
        --javascript.app-path /data/apps \
	--log.file /data/logs/arangodb.log \
        --temp-path /tmp/arangodb \
	--server.endpoint tcp://0.0.0.0:8529/ \
	"$@"
