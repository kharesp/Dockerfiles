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
