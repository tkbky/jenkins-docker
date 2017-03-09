# Version 0.0.1

FROM jenkins:latest

MAINTAINER KY "infcurious@gmail.com"

ARG MYSQL_ROOT_PASSWD=root

USER root

RUN apt-get -qy update
RUN echo "mysql-server-5.6 mysql-server/root_password password $MYSQL_ROOT_PASSWD" | debconf-set-selections
RUN echo "mysql-server-5.6 mysql-server/root_password_again password $MYSQL_ROOT_PASSWD" | debconf-set-selections
RUN apt-get install -qy mysql-client mysql-server libmysqlclient-dev
RUN apt-get install -qy postgresql postgresql-contrib libpq-dev
RUN apt-get install -qy sudo

RUN usermod -aG sudo jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jenkins
