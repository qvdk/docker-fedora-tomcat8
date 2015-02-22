FROM fedora

MAINTAINER Quentin Vandekerckhove

RUN yum -y upgrade && yum -y install java-1.8.0-openjdk.x86_64 less passwd vim && yum clean all
COPY apache-tomcat-8.0.18-1.noarch.rpm /tmp/
RUN rpm -ivh /tmp/apache-tomcat-8.0.18-1.noarch.rpm

EXPOSE 8080
