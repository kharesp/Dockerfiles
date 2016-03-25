#!/bin/sh
# This script is taken from http://container-solutions.com/dynamic-zookeeper-cluster-with-docker/
MYID=$1
ZK=$2

HOSTNAME=`hostname`
IPADDRESS=`ip -4 addr show scope global eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1`
cd $ZK_HOME

if [ -n "$ZK" ]
then
	echo "`bin/zkCli.sh -server $ZK:2181 get /zookeeper/config | grep ^server`" >> \
		$ZK_HOME/conf/zoo.cfg.dynamic
	echo "server.$MYID=$IPADDRESS:2888:3888:observer;2181" >> \
		$ZK_HOME/conf/zoo.cfg.dynamic
	cp $ZK_HOME/conf/zoo.cfg.dynamic $ZK_HOME/conf/zoo.cfg.dynamic.org
	$ZK_HOME/bin/zkServer-initialize.sh --force --myid=$MYID
	$ZK_HOME/bin/zkServer.sh start 
	$ZK_HOME/bin/zkCli.sh -server $ZK:2181 reconfig -add "server.$MYID=$IPADDRESS:2888:3888:participant;2181"
	$ZK_HOME/bin/zkServer.sh stop
	$ZK_HOME/bin/zkServer.sh start-foreground
else
	echo "server.$MYID=$IPADDRESS:2888:3888;2181" >> $ZK_HOME/conf/zoo.cfg.dynamic
	$ZK_HOME/bin/zkServer-initialize.sh --force --myid=$MYID 
	$ZK_HOME/bin/zkServer.sh start-foreground
fi
