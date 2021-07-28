FROM fhirfactory/pegacorn-base-hadoop:1.0.0

#Taken from https://hub.docker.com/r/dajobe/hbase/

COPY *.sh /build/

RUN ls -la /build/

RUN whoami
RUN chmod 700 /build/
RUN ls -la /build/

ENV HBASE_VERSION 2.2.4

RUN /build/prepare-hbase.sh
RUN cd /opt/hbase && /build/build-hbase.sh
RUN cd / && /build/cleanup-hbase.sh 
RUN rm -rf /build

VOLUME /data

ADD ./hbase-site.xml /opt/hbase/conf/hbase-site.xml

ADD ./zoo.cfg /opt/hbase/conf/zoo.cfg

ADD ./replace-hostname /opt/replace-hostname

ADD ./hbase-server /opt/hbase-server

# REST API
EXPOSE 8080
# REST Web UI at :8085/rest.jsp
EXPOSE 8085
# Thrift API
EXPOSE 9090
# Thrift Web UI at :9095/thrift.jsp
EXPOSE 9095
# HBase's Embedded zookeeper cluster
EXPOSE 2181
# HBase Master web UI at :16010/master-status;  ZK at :16010/zk.jsp
EXPOSE 16010

CMD ["/opt/hbase-server"]
