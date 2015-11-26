all:
	cp ../arangodb-mesos/bin/arangodb-framework mesos
	strip mesos/arangodb-framework
	docker build -t arangodb/arangodb-mesos .
	docker push arangodb/arangodb-mesos

23:
	cp ../arangodb-mesos23/bin/arangodb-framework mesos
	strip mesos/arangodb-framework
	docker build -t arangodb/arangodb-mesos:devel .
	docker push arangodb/arangodb-mesos:devel

25:
	cp ../arangodb-mesos23/bin/arangodb-framework mesos
	strip mesos/arangodb-framework
	docker build -t arangodb/arangodb-mesos:V2 .
	docker push arangodb/arangodb-mesos:V2

