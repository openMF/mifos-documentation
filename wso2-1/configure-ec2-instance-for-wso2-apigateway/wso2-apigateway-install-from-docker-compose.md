# WSO2 APIGateway install from docker-compose

Download and extract base files

```bash
$ cd ~
$ mkdir downloads
$ cd downloads
$ wget https://product-dist.wso2.com/downloads/api-manager/2.6.0/instruction-pages/non-subscription/docker/docker-apim-2.6.0.3.zip
$ unzip docker-apim-2.6.0.3.zip -d ~
```

Start delpoy application

```
$ cd ~
$ cd docker-apim-2.6.0.3/docker-compose/apim-is-as-km-with-analytics/scripts/
$ sudo ./deploy.sh
Do you have a WSO2 Subscription? (Y/N)n
Creating network "apim-is-as-km-with-analytics_default" with the default driver
Pulling mysql (mysql:5.7.19)...
5.7.19: Pulling from library/mysql
85b1f47fba49: Pull complete
27dc53f13a11: Pull complete
095c8ae4182d: Pull complete
0972f6b9a7de: Pull complete
1b199048e1da: Pull complete
159de3cf101e: Pull complete
963d934c2fcd: Pull complete
f4b66a97a0d0: Pull complete
f34057997f40: Pull complete
ca1db9a06aa4: Pull complete
0f913cb2cc0c: Pull complete
Digest: sha256:bfb22e93ee87c6aab6c1c9a4e7cdc68e9cb9b64920f28fa289f9ffae9fe8e173
Status: Downloaded newer image for mysql:5.7.19
Pulling am-analytics (wso2/wso2am-analytics-worker:2.6.0)...
2.6.0: Pulling from wso2/wso2am-analytics-worker
6abc03819f3e: Pull complete
05731e63f211: Pull complete
0bd67c50d6be: Pull complete
b4c273d356e5: Pull complete
b204e6864201: Pull complete
dc1a764b236a: Pull complete
c84929f004d2: Pull complete
2de2f373bbe7: Pull complete
6854457d47cd: Pull complete
d940fc245d52: Pull complete
66de0ee4ca52: Pull complete
Digest: sha256:05fa15b3d92781450825ceb917d82603cb428992962d8b4fc49ba4563608c9e6
Status: Downloaded newer image for wso2/wso2am-analytics-worker:2.6.0
Pulling is-as-km (wso2/wso2is-km:5.7.0)...
5.7.0: Pulling from wso2/wso2is-km
6abc03819f3e: Already exists
05731e63f211: Already exists
0bd67c50d6be: Already exists
b4c273d356e5: Already exists
b204e6864201: Already exists
640c760e76d4: Pull complete
fbd2cff3602d: Pull complete
12c6b19623df: Pull complete
23762d5f2e7a: Pull complete
d018f8e20bf4: Pull complete
34219a7c75cd: Pull complete
edc1574c4ea6: Pull complete
b2e05f137cac: Pull complete
8c3982d2f4b9: Pull complete
Digest: sha256:c2798e609268b07f96f120ade54952ddce1f2a259687b079eb4611bdf315817a
Status: Downloaded newer image for wso2/wso2is-km:5.7.0
Pulling api-manager (wso2/wso2am:2.6.0)...
2.6.0: Pulling from wso2/wso2am
6abc03819f3e: Already exists
05731e63f211: Already exists
0bd67c50d6be: Already exists
b4c273d356e5: Already exists
b204e6864201: Already exists
ca0be8a9d713: Pull complete
89902d3ef26e: Pull complete
0d51fd02df75: Pull complete
efbe0dc92c1b: Pull complete
e6dd6fc80fa8: Pull complete
15a4721e2123: Pull complete
8bb384c27d9b: Pull complete
3d2f4f49b510: Pull complete
b7ff501ae7f7: Pull complete
Digest: sha256:80e7c77ebe9a4caed83514db52e49d1e3f8b316a20d4df5411f772018dcce0c4
Status: Downloaded newer image for wso2/wso2am:2.6.0
Creating apim-is-as-km-with-analytics_mysql_1 ... done
Creating apim-is-as-km-with-analytics_am-analytics_1 ... done
Creating apim-is-as-km-with-analytics_is-as-km_1     ... done
Creating apim-is-as-km-with-analytics_api-manager_1  ... done

To access the Management Console of WSO2 API Manager, use https://localhost:9443/carbon.
To access the Publisher of WSO2 API Manager, use https://localhost:9443/publisher.
To access the Store of WSO2 API Manager, use https://localhost:9443/store.

To list the created WSO2 product server containers, use `docker ps` Docker client command.
For instructions to delete the created WSO2 product server setup, please see the Docker Compose FAQ (https://wso2.com/products/install/faq/#iDocker).

```

