# Target Users of Payment Hub EE

Payment Hub EE is primarily intended for DFSPs to connect to and effectively participate in L1-aligned payment systems like Mojaloop. It provides an open source production-ready tool to directly connect to Mojaloop. 

Likewise shared service providers, aggregators, and integrators providing core banking services and/or Mojaloop integration services will be a key user as they can leverage the multi-tenancy and scalability of the Payment Hub to provide a connection to multiple DFSPs.

## Current Mojaloop Use Cases Supported

With the Mojaloop connector that ships with Payment Hub EE, the following use cases are supported:

* Peer to Peer Transfer via MSISDN
* Merchant Proximity Payment via QR Code 
* Merchant Request to Pay \(Payee-initiated transfer\)
* Registration of Secondary Identifier to an Account
* Operation UI Monitoring and Actions
  * Incoming and outgoing transfers
  * Incoming and outgoing request to pay
  * Secondary identifier registration
  * Refund of incoming transfer
  * Manual Override



## How is Payment Hub EE Currently Being Used

### **Connection for GSMA mobile money APIs**

Point of Integration with Mobile Money API for real-time synchronization with mobile money transactions. Work is underway to integrate with the GSMA mobile money API standard as a reference implementation to support real-time synchronization of mobile money transactions affecting loan and savings accounts and Fineract and facilitate being able to initiate transactions via mobile money from the Mifos web and mobile interfaces. Integration with this standard OTT API for mobile money will serve as the blueprint for other mobile money connectors. 

* Efforts are underway in the community to build Payment Hub EE connectors for MTN Uganda and Safaricom/M-Pesa in Kenya. ****

### **Connection to other Real-time Payment Systems**

A number of partners are working on deploying the payment hub to provide a seamless point of integration with their local real-time payments system by building an additional connector into the Payment Hub EE. In Mexico, efforts are ongoing to build a connector to SPEI. Partners in Canada are exploring building an Interac connector and partners in Europe are exploring building a SEPA connector. Connection to other real-time payment systems like SEPA, SPEI, etc.



##  

