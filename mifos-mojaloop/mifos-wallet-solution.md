# Mifos Wallet Solution

The Mifos Wallet Solution makes use of fineract1.x as the core back end banking system with the Mifos User Interface(s) for operations and consumer interactions.

As of Sept 9th, 2020, *Fineract1.4* (a derivative of the MifosX code contributed to apache foundation) sourcecode is available here --> https://github.com/apache/fineract/tree/1.4.0.  Demo servers are also available, please seek assistance via the mifos.slack.com channel. Fineract is a core banking system, with APIs that cover accounts, transactions, customers, products, interest schemes, cron jobs, users, authentiction, etc.  

The *Mifos PaymentHubEE* is used to connect to Mojaloop (payments switch) for inbound and outbound transactions. The PaymentsHubEE implements the mojaloop API and maps to the fineract API.  See [payment-hub-ee] for more info. 

The Mifos Wallet App connects via a WSO2 api.  This is under development and appropriate for prototyping. Again, contact the mifos.slack.com channel for access and configuration. Sourcecode is available here: 

The API gateway built on WSO2 allows for new channel development on top of the PaymentHubEE.  




Diagram:

