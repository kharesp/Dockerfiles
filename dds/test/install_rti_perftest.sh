#!/bin/bash
# This script assumes that connext 5.2.0 is installed and JAVA_HOME, NDDSHOME, LD_LIBRARY_PATH are already set

# install perftest for RTI DDS Connext 5.2.0 
wget http://s3.amazonaws.com/RTI/PerformanceTest/rtiperftestdds520.tar.gz
tar -xvf rtiperftestdds520.tar.gz
rm rtiperftestdds520.tar.gz

# build java test scripts 
sudo apt-get install -y ant ksh
cd ./rtiperftest.5.2.0/perftest_java && ant -propertyfile ../resource/properties/dds_release.properties
