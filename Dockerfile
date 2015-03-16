FROM fedora

MAINTAINER Quentin Vandekerckhove

RUN yum -y update && yum -y install \
	git \
	hsqldb \
	java-1.8.0-openjdk.x86_64 \
	less \
	maven \
	passwd \
	rpm-build \
	sqlite3 \
	vim \ 
	&& yum clean all

COPY hsqldb_server.properties /var/lib/hsqldb/server.properties

COPY apache-tomcat-8.0.18-1.noarch.rpm liquibase-3.3.2-1.noarch.rpm /tmp/

WORKDIR /tmp

RUN rpm -ivh apache-tomcat-8.0.18-1.noarch.rpm 
RUN rpm -ivh --nodeps liquibase-3.3.2-1.noarch.rpm

# Launch hsqldb on startup
RUN echo "nohup /usr/lib/hsqldb/hsqldb-wrapper &> /dev/null &" >> ~/.bashrc

RUN mkdir /workspaces 
WORKDIR /workspaces
RUN git clone https://github.com/qvdk/salto-dojo-rpm-packaging.git
RUN git clone https://github.com/qvdk/salto-dojo-rpm-packaging-settings.git
RUN cd /workspaces/salto-dojo-rpm-packaging && mvn install -P rpm 
RUN cd /workspaces/salto-dojo-rpm-packaging-settings && mvn package -P rpm

ENTRYPOINT /bin/bash

EXPOSE 8080
EXPOSE 9001
