# Account and Transaction API Specification - v3.1.2

**Scope:** accounts\
**Swagger definition:** [https://raw.githubusercontent.com/OpenBankingUK/read-write-api-specs/v3.1.2/dist/account-info-swagger.yaml](https://raw.githubusercontent.com/OpenBankingUK/read-write-api-specs/v3.1.2-RC1/dist/account-info-swagger.yaml)\
**OpenBanking documentation: **[https://openbanking.atlassian.net/wiki/spaces/DZ/pages/1077805296/Account+and+Transaction+API+Specification+-+v3.1.2](https://openbanking.atlassian.net/wiki/spaces/DZ/pages/1077805296/Account+and+Transaction+API+Specification+-+v3.1.2)

**Implement section**

| Field               | Value                                                                            |
| ------------------- | -------------------------------------------------------------------------------- |
| Endpoint production | [http://lion.mlabs.dpc.hu/apischema/ob/](http://lion.mlabs.dpc.hu/apischema/ob/) |

**Manage section**\
_**Resources group**_

Add accounts scope

| Field       | Value             |
| ----------- | ----------------- |
| Scope Key   | accounts          |
| Scope Name  | accounts          |
| Role        | Internal/everyone |
| Description | (empty)           |

**Setup API calls**

After you add scope "accounts", you must set "accounts" scope to all API entry.\
You must modify "Caller type" to "Application" the following API entries:

* /account-access-consents
* /account-access-consents/{ConsentId}
* /account-access-consents/{ConsentId}

The remain API entries still "Application & Application User".

