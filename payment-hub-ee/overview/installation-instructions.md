---
description: Deploying and configuring a Payment Hub EE
---

# Installation instructions

## Installation overview

The Payment Hub EE is deployed using _Helm charts_ \(the Kubernetes package manager, see [https://helm.sh/](https://helm.sh/)\), so for a successful deployment one needs a basic understanding of how Helm charts work in general.

The payment hub ships with 2 Github repositories related to installation: [https://github.com/openMF/ph-ee-env-template](https://github.com/openMF/ph-ee-env-template) - this repo contains the Environment Template, which can be utilized as the base of a new environment setup. [https://github.com/openMF/ph-ee-env-labs](https://github.com/openMF/ph-ee-env-labs) - this repo holds 3 sample environments

## Requirements

The Payment Hub EE is supported on Kubernetes clusters running on Microsoft Azure by default. For deploying to other k8s clusters, the Azure Container Registry authentication needs to get configured, following the documentation here: [https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-kubernetes](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-kubernetes).

Zeebe command line tools \(the `zbctl` binary\) is also required for deploying the BPMN workflows. This is part of the Zeebe releases and can be downloaded from the Zeebe release page at [https://github.com/zeebe-io/zeebe/releases](https://github.com/zeebe-io/zeebe/releases).

## Installed components

Depending on the actual configuration, the payment hub's Helm chart installs the following software components:

* PH-EE AMS Mifos Connector
* PH-EE Channel Connector
* PH-EE Mojaloop Connector
* PH-EE Elasticsearch 
* PH-EE ES importer
* PH-EE Kibana
* PH-EE Operations App \(incorporating the PH-EE Identity Provider too\)
* PH-EE Operations MySQL database
* PH-EE Operations Web
* Zeebe microservice orchestration engine
  * Zeebe brokers
  * Gateway service
  * Elasticsearch 
  * Kibana
  * Zeebe Operate monitoring UI

Each of these components has a git repository in [https://github.com/orgs/openMF/repositories?q=ph-ee](https://github.com/orgs/openMF/repositories?q=ph-ee), containing source code and Dockerfiles.

Each component will contain a Jenkinsfile containing tasks related to deployment. Refer to this to understand the build steps of each project.

Most components will also have a Dockerfile. After building the image, you may wish to host these docker images in a local docker registry. This can be done using docker locally per [https://docs.docker.com/registry/deploying/](https://docs.docker.com/registry/deploying/), once you make sure that whatever domain name you use is available via DNS, or a local entry in /etc/hosts. This will mean replacing the images at 'paymenthubee.azurecr.io' in ph-ee-env-template with your own images.

For ph-ee-connector-common, a dependency of several of the connector components, you must build and install to a maven repository.

```bash
mvn deploy install
```

Certainly all these components have various Kubernetes objects \(ReplicationSets, Services, Ingresses, etc\). The Helm chart wraps all this complexity into a single package and allows a single-command deployment, as we will see very soon.

## First deployment

For the first deployment attempt, we suggest taking one of the 3 Lab Environments for a test-drive.

### ph-ee-engine

The `ph-ee-engine` dependency is defined in [https://github.com/openMF/ph-ee-env-template](https://github.com/openMF/ph-ee-env-template)

The lab environments depend on this component, and are configured to pull this from `http://jenkins.mifos.io:8082`. This can be operated locally by installing a custom host entry in your local hosts file (/etc/hosts on linux), and installing a local web server to serve the files.

A sample nginx vhost file is provided:

```
server {
        listen 8082;
        listen [::]:8082;

        root /var/www/jenkinsmifos-helm;

        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                try_files $uri $uri/ =404;
        }
}
```

Add these two entries to your /etc/hosts file. `x.x.x.x` should be replaced with your network IP - as some kubernetes environments run inside a VM, they need a network reachable IP to connect to. Only specifying `127.0.0.1` would make that VM try to connect to itself, not the host which provides the charts.
```
127.0.0.1 jenkins.mifos.io
x.x.x.x jenkins.mifos.io
```

Inspect [https://github.com/openMF/ph-ee-env-template/blob/master/helm/package.sh](https://github.com/openMF/ph-ee-env-template/blob/master/helm/package.sh) for build instructions, and customize the commands to suit your installation. Unless you are remotely pushing the files, you will not need to run scp. Only cp is needed in that case, however please ensure the web root directory (/usr/share/nginx/html) is updated to reflect your configuration. If using the nginx file above, it would be `/var/www/jenkinsmifos-helm`.

Verify your results by doing `curl http://jenkins.mifos.io:8082/index.yaml` to download your index.yaml. If problems occur, check your web server logs.

### Deploying the Helm chart

Deploying any of there is as simple as cloning the Labs repository, changing directory to eg. [https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-med](https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-med), installing the dependencies with `helm dep up`, and executing the command `helm install <release-name> .`, where release name is freely chosen, eg. `ph-ee-med`, in this case.

Upgrading an installation with changed or updated configuration parameters is possible with executing the command `helm upgrade <release-name>`.

### Deploying the BPMN flows

The Payment Hub EE business logic is always driven by the BPMN workflows included in the git repositories. It's not only possible, but often is necessary to customize this flows to meet the business requirements of a specific environment. Deploying the workflows to the K8S cluster is a separate step, which can be done either manually for each business flow, or using a shell script like this \(actual example from the project's CI server\):

```text
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

```text
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

* number of Zeebe brokers in the Zeebe cluster
* number of partitions
* replication factor 
* cpu and IO resources allocated to the orchestration engine
* whether or not Zeebe's Elasticsearch and Kibana is enabled
* Operations app MySQL parameters
* Connectors' active Spring profile
* etc

For an actual example of configuration customization, see the sample Large environment's helm chart at [https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-large](https://github.com/openMF/ph-ee-env-labs/tree/master/helm/payment-hub-large)

## Rolling your own helm chart

The best approach would be taking one of the tested Lab Environment examples and start customizing it to the actual requirements. Once the configuration looks proper, proceed with the deployment as detailed above.

