docker build --no-cache -t thoughtlane/oidc-proxy .

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
  -p 8126:80  thoughtlane/oidc-proxy


okta-headers.herokuapp.com 



docker run \
  -e OID_DISCOVERY=https://dev-365843.okta.com/.well-known/openid-configuration \
  -e OID_CLIENT_ID=0oajrto1wyWzPkNIL4x6 \
  -e OID_CLIENT_SECRET=SEu3ozzPtmhO5S3we7fyx1tdaj1OOd-PPCLEv6sQ \
  -e PROXY_HOST=okta-headers.herokuapp.com \
  -e PROXY_PORT=443 \
  -e PROXY_PROTOCOL=https \
  -p 8126:80  thoughtlane/oidc-proxy

https://okta-headers.herokuapp.com/  