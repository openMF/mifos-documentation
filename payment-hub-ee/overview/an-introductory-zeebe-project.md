# An introductory Zeebe project (Getting started)

We have created a [Hello World Zeebe project](https://github.com/peterforis/zeebe-demo-dpc), to help familiarization for those new to working with Zeebe. The project implements a bpmn consisting of service and receive tasks, an exclusive gateway containing a conditional and default path, and a timeout event, resulting in a simple introduction to core concepts used in the various payment hub bpmn workflows.

It also assists in familiarization, with the [payment hub ee exporter repository](https://github.com/openMF/ph-ee-exporter), which is used to send Zeebe data to Kafka.

Please follow the steps below to download and run the demo, or follow the instructions on the [zeebe-demo-dpc github page](https://github.com/peterforis/zeebe-demo-dpc)

### Set up your enviroment

1\. Make sure you have [Docker](https://www.docker.com) installed. If you don't, you can install it by following [their installation guide](https://docs.readthedocs.io/en/latest/development/install.html)

2\. Please ensure you can use docker compose

3\. Clone the [**zeebe-docker-compose** repository](https://github.com/camunda-community-hub/zeebe-docker-compose) from github. This will allow you to run zeebe, camunda operate, kafka and elasticsearch in a docker container&#x20;

```
$ git clone https://github.com/camunda-community-hub/zeebe-docker-compose.git
```

&#x20;4\. Clone the [**ph-ee-exporter** repository](https://github.com/openMF/ph-ee-exporter) from github. This will allow you to send data to Kafka

```
$ git clone https://github.com/openMF/ph-ee-exporter.git
```

5\. Run maven package in the ph-ee-exporter project, to generate a jar exporter-1.0.0-SNAPSHOT.jar and note the absolute path of this jar and kafka-clients-2.4.0.jar on your computer

6\. Navigate to zeebe-docker-compose/operate

```
$ cd zeebe-docker-compose/operate
```

7\. Replace the contents of the docker-compose.yml file with the following:

```
version: "2"

networks:
  zeebe_network:

volumes:
  zeebe_data:
  zeebe_elasticsearch_data:
  zookeeper_data:
    driver: local
  kafka_data:
    driver: local

services:
  zeebe:
    image: camunda/zeebe:1.1.0
    environment:
      - ZEEBE_LOG_LEVEL=debug
      - ZEEBE_BROKER_EXPORTERS_KAFKA_CLASSNAME=hu.dpc.rt.kafkastreamer.exporter.KafkaExporter
      - ZEEBE_BROKER_EXPORTERS_KAFKA_JARPATH=/exporter.jar
      - ZEEBE_BROKER_EXPORTERS_ELASTICSEARCH_JARPATH=/exporter.jar
      - ZEEBE_BROKER_EXPORTERS_ELASTICSEARCH_CLASSNAME=hu.dpc.rt.kafkastreamer.exporter.NoOpExporter
    ports:
      - "26500:26500"
      - "9600:9600"
    volumes:
      - zeebe_data:/usr/local/zeebe/data 
      - ./application.yaml:/usr/local/zeebe/config/application.yaml
      - [INSERT ABSOLUTE PATH OF kafka-clients-2.4.0.jar HERE]:/usr/local/zeebe/lib/kafka-clients-2.4.0.jar
      - [INSERT ABSOLUTE PATH OF exporter-1.0.0-SNAPSHOT.jar HERE]:/exporter.jar
    depends_on:
      - elasticsearch
    networks:
      - zeebe_network
  operate:
    image: camunda/operate:1.1.0
    ports:
      - "8080:8080"
    depends_on:
      - zeebe
      - elasticsearch
    volumes:
      - ../lib/application.yml:/usr/local/operate/config/application.yml
    networks:
      - zeebe_network
  elasticsearch:
    container_name: elasticsearch
    image: docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.2
    ports:
      - "9200:9200"
    environment:
      - discovery.type=single-node
      - cluster.name=elasticsearch
      - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
    volumes:
      - zeebe_elasticsearch_data:/usr/share/elasticsearch/data
    networks:
      - zeebe_network
  zookeeper:
    image: docker.io/bitnami/zookeeper:3.7
    ports:
      - "2181:2181"
    volumes:
      - "zookeeper_data:/bitnami"
    environment:
      - ALLOW_ANONYMOUS_LOGIN=yes
    networks:
      - zeebe_network
  kafka:
    container_name: kafka
    image: docker.io/bitnami/kafka:2
    ports:
      - "9094:9094"
    volumes:
      - "kafka_data:/bitnami"
    environment:
      - KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181
      - ALLOW_PLAINTEXT_LISTENER=yes
      - KAFKA_LISTENERS=INTERNAL://kafka:9092,OUTSIDE://kafka:9094
      - KAFKA_ADVERTISED_LISTENERS=INTERNAL://kafka:9092,OUTSIDE://localhost:9094
      - KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=INTERNAL:PLAINTEXT,OUTSIDE:PLAINTEXT
      - KAFKA_INTER_BROKER_LISTENER_NAME=INTERNAL
    depends_on:
      - zookeeper
    networks:
      - zeebe_network
  db:
    image: postgres
    environment:
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_DB=testdb
    volumes:
      - ./pgdata:/var/lib/postgresql/data
    ports:
      - "5432:5432"
```

8\. Replace lines 29 and 30 with the absolute path of exporter-1.0.0- SNAPSHOT.jar and kafka-clients-2.4.0.jar on your computer, in the indicated positions

9\. Start docker within zeebe-docker-compose/operate with the force-recreate option enabled to ensure docker runs with the new docker- compose.yml file

```
$ docker-compose up --force-recreate
```

&#x20;**The following steps are only necessary if you wish to use kafka-tool to view kafka messages:**

10\. Install [Kafka Tool](https://www.kafkatool.com)

11\. Add a new cluster, with Kafka Cluster Version 2.4. Zookeeper Host should be localhost and Zookeeper Port should be 2181. In advanced settings, set broker to localhost:9094.

### Running the Zeebe demo

1\. Clone the repository for the zeebe demo application

```
$ git clone https://github.com/peterforis/zeebe-demo-dpc.git
```

2\. Navigate to zeebe-docker-compose/operate

```
$ cd zeebe-docker-compose/operate
```

3\. Start docker within zeebe-docker-compose/operate

```
$ docker-compose up 
```

4\. Navigate to zeebe-docker-compose/bin

```
$ cd zeebe-docker-compose/operate
```

5\. Note the absolute path of hello-process.bpmn in the zeebe-demo-dpc project on your computer

6\. Deploy bpmn:

```
$ ./zbctl deploy --insecure <ABSOLUTE PATH OF hello-process.bpmn GOES HERE>
```

7\. Run ZeebeDemoApplication
