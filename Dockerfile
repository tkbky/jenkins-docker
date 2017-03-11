# Version 0.0.1

FROM jenkins:latest

MAINTAINER KY "infcurious@gmail.com"

ARG MYSQL_ROOT_PASSWD=root

USER root

RUN apt-get -qy update

# Set system locale
RUN apt-get install -qy locales
RUN locale-gen en_US.UTF-8

# Setup MYSQL
RUN echo "mysql-server-5.6 mysql-server/root_password password $MYSQL_ROOT_PASSWD" | debconf-set-selections
RUN echo "mysql-server-5.6 mysql-server/root_password_again password $MYSQL_ROOT_PASSWD" | debconf-set-selections
RUN apt-get install -qy mysql-client mysql-server libmysqlclient-dev

# Setup Postgresql
RUN apt-get install -qy postgresql postgresql-contrib libpq-dev
RUN apt-get install -qy build-essential git-core curl python-software-properties

# Setup Redis
RUN apt-get install -qy redis-server
RUN /etc/init.d/redis-server start

# Setup Sudo
RUN apt-get install -qy sudo
RUN usermod -aG sudo jenkins
RUN echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "local all jenkins trust" >> /etc/postgresql/9.4/main/pg_hba.conf

USER postgres

RUN /etc/init.d/postgresql start && psql -c "CREATE ROLE jenkins WITH SUPERUSER LOGIN;" && psql -c "ALTER ROLE jenkins WITH CREATEDB;"

USER jenkins
