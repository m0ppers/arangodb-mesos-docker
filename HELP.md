volumes:
  /data    	database files
  /apps    	application directory
  /apps-dev	application directory for development
  /logs    	log directory

start in development mode:
  docker run -e development=1 arangodb/arangodb-mesos

pipe the log file to standard out:
  docker run -e verbose=1 arangodb/arangodb-mesos

fire up a bash after starting the server:
  docker run -e console=1 -it arangodb/arangodb-mesos

show all options:
  docker run -e help=1 arangodb/arangodb-mesos

start and initialise an agency:
  docker run -p 4001:4001 -p 7001:7001 arangodb/arangodb-mesos agency.sh

start a server within a cluster:
  docker run -p <extport>:8529 -e HOST=<my-own-ip> -e PORT0=<extport> arangodb/arangodb-mesos tcp://<ip-for-agency>:4001 DBserver1


