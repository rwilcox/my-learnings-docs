---
path: "/learnings/ops_kubernetes"
title: "Learnings: Ops: Kubernetes"
---

# Difference between Liviness and Readiness checks

https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-probes/

K8S
Readiness Probe Fails
Stops Routing traffic to the pod
Liveness Probe fails
Kubernetes restarts the failed container
Readiness probe succeeds
Kubernetes starts routing traffic to the pod again

So when is the pod ready for traffic from MS perspective?  That should be Readiness Probe Configuration so this means any external connections needed are made etc 
Liveness lets us know if app is alive or dead.  App could be booted but not ready for traffic

These should be off the separate channel off the main thread (but observing the traffic thread(s) somehow cleverly in the case of readiness)

## See also

  * https://github.com/rwilcox/k8_spring_actuators

# See also

  * Learning_Ops_Java_Docker
  * Learning_Ops_Java_Docker_JMX_Considerations
  * 