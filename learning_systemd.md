---
path: "/learnings/systemd"
title: "Learnings: Systemd"
---

Systemd units
==================

  * .service
  * .path
  * .automount
  * .socket
  * .swap
  * .timer
  
Features
=========

  * starts sockets and reassigns to service once up, so can handle messages sent to service when it was restarting

CLI Cheatsheet
=================

    $ sudo systemctl status $SERVICE_NAME.service
    
    
    $ sudo systemctl start $SERVICE_NAME
    
    $ systemctl list-units --type service --all
      # list status of all services
      
    $ systemctl is-active name.service
    
    $ systemctl try-restart name.service # may perform ie configuration checks for you before restarting into failure
    
    $ systemctl enable service.service # enables service to start on boot
   
##   Listing units 

By default list-units only lists active units.—all shows even disabled ones

# Dependancies

## listing dependencies of a unit

    $ systemctl list-dependencies --after $SERVICE_NAME.service
    
  ## listing services started after a service (aka that might be depended on the service in question):
  
      $ systemctl list-dependencies --after $SERVICE_NAME.service
      
   

# targets: scheduling a service when: a replacement for runlevels

    $ systemctl list-units --type target # lists all targets on system you can be a part of
    
# Units

## location of custom zzunits (probably)

/etc/systemd/system/

## reload systemd so it sees new Files

    $ systemctl daemon-reload
   
## unit file

### Useful [Service] declarations

  * EnvironmentFile
  * ExecStartPre
  * ExecStart  — xxxxxxx
  * Environment - bash style ENV cars to set if you just have a couple
  
### Customizing units
#### modifying existing unit files

Can extend built in units (Q: custom units too?) in /etc/systemd/system/$UNIT.d/

Unit here also includes the type, so javaapp.service

Then make config file in that directory. Whatever.conf.  place INI commands in there as normal.

Note some systemd options can be specified multiple times, and some can only be declared once. if you override one that can only be defined once, you are replacing that default value (you own it completely now).

#### overriding existing unit files

Make a copy of file and place in /etc/systemd/system/. this will override previously defined unit

#### seeing what changed

    $ systemd-delta
    
  
 
