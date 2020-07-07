---
description: >-
  The description of the payment hub APIs to initiate payment, query payment details, register MSISDN,
  initiate request to pay.
---

# Payment Hub APIs

__Initiate Payment__ \
http://{environment-channel-connector-domain}/channel/transfer \
Headers: \
Platform-TenantId: {configured-tenantId-in-channel-connector} \
Content-Type: application/json \
\
{ \
	"payer": { \
		"partyIdInfo": { \
			"partyIdType": "MSISDN", \
			"partyIdentifier": "27710101999" \
		} \
	}, \
	"payee": { \
		"partyIdInfo": { \
			"partyIdType": "MSISDN", \
			"partyIdentifier": "27710102999" \
		} \
	}, \
	"amount": { \
		"amount": 230, \
		"currency": "TZS" \
	} \
} \
\
__Query Payment Details__ \
http://{environment-channel-connector-domain}/channel/transfer/{transactionId} \
Headers: \
Platform-TenantId: {configured-tenantId-in-channel-connector} \
\
__Initiate Request To Pay__ \
http://{environment-channel-connector-domain}/channel/transactionRequest \
Headers: \
Platform-TenantId: {configured-tenantId-in-channel-connector} \
Content-Type: application/json \
\
{ \
	"payer": { \
		"partyIdInfo": { \
			"partyIdType": "MSISDN", \
			"partyIdentifier": "27710203999" \
		} \
	}, \
	"payee": { \
		"partyIdInfo": { \
			"partyIdType": "MSISDN", \
			"partyIdentifier": "27710305999" \
		} \
	}, \
	"amount": { \
		"amount": 77, \
		"currency": "TZS" \
	} \
} \
\
__Register Secondary Identifier__ \
http://{environment-channel-connector-domain}/channel/partyRegistration \
Headers: \
Platform-TenantId: {configured-tenantId-in-channel-connector} \
Content-Type: application/json \
\
{ \
	"accountId":"9062b90de19b43989005", \
  "idType": "EMAIL", \
  "idValue": "test@test.hu" \
}
