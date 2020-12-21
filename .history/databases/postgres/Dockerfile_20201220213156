FROM postgres:10.4
LABEL MAINTAINER Ashwin Rayaprolu <ashwin.rayaprolu@gmail.com>

# Install prerequisites
RUN apt-get update && apt-get install -y curl

RUN mkdir /var/temp

# To copy any script try to create something like next 2 lines
#COPY db.tar.gz /var/temp/
#RUN (cd /var/temp/ && tar -zxvf db.tar.gz && cp /var/temp/db.sql /docker-entrypoint-initdb.d/1_db.sql)

EXPOSE  5432
