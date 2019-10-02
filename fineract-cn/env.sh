#!/usr/bin/env bash

CLONE_REPOSITORIES='true'
DEP_PERSISTENT='true'
DEP_PROVISION='true' # if true then redeploy the full database, if false then only migrations will happen

DEP_CASSANDRA_ADDR='localhost:9042'
DEP_CASSANDRA_USER='cassandra'
DEP_CASSANDRA_PWD='password'
DEP_CASSANDRA_KEYSPACE='seshat'

DEP_MARIADB_HOST='localhost'
DEP_MARIADB_PORT='3306'
DEP_MARIADB_USER='root'
DEP_MARIADB_PASS='mysql'
