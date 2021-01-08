local opts = { 
    redirect_uri = os.getenv("OID_REDIRECT_PATH") or "/redirect_uri",
    discovery = os.getenv("OID_DISCOVERY"),
    client_id = os.getenv("OID_CLIENT_ID"),
    client_secret = os.getenv("OID_CLIENT_SECRET"),
    token_endpoint_auth_method = os.getenv("OIDC_AUTH_METHOD") or "client_secret_post",
    -- Backwards compatible with typo 'OIDC_RENEW_ACCESS_TOKEN_ON_EXPIERY'
    renew_access_token_on_expiry = os.getenv("OIDC_RENEW_ACCESS_TOKEN_ON_EXPIRY") ~= "false" and os.getenv("OIDC_RENEW_ACCESS_TOKEN_ON_EXPIERY") ~= "false",
    scope = os.getenv("OIDC_AUTH_SCOPE") or "openid email profile",
    iat_slack = 600,
    
    
}



-- call authenticate for OpenID Connect user authentication
local res, err, _target, session = require("resty.openidc").authenticate(opts)

ngx.log(ngx.INFO, tostring(res))
ngx.log(ngx.INFO, tostring(err))

ngx.log(ngx.INFO,
  "session.present=", session.present,
  ", session.data.id_token=", session.data.id_token ~= nil,
  ", session.data.authenticated=", session.data.authenticated,
  ", opts.force_reauthorize=", opts.force_reauthorize,
  ", opts.renew_access_token_on_expiry=", opts.renew_access_token_on_expiry,
  ", try_to_renew=", try_to_renew,
  ", token_expired=", token_expired
)

if err then
    ngx.status = 500
    ngx.header.content_type = 'text/html';

    ngx.say("There was an error while logging in: " .. err)
    ngx.exit(ngx.HTTP_INTERNAL_SERVER_ERROR)
end

ngx.log(ngx.INFO, "Authentication successful, setting Auth header...")
ngx.req.set_header("Authorization", "Bearer "..session.data.enc_id_token)
-- set headers with user info: this will overwrite any existing headers
-- but also scrub(!) them in case no value is provided in the token

ngx.log(ngx.INFO,"---------OIDC-USER=", res.id_token.preferred_username )
ngx.req.set_header("OIDC-USER", res.id_token.sub)
ngx.req.set_header("OIDC-EMAIL", res.id_token.email)
ngx.req.set_header("OIDC-NAME", res.id_token.name)
ngx.req.set_header("OIDC-PREFERED_USERNAME", res.id_token.preferred_username) 



ngx.var.user_id = res.id_token.sub
ngx.var.user_name = res.id_token.name
ngx.var.user_email = res.id_token.email
ngx.var.user_prefered_name = res.id_token.preferred_username

