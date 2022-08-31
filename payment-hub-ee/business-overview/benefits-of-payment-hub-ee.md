# Benefits of Payment Hub EE

The Payment Hub EE abstracts out the complexity of connecting directly to the APIs of an external payment system and provides a scalable and sophisticated orchestration layer powered by Zeebe to elegantly route payments and transactions across various microservices and APIs facilitating the flow of transactions amongst the core banking system, channel applications, and external payment systems.&#x20;

The operational control center provides an operational interface and analytics tools allowing a DFSP to effectively manage its participation in a real-time payment switch by having the ability to monitor and take action in real-time transactions flowing through system and being able to perform analysis and gain insight into these transactions.&#x20;

Its extensibility and open source license enables integrators and solution providers to build an enterprise-grade commercial integration solution.

### **Operational Control Center for DFSPs**

Payment Hub EE provides a full operational control center to enable DFSPs to effectively participate in a real-time payment system.&#x20;

* **Seamless & Easy to Use -** Payment Hub EE abstracts out the complexity of API integration drastically reducing the time for a DFSP to onboard onto a payment system**.**
* **Operational Control Center -** Payment Hub EE is much more than just a tool to connect to the system - it provides a full operation control center enabling the DFSP to monitor, analyze, and respond to payment transactions in real-time at both a business and technical level.

### **Scalable & Enterprise-Grade**&#x20;

Payment Hub EE was designed and architected to support DFSPs large and small, with a highly scalable and fault-tolerant architecture to support large DFSPs and full multitenancy to easily onboard and support multiple DFSPs in a shared environment. &#x20;

* **Flexible deployment options** - fully containerized, Payment Hub EE can be deployed on-premise or in the cloud of your choice.&#x20;
* **Different deployment scenarios**: depending on the size of the DFSP, Payment Hub EE can be deployed in three different configurations based on the level of availability, fault tolerance and the volume of transactions to be supported:
  * barebone - single instance of components, minimized resource usage, no loss of functionality
  * medium - single real-time engine
  * fully scaled - multiple real-time engines
* **Multi-tenant**: Payment Hub EE can be utilized by shared service providers offering services to multiple smaller DFSPs to spread out operational costs and leverage economies of scale. Using a multi-tenant core banking platform like Mifos, a single Payment Hub EE deployment could serve all the tenants, providing isolated audit logs for the different DFSPs served with separate user databases for the DFSP operators

### **Flexible & Extensible**

With the Zeebe workflow engine at its core and the ability to build different connectors for payments, core banking, and channels, there are a myriad of configurations of Payment Hub EE to support your operations.&#x20;

* **Core Banking System Agnostic** - While Payment Hub EE is built with a default account management system connector to Mifos/Fineract, it can connect to any core banking or account management system simply by building another connector.&#x20;
* **Flexible Payment Bridge** - likewise, while Payment Hub EE ships with a Mojaloop connector by default and was built to connect to Level One-Aligned payment systems, it can connect to any other payment system simply by building additional connectors such as SEPA, SWIFT, ISO 20022, or any mobile money API. As the community around Payment Hub EE grows, the list of available connectors will as well.&#x20;
* **Extensible Architecture -** Simply build additional connectors for your payments, core banking systems, or channel applications. Orchestrate these different microservices by creating new BPMN diagrams and Zeebe workers.&#x20;

### **Powerful Workflow Engine for Microservices Orchestration**

Payment Hub EE is built around Zeebe, a modern workflow engine for microservices orchestration built by Camunda. While you can orchestrate any end-to-end workflow across your payments, core banking systems, and channels, Zeebe can be used to orchestrate any microservices by creating additional workers and simply designing new BPMN workflow diagrams.&#x20;

Zeebe nicely documents the power of their workflow engine on the [_What is is Zeebe_](https://zeebe.io/what-is-zeebe/) section of their website but to summarize. Workflow engines are systems that manage business processes, monitoring the state of activities in a workflow and determining which new activity to transition to according to defined processes. Zeebe is a modern incarnation of this tool that solves the problem of microservices whereby a core tenant of the architecture is the separation of concern where each service is responsible for only one business capability. In such an architecture though, no one microservice is responsible for the end-to-end workflow. Additionally, the pure choreography pattern many microservices architectures follow for communication offers a high degree of flexibility but doesn’t provide visibility into the workflow nor failure handling.   Zeebe solves this problem by enabling one to:&#x20;

* Explicitly define and model workflows that span multiple microservices
* Gain detailed visibility into how a workflow is performing and understand where there are problems
* Orchestrate microservices that fulfill a defined workflow to ensure that all workflow instances are completed according to plan–even when there are issues along the way

### **Open Source**

Payment Hub EE is built and developed under a permissive open source license enabling commercial integrators to extend it with proprietary features and functionality while accessing a continually maintained and evolved core architecture from the open source community.&#x20;

* **Flexibility and Control -** DFSPs have full control over the Payment Hub EE and can extend it their requirements and are not locked into any one vendor the support their payment solutions.&#x20;
* **Commercially Deployable -** Commercial integrators can lower the overall cost of delivering and distributing a robust, enterprise grade tool but building on top of Payment Hub EE additional proprietary and region-specific features.&#x20;
* **Roadmap & Virtuous Cycle -** Everyone using and building on Payment Hub EE can benefit from the virtuous cycle of a global community collectively maintaining and contributing to Payment Hub EE. Roadmap will guide the community in implementing and incorporating new functionality and enhancements over time.&#x20;



****

\
