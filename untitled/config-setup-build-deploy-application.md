# Config, setup, build, deploy application

## Config before build

### Configure bank access

We add Lion and Elephant bank access.  
You must signup and subscribe APIs to get valid values.

{% code title="opb-acefintech/src/main/resources/db/changelog/sql/init-1.0.sql" %}
```sql
INSERT INTO BANKS VALUES('2ebf6b62-069b-496b-89f1-c4b4b08e04ae',
                         'Lion','Lion','Lion Bank Ltd.',
                         '/netbank/images/bank/lion.svg',
                         'https://api.lion.mlabs.dpc.hu:8243/token',
                         'https://api.lion.mlabs.dpc.hu:8243/open-banking/v3.1/aisp/v3.1.2',
                         'Jg7O55zbOOlJiSJOaG9Qm5nq7qsa',
                         'rEpxSqsEJUUGrJt8dcWsvAxIhx8a',
                         'https://acefintech.mlabs.dpc.hu/netbank/customer/banks/authorize',
                         'acefintech',
                         'https://api.lion.mlabs.dpc.hu:8243/authorize',
                         'https://api.lion.mlabs.dpc.hu:8243/open-banking/v3.1/pisp/v3.1.2');
INSERT INTO BANKS VALUES('7a807744-a081-4da7-ba67-00a4936b9133',
                         'Elephant','Elephant','Elephant Bank Ltd.',
                         '/netbank/images/bank/elephant.svg',
                         'https://api.elephant.mlabs.dpc.hu:8243/token',
                         'https://api.elephant.mlabs.dpc.hu:8243/open-banking/v3.1/aisp/v3.1.2',
                         'W1q6iz4uygm1O9zFWJhc20xEpV8a',
                         's301JImQb0aRuLndn6kKpf67cQUa',
                         'https://acefintech.mlabs.dpc.hu/netbank/customer/banks/authorize',
                         'acefintech',
                         'https://api.elephant.mlabs.dpc.hu:8243/authorize',
                         'https://api.elephant.mlabs.dpc.hu:8243/open-banking/v3.1/pisp/v3.1.2');
```
{% endcode %}

#### BANKS table structure

**id**  
UUID for identify a bank  
eg: 2293e2cf-1c54-38cf-9934-6be4e94e60f8  
Use only internally. We just generate random UUID value.

**name**  
Name of the bank  
eg: Lion

**shortName**  
Short name of the bank  
eg: Lion

**longName**  
Long name of the bank  
eg: Lion Bank Ltd.

**logoUrl**  
url for the bank logo.  
eg: /images/bank/lion.svg  
Bank logo images can found at GUI application.

**tokenUrl**  
OAuth token url  
eg: https://api.lion.mlabs.dpc.hu:8243/token

**accounts\_url**  
Accounts API url, defined via Bank at Publisher site.  
eg: https://api.lion.mlabs.dpc.hu:8243/open-banking/v3.1/aisp/v3.1.2

**client\_id**  
LionFintech application OAuth client id \(consumer key\).  
eg: PttPN26uJLQgvRjSrhmh5ShaqZga  
You can find at API Store. This value must be identical with WSO2 API Store values. 

**client\_secret**  
LionFintech application OAuth client secret \(consumer secret\).  
eg: gUPRoq7QUgkuBkdLIkLc1d6fJhka  
You can find at API Store. This value must be identical with WSO2 API Store values. 

**callback\_url**  
LionFintech OAuth callback url. After user OAuth authorization, the WSO2 call this url. In OAuth calls we must provide this information too, based on OAuth standard.  
eg: https://acefintech.mlabs.dpc.hu/lionfintech/customer/banks/authorize  
You can find at API Store. This value must be identical with WSO2 API Store values. 

**userName**  
LionFintech username at WSO2 API Store. This username must be identical that user which signed up at API Store.  
eg: lionfintech

**authorize\_url**  
OAuth authorization url.  
eg: https://api.lion.mlabs.dpc.hu:8243/authorzize

**payments\_url**  
Payments API url, defined via Bank at Publisher site.  
eg: https://api.lion.mlabs.dpc.hu:8243/open-banking/v3.1/pisp/v3.1.2

### Add user to application

{% code title="opb-acefintech/src/main/resources/db/changelog/sql/init-1.0.sql" %}
```sql
INSERT INTO USERS
VALUES ('tppuser', '{bcrypt}$2a$10$FgRPdjDFcfxrCzWzVO/mZuWwVEm8CxqRNx4qQAOGVjzh/983lUPJy', TRUE);
INSERT INTO AUTHORITIES
VALUES ('tppuser', 'ROLE_USER');
```
{% endcode %}

