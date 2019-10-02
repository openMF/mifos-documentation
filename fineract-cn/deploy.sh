#!/usr/bin/env bash

source ./env.sh

if [ "$DEP_PROVISION" = "true"  ]; then
    echo "-- FULL PROVISON --"
else
    echo "-- Migration --"
fi

echo "Is Persistent: $DEP_PERSISTENT"
echo "Eureka will running on http://localhost:8761/"
echo "Starting Provision App ..."

DEPLOY_JAR_FILE='./jars/fineract-cn-deploy-server/deploy-server-0.1.0-BUILD-SNAPSHOT.jar'
JARS_DIR=`pwd`/jars

java -Djarsdir=$JARS_DIR \
    -Ddeployserver.persistent=$DEP_PERSISTENT \
    -Ddeployserver.provision=$DEP_PROVISION \
    -Dcustom.cassandra.contactPoints=$DEP_CASSANDRA_ADDR \
    -Dcassandra.cluster.user=$DEP_CASSANDRA_USER \
    -Dcassandra.cluster.pwd=$DEP_CASSANDRA_PWD \
    -Dcassandra.keyspace=$DEP_CASSANDRA_KEYSPACE \
    -Dcustom.mariadb.host=$DEP_MARIADB_HOST \
    -Dcustom.mariadb.port=$DEP_MARIADB_PORT \
    -Dcustom.mariadb.user=$DEP_MARIADB_USER \
    -Dcustom.mariadb.password=$DEP_MARIADB_PASS \
    -jar $DEPLOY_JAR_FILE