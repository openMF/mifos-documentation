# Microservices orchestration - Zeebee

Opensource microservice orchestration engine, implemented in highly scalable, highly performant and fault tolerant way using state of the art, proven technology building blocks

* Using Raft protocol for consensus and replication
* Using RocksDB, an embeddable high performance key-value store, for its persistency
* All process instances are auditable, and audit records can be sent to Elasticsearch or Kafka
* Using an efficient, high performance binary protocol (gRPC) for the clients to connect and receive tasks for execution

|  **Benefits**                               | Description                                                                                                             |
| ------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| Workflow definition                         | BPMN 2.0, YAML - provides integrators with an easy to use tool to customize workflows                                   |
| Visual workflow representation              | Yes, BPMN workflows are both executable and have visual representation                                                  |
| State storage for active workflow instances | Stored on the machines running Zeebe using embedded RocksDB (no external storage required)                              |
| Scalability                                 | Horizontally scalable via partitions (no DB bottleneck)                                                                 |
| Fault tolerance                             | Yes, via replication factor (3 node, 1 can fail, or 5 node and 2 can fail)                                              |
| Supported programming languages             | Ships with Java and Go clients, plus NodeJS, C# and Ruby clients available, using gRPC for the clients                  |
| Historic workflow data                      | Can be streamed to storage systems via exporters (Elasticsearch and Apache Kafka is available). Complete auditable log. |

#### Important features

* Timers surviving node failures without interruption
* Correlation of incoming messages to existing workflow instances across the cluster nodes
* Capability to handle non correlating cases - important for cross payment hub engine flows
* Handle failover situation without interruption (3 nodes: 1 can fail, or 5 nodes: 2 can fail) - utilizing Raft protocol for consensus, hand over “leadership” in case failed nodes and replication of state

#### **Focus on system integrators**

* BPMN let implementation team focus on the business flow changes inside the given DFSP, making adoption and customization much easier
* Multi programming language support for component implementation, let implementation team to create the necessary connector components in any of the supported languages, the engine is able to orchestrate the steps. (e.g. multiple AMS integration is required), using gRPC protocol for efficient communication
* Connector components are stateless, easy and simple implementation
* No additional components required in the realtime engines, no databases to maintain, all active process states are stored in the embedded RocksDB data store. Auditlogs, and other events are stored in Kafka clusters before storing them
* Scalability - using partitioning (sharding), the system scales horizontally to create thousands of workflow instances per second
* Fault tolerance enables, that system recovers from a failure without data loss, and using replication to define the number of copies for all instances\
  In case of failures, “leader election” is taking place for the given partitions to continue operations uninterrupted (using Raft Consensus and Replication Protocol)
