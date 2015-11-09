#!/bin/bash

# Arguments:
#   - endpoint for agency like "tcp://<ip-address>:4001"
#   - own ID like "DBserver1"

# Environment:
#   - ${HOST} must be the cluster-wide external address of the host
#   - ${PORT0} must be the external port of this server

set -e

echo "starting ArangoDB in cluster mode"

env

if [ "x$1" == "x" ] ; then
    echo Need first argument to be the agency endpoint.
    exit 1
fi

if [ "x$2" == "x" ] ; then
    echo Need second argument to be our own ID.
    exit 2
fi

if [ "x$HOST" == "x" ]; then
    echo Need environment variable HOST to be set.
    exit 3
fi

if [ "x$PORT0" == "x" ]; then
    echo Need environment variable PORT0 to be set to my external port.
    exit 4
fi

export Agency=$1
export MyID=$2
shift
shift

export MyAddress="tcp://${HOST}:${PORT0}"

# fix permissions
test -d /data/db || mkdir /data/db
test -d /data/apps || mkdir /data/apps
test -d /data/logs || mkdir /data/logs

touch /data/logs/arangodb.log
touch /data/logs/requests.log
rm -rf /tmp/arangodb
mkdir /tmp/arangodb

chown arangodb:arangodb /data/db /data/apps /data/logs /data/logs/arangodb.log /data/logs/requests.log /tmp/arangodb

export SchedulerThreads=3
export DispatcherThreads=5
if [[ "${MyID}" =~ ^Coordinator ]] ; then
    export SchedulerThreads=4
    export DispatcherThreads=60
elif [[ "${MyID}" =~ ^Secondary ]] ; then
    export SchedulerThreads=1
    export DispatcherThreads=2
fi

echo Scheduler threads: $SchedulerThreads
echo Dispatcher threads: $DispatcherThreads

# start server
exec sudo -u arangodb -g arangodb -- /usr/sbin/arangod \
        --database.directory /data/db \
        --javascript.app-path /data/apps \
	--log.file /data/logs/arangodb.log \
        --temp-path /tmp/arangodb \
	--server.endpoint tcp://0.0.0.0:8529 \
        --cluster.agency-endpoint ${Agency} \
        --cluster.my-address ${MyAddress} \
        --cluster.my-id ${MyID} \
        --scheduler.threads ${SchedulerThreads} \
        --server.threads ${DispatcherThreads} \
        --server.foxx-queues false \
        --server.disable-statistics true \
	"$@"
