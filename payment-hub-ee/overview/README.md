---
description: >-
  Information on the concept and implementation of the Payment Hub Enterprise
  Edition
---

# Payment Hub EE Overview

In this section, we'll provide an overview of the Payment Hub EE - the business requirements it supports, the architecture it's built on and the current status of the code.

## Overview

The Payment Hub is a self contained application to enable a financial institution \(DFSP - digital financial service provider\) to integrate its various core banking systems \(AMS - account management system\), its banking channels, where customers initiate payment transactions and the various payment schemas that funds could be transferred.

### Purpose

Enable DFSPs running various core banking platforms to rapidly connect to the Mojaloop or other payment schemas with a fully auditable manner, where their payment operators will have access to their own records and mechanism for investigation and interaction with transactions.

### Design

![Logical Model of the Payment Hub](https://lh6.googleusercontent.com/Xdp2YHrqxBzjeu--jfxkK3ns-gLtpNcOJ6rpwtQe1Xw0h6IRG5HmDbEESvLnUspZ4IYJyKWogu0ELDkjRK79eh9QQpBGAYskdpJ-M4d76hQUDnINfFwfxDHu59CWG39oR1bRNtM8Zj8)



![The role of the Payment Hub EE at a DFSP](https://lh5.googleusercontent.com/RXlgz3ImVMzEIMk0qAG31YkiN0Gswi6HikHMKfGQ5EKyHKAf30ZwWzmsNoTepPDGGmRLi_vgq65r1N_aSzvca0hwoTwaJDDFTfsPwNywO0K7HViFv2zJD9lTybCg9gHOSkmDqTzRB0s)

### Architecture

#### Key architectural considerations

* Running on on-premises and cloud infrastructures, utilising Kubernetes
* Separate real-time engine and operations backend systems
* The Payment Realtime Engine is self contained, highly available and fault tolerant, can handle complete transaction flows
* Orchestrating the microservices are desired
  * handling timeouts
  * correlations of asynchronous events
  * handling error and exception scenarios with the necessary compensations
  * overview of in-flight transactions
* A Payment Realtime Engine manages the state machine using a microservice orchestration layer
  * Using Raft for consensus and log replication
  * Using RocksDB for key-value store of states
  * Does not use external NoSQL or Relational DB, which hinders scalability
* One engine is bounded to a single data center, for high performance, low latency and minimizing issues from network failure scenarios
* Multiple realtime engines could run parallel and independent
  * Protect against complete site failure
  * 24x7, 99.99+% availability operations require version upgrades, certificate changes, hardware replacement, … without interruption of the service
  * If payment network supports the notion of independent engines at a single DFSP, than routing could happen at the Switch, otherwise, the Payment Hub realtime engines could hand over the callbacks amongst each-other internally
* Systems for backoffice operations, including long term storage database, audit logging, monitoring, reconciliation - detached in a separate cluster
  * These components could be offline without any payment service interruption and data loss - the realtime engines Kafka layer keeps the records
  * “Operations systems” are not performance critical
  * Backoffice user access allowed only to these components, not the realtime engines

#### Internal structure of the Payment Hub EE

* Process orchestration by Zeebe 
* Mojaloop connector 
* Channel connector 
* AMS connector 
* Audit Streamer 
* Operations Streamer 
* Operations App 
* Operations Frontend

![Payment Hub EE internal structure](https://lh3.googleusercontent.com/5soKMo53ewvbIRHzclMjUWgR8LGD_jwAjRnNbgy1h84MxzBJXpQMWr_LfAX6jhTAV2GzARdGEXBptcZpc7A6oPhAX_5CBwpKzOoL-L6F7qJ9A55F7aBthcn6S83XpFp7qrZaWOrh_5w)