**Modify docker-compose.yml file**

We only add "/home/ec2-user/authenticationendpoint.war:/home/wso2carbon/wso2am-2.6.0/repository/deployment/server/webapps/authenticationendpoint.war" entry at api-manager/volumes section.\
This modification enabling deploy from outside the modified authentication screens.\
You may increese startup time, for the follwing values or higher.\
interval --> 120s\
timeout --> 300s\
start\_period --> 300s\
retries --> 30

```yaml
version: '2.3'
services:
  mysql:
    image: mysql:5.7.19
    ports:
      - 3306
    environment:
      MYSQL_ROOT_PASSWORD: root
    volumes:
      - ./mysql/scripts:/docker-entrypoint-initdb.d
    command: [--ssl=0]
    healthcheck:
      test: ["CMD", "mysqladmin" ,"ping", "-uroot", "-proot"]
      interval: 120s
      timeout: 300s
      retries: 30
      start_period: 300s
  am-analytics:
    image: wso2/wso2am-analytics-worker:2.6.0
    ports:
      - "9091:9091"
      - "9444:9444"
    healthcheck:
      test: ["CMD", "nc", "-z","localhost", "9091"]
      interval: 120s
      timeout: 300s
      start_period: 300s
      retries: 30
    depends_on:
      mysql:
        condition: service_healthy
    volumes:
      - ./apim-analytics:/home/wso2carbon/wso2-config-volume
  is-as-km:
    image: wso2/wso2is-km:5.7.0
    healthcheck:
      test: ["CMD", "curl", "-k", "-f", "https://localhost:9443/carbon/admin/login.jsp"]
      interval: 120s
      timeout: 300s
      start_period: 300s
      retries: 30
    depends_on:
      mysql:
        condition: service_healthy
      am-analytics:
        condition: service_healthy
    volumes:
      - ./is-as-km:/home/wso2carbon/wso2-config-volume
    ports:
      - "9765:9763"
      - "9445:9443"
  api-manager:
    image: wso2/wso2am:2.6.0
    healthcheck:
      test: ["CMD", "curl", "-k", "-f", "https://localhost:9443/carbon/admin/login.jsp"]
      interval: 120s
      timeout: 300s
      start_period: 300s
      retries: 30
    depends_on:
      mysql:
        condition: service_healthy
      am-analytics:
        condition: service_healthy
      is-as-km:
        condition: service_healthy
    volumes:
      - ./apim:/home/wso2carbon/wso2-config-volume
      - /home/ec2-user/authenticationendpoint.war:/home/wso2carbon/wso2am-2.6.0/repository/deployment/server/webapps/authenticationendpoint.war
    ports:
      - "9763:9763"
      - "9443:9443"
      - "8280:8280"
      - "8243:8243"
```

### Modify WSO2 config files

**Modify carbon.xml**\
****Find the following lines and modify it.

{% code title="docker-apim-2.6.0.3/docker-compose/apim-is-as-km-with-analytics/apim/repository/conf/carbon.xml" %}
```
<!--<HostName>api-manager</HostName>-->
<!--<MgtHostName>api-manager</MgtHostName>-->
```
{% endcode %}

Write here you full domain name. In our example api.lion.mlabs.dpc.hu

```
<HostName>api.lion.mlabs.dpc.hu</HostName>
<MgtHostName>api.lion.mlabs.dpc.hu</MgtHostName>
```

**Modify api-manager.xml**\
****Find the following entries and modify it to your full domain name.

{% code title="docker-apim-2.6.0.3/docker-compose/apim-is-as-km-with-analytics/apim/repository/conf/api-manager.xml" %}
```
<APIManager>
...
    <AuthManager>
        <ServerURL>https://api.lion.mlabs.dpc.hu:9443/services/</ServerURL>
...
    <APIGateway>
        <Environments>
            <Environment type="hybrid" api-console="true">
                <GatewayEndpoint>http://api.lion.mlabs.dpc.hu:${http.nio.port},https://api.lion.mlabs.dpc.hu:${https.nio.port}</GatewayEndpoint>
...
    <APIKeyValidator>
        <ServerURL>https://api.lion.mlabs.dpc.hu:9443/services/</ServerURL>
```
{% endcode %}
