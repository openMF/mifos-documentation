# How to import swagger file to API store

#### Login API publisher [https://api.lion.mlabs.dpc.hu:9443/publisher](https://api.lion.mlabs.dpc.hu:9443/publisher/site/pages/login.jag?requestedPage=/publisher/)

![API Publisher login page](../../.gitbook/assets/screenshot-from-2019-08-07-13-05-30.png)

#### Add new API

![Click to &quot;ADD NEW API&quot;](../../.gitbook/assets/screenshot-from-2019-08-07-13-07-12.png)

#### Choose "I Have an Existing API"

![](../../.gitbook/assets/screenshot-from-2019-08-07-13-11-28.png)

Select "Swagger File" option and browse the required Swagger YAML file.  
After click "Start Creating" button.

#### WSO2 import and parsing Swagger file, after show the next screen.

![Design API screen after import Swagger file](../../.gitbook/assets/fireshot-capture-001-api-publisher-add-rest-api-api.lion.mlabs.dpc.hu.png)

Unfortunately the "Name" field doesn't contains space. You must review this field.

* Name
* Context
* Version
* Access Control
* Visibility on Store
* Description
* Tags
* Thumbnail Image

**We use the following settings in this demo.**

**Demo section**

| Field | Value |
| :--- | :--- |
| Access Control | All |
| Visibility on Store | Public |

**Implement section**

| Field | Value |
| :--- | :--- |
| Endpoint type | HTTP/REST Endpoint |
| Load Balanced | unchecked |
| Failover | unchecked |
| Endpoint Security Scheme | Not Secured |
| Enable Message Mediation | unchecked |
| Enable API based CORS Configuration | unchecked |

**Manage section**

| Group | Field | Value |
| :--- | :--- | :--- |
| Configurations | Make this the Default version | unchecked |
|  | Transports | HTTPS, HTTP |
|  | Response Caching | Disabled |
|  | Authorization Header | \(empty\) |
| Throttling Settings | Maximum Backend Throughput | Unlimited |
|  | Subscription Tiers | Unlimited |
|  | Advanced Throttling Policies | Apply per Resource |
| API Gateways | Production and Sandbox | checked |
| Business Information | \(we not used\) |  |
| API Properties | \(we not used\) |  |



