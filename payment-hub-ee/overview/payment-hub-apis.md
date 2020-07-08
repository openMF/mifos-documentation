---
description: >-
  The description of the payment hub APIs to initiate payment, query payment
  details, register MSISDN, initiate request to pay.
---

# Payment Hub APIs

**Initiate Payment** \
Payer sends amount of money to payee.
```text
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
```

**Query Payment Details** \
Check the details of an ongoing transfer, not the details of a transaction request.
```text
Url: http://{environment-channel-connector-domain}/channel/transfer/{transactionId}
Method: GET
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
```

**Initiate Request To Pay** \
Payee asks payer to send amount of money. (currently without confirmation and authorization)
```text
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
```

**Register Secondary Identifier** \
The secondary identifier will be registered to the account in FineractX(FineractCN not yet implemented), if it is connected to anoter account then it will be re-registered for the new account. It will be also registered in the Oracle system used by Mojaloop to lookup parties, same re-registration is used here.
```text
Url: http://{environment-channel-connector-domain}/channel/partyRegistration
Method: POST
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
  Content-Type: application/json
Body:
{
  "accountId":"9062b90de19b43989005",
  "idType": "EMAIL",
  "idValue": "test@test.hu"
}
```

