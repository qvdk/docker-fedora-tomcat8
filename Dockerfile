FROM fedora

MAINTAINER Quentin Vandekerckhove

RUN yum -y upgrade && yum -y install java-1.8.0-openjdk.x86_64 less passwd vim && yum clean all
COPY apache-tomcat-8.0.18-1.noarch.rpm liquibase-3.3.2-1.noarch.rpm /tmp/
WORKDIR /tmp
RUN yum -y --nogpgcheck localinstall liquibase-3.3.2-1.noarch.rpm apache-tomcat-8.0.18-1.noarch.rpm && yum clean all
EXPOSE 8080
