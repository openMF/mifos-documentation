# Config, setup, build, deploy application

## Config before build

### Configure OpenBanking gateway

Setup OpenBanking gateway url.  
You must change value if you create build for Lion or Elephant bank or for other endpoint.

{% code title="opb-api-gateway/src/main/webapp/WEB-INF/web.xml" %}
```markup
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns="http://java.sun.com/xml/ns/javaee"
         xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd"
         version="3.0">
...         
     <context-param>
        <param-name>openbanking.logic.url</param-name>
        <param-value>http://lion.mlabs.dpc.hu/accessschema/ob</param-value>
        <!-- param-value>http://elephant.mlabs.dpc.hu/accessschema/ob</param-value -->
    </context-param>
    <!-- context-param>
        <param-name>openbanking.logic.mock.param-name</param-name>
        <param-value>x-mock-epic</param-value>
    </context-param>
    <context-param>
        <param-name>openbanking.logic.mock.param-value</param-name>
        <param-value>default</param-value>
    </context-param -->
...
```
{% endcode %}

## Compile

```bash
$ mvn clean package
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.inject.internal.cglib.core.$ReflectUtils$1 (file:/usr/share/maven/lib/guice.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
WARNING: Please consider reporting this to the maintainers of com.google.inject.internal.cglib.core.$ReflectUtils$1
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
[INFO] Scanning for projects...
[INFO] 
[INFO] --< org.wso2.carbon.identity.framework:dpc.org.wso2.carbon.identity.application.authentication.endpoint >--
[INFO] Building WSO2 Carbon - Identity Application Authentication Endpoint 5.12.153
[INFO] --------------------------------[ war ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:3.1.0:clean (default-clean) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] Deleting /home/tsipos/dev/dpchu/opb-api-gateway/target
[INFO] 
[INFO] --- maven-resources-plugin:3.0.2:resources (default-resources) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 4 resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.0:compile (default-compile) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 368 source files to /home/tsipos/dev/dpchu/opb-api-gateway/target/classes
[INFO] /home/tsipos/dev/dpchu/opb-api-gateway/src/main/java/hu/dpc/openbanking/apigateway/ReportAuthorizeResult.java: Some input files use or override a deprecated API.
[INFO] /home/tsipos/dev/dpchu/opb-api-gateway/src/main/java/hu/dpc/openbanking/apigateway/ReportAuthorizeResult.java: Recompile with -Xlint:deprecation for details.
[INFO] /home/tsipos/dev/dpchu/opb-api-gateway/src/main/java/org/wso2/carbon/identity/application/authentication/endpoint/client/AuthAPIServiceClient.java: /home/tsipos/dev/dpchu/opb-api-gateway/src/main/java/org/wso2/carbon/identity/application/authentication/endpoint/client/AuthAPIServiceClient.java uses unchecked or unsafe operations.
[INFO] /home/tsipos/dev/dpchu/opb-api-gateway/src/main/java/org/wso2/carbon/identity/application/authentication/endpoint/client/AuthAPIServiceClient.java: Recompile with -Xlint:unchecked for details.
[INFO] 
[INFO] --- maven-resources-plugin:3.0.2:testResources (default-testResources) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/tsipos/dev/dpchu/opb-api-gateway/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.0:testCompile (default-testCompile) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] No sources to compile
[INFO] 
[INFO] --- maven-surefire-plugin:2.22.1:test (default-test) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] No tests to run.
[INFO] 
[INFO] --- maven-war-plugin:3.2.2:war (default-war) @ dpc.org.wso2.carbon.identity.application.authentication.endpoint ---
[INFO] Packaging webapp
[INFO] Assembling webapp [dpc.org.wso2.carbon.identity.application.authentication.endpoint] in [/home/tsipos/dev/dpchu/opb-api-gateway/target/authenticationendpoint]
[INFO] Processing war project
[INFO] Copying webapp resources [/home/tsipos/dev/dpchu/opb-api-gateway/src/main/webapp]
[INFO] Webapp assembled in [269 msecs]
[INFO] Building war: /home/tsipos/dev/dpchu/opb-api-gateway/target/authenticationendpoint.war
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  9.716 s
[INFO] Finished at: 2019-08-12T15:46:29+02:00
[INFO] ------------------------------------------------------------------------
```

## Deploy

Copy created war file to destination.  
If docker is running it will be detect war file changed and automatically redeploy it.  
If you deploy application while docker stopped and just after start docker, then docker will not detect external changing. If you want redeploy application use must use "touch authenticationendpoint.war". Another solution you need modify docker images and remove "authenticationendpoint.war" application.

```bash
$ scp authenticationendpoint.war api.lion.mlabs.dpc.hu:
or
$ scp authenticationendpoint.war api.elephant.mlabs.dpc.hu:
```

Redeploying webapp log entries:

