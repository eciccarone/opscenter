#Image for Cassandra OpsCenter Community Edition

FROM ubuntu:latest
LABEL version="1.0"
LABEL maintainer "Erik Ciccarone"

# Download Prereqs
RUN \
  apt-get update; \
  apt-get -qq -y install build-essential libssl-dev libffi-dev python3-dev; \
  apt-get -qq -y install curl;
  
RUN \
  curl -L https://debian.datastax.com/debian/repo_key | apt-key add -;
  
# Download and extract OpsCenter
RUN \
  echo "deb http://debian.datastax.com/community stable main" | tee -a /etc/apt/sources.list.d/datastax.community.list; \
  apt-get update; \
  apt-get -qq -y install opscenter;

# Expose ports
EXPOSE 8888 61620

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /etc/init.d/opscenterd start && \
    /bin/bash

