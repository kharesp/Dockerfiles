# Start with Ubuntu base image
FROM ubuntu:16.04
MAINTAINER Shweta Khare<shweta.p.khare@vanderbilt.edu>

# Install dependencies
RUN apt-get update && apt-get install -y \
  git \
  software-properties-common \
  libssl-dev \
  libzmq3-dev \
  python-zmq \
  python-pip \
  ipython3

# Install Jupyter Notebook 
RUN pip install --upgrade pip
RUN python -m pip install jupyter

# install sudo
RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# Add user 'ubuntu'
RUN adduser --disabled-password --gecos '' ubuntu
RUN usermod -aG sudo ubuntu
RUN echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /home/ubuntu/dev_environ
RUN chown -R ubuntu:ubuntu /home/ubuntu/dev_environ
USER ubuntu

# Run Torch7 installation scripts
WORKDIR /home/ubuntu/dev_environ
RUN git clone https://github.com/torch/distro.git  torch --recursive && cd torch && \
  bash install-deps && \
  ./install.sh
RUN chown -R ubuntu:ubuntu /home/ubuntu/dev_environ/torch

# Export environment variables
ENV PATH=/home/ubuntu/dev_environ/torch/install/bin:$PATH

# Install itorch
WORKDIR /home/ubuntu/dev_environ
RUN git clone https://github.com/facebook/iTorch.git && \
    cd iTorch && \
    luarocks make

WORKDIR /home/ubuntu/workspace
