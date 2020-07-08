---
description: >-
  List of repositories where PaymentHubEE source code, and the related Fineract
  1.x and CN changes are located
---

# Source Code repositories

The Payment Hub EE uses a microservice architecture where each microservice is self-contained and use its own git repository. Despite the larger number of repositories involved, the payment hub can still be deployed as a single component using the Helm charts as described in the installation instructions in detail.

The list of the Payment Hub EE repositories:  
[https://github.com/openMF?q=ph-ee](https://github.com/openMF?q=ph-ee&type=&language=)

| Repo | Description |
| :--- | :--- |
| [ph-ee-connector-common](https://github.com/openMF/ph-ee-connector-common) | Shared artifacts/ common code between Java-based connectors. |
| [ph-ee-connector-channel](https://github.com/openMF/ph-ee-connector-channel) | Channel connector microservice |
| [ph-ee-exporter](https://github.com/openMF/ph-ee-exporter) | Zeebe exporter component which sends all data to Kafka |
| [ph-ee-operations-app](https://github.com/openMF/ph-ee-operations-app) | Operations web application backend |
| [ph-ee-operations-web](https://github.com/openMF/ph-ee-operations-web) | Operations web application frontend |
| [ph-ee-env-template](https://github.com/openMF/ph-ee-env-template) | Environment templates for payment hub-ee |
| [ph-ee-env-labs](https://github.com/openMF/ph-ee-env-labs) | Configurations of Lab Environment, BPMN flows, and Helm Charts |
| [ph-ee-importer-es](https://github.com/openMF/ph-ee-importer-es) | Microservice consuming Kafka and sends all Zeebe-related data to ES |
| [ph-ee-importer-rdbms](https://github.com/openMF/ph-ee-importer-rdbms) | Microservice consuming Kafka and feeding the off-site RDMS with business data of the flows |
| [ph-ee-identity-provider](https://github.com/openMF/ph-ee-identity-provider) | Identity provider microservice |
| [ph-ee-connector-ams-mifos](https://github.com/openMF/ph-ee-connector-ams-mifos) | Account Management System connector microservice for Mifos |
| [ph-ee-connector-mojaloop-java](https://github.com/openMF/ph-ee-connector-mojaloop-java) | Mojaloop connector microservice |
| [https://github.com/apache/fineract](https://github.com/apache/fineract) | Fineract 1.x repository, currently release 1.2 is deployed in PHEE environments |
| [https://github.com/apache/fineract-cn-interoperation](https://github.com/apache/fineract-cn-interoperation) | Fineract CN interoperability micro service |

