FROM ubuntu:14.04
MAINTAINER shweta khare <shweta.p.khare@vanderbilt.edu>

LABEL zk_version="3.5.0-alpha"

WORKDIR /home/root/dev_environ/

# install oracle-jre-8 and zookeeper
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y wget && \
    wget --no-check-certificate  -q -O - \
        --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" \
        http://download.oracle.com/otn-pub/java/jdk/8u77-b03/jre-8u77-linux-x64.tar.gz | \
        tar -xz && \
    wget -q -O - http://apache.mirrors.lucidnetworks.net/zookeeper/zookeeper-3.5.0-alpha/zookeeper-3.5.0-alpha.tar.gz |\
        tar -xz   

# expose environment variables
ENV JRE_HOME=/home/root/dev_environ/jre1.8.0_77 \
    ZK_HOME=/home/root/dev_environ/zookeeper-3.5.0-alpha \
    PATH=$PATH:/home/root/dev_environ/jre1.8.0_77/bin

# configure zoo.cfg
RUN cp $ZK_HOME/conf/zoo_sample.cfg $ZK_HOME/conf/zoo.cfg && \
    echo "standaloneEnabled=false" >> $ZK_HOME/conf/zoo.cfg && \
    echo "dynamicConfigFile=$ZK_HOME/conf/zoo.cfg.dynamic" >> $ZK_HOME/conf/zoo.cfg 

# expose required ports
EXPOSE 2181 2888 3888

# add zk-init.sh script
COPY dep/zk-init.sh .
