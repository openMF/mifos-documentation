# web.xml

Web application configuration file.

We added "openbanking.logic.url" parameter to the configuration.  
This parameter shows what is the OpenBanking adapter APIs url.

For debugging, developing and testing the integration we introduced the following parameters to we can use Postman mocked services.  
Parameter name: openbanking.logic.mock.param-name  
Parameter value: openbanking.logic.mock.param-value

When using Postman mocking services the "openbanking.logic.url" parameter looks like similar "https://a3c81e50-952b-4a4c-ae82-d6a98735e7.mock.pstmn.io".  
Currently we doesn't offer Postman mocking collections.

