FROM httpd:alpine
RUN apk update && \
	apk add apache2-dev && \
 	apk add build-base && \
  	apk add libtool

COPY socketvar.h /usr/include/sys/socketvar.h
COPY httpd.conf /usr/local/apache2/conf/httpd.conf
COPY workers.properties /usr/local/apache2/conf/workers.properties
COPY mod_jk.conf /usr/local/apache2/conf/mod_jk.conf
COPY uriworkermap.properties /usr/local/apache2/conf/uriworkermap.properties

RUN wget http://archive.apache.org/dist/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz && \
        tar -xvf tomcat-connectors-1.2.48-src.tar.gz && \
        cd tomcat-connectors-1.2.48-src/native/ && \
        ./configure --with-apxs=/usr/local/apache2/bin/apxs && \
        make && \
        make install
EXPOSE 80

