# Tuning and performance

The Payment Hub EE performance can vary on the highest scale depending on the available resources and deployment options. This page concludes our past experiencing with tuning the PHEE to achieve the highest possible performance results.

## Performance tuning

### CPU architecture

We collected lots of experience running the Payment Hub on Azure using AMD CPUs, on AWS using Intel CPU nodes in the Kubernetes environment, and lastly on Azure AKS using Intel CPUs. Our experience clearly show a pattern: Azure nodes having AMD CPUs show inferior performance compared to all other tried approaches, and often these differences are on the 1:5 scale.

Therefore we do recommend choosing Kubernetes nodes with Intel CPUs only for running PHEE.

### Zeebe deployment parameters

The central place for Zeebe configuration is the `values.yaml` file of the Helm chart used for deployment. See the Large Lab Environment's `values.yaml` as an example: [https://github.com/openMF/ph-ee-env-labs/blob/master/helm/payment-hub-large/values.yaml](https://github.com/openMF/ph-ee-env-labs/blob/master/helm/payment-hub-large/values.yaml). The following paragraph summarizes the most important tuneable parameters and their recommended values:

* `clustersize` - number of Zeebe broker nodes in the cluster. We use 3 nodes for the Large Lab Environment.
* `partitionCount`- we used 15 partitions for optimal distribution among broker nodes
* `replicationFactor` - we set this to 2 to achieve a fine balance between replication and performance
* `cpuThreadCount` - we set this &lt;`# of cpu cores in a node` - `ioThreadCount`&gt;, so we used 6
* `ioThreadCount` - our measurements showed optimal performance using 2 IO threads
* `JavaOpts` - this drives the JVM tuning parameters inside the Zeebe brokers, including garbage collector settings. We experienced with various approaches, the best results \(somewhat surprisingly\) came using these settings: `-Xms32g -Xmx32g -XX:+UseParallelGC -XX:MinHeapFreeRatio=5 -XX:MaxHeapFreeRatio=10 -XX:MaxRAMPercentage=25.0 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90`

### Exporters

 During our loadtests, the Zeebe ElasticSearch exporter became a bottleneck soon. This component is enabled by default by the Zeebe Helm chart, so we needed to get rid of it. The following did the trick:

```text
env:
  - name: ZEEBE_BROKER_EXPORTERS_ELASTICSEARCH_CLASSNAME
    value: "hu.dpc.rt.kafkastreamer.exporter.NoOpExporter"
```

Note that there's an open ticket in the Zeebe community to allow disabling the exporter in the deployment.

The Payment Hub EE ships its own exporter which uses Kafka and does not cause any bottlenecks. We recommend relying on this component and the `ph-ee-importer-es` to achieve a scalable ElasticSearch export. Again, the working setup can be checked in the Large Lab Environment's helm chart at [https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-large](https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-large)

### Metrics

To be able to expose metrics for Prometheus and visualize using Grafana, we need to enable Zeebe metrics in the helm chart, similarly to this:

```text
env:
  - name: ZEEBE_BROKER_EXECUTION_METRICS_EXPORTER_ENABLED
    value: "true"
```

### Backpressure

Zeebe ships with a highly configurable backpressure algorithm, which helps to avoid overloading the broker cluster and maintain an ideal load/latency setup. This however works by blocking incoming new requests completely to ensure the brokers' optimal performance. To avoid hitting backpressure for the load tests, we turned this feature off by setting this value in the Helm chart:

```text
env:
  - name: ZEEBE_BROKER_BACKPRESSURE_ENABLED
    value: "false"

```

## Performance measurements

The demonstrated loadtest measurements took place in the Large Lab Environment on Azure AKS Kubernetes, running 4 nodes: `1x Standard_A2m_v2`, `3x Standard_D13_v2`. This turned out to be a relatively cost-saving approach while still providing plenty of resources for the Zeebe cluster. 

Each broker used a node having 8 cpu Intel Xeon \(Skylake or higher\) cores and 56 Gib of memory. We scaled up the PHEE Channel Connector components to 6 replicas in the Deployment, and provided the load from 3 different hosts through the k8s Ingresses. The Payment Hub had both the Mojaloop and AMS connectors effectively disabled through the ConfigMap settings, to allow measuring the PHEE performance isolated, without any external, possibly slower dependent components. We also applied all configuration suggestions from this page. 

Showing the metrics for a complete test run of 10000 payment transactions:

![](../../.gitbook/assets/image%20%284%29.png)

the number of parallelly running workflow instances peaked over 5200 Zeebe workflows. All 10k payment transactions could finish within 3:15, hitting the average of **51 TPS**. 

Examining the event processing latencies on a Grafana heatmap \(darker boxes meaning large number of measured values in that timewindow\):

![](../../.gitbook/assets/image%20%286%29.png)

we conclude that highest number of events finished in the 100-250ms range. 



