#!/bin/bash

MONGODB1=mongodb

echo "Waiting for startup.."
until curl http://${MONGODB1}:27017/serverStatus\?text\=1 2>&1 | grep uptime | head -1; do
  printf '.'
  sleep 1
done

echo Executing setup at `date +"%T" `
mongosh --quiet --host ${MONGODB1}:27017 <<EOF
rs.initiate();
db.getMongo().setReadPref('primaryPreferred');
rs.status();
EOF