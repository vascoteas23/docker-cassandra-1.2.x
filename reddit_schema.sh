#!/bin/bash

cd /apache-cassandra-1.2.16/bin/

./cassandra-cli
create keyspace reddit;
use reddit;
create column family permacache with column_type = 'Standard' and comparator = 'BytesType';
