---
path: "/learnings/ops_networking"
title: "Learnings: Ops: Networking"
---

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