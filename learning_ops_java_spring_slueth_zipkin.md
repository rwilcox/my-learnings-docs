---
path: "/learnings/ops_java_spring_sluent_zipkin"
title: "Learnings: Ops: Java: Spring: Sluent / Zipkin"
---


FYI - on slueth...
1) you can config your spring boot app to have sleuth automatically inject span and trace ids OR you can control the generation and injection programmatically

2) you can control the names (which by default are randomly generated long ints convert to hex strings)

3) there is a REST api to read traces that have been recorded but it doesnt appear as if Sleuth has REST apis that can be used to start a trace, making using this solution difficult to utilize (not impossible) from the mobile app, there is no Sleuth iOS or Android APIs for starting/getting a trace either.
 

