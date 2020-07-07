# Signup and subscribe APIs as TPP/FPP

{% hint style="info" %}
Signup process is almost same for TPP and FPP.
{% endhint %}

## Signup at developer portal

**Go to developer portal**: [https://api.lion.mlabs.dpc.hu:9443/store](https://api.lion.mlabs.dpc.hu:9443/store) for Lion, [https://api.elephant.mlabs.dpc.hu:9443/store](https://api.elephant.mlabs.dpc.hu:9443/store) for Elephant bank.

![Developer portal](../.gitbook/assets/screenshot-from-2019-08-12-14-13-12.png)

**Give the required fields.**

![Signup screen](../.gitbook/assets/screenshot-from-2019-08-12-14-15-15.png)

![](../.gitbook/assets/screenshot-from-2019-08-12-14-15-50.png)

**You must login with the newly created username and password.**

![Login screen](../.gitbook/assets/screenshot-from-2019-08-12-14-16-39.png)

**After login you may see the following screen.**

![Overview screen after login](../.gitbook/assets/screenshot-from-2019-08-12-14-17-12.png)

**You must select "Application" menu at left side.**

![Initial application screen](../.gitbook/assets/screenshot-from-2019-08-12-14-18-24.png)

**Select "Edit" action for "DefaultApplication" and modify "Application name".**  
Token type must be "OAuth" in this demo.

![Edit Application infos](../.gitbook/assets/screenshot-from-2019-08-12-14-19-42.png)

**Select "APIS" menu at left side.**  
Maybe you can see the following APIs.

![APIs overview screen](../.gitbook/assets/screenshot-from-2019-08-12-14-23-19.png)

**Select "AccountTransactionAPI - v3.1.2"**

![AccountTransactionAPI - v3.1.2 overview screen](../.gitbook/assets/screenshot-from-2019-08-12-14-24-34.png)

**Select "NewBank Application v1.0" at "Application" dropdown and "Subscribe".**

![Subscription successful](../.gitbook/assets/screenshot-from-2019-08-12-14-25-44.png)

**Go back to APIS screen and subscribe to "PaymentInitiationAPI - v3.1.2".**  
After subscribe APIs in the Application subscriptions screen you can see the following.

![Application subscriptions](../.gitbook/assets/screenshot-from-2019-08-12-14-27-11.png)

**Go to "Production Keys" tab.**

![Production keys screen before setup](../.gitbook/assets/screenshot-from-2019-08-12-14-28-53.png)

**You must specify "Callback url"** where your application will handle OAuth callback requests, when returned after "bank user" authorized one of the consent screen while using TPP application or handle after login while using FPP application.  
If you change this callback url, you must change in your application to.

**Click "Generate keys" to save changes.**  
After keys generated you must see a similar screen.

![Overview screen after setup callback url](../.gitbook/assets/fireshot-capture-002-application-api.lion.mlabs.dpc.hu.png)

In this screen appearing to very imported fields "Consumer Key" and "Consumer Secret". This values require to call OAuth calls. You must save this values. This values is maybe changing while changing "Grant Types" or "Callback URL". Please double check this values after changing something in this page.

If "Consumer Key", "Consumer Secret" or "Callback URL" will not same while call OAuth requests your requests will fail.

Now you have got all information to get Access token and call Application level APIs \(eg. consent requests\).

