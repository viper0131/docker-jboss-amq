#!/bin/bash

VERSION=$1

# Start Fuse
echo "Starting fuse..."
/opt/jboss/jboss-a-mq-$VERSION/bin/start
sleep 30
echo "Fuse started"

tail -f /opt/jboss/jboss-a-mq-$VERSION/data/log/amq.log
