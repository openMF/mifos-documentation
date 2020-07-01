---
description: How to configure the adapter to link the API user with Fineract customer.
---

# Setting up the adapter

{% embed url="https://github.com/openMF/openbanking-adapter/blob/master/sources/openbanking-adapter/src/main/resources/db/changelog/sql/01-ob\_tn01\_init.sql" %}

The above script provides information on the linking of the banking API user with the Fineract user inside the OpenBanking Adapter database.

Example:

```text
INSERT INTO `user` (`api_user_id`, `psp_user_id`, `active`) VALUES ("lionuser1", "1", 1);
INSERT INTO `trusted_client` (`client_id`, `created_on`) VALUES ("Jg7O55zbOOlJiSJOaG9Qm5nq7qsa", current_date);
```

api\_user\_id - the user id provided via the API calls

psp\_user\_id - the primary key of the client in the Fineract Database

trusted\_client - required for first party client. The registered client ID assigned on the API gateway. Trusted clients could invoke the API services on behalf of the customer without the additional consent flow. 



