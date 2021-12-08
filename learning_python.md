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
