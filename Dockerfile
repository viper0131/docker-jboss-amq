FROM jboss/base-jdk:7

### Install AMQ 6.3.0
ENV VERSION 6.3.0.redhat-187
ENV USER "jboss"

LABEL activemq-version="${VERSION}" desc="Apache ActiveMQ"

USER root

ADD installs/jboss-a-mq-${VERSION}.zip /tmp/jboss-a-mq-${VERSION}.zip
RUN unzip /tmp/jboss-a-mq-${VERSION}.zip
ADD docker_init.sh /opt/jboss/jboss-a-mq-${VERSION}/docker_init.sh

### Set Environment
ENV KARAF_HOME /opt/jboss/jboss-a-mq-${VERSION}

### Set Permissions
RUN chown -R jboss:jboss $KARAF_HOME
RUN chmod 755 $KARAF_HOME/docker_init.sh
USER ${USER}

### Create A-MQ User
RUN sed -i "s/#admin/admin/" $KARAF_HOME/etc/users.properties
RUN sed -i "s/#activemq.jmx.user/activemq.jmx.user/" $KARAF_HOME/etc/system.properties
RUN sed -i "s/#activemq.jmx.password/activemq.jmx.password/" $KARAF_HOME/etc/system.properties

RUN ln -s /opt/jboss/jboss-a-mq-${VERSION} /opt/jboss/jboss-a-mq
VOLUME /opt/jboss/jboss-a-mq/data

RUN mkdir -p ${KARAF_HOME}
### Open Ports
# SSH, Karaf-ssh, Web, rmiServerPort, rmiRegistry, ActiveMQ
EXPOSE 22 8101 8181 44444 1099 61616 

### Start A-MQ
CMD $KARAF_HOME/docker_init.sh ${VERSION}
