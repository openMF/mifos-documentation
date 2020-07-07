---
description: Deploying and configuring a Payment Hub EE
---

## Installation overview
The Payment Hub EE is deployed using *Helm charts* (the Kubernetes package manager, see https://helm.sh/), so for a successful deployment one needs a basic understanding of how Helm charts work in general.

The payment hub ships with 2 Github repositories related to installation:
https://github.com/openMF/ph-ee-env-template - this repo contains the Environment Template, which can be utilized as the base of a new environment setup.
https://github.com/openMF/ph-ee-env-labs - this repo holds 3 sample environments

## Requirements
The Payment Hub EE is supported on Kubernetes clusters running on Microsoft Azure by default. For deploying to other k8s clusters, the Azure Container Registry authentication needs to get configured, following the documentation here: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-kubernetes.

Zeebe command line tools (the `zbctl` binary) is also required for deploying the BPMN workflows. This is part of the Zeebe releases and can be downloaded from the Zeebe release page at https://github.com/zeebe-io/zeebe/releases.

## Installed components
Depending on the actual configuration, the payment hub's Helm chart installs the following software components:
* PH-EE AMS Mifos Connector
* PH-EE Channel Connector
* PH-EE Mojaloop Connector
* PH-EE Elasticsearch 
* PH-EE ES importer
* PH-EE Kibana
* PH-EE Operations App (incorporating the PH-EE Identity Provider too)
* PH-EE Operations MySQL database
* PH-EE Operations Web
* Zeebe microservice orchestration engine
  * Zeebe brokers
  * Gateway service
  * Elasticsearch 
  * Kibana
  * Zeebe Operate monitoring UI

Certainly all these components have various Kubernetes objects (ReplicationSets, Services, Ingresses, etc). The Helm chart wraps all this complexity into a single package and allows a single-command deployment, as we will see very soon.

## First deployment
### Deploying the Helm chart
For the first deployment attempt, we suggest taking one of the 3 Lab Environments for a test-drive. Deploying any of there is as simple as cloning the Labs repository, changing directory to eg. https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-med and executing the command `helm install <release-name> .`, where release name is freely chosen, eg. `ph-ee-med`, in this case.

Upgrading an installation with changed or updated configuration parameters is possible with executing the command `helm upgrade <release-name>`.

### Deploying the BPMN flows
The Payment Hub EE business logic is always driven by the BPMN workflows included in the git repositories. It's not only possible, but often is necessary to customize this flows to meet the business requirements of a specific environment. Deploying the workflows to the K8S cluster is a separate step, which can be done either manually for each business flow, or using a shell script like this (actual example from the project's CI server):
```
declare -A tenants
tenants=([bb-dfsp]="tn03 tn04" [med-dfsp]="tn05 tn06" [large-dfsp]="tn01 tn02")
PREV="DFSPID"
for lab in large-dfsp; do 
	echo "using env $lab"
  kubectx $lab
  svc=`kubectl get pods | grep zeebe-zeebe-gateway | awk '{ print $1 }'`
  kubectl port-forward $svc 26500:26500 &
  sleep 1
	for tenant in ${tenants[$lab]}; do 
		for bpmn in ./orchestration/feel/*.bpmn; do
			echo "processing bpmn: $(basename $bpmn) tenant: ${tenant} currently_replacing: ${PREV}"
			sed -i "s/$PREV/$tenant/" $bpmn
			cat $bpmn | grep bpmn:process
            /var/lib/jenkins/zeebe/bin/zbctl deploy --insecure $bpmn
            sleep 1
		done
		PREV=${tenants[$lab]:0:4}
		echo "--- DONE tenant ${tenant} ---"
	done
	PREV=${tenants[$lab]:5:4}
	echo "--- DONE environment ${lab} ---"
    killall kubectl
done
```

### Updating DNS
To be able to access the Operations application externally, the right DNS settings also need to get set up in the environment. The hostnames of the various components can be overwritten in the `values.yml` file, eg: 

```
  ph_ee_operations_app:
    SPRING_PROFILES_ACTIVE: "large"
    hostname: "large-operations.mifos.io"

  ph_ee_operations:
    SPRING_PROFILES_ACTIVE: "large"
    hostname: "large-operations.mifos.io"
    webhost: "large-operations-ui.mifos.io"
```

## Customizing the deployment configuration
The Payment Hub EE's Helm chart picks sensible defaults for most configuration options, but it's certainly possible to customize all aspects by depending on the Helm chart and adding a custom `values.yml` file. This way we can fine-tune most aspects of the deployment, including but not limited to:
- number of Zeebe brokers in the Zeebe cluster
- number of partitions
- replication factor 
- cpu and IO resources allocated to the orchestration engine
- whether or not Zeebe's Elasticsearch and Kibana is enabled
- Operations app MySQL parameters
- Connectors' active Spring profile
- etc

For an actual example of configuration customization, see the sample Large environment's helm chart at https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-large

## Rolling your own helm chart
The best approach would be taking one of the tested Lab Environment examples and start customizing it to the actual requirements. Once the configuration looks proper, proceed with the deployment as detailed above. 
