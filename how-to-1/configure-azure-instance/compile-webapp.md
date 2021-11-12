# Compile WebApp

### Git source repositories

**First Party client**\
[https://github.com/openMF/openbanking-fpp-client\
https://github.com/onlyonce/openbanking-fpp-client](https://github.com/onlyonce/openbanking-fpp-client)

**Third Party client (ACEFintech)**\
[https://github.com/openMF/openbanking-tpp-client\
https://github.com/onlyonce/openbanking-tpp-client](https://github.com/onlyonce/openbanking-tpp-client)



You must review and modify domain names, OAuth clientID, etc

You can use in **src** folder to find required files:

`grep -R 'elephant' * `

### openbanking-fpp-client

`/src/config/server.js`\
`/src/utils/externalUrlHelper.js`



### Compile WebApp

```
> sudo npm run build
```
