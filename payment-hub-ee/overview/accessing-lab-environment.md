# Accessing Lab Environment

### Overview

The Mifos Mojaloop Lab Environment consists of a number of a different ways for various stakeholders to access and interact with Mojaloop and a core banking system, Mifos/Fineract, at both an API level and user interface level. Transactions can be initiated directly via API Calls in Postman, an attached simulator or through reference customer-facing mobile apps. 

The transactions that have been completed can be viewed in a number of ways - as reflected in the core banking system from the perspective of staff of the DFSP, as reflected in a customer-facing mobile wallet or mobile banking app, and from the operational interface for the Payment Hub EE .  

The Payment Hub provides both the gateway/integration layer with Mojaloop as well as a microservices workflow and orchestration engine. The Payment Hub is accessible via APIs or the operational UI. Access can be provided to the Zeebe engine which powers the Payment Hub, the Zeebe Operate UI would allow the configuration of new workflows which can be extended by building new connectors for other systems or new connectors for other payment systems to test routing transactions across different systems and networks outside of Mifos and/or Mojaloop, generating notifications, etc. 

Testing via third party and OTT API is also available via a set Open Banking APIs that are published through WS02 API Gateway and integration with the GSMA Mobile Money API.   


### Core Banking System - Mifos/Fineract

At the core banking system level, our lab environment consists of two generations of our core banking system being deployed:

* Fineract CN \(our next generation cloud-native microservices architecture that still only has limited functionality\) and
* Fineract 1.x \(a very mature and functionally robust core banking platform, especially at the loan level\). 

Both generations are accessible at an API level and via the user interface built on Angular. Multi-tenancy is leveraged so on the single instance of Fineract 1.x there are four separate Mifos X tenants set up and configured at the moment. New instances can be configured and deployed for each fintech participant if necessary. There are two tenants created on the Fineract CN instance. Tenants have been named with African wildlife names.   


This Google Sheet has full details on accessing all the Fineract instances but here are details for one of the medium tenants:

####  Gorilla Tenant

* **Gorilla Tenant API**: 
* **Gorilla Tenant Staff User Interface**: [http://gorilla.mifos.io:9002/?baseApiUrl=https://gorilla.mifos.io:8443&tenantIdentifier=tn06](http://gorilla.mifos.io:9002/?baseApiUrl=https://gorilla.mifos.io:8443&tenantIdentifier=tn06)
  * Credentials: mifos/password
  * Customer ID: InteropMerchant
  * Customer MSISDN: 27710306999

This is the interface a staff user would log into to view the transactions that have been reflected on the customer accounts of that DFSP.   


Documentation on the specific Fineract APIs is accessible at [https://docs.google.com/spreadsheets/d/1b8BRajrpNacFNEH6gGENDVWIGusLc0pGRd6MnKbqTKM/edit\#gid=476821922](https://docs.google.com/spreadsheets/d/1b8BRajrpNacFNEH6gGENDVWIGusLc0pGRd6MnKbqTKM/edit#gid=476821922)  


### Initiating Transactions 

Transactions via Mojaloop can be initiated in a number of ways.

####  Directly via API Calls through Postman

All of the Mojaloop APIs and Payment Hub EE APIs can be tested out across the various system endpoints within Postman. We have compiled these into a collection at &lt;INSERT LINK&gt;.   


#### Through ACE Fintech App via Open Banking APIs through WS02 API Gateway App

The Ace Fintech App is a Third Party Provider app that allows a user to log in, get consent from its DFSP to initiate transactions or view account information on its behalf via an Open Banking API. The credentials below are for a TPP, Ace Fintech, on behalf of a customer of the Gorilla Bank. 

The [log-in credentials and process](https://docs.google.com/spreadsheets/d/1b8BRajrpNacFNEH6gGENDVWIGusLc0pGRd6MnKbqTKM/edit#gid=481267967) are documented below. 

URL for Ace Fintech App: 

| Acefintech URL | [http://acefintech.mifos.io/](http://acefintech.mifos.io/) |  |
| :--- | :--- | :--- |
| App User credentials | tppuser | password |
| User credentials at the registered Gorilla Bank | gorillauser | GorillaUser |

First access the URL and then log in as the app user. Then click the more menu on the right and log with user credentials at Gorilla Bank to authorize consent \(OTP has been simulated through a checkbox\) to be able to initiate transactions.

Through the Ace Fintech app, one should now be able to initiate transfers via Mojaloop via an Open Banking API. 

####  Through MifosPay Mobile Wallet App

Mifos Pay is a reference mobile wallet application. Below is an APK to download and the log-in credentials for a self-service user which is a customer of the Leopard DFSP instance. 

* APK Download
* Credentials 

#### Through Mifos Mobile Mobile Banking App

Mifos Mobile is a reference mobile banking application. Below is an APK to download and the log-in credentials for a self-service user which is a customer of the Leopard DFSP instance.

* APK Download
* Credentials 

  
Mojaloop APIs are documented at:

Payment Hub APIs are documented at: https://mifos.gitbook.io/docs/payment-hub-ee/overview/payment-hub-apis  
Mojaloop API 

###  Viewing Transactions

#### View Transactions via Mifos X Web App \(Staff\)

Log in to the URL above and navigate to a customer and click the customer and then view account and view details of transactions. 

####  View Transactions via Payment Hub EE Operations App

This provides the DFSP a view into all transactions going through the switch that they're connected to. One can view and search incoming and outgoing transactions and incoming and outgoing requests to pay. 

* URL: [http://med-operations-ui.mifos.io/login](http://med-operations-ui.mifos.io/login)
* Gorilla Credentials: mifos/password/tn06

####  View Transactions via Mobile Apps \(Customer\)

Log into the respective apps and view transaction details or click into a specific account and then view transaction details. 

### Payment Hub EE

#### Configuring New Workflows 

New workflows routing transactions across different systems can be done through modifying the BPMN diagram and building/adding new connectors. Once the BPMN file is created in Zeebe Modeler, it needs to get deployed to the Zeebe cluster of the related environment.

#### Accessing Zeebe Operate

To access the Zeebe Operate UI in a Payment Hub EE instance, please follow the below instructions:

* Ensure you have Azure credentials to access the AKS Kubernetes environment
* Use the Azure CLI tools to set up kubernetes access on your local machine, with the following command (example shows the Large env configuration):
```
az aks get-credentials --resource-group dpc-large-dfsp --name large-dfsp
```
  and follow the instructions given by the tool. Once this is set up, you can reach the environment from your developer box using `kubectl` or a more sophisticated tool like `k9s` (see https://k9scli.io/)
* Port-forward the zeebe-operate Service's port `8080` to your local machine, using `kubectl` or `k9s`
* Access Zeebe Operate's local endpoint at http://localhost:8080/. The default credentials are `demo/demo`.
   
  
To access the user interface of the For fineract, highlight login urls, show APIs, this where pepl  
  
Payment Hub show   
Mojaloopday can initiate transactions via set of scripts, through these apps or could connect simulator, can them see balance reflected in UIs, show the APIs  
Can log into operations app to see transactions or can get access to zeebe, show the APIs for payment hub, can connect other systems, can connect other payment networks, can change the information that gets returned back.  
Initiating transactions, ace fintech app log in and request info or do transfer  
Show apk of other do app and log in and corresponding accounMobile wallet, mobile banking app, reference also having fintech app 

