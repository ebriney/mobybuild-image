FROM ubuntu
MAINTAINER emmanuel.briney@docker.com
LABEL Description="This image is used to build moby" Vendor="Docker Inc." Version="1.0"

#add docker apt repo
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates \
 && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
 && echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" > /etc/apt/sources.list.d/docker.list \
 && rm -rf /var/lib/apt/lists/*

#install dependencies
RUN apt-get update && apt-get install -y \
 docker-engine \ 
 git \ 
 curl \
 make \
 && rm -rf /var/lib/apt/lists/*

#set default branch to build
ENV branch master

#define the output directory (pinata root)
VOLUME /output
#ssh keys to clone moby (will be copied in /root/.ssh changing access rights to make samba share working)
VOLUME /sshkeys
#share docker cache
VOLUME /var/lib/docker

#script to execute on run
COPY Execute.sh /
RUN chmod 777 /Execute.sh
CMD /Execute.sh
