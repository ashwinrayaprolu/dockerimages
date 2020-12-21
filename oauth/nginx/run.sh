docker build --no-cache -t 247ai/oidc-proxy .

docker run \
  -e OID_DISCOVERY=https://dev-365843.okta.com/.well-known/openid-configuration \
  -e OID_CLIENT_ID=0oajrto1wyWzPkNIL4x6 \
  -e OID_CLIENT_SECRET=SEu3ozzPtmhO5S3we7fyx1tdaj1OOd-PPCLEv6sQ \
  -e OID_REDIRECT_PATH=/redirect_uri \
  -e PROXY_HOST=okta-headers.herokuapp.com \
  -e PROXY_PORT=443 \
  -e PROXY_PROTOCOL=https \
  -e OID_SESSION_SECRET=623q4hR325t36VsCD3g567922IC0073T \
  -e OID_SESSION_CHECK_SSI=off \
  -e OID_SESSION_NAME=oidc_auth \
  -p 8126:80  247ai/oidc-proxy


# For 247 AI
https://login.247ai.com/.well-known/openid-configuration
ClientID = 0oav0blwg6nUlZVbb0h7
secret=SbJYQPNtbY9Bs6-ReaeF3We8Fj_oranKrhhm9VF0




okta-headers.herokuapp.com 


docker run \
  --add-host=okta-headers.herokuapp.com:52.200.98.31 \
  -e OID_DISCOVERY=https://login.247ai.com/.well-known/openid-configuration \
  -e OID_CLIENT_ID=0oav0blwg6nUlZVbb0h7 \
  -e OID_CLIENT_SECRET=SbJYQPNtbY9Bs6-ReaeF3We8Fj_oranKrhhm9VF0 \
  -e OID_REDIRECT_PATH=/redirect_uri \
  -e PROXY_HOST=okta-headers.herokuapp.com \
  -e PROXY_PORT=443 \
  -e PROXY_PROTOCOL=https \
  -e OID_SESSION_SECRET=623q4hR325t36VsCD3g567922IC0073T \
  -e OID_SESSION_CHECK_SSI=off \
  -e OID_SESSION_NAME=oidc_auth \
  -p 8126:80  \
  --rm 247ai/oidc-proxy





http://scooterlabs.com/echo

docker run \
  --add-host=scooterlabs.com:66.39.74.7 \
  -e OID_DISCOVERY=https://login.247ai.com/.well-known/openid-configuration \
  -e OID_CLIENT_ID=0oav0blwg6nUlZVbb0h7 \
  -e OID_CLIENT_SECRET=SbJYQPNtbY9Bs6-ReaeF3We8Fj_oranKrhhm9VF0 \
  -e OID_REDIRECT_PATH=/redirect_uri \
  -e PROXY_HOST=scooterlabs.com \
  -e PROXY_PORT=80 \
  -e PROXY_PATH="/echo" \
  -e PROXY_PROTOCOL=http \
  -e OID_SESSION_SECRET=623q4hR325t36VsCD3g567922IC0073T \
  -e OID_SESSION_CHECK_SSI=off \
  -e OID_SESSION_NAME=oidc_auth \
  -p 8126:80  \
  --rm 247ai/oidc-proxy



docker run \
  -e OID_DISCOVERY=https://dev-365843.okta.com/.well-known/openid-configuration \
  -e OID_CLIENT_ID=0oajrto1wyWzPkNIL4x6 \
  -e OID_CLIENT_SECRET=SEu3ozzPtmhO5S3we7fyx1tdaj1OOd-PPCLEv6sQ \
  -e PROXY_HOST=okta-headers.herokuapp.com \
  -e PROXY_PORT=443 \
  -e PROXY_PROTOCOL=https \
  -p 8126:80  247ai/oidc-proxy

https://okta-headers.herokuapp.com/  