---
path: /learnings/macports
title: 'Learnings: Macports'
---
# <<PostgresMacportsInstallation_pgdump>>

    /opt/local/lib/postgresql94/bin/pg_dump

   and other tools in that location too

# How the select stuff works

Some sets of ports can hook themselves into the select system: you have multiple versions of some software installed at a time (say python 3.10 and python 3.12), but by default you want to use one particular version.

```
$ sudo port select --summary

Name       Selected      Options
====       ========      =======
helm       helm3.10      helm3.10 none
pip        pip311        pip3-apple pip311 none
pip2       none          none
pip3       pip311        pip3-apple pip311 none
python     none          python310 python311 python39 none
python3    python311     python310 python311 python39 none
terraform  terraform1.4  terraform1.4 none
```

To see what versions of a thing you are running:
```
sudo port select --show helm

The currently selected version for 'helm' is 'helm3.10'.
```

To see what versions are availible for a port:

```
$ sudo port select --list helm
Available versions for helm:
	helm3.10 (active)
	none
```

See also:
  * [port-select man page](https://man.macports.org/port-select.1.html)