We defined "tppuser" with "password" password.  


## Create environment

```text
cd ~
mkdir acefintech
mkdir acefintech/db
mkdir acefintech/config
```

### Create and edit application.properties

{% code title="acefintech/config/application.properties" %}
```text
#
# This Source Code Form is subject to the terms of the Mozilla
# Public License, v. 2.0. If a copy of the MPL was not distributed
# with this file, You can obtain one at
#
# https://mozilla.org/MPL/2.0/.
#
server.port=8080
server.servlet.context-path=/
####Jetty specific properties########
# Number of acceptor threads to use.
server.jetty.acceptors=1
# Maximum size in bytes of the HTTP post or put content.
server.jetty.max-http-post-size=32768
# Number of selector threads to use.
server.jetty.selectors=1
spring.datasource.url=jdbc:hsqldb:file:/home/ec2-user/acefintech/db/
spring.datasource.username=SA
spring.datasource.password=
spring.datasource.tomcat.max-wait=20000
spring.datasource.tomcat.max-active=50
spring.datasource.tomcat.max-idle=20
spring.datasource.tomcat.min-idle=15
spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.HSQLDialect
spring.jpa.properties.hibernate.id.new_generator_mappings = false
spring.jpa.properties.hibernate.format_sql = true
spring.jpa.hibernate.ddl-auto=none
logging.level.org.hibernate.SQL=DEBUG
logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE
spring.liquibase.enabled=true
logging.level.org.springframework.web.filter.CommonsRequestLoggingFilter=DEBUG
```
{% endcode %}

### Create startup script \(start\_acefintech.sh\)

{% code title="start\_lionfintech.sh" %}
```bash
$ nohup java -jar acefintech/backend-0.0.1-SNAPSHOT.jar --spring.config.location=file:./acefintech/config/ > acefintech.log &
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
[INFO] ---------------< hu.dpc.openbank.tpp.acefintech:backend >---------------
[INFO] Building acefintech backend 0.0.1-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO] 
[INFO] --- maven-clean-plugin:3.1.0:clean (default-clean) @ backend ---
[INFO] Deleting /home/tsipos/dev/dpchu/opb-acefintech/target
[INFO] 
[INFO] --- maven-resources-plugin:3.1.0:resources (default-resources) @ backend ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] Copying 0 resource
[INFO] Copying 8 resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:compile (default-compile) @ backend ---
[INFO] Changes detected - recompiling the module!
[INFO] Compiling 157 source files to /home/tsipos/dev/dpchu/opb-acefintech/target/classes
[INFO] 
[INFO] --- maven-resources-plugin:3.1.0:testResources (default-testResources) @ backend ---
[INFO] Using 'UTF-8' encoding to copy filtered resources.
[INFO] skip non existing resourceDirectory /home/tsipos/dev/dpchu/opb-acefintech/src/test/resources
[INFO] 
[INFO] --- maven-compiler-plugin:3.8.1:testCompile (default-testCompile) @ backend ---
[INFO] Changes detected - recompiling the module!
[INFO] 
[INFO] --- maven-surefire-plugin:2.22.2:test (default-test) @ backend ---
[INFO] 
[INFO] --- maven-jar-plugin:3.1.2:jar (default-jar) @ backend ---
[INFO] Building jar: /home/tsipos/dev/dpchu/opb-acefintech/target/backend-0.0.1-SNAPSHOT.jar
[INFO] 
[INFO] --- spring-boot-maven-plugin:2.1.5.RELEASE:repackage (repackage) @ backend ---
[INFO] Replacing main artifact with repackaged archive
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  5.623 s
[INFO] Finished at: 2019-08-12T10:17:16+02:00
[INFO] ------------------------------------------------------------------------
```

## Deploy

Copy created jar file to destination.

```bash
$ scp opb-acefintech/target/backend-0.0.1-SNAPSHOT.jar acefintech.mlabs.dpc.hu:acefintech/
```

## Start

```text
$ ssh acefintech.mlabs.dpc.hu
$ ./start_acefintech.sh
```

## Stop

Find the required process and terminate them.

```text
$ ps -ef | grep acefintech
ec2-user 11573     1  6 12:11 pts/0    00:00:33 java -jar acefintech/backend-0.0.1-SNAPSHOT.jar --spring.config.location=file:./acefintech/config/
ec2-user 11636 11326  0 12:19 pts/1    00:00:00 grep --color=auto acefintech

$ kill 11573
```

## Watch log file

```text
$ tail -f acefintech.log
```



