#### Dockerfile for installing RTI DDS Connext Professional 5.2.0 on Ubuntu 14.04

###### To build the docker image:
 1. Create new build directory
 
    Example: `~/dds`
 2. Place this Dockerfile in build directory
 
    Example: `~/dds/Dockerfile`
 3. Place target,host bundles and the license file in sub-directory named `dep/`
 
    Example:
    ```
 ~/dds/dep/rti_connext_dds-5.2.0-pro-host-x64Linux.run
 ~/dds/dep/rti_connext_dds-5.2.0-pro-target-x64Linux3gcc4.8.2.rtipkg
 ~/dds/dep/rti_license.dat
    ```
 4. Build Docker image from base directory with:
 
   `docker build -t <repo>/<imagename>:tag .`

    Example: `docker build -t kharesp/rti_dds:5.2.0 . `
 5. Run Docker container with:
 
    `docker run -t -i <repo>/<imagename>:tag /bin/bash`

     
     
     Example: `docker run -t -i kharesp/rti_dds:5.2.0 /bin/bash`
 
###### To run hello\_simple pub-sub example:
 1. Run publisher docker container in one terminal with:
 
   `docker run -t -i <repo>/<imagename>:tag /bin/bash`

    Once inside the container:
    ```
    cd $RTI_WORKSPACE/5.2.0/examples/connext_dds/java/hello_simple
    Build the example with: ./build.sh
    Run publisher with: ./runPub.sh
    ```

 2. Run subscriber docker container in another terminal with:
 
    `docker run -t -i <repo>/<imagename>:tag /bin/bash`

    Once inside the container:
    ```
    cd $RTI_WORKSPACE/5.2.0/examples/connext_dds/java/hello_simple
    Build the example with: ./build.sh
    Run subscriber with: ./runSub.sh
    ```

###### Performance Test Results: 

[RTI's perftest] (https://community.rti.com/downloads/rti-connext-dds-performance-test) module was used to get some baseline throughput and latency results for running RTI DDS in a dockerized environment. The tests were run for the following four configurations: 

  * **Single VM**: Perftest's publisher and subscriber were run on a single VM
  * **Single VM 2 Containers**: Dockerized perftest publisher and Dockerized perftest subscriber were run on a single VM
  * **2 VMs**: Perftest's publisher and subscriber were run on two different VMs (on the same virtual LAN)
  * **2 VMs 2 Containers**: Dockerized perftest publisher and Dockerized perftest subscriber were run on two different VMs. [Weave](https://www.weave.works/) was used for networking the docker containers running on two different VMs. 

Three tests were performed for each of the above four configurations:

  * **Test-1**: Perftest publisher sends 10,000,000 messages (100 byes each) to the subscriber. After each 1000th message, a latency ping is sent by the publisher. On receiving the latency ping, the subscriber echoes it back to the publisher. The publisher reports the round-trip latency (publisher-subscriber-publisher) on receiving the latency echo  and the subscriber reports the throughput observed. 

    ```
    perftest_java -pub -numIter 10000000 -latencyCount 1000 -noPrintIntervals
    perftest_java -sub -noPrintIntervals
    ```
  * **Test-2**: Publisher sends 10,000 latency pings to get the baseline latency measurements.

    ```
    perftest_java -pub -latencyTest -numIter 10000 -noPrintIntervals
    perftest_java -sub -noPrintIntervals
    ```

  * **Test-3**: Scan test for different message sizes (32 bytes to 63000 bytes)

    ```
    perftest_java -pub -scan -noPrintIntervals
    perftest_java -sub -noPrintIntervals
    ```

The following results were observed for `ps.small` VM (1 Virtual CPU, 2 GB RAM, 40 GB storage) running `ubuntu 14.04`, `docker version 1.10.3` and `weave 1.4.6`. 

