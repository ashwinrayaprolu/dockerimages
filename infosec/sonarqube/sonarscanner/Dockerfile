from newtmitch/sonar-scanner:4.5
#RUN cat /etc/*-release
RUN apk add --update --no-cache netcat-openbsd dos2unix -y
#RUN apt-get update && apt-get install netcat dos2unix -y

COPY ./init.sh /bin

RUN chmod a+x /bin/init.sh
RUN dos2unix /bin/init.sh


ENTRYPOINT ["init.sh"]