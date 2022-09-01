# Bulk Disbursement Integration

### Bulk Payment Design

* Provide scalable and fault tolerant design with easy integration
* Allow easy plugging with different payment types (Mojaloop, GSMA, Afrimoney and others)
* Enable reuse of existing BPMNs to facilitate transfers

#### Prioritizing New Use Cases

<table><thead><tr><th>Title</th><th>Sells Well</th><th>Drives Vol</th><th>Changes Market</th><th>Tech Diverse</th><th data-type="number">Index Score</th></tr></thead><tbody><tr><td></td><td></td><td></td><td></td><td></td><td>null</td></tr></tbody></table>

#### Staging the Payment

![](../../.gitbook/assets/bulk\_processor.png)

* Bulk processing is designed as a separate system within Payment Hub EE architecture supporting
* File integrity check with MD5/SHA256 checksum when received in channel connector
* Bulk processor
  * Parse CSV file
  * Order payments
  * Format data as per requirement
  * Publish to Kafka payment topic
* Workflow Initiator
  * Pull messages from Kafka payments topic
  * Format data based on payment connector requirements
  * Initiate payment type-specific workflows

#### Configurations

To provide a granular level of control, the bulk processor supports multiple configurations for different stages like ordering, formatting, splitting etc.

* partylookup.enable: used to enable or disable the partylookup stage
* approval.enable: used to enable or disable the approval stage
* ordering.enable: used to enable or disable the ordering of transactions in a data set based on a field provided.
* ordering.field: the field based on which ordering will be done.
* formatting.enable: enable or disable the formatting of data set. If formatting is disabled the default formatting standard is used.
* formatting.standard: the formatting standard to be used for transactions, possible values are "DEFAULT", "GSMA".
* splitting.enable: enable or disable the splitting of the original csv file into sub-batches. Splitting is done on the sub-batch-size field configuration.&#x20;
* splitting.sub-batch-size: the size of the single sub batch.
* mergeback.enable: enable or disable the merging back of the sub batches result.
* success-threshold-check.enable: enable or disable the success threshold check, use this configuration to make sure at least x percentage of transaction is successful in a batch.
* success-threshold-check.success-rate: a percentage value that will be used while making the threshold check.

**Key Considerations:**

* Kafka provides auto partitioning within topics based on throughput and data
* Scalable and fault-tolerant system provided by the multi-cluster setup
* Handle backpressure from Zeebe and throttle workflow initiation
  * Kafka will act as a buffer in this case
* Advantageous when Zeebe is overloaded
  * Due to resource limitations
  * Or not fast enough scaling
* Reduces cascading Denial of Service for other payment connectors.
* Provide a visual workflow representation with Zeebe
* Stores every state for workflow instances
* Timers surviving node failures without interruptions
* Using an efficient, high-performance binary protocol (gRPC) for the clients to connect and receive tasks for execution
* Retry mechanism on the entire subprocess
  * But retry is already in place within subprocesses
* Unified payment architecture
* Easy integration with AMS if payment staging requires it
  * In case of beneficiary creation during transfer
* Using Raft for log replication
  * Kafka to write ahead log replication as well.
* Easy integration of pre and post-transaction workers
  * Such as bulk notification

#### References:

