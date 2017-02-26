#!/bin/bash

docker run -d -p 61616:61616 -p 8181:8181 --name amq \
           -v $(pwd)/data:/opt/jboss/jboss-a-mq/data:Z \
          dockerhub.novamedia.com/nlmacamp/amq:6.3.0
