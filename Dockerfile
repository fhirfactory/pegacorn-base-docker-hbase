FROM debian:buster
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openjdk-11-jdk \
      net-tools \
      curl \
      netcat \
      gnupg \
      libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

RUN apt-get update && apt-get install nano
RUN apt-get install -y --no-install-recommends curl
RUN cd /opt && curl -SL http://archive.apache.org/dist/hbase/2.4.5/hbase-2.4.5-bin.tar.gz | tar -x -z && mv hbase-2.4.5 hbase

#Zookeeper
EXPOSE 2181
# REST API
EXPOSE 8080
# REST Web UI at :8085/rest.jsp
EXPOSE 8085
#Direct connect with Java
EXPOSE 16000
#Master web ui
EXPOSE 16010
