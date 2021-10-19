---
path: /learnings/java_http_clients
title: 'Learnings: Java: HTTP(s) Clients'
---
# Table Of Contents

<!-- toc -->

- [OkHttp](#okhttp)
  * [Android](#android)
  * [Not-Droid](#not-droid)

<!-- tocstop -->

# OkHttp

## Android

> The aforementioned solution has one drawback: httpClient adds authorization headers only after receiving 401 response

> When OkHttp tries a proxy, and that route fails once, every request after that request will completely bypass the Android system proxy

Source:

  * https://github.com/square/okhttp/issues/2525
  * https://stackoverflow.com/a/36056355/224334

## Not-Droid