[https://forum.camunda.io/t/zeebe-usecase-architecture-question/1168/6](https://forum.camunda.io/t/zeebe-usecase-architecture-question/1168/6)

[https://stage.docs.zeebe.io/reference/grpc.html#error-handling](https://stage.docs.zeebe.io/reference/grpc.html#error-handling)

[https://docs.camunda.io/docs/product-manuals/zeebe/deployment-guide/operations/backpressure/](https://docs.camunda.io/docs/product-manuals/zeebe/deployment-guide/operations/backpressure/)

[https://stage.docs.zeebe.io/bpmn-workflows/multi-instance/multi-instance.html](https://stage.docs.zeebe.io/bpmn-workflows/multi-instance/multi-instance.html)

[https://camunda.com/blog/2019/08/zeebe-horizontal-scalability/](https://camunda.com/blog/2019/08/zeebe-horizontal-scalability/)

[https://docs.camunda.io/docs/0.25/product-manuals/zeebe/bpmn-workflows/embedded-subprocesses/embedded-subprocesses/](https://docs.camunda.io/docs/0.25/product-manuals/zeebe/bpmn-workflows/embedded-subprocesses/embedded-subprocesses/)

[https://docs.camunda.io/docs/0.25/product-manuals/zeebe/bpmn-workflows/event-subprocesses/event-subprocesses](https://docs.camunda.io/docs/0.25/product-manuals/zeebe/bpmn-workflows/event-subprocesses/event-subprocesses)

[https://medium.com/@jayphelps/backpressure-explained-the-flow-of-data-through-software-2350b3e77ce7](https://medium.com/@jayphelps/backpressure-explained-the-flow-of-data-through-software-2350b3e77ce7)

## API Specification

* Provide developer friendly consumer APIs
* Enable easy integration by abstracting underlying payment type API complexities
* Group common fields across various payment APIs and make em mandatory field
  * All fields in the spec below are mandatory fields
* Allow addition of payment type specific fields as optional





### 1. Bulk Transfer

Use below csv file for refernece.

```csv
id,request_id,payment_mode,payer_identifier_type,payer_identifier,payee_identifier_type,payee_identifier,amount,currency,note
0,f1e22fe3-9740-4fba-97b6-78f43bfa7f2f,slcb,accountNumber,003001003874120160,accountNumber,927549027483,850,USD,Test Payee Payment
1,72aa3ea4-e6f6-4880-877f-39f6ac4d052e,slcb,accountNumber,003001003873110196,accountNumber,927549027483,222,USD,Test Payee Payment
2,f1e22fe3-9740-4fba-97b6-78f43bfa7f2f,slcb,accountNumber,003001003874120160,accountNumber,927549027483,850,USD,Test Payee Payment
3,72aa3ea4-e6f6-4880-877f-39f6ac4d052e,slcb,accountNumber,003001003873110196,accountNumber,927549027483,222,USD,Test Payee Payment
4,f1e22fe3-9740-4fba-97b6-78f43bfa7f2f,mojaloop,accountNumber,003001003874120160,mosip,437892675228,850,USD,Test Payee Payment
5,72aa3ea4-e6f6-4880-877f-39f6ac4d052e,mojaloop,accountNumber,003001003873110196,mosip,437892675228,222,USD,Test Payee Payment
6,f1e22fe3-9740-4fba-97b6-78f43bfa7f2f,mojaloop,accountNumber,003001003874120160,mosip,437892675228,850,USD,Test Payee Payment
7,72aa3ea4-e6f6-4880-877f-39f6ac4d052e,mojaloop,accountNumber,003001003873110196,mosip,437892675228,222,USD,Test Payee Payment
8,f1e22fe3-9740-4fba-97b6-78f43bfa7f2f,gsma,accountNumber,003001003874120160,msisdn,8837461856,850,USD,Test Payee Payment
9,72aa3ea4-e6f6-4880-877f-39f6ac4d052e,gsma,accountNumber,003001003873110196,msisdn,8837461856,222,USD,Test Payee Payment
10,f1e22fe3-9740-4fba-97b6-78f43bfa7f2f,gsma,accountNumber,003001003874120160,msisdn,8837461856,850,USD,Test Payee Payment
11,72aa3ea4-e6f6-4880-877f-39f6ac4d052e,gsma,accountNumber,003001003873110196,msisdn,8837461856,222,USD,Test Payee Payment
```

```bash
curl --location --request POST 'https://bulk-connector.sandbox.fynarfin.io/bulk/transfer/3a4dfab5-0f4f-4e78-b6b5-1aff3859d4e8/ph-ee-bulk-demo-6.csv' \
--header 'Platform-TenantId: ibank-usa' \
--form 'data=@"ph-ee-bulk-demo-6.csv"'
```

```json
{
    "batch_id": "738bd830-3bd9-4511-bb42-3d0f5798e014",
    "request_id": "3a4dfab5-0f4f-4e78-b6b5-1aff3859d4e8",
    "status": "queued"
}
```

### 2. Bulk Transfer Status

```bash
curl --location --request GET 'https://ops-bk.sandbox.fynarfin.io/api/v1/batch?batchId=3112a0ba-0733-4133-ae24-fc3310cb7dfe' \
--header 'Platform-TenantId: ibank-usa' \
--header 'Authorization: Bearer token'
```

```json
  "batch_id": "UUID",
	"request_id": "UUID",
	"notes": "Bulk transfers",
  "status": "processing",
  "mode": "{payment_mode}",
  "purpose": "refund",
  "total": 1000,
	"successful": 980,
	"failed": 20,
	"file": "S3 link", // Based on detailed boolean passed in req param
  "created_at": 1545383037
}
```

### 3. Batch Details

```bash
curl --location --request GET 'https://ops-bk.sandbox.fynarfin.io/api/v1/batch/detail?batchId=45e2baca-b087-4d90-8392-da2961f9b9ed&pageNo=1&pageSize=10' \
--header 'Accept-Language: en-US,en;q=0.5' \
--header 'Platform-TenantId: ibank-usa' \
--header 'Authorization: Bearer token'
```

```json
[
    {
        "id": 568,
        "workflowInstanceKey": 2251799907439003,
        "transactionId": "e5eea064-1445-4d32-bc55-bd9826c779a0",
        "startedAt": 1629130966000,
        "completedAt": 1629130967000,
        "status": "IN_PROGRESS",
        "statusDetail": null,
        "payeeDfspId": "ibank-india",
        "payeePartyId": "919900878571",
        "payeePartyIdType": "MSISDN",
        "payeeFee": null,
        "payeeFeeCurrency": null,
        "payeeQuoteCode": null,
        "payerDfspId": "ibank-usa",
        "payerPartyId": "7543010",
        "payerPartyIdType": "MSISDN",
        "payerFee": null,
        "payerFeeCurrency": null,
        "payerQuoteCode": null,
        "amount": 448,
        "currency": "USD",
        "direction": "OUTGOING",
        "errorInformation": "{\\\"errorInformation\\\":{\\\"errorDescription\\\":\\\"Invalid responseCode 500 for transfer on PAYER side, transactionId: e5eea064-1445-4d32-bc55-bd9826c779a0 Message: {\\\\\\\"timestamp\\\\\\\":1629130966891,\\\\\\\"status\\\\\\\":500,\\\\\\\"error\\\\\\\":\\\\\\\"Internal Server Error\\\\\\\",\\\\\\\"message\\\\\\\":\\\\\\\"\\\\\\\",\\\\\\\"path\\\\\\\":\\\\\\\"/fineract-provider/api/v1/interoperation/transfers\\\\\\\"}\\\",\\\"errorCode\\\":\\\"4101\\\"}}",
        "batchId": "c02a14f0-5e7e-44a1-88eb-5584a21e6f28"
    }
]
```

## Payment Routing

* Route enables user to split payments received and transfer the funds to various vendors/beneficiaries.
* Sample request body

```json
{
  "amount": 2000,
  "currency": "INR",
  "transfers": [
    {
      "account": "acc_CPRsN1LkFccllA",
      "amount": 1000,
      "currency": "INR",
      "notes": {
        "branch": "Acme Corp Bangalore North",
        "name": "Gaurav Kumar"
      },
    },
    {
      "account": "acc_CNo3jSI8OkFJJJ",
      "amount": 1000,
      "currency": "INR",
      "notes": {
        "branch": "Acme Corp Bangalore South",
        "name": "Saurav Kumar"
      },
    }
  ]
}
```



* With Auto Payout
  * Targeting individuals
  * Money is transferred directly to bank accounts / mobile money wallets from the sender float account.
  * No involvement of AMS.
*   Without Auto Payout

    * Targeting organisations
    * Money is transferred to Fineract wallets of the receivers.
    * Receiver can choose if they want to withdraw the money out of the wallet
    * Or consider using the money in float/current/checking account for L2 beneficiaries (clear invoices, payroll) seamlessly in one platform (L1 beneficiary amount remains in closed loop)
    * This provides an advantage to beneficiary orgs to manage their payouts if they have a legacy current/checking account with mostly manual payout processing.

