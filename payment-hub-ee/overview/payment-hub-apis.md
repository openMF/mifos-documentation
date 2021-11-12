---
description: >-
  The description of the payment hub APIs to initiate payment, query payment
  details, register MSISDN, initiate request to pay.
---

# Payment Hub APIs

### SwaggerHub Links

{% embed url="https://app.swaggerhub.com/apis/rrkas/open-g_2_p_erp/1.0" %}
OpenG2P APIs
{% endembed %}

{% embed url="https://app.swaggerhub.com/apis/myapi943/payment-hub_ap_is/1.0" %}
Payment Hub APIs
{% endembed %}

{% embed url="https://app.swaggerhub.com/apis/rrkas/mobile-money_simulator_api/1.0" %}
Mobile Money Simulator APIs
{% endembed %}

{% embed url="https://app.swaggerhub.com/apis/rrkas/fineract/1.0" %}
Fineract APIs
{% endembed %}

Configured domain for channel-connectors:

* barebone: -
* medium: med-connector-channel.mifos.io
* large: large-connector-channel.mifos.io

Configured tenants in lab environments:

* barebone: tn03, tn04
* medium: tn05, tn06
* large: tn01

**Initiate Payment** Payer sends amount of money to payee.

```
Url: http://{environment-channel-connector-domain}/channel/transfer
Method: POST
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
  Content-Type: application/json
Body:
{
    "payer": {
        "partyIdInfo": {
            "partyIdType": "MSISDN",
            "partyIdentifier": "27710101999"
        }
    },
    "payee": {
        "partyIdInfo": {
            "partyIdType": "MSISDN",
            "partyIdentifier": "27710102999"
        }
    },
    "amount": {
        "amount": 230,
        "currency": "TZS"
    }
}
Response:
{
    "transactionId":"84b34cfc-15ee-4646-902b-d92152028200"
}
```

**Query Payment Details** Check the details of an ongoing transfer, not the details of a transaction request.

```
Url: http://{environment-channel-connector-domain}/channel/transfer/{transactionId}
Method: GET
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
Response:
{
    "clientRefId": "000000", -- possibly unknown client started it because it is not a required field in the request
    "completedTimestamp": "2020-07-06T18:58:46.883", -- possibly null field in case of not yet completed transfer
    "transactionId" : "84b34cfc-15ee-4646-902b-d92152028200",
    "transferState" : "RECEIVED",
    "transferId" : "b155e298-dd7f-4199-9636-fa5ebec2bc58" -- possibly null field, transfer code only captured after transfer sent
}
```

**Initiate Request To Pay** Payee asks payer to send amount of money. (currently without confirmation and authorization) The receiving DFSP(payee) of this request will be target of the transfer from the payer.

```
Url: http://{environment-channel-connector-domain}/channel/transactionRequest
Method: POST
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
  Content-Type: application/json
Body:
{
    "payer": {
        "partyIdInfo": {
            "partyIdType": "MSISDN",
            "partyIdentifier": "27710203999"
        }
    },
    "payee": {
        "partyIdInfo": {
            "partyIdType": "MSISDN",
            "partyIdentifier": "27710305999"
        }
    },
    "amount": {
        "amount": 77,
        "currency": "TZS"
    }
}
Response:
{
    "transactionId":"84b34cfc-15ee-4646-902b-d92152028200"
}
```

**Register Secondary(Interoperation) Identifier** The secondary identifier will be registered to the account in FineractX or FineractCN, if it is connected to another account then it will be re-registered for the new account. It will be also registered in the Oracle system used by Mojaloop to lookup parties, same re-registration is used here.

```
Url: http://{environment-channel-connector-domain}/channel/partyRegistration
Method: POST
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
  Content-Type: application/json
Body:
{
  "accountId":"9062b90de19b43989005", -- real savings account number, not external interoperation identifier
  "idType": "EMAIL",
  "idValue": "test@test.hu"
}
Response: empty
```

