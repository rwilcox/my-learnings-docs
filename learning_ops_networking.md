---
path: /learnings/ops_networking
title: 'Learnings: Ops: Networking'
---
# Table Of Contents

<!-- toc -->

- [>](#)
  * [ARP >](#arp-)
    + [MAC Address caching in ARP table](#mac-address-caching-in-arp-table)
  * [Parsing / Reading CIDR blocks >](#parsing--reading-cidr-blocks-)
- [Book Recommendations](#book-recommendations)

<!-- tocstop -->

# <<Learning_Ops_Networking>>

## ARP <<Learning_Ops_Networking_ARP_Cache>>

### MAC Address caching in ARP table

If network utilizes large L3 IP space the number of neighboring nodes may flood the space of the ARP cache

## Parsing / Reading CIDR blocks <<Learning_Ops_Networking_CIDR_Blocks>>

Knowing that ipv4 addresses are 32 bit integers, thus made up of 4 1 byte chunks like so:

    196.168.42.138

    C0.A8.2A.8A

    OR, in base 2

    1100 0100 . 1010 1000 . 0010 1010 . 1000 1010

CIDR annotation allows you to say "I want IPs that match these same prefix of **bits**, and a wildcard of anything below that limit".

Given that information, a sample CIDR block makes more sense now:

    196.168.42.0/23

This means, my prefix of bytes is:


    11 00 01 00 . 10 10 10 00 . 00 10 10 10 . 10 00 10 10

I have a 23 **bit** prefix: that is, I care only about addresses matching the first 23 bytes: only these pass my filter, and the bytes to the left of that marker I do not.

Our sample here:

    11 00 01 00 . 10 10 10 00 . 00 10 10 10 . 10 00 10 10


I put a !! on bit 23 here

    base 10       196      .     168        .     42         .  138
    base 16       C0       .     A8         .     2A         .  8A
    base 2       1100 0100 .    1010 1000 .    0010 10!!10   . 1000 1010

Thus any address of `198.168.40.*` , (198.168.0010 !! 1000) , `198.168.41.*` ((198.168.0010 !! 1001), `198.168.42.*` ((198.168.0010 !! 1010), `198.168.43.*` ((198.168.0010 !! 1011), `198.168.44.*` ((198.168.0010 !! 1100) ... etc to `198.168.47.*` is matched by this CIDR block

# Book Recommendations

  * [TCP/IP Illustrated Vol 1: The Protocols](https://www.amazon.com/TCP-Illustrated-Protocols-Addison-Wesley-Professional-ebook/dp/B00666M52S/ref=as_li_ss_tl?keywords=TCP+stevens&qid=1555896412&s=books&sr=1-1&linkCode=ll1&tag=wilcodevelsol-20&linkId=c4bd05545265738515040768cb31c1ae&language=en_US)
  * [TCP/IP Illustated Vol 2: The Implementation](https://www.amazon.com/TCP-IP-Illustrated-Implementation-Vol-dp-020163354X/dp/020163354X/ref=as_li_ss_tl?_encoding=UTF8&me=&qid=1555896493&linkCode=ll1&tag=wilcodevelsol-20&linkId=62d54b786768a0abe5ab163a7691e0b1&language=en_US)
  * [Advanced Progamming in the Unix Environment](https://www.amazon.com/gp/product/0321637739/ref=as_li_ss_tl?ie=UTF8&linkCode=ll1&tag=wilcodevelsol-20&linkId=93f1e348175640241249d112ba254402&language=en_US)

