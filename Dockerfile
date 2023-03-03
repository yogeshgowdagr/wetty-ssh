FROM ubuntu:latest

RUN apt update
RUN apt install -y openssh-server sudo
EXPOSE 22 

ARG UID=1000
ARG GID=1000

RUN groupadd -g "${GID}" ubuntu \
  && useradd --create-home -s /bin/bash --no-log-init -u "${UID}" -g "${GID}" ubuntu && adduser ubuntu sudo

RUN echo "ubuntu:ubuntu123876"|chpasswd
RUN ssh-keygen -A

USER ubuntu
WORKDIR /home/ubuntu
RUN ssh-keygen -A

USER root

RUN /usr/sbin/service ssh start

CMD [ "service","ssh","start","-D" ]