```text
[2019-08-12 14:29:11,137]  INFO - WebApplication Unloaded webapp: StandardEngine[Catalina].StandardHost[localhost].StandardContext[/authenticationendpoint]
[2019-08-12 14:29:11,229]  INFO - TomcatGenericWebappsDeployer Undeployed webapp: StandardEngine[Catalina].StandardHost[localhost].StandardContext[/authenticationendpoint].File[/home/wso2carbon/wso2am-2.6.0/repository/deployment/server/webapps/authenticationendpoint.war]
[2019-08-12 14:29:13,056]  INFO - TaglibUriRule TLD skipped. URI: https://www.owasp.org/index.php/OWASP_Java_Encoder_Project#advanced is already defined
[2019-08-12 14:29:13,058]  INFO - TaglibUriRule TLD skipped. URI: https://www.owasp.org/index.php/OWASP_Java_Encoder_Project is already defined
[2019-08-12 14:29:13,089]  INFO - TenantDataManager EndpointConfig.properties file loaded from ./repository/conf/identity/EndpointConfig.properties
[2019-08-12 14:29:13,103]  INFO - MutualSSLManager EndpointConfig.properties file loaded from ./repository/conf/identity/EndpointConfig.properties
[2019-08-12 14:29:14,871]  INFO - TomcatGenericWebappsDeployer Deployed webapp: StandardEngine[Catalina].StandardHost[localhost].StandardContext[/authenticationendpoint].File[/home/wso2carbon/wso2am-2.6.0/repository/deployment/server/webapps/authenticationendpoint.war]
```

## Start

After you see the all container started, you must check logs and watch when finished really.

```bash
$ cd docker-apim-2.6.0.3/docker-compose/apim-is-as-km-with-analytics/
Starting mysql        ... done
Starting am-analytics ... done
Starting is-as-km     ... done
Starting api-manager  ... done
```

Check logs

```text
[2019-08-12 14:40:16,545]  INFO - ThriftDataReceiver$ServerThread Thrift receiver started on 0.0.0.0:7711
[2019-08-12 14:40:16,554]  INFO - PassThroughHttpListener Starting Pass-through HTTP Listener...
[2019-08-12 14:40:16,561]  INFO - ThriftDataReceiver$ServerThread Thrift receiver started on 0.0.0.0:7611
[2019-08-12 14:40:16,584]  INFO - PassThroughListeningIOReactorManager Pass-through HTTP Listener started on 0.0.0.0:8280
[2019-08-12 14:40:16,584]  INFO - PassThroughHttpSSLListener Starting Pass-through HTTPS Listener...
[2019-08-12 14:40:16,609]  INFO - PassThroughListeningIOReactorManager Pass-through HTTPS Listener started on 0.0.0.0:8243
[2019-08-12 14:40:16,617]  INFO - NioSelectorPool Using a shared selector for servlet write/read
[2019-08-12 14:40:16,786]  INFO - NioSelectorPool Using a shared selector for servlet write/read
[2019-08-12 14:40:16,857]  INFO - TaskServiceImpl Task service starting in STANDALONE mode...
[2019-08-12 14:40:16,945]  INFO - RegistryEventingServiceComponent Successfully Initialized Eventing on Registry
[2019-08-12 14:40:17,098]  INFO - JMXServerManager JMX Service URL  : service:jmx:rmi://localhost:11111/jndi/rmi://localhost:9999/jmxrmi
[2019-08-12 14:40:17,101]  INFO - StartupFinalizerServiceComponent Server           :  WSO2 API Manager-2.6.0
[2019-08-12 14:40:17,102]  INFO - StartupFinalizerServiceComponent WSO2 Carbon started in 57 sec
[2019-08-12 14:40:17,814]  INFO - CarbonUIServiceComponent Mgt Console URL  : https://api.lion.mlabs.dpc.hu:9443/carbon/
[2019-08-12 14:40:17,815]  INFO - CarbonUIServiceComponent API Store Default Context : https://api.lion.mlabs.dpc.hu:9443/store
[2019-08-12 14:40:17,815]  INFO - CarbonUIServiceComponent API Publisher Default Context : https://api.lion.mlabs.dpc.hu:9443/publisher
[2019-08-12 14:40:17,857]  INFO - EventReceiverDeployer Event Receiver undeployed successfully: throttleEventReceiver.xml
[2019-08-12 14:40:17,863]  INFO - InputAdapterRuntime Connecting receiver throttleEventReceiver
[2019-08-12 14:40:17,865]  INFO - EventJunction Producer added to the junction. Stream:org.wso2.throttle.request.stream:1.0.0
[2019-08-12 14:40:17,865]  INFO - EventReceiverDeployer Event Receiver configuration successfully deployed and in active state: throttleEventReceiver
[2019-08-12 14:40:29,842]  INFO - CarbonEventManagementService Starting polling event receivers
```

## Stop

Find the required process and terminate them.

```bash
$ cd docker-apim-2.6.0.3/docker-compose/apim-is-as-km-with-analytics/
$ docker-compose stop
Stopping apim-is-as-km-with-analytics_api-manager_1  ... done
Stopping apim-is-as-km-with-analytics_is-as-km_1     ... done
Stopping apim-is-as-km-with-analytics_am-analytics_1 ... done
Stopping apim-is-as-km-with-analytics_mysql_1        ... done
```

## Watch log file

