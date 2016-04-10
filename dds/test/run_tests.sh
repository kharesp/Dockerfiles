#!/bin/bash

#Test specific constants
NUMITER=10000000
LATENCY_COUNT=1000

function subscriber {
  mkdir -p output
  for i in `seq 1 3`;
  do 
    echo "Running subscriber test-$i"
    echo "./scripts/perftest_java -sub -noPrintIntervals > output/subscriber_$i.txt"
    sleep 5 
  done
  exit 0
}

function publisher {
  mkdir -p output
  
  #test-1
  echo "Running publisher test-1"
  echo "./scripts/perftest_java -pub -noPrintIntervals -numIter $NUMITER -latencyCount $LATENCY_COUNT > output/publisher_1.txt"
  sleep 5

  #test-2
  echo "Running publisher test-2"
  echo "./scripts/perftest_java -pub -noPrintIntervals -numIter $NUMITER -latencyTest > output/publisher_2.txt"
  sleep 5

  #test-3
  echo "Running publisher test-3"
  echo "./scripts/perftest_java -pub -noPrintIntervals -scan > output/publisher_3.txt"
  sleep 5
  exit 0
}

#obtain script name
SCRIPT=`basename ${BASH_SOURCE[0]}`

#print out help msg
function help {
  echo "Usage: $SCRIPT -s|p"
  echo "-s To run tests in subscriber mode"
  echo "-p To run tests in publisher mode"
  exit 1
}

#obtain number of input args
NUMARGS=$#
if [ $NUMARGS -eq 0 ]; then
  help 
fi

#process cmd line options
while getopts :sph opt; do
  case $opt in
    s)#running test in subscriber mode 
      subscriber
      ;;
    p)#running test in publisher mode 
      publisher
      ;;
    h)#print help msg
      help
      ;;
    \?)#invalid option
      echo "invalid option -$OPTARG"
      help
      ;;
  esac
done
