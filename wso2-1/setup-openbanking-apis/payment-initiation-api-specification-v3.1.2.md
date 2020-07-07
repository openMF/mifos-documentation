# Payment Initiation API Specification - v3.1.2

**Scope:** payments  
**Swagger definition:** [https://raw.githubusercontent.com/OpenBankingUK/read-write-api-specs/v3.1.2/dist/payment-initiation-swagger.yaml](https://raw.githubusercontent.com/OpenBankingUK/read-write-api-specs/v3.1.2-RC1/dist/payment-initiation-swagger.yaml)  
**OpenBanking documentation:** [https://openbanking.atlassian.net/wiki/spaces/DZ/pages/1077805296/Account+and+Transaction+API+Specification+-+v3.1.2](https://openbanking.atlassian.net/wiki/spaces/DZ/pages/1077805743/Payment+Initiation+API+Specification+-+v3.1.2)

**Implement section**

| Field | Value |
| :--- | :--- |
| Endpoint production | [http://lion.mlabs.dpc.hu/apischema/ob/](http://lion.mlabs.dpc.hu/apischema/ob/) |

**Manage section**  
_**Resources group**_

Add accounts scope

| Field | Value |
| :--- | :--- |
| Scope Key | payments |
| Scope Name | payments |
| Role | Internal/everyone |
| Description | \(empty\) |

**Setup API calls**

After you add scope "payments", you must set "payments" scope to all API entry.  
You must modify "Caller type" to "Application" the following API entries:

* /domestic-payment-consents
* /domestic-payment-consents/{ConsentId}
* /domestic-payments/{DomesticPaymentId}

You must modify "Caller type" to "Application User" the following API entries:

* /domestic-payment-consents/{ConsentId}/funds-confirmation

The remain API entries still "Application & Application User".



