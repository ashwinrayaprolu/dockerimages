from kong:2.2-alpine
LABEL MAINTAINER Ashwin Rayaprolu <ashwin.rayaprolu@gmail.com>

# Install Kong OIDC
USER root
RUN luarocks install kong-oidc

#RUN luarocks remove luacrypto --force

RUN apk add --no-cache openssl-dev
RUN apk add build-base

#RUN luarocks install luacrypto


RUN echo $KONG_PLUGINS
RUN export KONG_PLUGINS="oidc","grpc-web","correlation-id","pre-function","cors","rate-limiting","loggly","hmac-auth","zipkin","request-size-limiting","azure-functions","request-transformer","oauth2","response-transformer","ip-restriction","statsd","jwt","proxy-cache","basic-auth","key-auth","http-log","session","datadog","tcp-log","prometheus","post-function","ldap-auth","acl","grpc-gateway","file-log","syslog","udp-log","response-ratelimiting","aws-lambda","bot-detection","acme","request-termination"

USER kong
#ENV KONG_LOG_LEVEL=debug
ENV KONG_PLUGINS="oidc","grpc-web","correlation-id","pre-function","cors","rate-limiting","loggly","hmac-auth","zipkin","request-size-limiting","azure-functions","request-transformer","oauth2","response-transformer","ip-restriction","statsd","jwt","proxy-cache","basic-auth","key-auth","http-log","session","datadog","tcp-log","prometheus","post-function","ldap-auth","acl","grpc-gateway","file-log","syslog","udp-log","response-ratelimiting","aws-lambda","bot-detection","acme","request-termination"

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444 $EE_PORTS

STOPSIGNAL SIGQUIT

CMD ["kong", "docker-start"]