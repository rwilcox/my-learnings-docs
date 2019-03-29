---
path: "/learnings/java_spring_security"
title: "Learnings: Java: Spring: Security"
---

# Implementing your own Oauth server

### You have your own `AuthorizationServerConfigurerAdapter` yah?

#### I want to add a filter chain filter, to say capture a tracing header from a request

Add a middleware filter like so:

    public void configure(org.springframework.security.oauth2.config.annotation.web.configurers.AuthorizationServerSecurityConfigurer oauthServerConfig) {
        oauthServerConfig.addTokenEndpointAuthenticationFilter( new RetrieveTraceIdFilter() );
    }

NOTES:

  * this filter is a servlet filter: inside this filter you MUST call the next item in the chain
  * ... yes, this is NOT how you set up the `WebSecurityConfigurerAdapter` thing, where you `addFilterAfter` or such

## See also

  * https://spring.io/guides/topicals/spring-security-architecture. Hints from that document:    
  * http://blog.florian-hopf.de/2017/08/spring-security.html (some hints about the acctuator exceptions)
  * https://projects.spring.io/spring-security-oauth/docs/oauth2.html
  * https://docs.spring.io/spring-security-oauth2-boot/docs/current-SNAPSHOT/reference/htmlsingle/
  * 