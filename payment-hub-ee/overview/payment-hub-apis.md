---
description: >-
  The description of the payment hub APIs to initiate payment, query payment
  details, register MSISDN, initiate request to pay.
---

# Payment Hub APIs

**Initiate Payment**

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

**Query Payment Details**

```text
Url: http://{environment-channel-connector-domain}/channel/transfer/{transactionId}
Method: GET
Headers:
  Platform-TenantId: {configured-tenantId-in-channel-connector}
```

**Initiate Request To Pay**

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

**Register Secondary Identifier**

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

