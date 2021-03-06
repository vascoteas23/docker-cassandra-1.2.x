FROM ubuntu:12.04
MAINTAINER Ryan Fowler <ryan.fowler@singlewire.com>
COPY d/data/ /var/lib/cassandra/data/

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends openjdk-7-jdk openjdk-7-jre
RUN apt-get install -y curl vim python-pip libssl-dev
RUN apt-get install -y python-openssl python-dev

#RUN pip install https://github.com/jplana/python-etcd/
#RUN pip install python-etcd

RUN curl -O "http://archive.apache.org/dist/cassandra/1.2.16/apache-cassandra-1.2.16-bin.tar.gz"

RUN tar -zxvf apache-cassandra-1.2.16-bin.tar.gz
ENV C_DIR_NAME apache-cassandra-1.2.16
RUN ln -s /apache-cassandra-1.2.16 /apache-cassandra

#RUN mkdir /var/lib/cassandra
RUN mkdir /var/log/cassandra
#ADD ./cassandra.py /cassandra.py
#ADD ./cassandra.yaml.template /apache-cassandra-1.2.16/conf/cassandra.yaml.template

ENV SEEDS 127.0.0.1
ENV CLUSTER_NAME "Test Cluster"
ENV LISTEN_ADDRESS 127.0.0.1
ENV BROADCAST_ADDRESS 127.0.0.1
ENV RPC_ADDRESS 0.0.0.0
ENV NUM_TOKENS 256

RUN echo "127.0.0.1 $HOSTNAME" | tee -a /etc/hosts

EXPOSE 7000 7001 7199 9042 9160
CMD ["apache-cassandra-1.2.16/bin/cassandra", "-f"]

COPY reddit_schema.sh /

RUN chmod 777 ./reddit_schema.sh
#/Users/v.coelho/Documents/docker-cassandra-1.2.x ./var/lib/cassandra/data
#VOLUME ["/test", "/test"]
#RUN ./reddit_schema.sh

#CMD ["apache-cassandra-1.2.16/bin/cassandra-cli", "localhost"]

#RUN apache-cassandra-1.2.16/bin/cassandra -f

#CMD ["/cassandra.py"]
