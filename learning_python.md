---
path: /learnings/learning_python
title: Learning Python
---
# Table Of Contents

<!-- toc -->

- [Pip](#pip)
  * [Properly configuring](#properly-configuring)

<!-- tocstop -->

# Pip

Now a days (Python 3.4+) Pip is built into Python.

`python3 -m pip --version`

Usually this is aliased to `pip` or `pip3`

## Properly configuring

pip itself will tell you where your config files should be

`pip3 config debug`

This outputs

```
env_var:
env:
global:
  /Library/Application Support/pip/pip.conf, exists: False
site:
  /Applications/Xcode.app/Contents/Developer/Library/Frameworks/Python3.framework/Versions/3.8/pip.conf, exists: False
user:
  /Users/rwilcox/.pip/pip.conf, exists: False
  /Users/rwilcox/.config/pip/pip.conf, exists: False
  ```

When you do override a file correctly it will look like

```
env_var:
env:
global:
  /Library/Application Support/pip/pip.conf, exists: False
site:
  /Applications/Xcode.app/Contents/Developer/Library/Frameworks/Python3.framework/Versions/3.8/pip.conf, exists: False
user:
  /Users/rwilcox/.pip/pip.conf, exists: False
  /Users/rwilcox/.config/pip/pip.conf, exists: True
    some.setting.you.set.in.this.file: "value"
    another.setting.you.set: "another value"
  ```

# Using Python as a shell script replacement language

Python has low level tools to handle this, deprecated tools to handle this, and high level tools to handle this. My favorite high level tool is currently `subprocess.check_output`.

```python

import subprocess

res = subprocess.check_output("ls", shell=True, stderr=subprocess.STDOUT)
# res is a bytes object

output_as_lines = res.decode("utf-8").split("\n")
```

[docs for subprocess.check_output](https://docs.python.org/3.11/library/subprocess.html#subprocess.check_output).

It will throw a `CalledProcessError` if non-zero error code