```text
$ docker ps
CONTAINER ID        IMAGE                                COMMAND                  CREATED             STATUS                             PORTS                                                                                                                                                                   NAMES
31998ebb73eb        wso2/wso2am:2.6.0                    "/home/wso2carbon/in…"   6 weeks ago         Up 17 seconds (health: starting)   5672/tcp, 7611/tcp, 0.0.0.0:8243->8243/tcp, 7711/tcp, 0.0.0.0:8280->8280/tcp, 9099/tcp, 9611/tcp, 0.0.0.0:9443->9443/tcp, 9711/tcp, 10397/tcp, 0.0.0.0:9763->9763/tcp   apim-is-as-km-with-analytics_api-manager_1
1921e12b2252        wso2/wso2is-km:5.7.0                 "/home/wso2carbon/in…"   7 weeks ago         Up About a minute (healthy)        0.0.0.0:9445->9443/tcp, 0.0.0.0:9765->9763/tcp                                                                                                                          apim-is-as-km-with-analytics_is-as-km_1
086ee2183f71        wso2/wso2am-analytics-worker:2.6.0   "/home/wso2carbon/in…"   7 weeks ago         Up 2 minutes (healthy)             7071/tcp, 7444/tcp, 7612/tcp, 0.0.0.0:9091->9091/tcp, 7712/tcp, 9613/tcp, 9713/tcp, 0.0.0.0:9444->9444/tcp                                                              apim-is-as-km-with-analytics_am-analytics_1
079d4da04c01        mysql:5.7.19                         "docker-entrypoint.s…"   7 weeks ago         Up 2 minutes (healthy)             0.0.0.0:32784->3306/tcp                                                                                                                                                 apim-is-as-km-with-analytics_mysql_1

or just
$ docker ps --format "{{.ID}} {{.Image}}"
31998ebb73eb wso2/wso2am:2.6.0
1921e12b2252 wso2/wso2is-km:5.7.0
086ee2183f71 wso2/wso2am-analytics-worker:2.6.0
079d4da04c01 mysql:5.7.19

$ docker logs -f 31998ebb73eb
...
[2019-08-12 14:40:16,545]  INFO - ThriftDataReceiver$ServerThread Thrift receiver started on 0.0.0.0:7711
[2019-08-12 14:40:16,554]  INFO - PassThroughHttpListener Starting Pass-through HTTP Listener...
[2019-08-12 14:40:16,561]  INFO - ThriftDataReceiver$ServerThread Thrift receiver started on 0.0.0.0:7611
[2019-08-12 14:40:16,584]  INFO - PassThroughListeningIOReactorManager Pass-through HTTP Listener started on 0.0.0.0:8280
[2019-08-12 14:40:16,584]  INFO - PassThroughHttpSSLListener Starting Pass-through HTTPS Listener...
[2019-08-12 14:40:16,609]  INFO - PassThroughListeningIOReactorManager Pass-through HTTPS Listener started on 0.0.0.0:8243
[2019-08-12 14:40:16,617]  INFO - NioSelectorPool Using a shared selector for servlet write/read
[2019-08-12 14:40:16,786]  INFO - NioSelectorPool Using a shared selector for servlet write/read
[2019-08-12 14:40:16,857]  INFO - TaskServiceImpl Task service starting in STANDALONE mode...
[2019-08-12 14:40:16,945]  INFO - RegistryEventingServiceComponent Successfully Initialized Eventing on Registry
[2019-08-12 14:40:17,098]  INFO - JMXServerManager JMX Service URL  : service:jmx:rmi://localhost:11111/jndi/rmi://localhost:9999/jmxrmi
[2019-08-12 14:40:17,101]  INFO - StartupFinalizerServiceComponent Server           :  WSO2 API Manager-2.6.0
[2019-08-12 14:40:17,102]  INFO - StartupFinalizerServiceComponent WSO2 Carbon started in 57 sec
[2019-08-12 14:40:17,814]  INFO - CarbonUIServiceComponent Mgt Console URL  : https://api.lion.mlabs.dpc.hu:9443/carbon/
[2019-08-12 14:40:17,815]  INFO - CarbonUIServiceComponent API Store Default Context : https://api.lion.mlabs.dpc.hu:9443/store
[2019-08-12 14:40:17,815]  INFO - CarbonUIServiceComponent API Publisher Default Context : https://api.lion.mlabs.dpc.hu:9443/publisher
[2019-08-12 14:40:17,857]  INFO - EventReceiverDeployer Event Receiver undeployed successfully: throttleEventReceiver.xml
[2019-08-12 14:40:17,863]  INFO - InputAdapterRuntime Connecting receiver throttleEventReceiver
[2019-08-12 14:40:17,865]  INFO - EventJunction Producer added to the junction. Stream:org.wso2.throttle.request.stream:1.0.0
[2019-08-12 14:40:17,865]  INFO - EventReceiverDeployer Event Receiver configuration successfully deployed and in active state: throttleEventReceiver
[2019-08-12 14:40:29,842]  INFO - CarbonEventManagementService Starting polling event receivers
...
```



