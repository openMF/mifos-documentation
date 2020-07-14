# Deployment models

Deploying the Payment Hub can be On-premises or any of the cloud providers, depending on the client requirements and regulations in the given jurisdiction.

The Payment Hub is designed in a fashion, where even a single deployment could become a shared service serving multiple DFSPs run by an aggregator \(multiple SACCOs, credit unions on a multitenant setup\).

Depending on the scale, expected throughput, fault tolerance, high availability requirements we are suggesting three different type of deployments for the Payment Hub.

* barebone - single instance of components, minimised resource usage, no loss of functionality 
* medium - single realtime engine 
* fully scaled - multiple realtime engines 

## Barebone deployment



![Barebone deployment](https://lh5.googleusercontent.com/nNo1VE5BPyr5o5CyNT-OExdrAD7vbzO_FEifnD7y-cRd9L2MGAKbK0jMQppb6flJc0vaPnVGF4Ovc_XX20ZSU8t8BDyQc1abyoB18X8GRwbUeLS8GwdBKEB_PFAJVLhcdbwttRXFEK4)

## Medium deployment

Single kubernetes cluster to contain all the necessary components 

Fault tolerance provided by the clustered components 

Stretched installation across data centers possible, but not ideal

![Medium deployment](https://lh4.googleusercontent.com/OG277n1F7I6YQv9pusN62_sRuxSExtjAIAqLtnt8lYDfYHaHI1UaWiU1qqxDLolZ6SCAo_IGuzRzD4tu6fcY_4Dz9c9NoF-CoXzGOukUVHIOZ7CFrLr24S7l9XwIxKZmyCPa3Ec6tbs)

## Full scale - large deployment

Multiple independent payment engines \(a single engine is collocated for performance\), enabling complete version upgrades without service interruptions 

Running in different data centers on independent network connections \(high availability, fault tolerant even in case of disaster scenarios\) 

Partitioning the load across the engines

![Fully scaled version for large environments](https://lh6.googleusercontent.com/2nCgoDSZSv3QOJbuDfQDPLUA2aYYS8YhJE0iFQNSsel_WWtA0_9O248yT4Afx7t9qX7mRfNO6EPXOgBUutNmOo2yjmi2eyKkoMReF40QcK3r2Lg5gmn7Xw6gIdK_ynnbvD-pn1gug3U)

