An Org Babel cheatsheet of stuff I do

# Deno

`#+BEGIN_SRC bash :shebang "#!//usr/bin/env deno run --allow-net --allow-import --allow-write" :results output`

# Hurl stuff

## Pretty looking output

`#+BEGIN_SRC hurl :wrap src json`

will return the output in an org babel json block (`#+begin_src json`). It will not prettify it but it does remain a drawer of the RESULTS block (so hiding works) AND you _could_ just select the json region and `M-x json-pretty-prent`

### Pretty looking output all the time!

Using modeline `# -*- org-use-property-inheritance: t; org-imenu-depth: 5 -*-`

Then you can set properties on the header only, and not have to repeat them everywhere:

```org
* Big Heading that Everything Is Under
:PROPERTIES:
:header-args: :wrap src json

#+begin_src hurl
...
```
It will still wrap your output correctly

# Database stuff

## Mysql

No you can not use property inheritance with [ob-sql to put header parameters in one place](https://github.com/nikclayton/ob-sql-mode/blob/master/ob-sql-mode.el#L135)


# Random org stuff
