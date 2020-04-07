---
path: "/learnings/javascript_security_for_apis"
title: "Learnings: Javascript: Security: For APIs"
---

# About / The Basics

This page mostly - with some exceptions - focuses on security concerns you may have with building an API in Node.js. Aka: not a Rails style "everything is generated on and lives on the server" style of app, but a "UI less Node API that serves data for some separe front end only user facing application".

## OWASP Top Ten

[Top 10 list](https://owasp.org/www-project-top-ten/)

  1. Injection
  2. Broken Auth
  3. Sensative Data Expose
  4. XML External Entities
  5. Broken Access Control
  6. Security Misconfiguration
  7. Cross-site scripting XSS
  8. Insecure Deserialization
  9. Using components with known vulnerabilities
  10. Insufficent loging and monitoring

## Node Specific documentation

  * [Rising Stack's Node Security checklist](https://blog.risingstack.com/node-js-security-checklist/) <-- mostly a Node specific iteration of the OWASP top ten list. But very nice.
  * [OWASP Node Cheatsheet](https://cheatsheetseries.owasp.org/cheatsheets/Nodejs_security_cheat_sheet.html)

# Injection

## Null Character <<Learning_Javascript_Security_For_Apis_Null_Character_Concerns>>

[json.porso handles this just fine,by giving yeu bock a string with the null value](https://stackoverflow.com/questions/54272131/javascript-json-strings-with-nul-0)



### Passing null characters, unaware, outside of Javascript world

in fact, even in certain places in v8 [null characters don't play well](https://github.com/nodejs/node/issues/28761)

Remember C/Unix doesn't deal with null bytes very well, so you'll likely want to check for null bytes when:

  * [Letting users provide a name for accessing even a sandboxed filename](https://nodejs.org/en/knowledge/file-system/security/introduction/)
  * ??
  *

### See also

  * Learning_Javascript_Unicode 
  * Learning_Javascript_Security_For_Apis_JSON_Unicode_Considerations

### Next, understanding where the attack is

- [TODO]: write me

### See Also
  * [OWASP Embedding null code](https://owasp.org/www-community/attacks/Embedding_Null_Code)
  * [Unicode URL encoding](https://owasp.org/www-community/attacks/Unicode_Encoding)
  * [Javascript escape sequences](https://mathiasbynens.be/notes/javascript-escapes)

## Unicode fun

First, read Learning_Javascript_Unicode

So:
  * for high unicode points things like `.length` will be wrong
  * unicode points that "look" alike but are not actually like will match (say latin-small-letter-n and n-combining-tilde)
  * reverse with high level unicode characters may get odd
  * substr might or might not really work? <-- A: this is correct you likely want: https://github.com/lautis/unicode-substring

### Ok great what does that mean for API security? <<Learning_Javascript_Security_For_Apis_JSON_Unicode_Considerations>>

The [JSON spec](https://www.ecma-international.org/publications/files/ECMA-ST/ECMA-404.pdf) says:

> A string is a sequence of Unicode code points wrapped with quotation marks (U+0022). All code points
> may be  placed  within  the  quotation  marks  except  for  the code  points that  must  be  escaped:  
> quotation  mark (U+0022), reverse solidus (U+005C), and the control characters U+0000 to U+001F.
> There are two-character escape sequence representations of some characters.
> \" represents the quotation mark character (U+0022).
> \\represents the reverse soliduscharacter(U+005C).
> \/represents the solidus character (U+002F).
> \brepresents the backspace character(U+0008).
> \frepresents the form feed character (U+000C).
> \nrepresents the line feed character (U+000A).
> \rrepresents the carriage return character (U+000D).
> \trepresents the character tabulation character (U+0009).
> So, for example, a string containing only a single reverse solidus character may be represented as "\\".Any code point may be represented as a hexadecimal escape sequence. The meaning ofsuch a hexadecimal number is determined by ISO/IEC 10646. If the code point is in the Basic Multilingual Plane (U+0000 through U+FFFF),  then  it  may  be  represented  as  a  six-character  sequence:  a  reverse  solidus,  followed  by  the lowercase letter u, followedby four hexadecimal digits that encode the code point. Hexadecimal digits can be 
> 5digits  (U+0030  through  U+0039)  or  the  hexadecimal  letters Athrough Fin  uppercase  (U+0041  through U+0046)  or  lowercase (U+0061 through U+0066). So, for  example, a string containing only  a single reverse solidus character may be represented as "\u005C".The following four cases all produce the same result:"\u002F""\u002f""\/""/"To  escape  a  code  point  that  is  not  in  the  Basic  Multilingual  Plane,  the  character  may  be  represented  as  a twelve-character  sequence,  encoding  the  UTF-16  surrogate  pair  corresponding  to  the  code  point.  So  for example, a string containing only the G clef character (U+1D11E) may be represented as "\uD834\uDD1E".However, whether a processor of JSON texts interprets such a surrogate pair as a single code point or as an explicit surrogate pair is a semantic decision that is determined by the specific processor

Essentially: really hope you read that part about Unicode in Javascript.

APIs that use JSON.stringify, if they used unicode that would require surrogate pairs would return JSON that was invalid and could not be read in via JSON.parse: [Node 12 apparently fixed this bug?](https://v8.dev/features/well-formed-json-stringify)

But, in general: trust the v8 parser, everyone does and seemingly nobody does anything else...

### See also

  * Learning_Javascript_Unicode 
  * [OWASP page on unicode encoding bugs](https://owasp.org/www-community/attacks/Unicode_Encoding)

## Sql / NoSQL Injection

Best practice:: use parameterized queries in your code

### See also

  * https://snyk.io/blog/sql-injection-orm-vulnerabilities/
  * https://cheatsheetseries.owasp.org/cheatsheets/Query_Parameterization_Cheat_Sheet.html

## Node source code injection

don't `eval`. You can set `eslint` to warn you about this.

### See also

  * https://www.websecgeeks.com/2017/04/pentesting-nodejs-application-nodejs.html

## Javascript Prototype poisoning
Because Javascript has prototype inheritance, evil requests that are json.parsed could set attributes of the Object / Array class to things *during parsing*.

Three possibilities of mitigating this:

### @hapi/bourne

Problem here is that it replaces json.parse (awesome!) except if you are using Express's bodyParser that doesn't let you drop in a new JSON parsing function. So you can't get those two Lego blocks to connect.

I'm guessing hapi lets you use this? But if you're not using hapi this isn't super drop in...

### Using a reviver function

Just skip bourne and implement the checks yourself.

Source: https://gist.github.com/rgrove/3ea9421b3912235e978f55e291f19d5d

    // AFTER
    //
    // To prevent prototype poisoning, add this reviver function to body-parser's
    // options object.
    app.use(bodyParser.json({
      reviver(key, value) {
        // NOTE / TODO: also check for `constructor`, `prototype`, per lodash vulnerability link below
        if (key === '__proto__') {
          throw new SyntaxError('JSON object contains forbidden __proto__ property');
        }

        return value;
      }
    }));

### Using a middleware to plug bourne into the process

(Potentially coupling this with the raw-body middleware...)

Source: https://github.com/expressjs/body-parser/issues/347#issuecomment-461844627

    app.use((req, res, next) => {
      if (req.body && typeof req.body === 'object') Bourne.scan(req.body, { your options })
      next()
    })

But... you need to make sure that you have a body parser, then this, then body parse the JSON? The syntax to do this is not obvious...


### See also:
  * https://medium.com/intrinsic/javascript-prototype-poisoning-vulnerabilities-in-the-wild-7bc15347c96
  * https://hueniverse.com/a-tale-of-prototype-poisoning-2610fa170061
  * [body parser discussion on this](https://github.com/expressjs/body-parser/issues/347#issuecomment-461844627)
  * [lodash prototype vulnerability discussion (also talks about potential mitigations)](https://snyk.io/vuln/npm:lodash:20180130)
  * https://blog.0daylabs.com/2019/02/15/prototype-pollution-javascript/
  *


## Query Parameter attacks

What if you ae building a query string by hand and someone inserts either URL encoded information or does a Bobby Tables style attack on the data you put in the URL?

[URLSearchParams](https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams) is an HTML5/WHATWG standard to help with URI encoding and query building

    > var a = new URLSearchParams({first: 1, second: "+42&hacker=me"})
    > a.toString()
    "first=1&second=%2B42%26hacker%3Dme"

### See also

  * [MDN: URLSearchParams](https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams)


## Command / Server Side Includes (SSI) Injection

ie if you have a downloads endpoint don't just accept anything passed in: maybe they pass in `/etc/passwd` or something.

### See also

  * [OWAPS on SSI injection](https://wiki.owasp.org/index.php/Testing_for_SSI_Injection_(OTG-INPVAL-009))

## Cross-site scripting (XSS) / 
Server Side tomplate injection

Couple different ways this can happen a couple different behaviors:

  1. people adding javascipt into areas where we let users customize their own say profile pages - users might slip in malicious javascipt (this is sometimes called "stored XSS" or template injection)
  2. Users may attempt to use various escape characters ie in a a URL that you hope the server parrots back to the user, then the attacker "has" the user (this is sometimes called "reflected XSS")
  3. Some clever red team people can put Javascript in JPEGs. Best way to avoid this is to host uploaded images in a different domain and ensure the domain is not set for script execution (via CORS controls), and/or remove JPG header comments.
  4. [Injection that grabs cookies](https://blog.codinghorror.com/protecting-your-cookies-httponly/)
  
### XSS: Injection that grabs cookies

If you have something you've set that you JUST ON THE SERVER SIDE are going to read later, set this as an HttpOnly cokie (which really means "server only" by the following)

    response.setHeader('Set-Cookie', 'foo=bar; HttpOnly')
    
This will prevent client side fiddling with the cookie in JS
  
### See also

  * [Cross Site Scripting](https://owasp.org/www-community/attacks/xss/)
  * [another good article on tem.late injection](https://portswigger.net/research/server-side-template-injection)
  * [DOMPurity might be a good Node module for this](https://github.com/cure53/DOMPurify)
  * or https://www.npmjs.com/package/secure-filters
  * [strip JS commands out of plain ol HTML](https://www.npmjs.com/package/strip-js)


# JSON: Validation that you have JSON in your request body (and not a bunch of PHP...)

Yes, you can look at the MIME type, but that's... not going to be respected by some cracker. You probably want to inspect the request body to find out what's actually happening...


## Your users are uploading images or something and you want to detect it's valid per your list of supported types

Couple options here, depending on how much you can handle native dependencies...

| Module          | URL                                          | Notes                                 |
|:--------------- |:-------------------------------------------- |:------------------------------------- |
| stream-mmmagic  | https://www.npmjs.com/package/stream-mmmagic | Uses libmagic (so has native dep??)   |
| mime-stream     | https://github.com/meyfa/mime-stream         | Uses file-type which correctly identifies a bunch of binary pictures and images (but "only" a handful of dozens, excluding json) |


## "Is this request body JSON? Because this is an API endpoint and we don't support anything else"

Probably easiest way here is to use Express's [bodyParser JSON type parameter](https://www.npmjs.com/package/body-parser#type). This uses [type-is](https://www.npmjs.com/package/type-is) to check to see if the req.body is in fact application/json. (You can provide a function yourself if you're paranoid). [Source](https://github.com/expressjs/body-parser/blob/master/lib/types/json.js#L67).

Checks body parser does (in order):
  1. It reads and puts the entire stream in memory _after_ it uses [type-is](https://www.npmjs.com/package/type-is) to see if the request body actually is JSON. (which works on examining at most the first 16kb from the request to identify the kind of content).
  2. checks charset per RFC 7159 sec 8.1
  3. very simple checks like "is the first character a { or [" because that's a good initial test.
  
ONLY THEN does it JSON.parse()

Can also pass bodyParser.json a verify functor, which will be called with the stream of the request, if you want extra checks (abort the request by throwing an error, bodyParser catches it). [source](https://github.com/expressjs/body-parser/blob/master/lib/read.js#L101)

IN fact, bodyParser uses raw-body...

## Is It Really JSON and not just an x86 binary?

Potential solutions:
  * no, seriously, use bodyParser, see above
  * [raw-body](https://www.npmjs.com/package/raw-body)  <-- look at this first before you call req.json()!
  * https://stackoverflow.com/questions/35164808/unobtrusive-middle-ware-for-expres-js-to-inspect-request-body
  * mime type inspection / detection


## Or is it a JSON version of a Node Buffer?

[Buffer API information](https://medium.com/@jasnell/node-js-buffer-api-changes-3c21f1048f97) some upgrades that happened in the Node 6.x timeframe


## Does it really follow the rules (ie escapes correctly, JSON rules around high order characters) or not?

### Character encoding: provided by body-parser

body-parser works by having a set of middlewares you declare as how you want the body parsed. Because these middlewares (json, plain text, and urlencoded) are really very close, here's what happens:

(body parser you want) -> (body parser specific checks) -> (generic read function) -> (your defined next middleware in the chain)

The JSON specfic body parser json it validates the charset header is utf- (throwing an error if it's not) or defaults to utf-8, passing that encoding information to the generic read function. The generic read function uses 'iconv-lite' to decode the binary stream into that specified charset. Untranslatable characters are set to � or ?. No transliteration is currently supported by iconv-lite.

So character strings that don't make sense are thrown away.


### See also

  * https://www.bennadel.com/blog/2576-testing-which-ascii-characters-break-json-javascript-object-notation-parsing.htm
  * Learning_Javascript_Security_For_Apis_Null_Character_Concerns
  * Learning_Javascript_Unicode

## Might it be a zip bomb?

- [TODO]: write me

## buffer size mismatching: give a wrong content-type and try to crash it that way / make the socket hang forever

bodyParser uses the length of the stream (not the content size in the header) to talk to [raw-body](https://www.npmjs.com/package/raw-body). If you pass `limit` to the bodyParser json middleware constructor it'll pass `limit` passed through to raw-body. 


## crashing Node's buffer size limitsFrom Fastly's work on this (aka: passing in a HUGE payload):

> one must send a request with Content-Type: application/json containing a very large payload. The request may be streamed. The payload only needs to be large enough to surpass V8's string length limit (2^30 - 25 bytes with V8 62 / Node 9, or 2^28 - 16 bytes for earlier versions), at which point the Node.js process will crash with an uncaughtException. If the process running Node has less memory than V8's maximum string size, the process will run out of memory and crash earlier. If multiple requests with a large payload are made in parallel, the process will run out of memory very quickly (this can be done with only a few parallel requests).

One idea is to catch these large request bodies in a higher layer (an application manager / gateway) waaaayyy before Node tries to get to it. (Yes, onion defences, and also...)

Potential solutions:
  * use bodyParser and set limit (?? might work for you. Will work if you set it...)
  * bodyParser's limit is by default set to 100kb??!!!
  * [raw-body](https://www.npmjs.com/package/raw-body)  <-- look at this first before you call req.json()!
  * [example of using raw-body to limt](https://stackoverflow.com/a/41232664) <-- raw-body will error if streamed data becomes > that limit

### See Also

  * [Fastly bug on this](https://hackerone.com/reports/303632)

## Q: How good is Node's json parser

  * https://stackoverflow.com/questions/51876427/node-js-implementation-of-json-parse#comment91512375_51877188
  * [source code for json-parser in v8](https://github.com/v8/v8/blob/4b9b23521e6fd42373ebbcb20ebe03bf445494f9/src/torque/ls/json-parser.cc)

  
## See also:

  * Learning_Javascript_Security_For_Apis_JSON_Unicode_Considerations


# Schema Validation: ("I know I have good JSON or XML, is it the right shape?")

Couple interesting modules here:
  * [Joi](https://www.npmjs.com/package/@hapi/joi) is an excellent way to validate the request coming into your microservice.
  * [celebrate](https://alligator.io/nodejs/avoid-invalid-requests-express-celebrate/) <-- wraps Joi in an Express middleware


# XML: Validation that you have XML in your request body (and not a bunch of PHP...)

## Is it really XML and not just an x86 binary?

- [TODO]: write me

## Does it really follow the rules (ie escapes correctly, high order character rules), etc

- [TODO]: write me


## Might to be zip bomb?

- [TODO]: write me

## Might it be a [billion lols](https://en.wikipedia.org/wiki/Billion_laughs_attack) ?

- [TODO]: write me

## buffer size mismatching: give a wrong content-type and try to crash it that way / make the socket hang forever


- [TODO]: write me

# Potentially Useful middeware

## [helmet](https://github.com/helmetjs/helmet)

Middleware that provides following services, mostly by setting headers corectly.


### Useful if you use is directly hitting site

  * [content security policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
  * control DNS prefetching
  * enforce certificate transparency
  * feature policy: ie you can turn off microphone APIs to make sure neither you no oe third party can't turn on the microphone.
  * clickjack projection
  * IE8+ download options
  * disable client side caching
  * disable MIME type sniffing
  * hide referer header

### If you only sere APIs that serve the user

  * enable strict transport security
  *

### all useful

  * removed powered by header
  * some XSS filtering around setting the X-XSS-Protection header




## Rate Limiting / DDOS protection

# See Also

  * [Securing Node Applications O'Reilly Media whitepaper](https://learning.oreilly.com/library/view/securing-node-applications/9781491982426/)
  * [Patterns in Node Package Vulnerabilities](https://learning.oreilly.com/library/view/patterns-in-node/9781491999981/)
  * [AirBnB publishes an analysis of their security findings - touching on many of the above issues](https://buer.haus/2017/03/08/airbnb-when-bypassing-json-encoding-xss-filter-waf-csp-and-auditor-turns-into-eight-vulnerabilities/)
  * [Node.js anatomy of an HTTP request](https://nodejs.org/en/docs/guides/anatomy-of-an-http-transaction/)
