# Splunk OpenTelemetry Collector for Kubernetes

Splunk OpenTelemetry Collector (Splunk OTEL) is the latest evolution in Splunk data collection solutions for Kubernetes. It enables exporting Kubernetes data sources simultaneously to Splunk HTTP Event Collector (HEC) and Splunk Observability Cloud. The OpenTelemetry Collector for Kubernetes improves the work started in Splunk Connect for Kubernetes (Fluentd) and is now the Splunk-recommended option for Kubernetes logging and metrics collection.

The idea of OpenTelemetry as a whole is to unify the data so it's suitable for every input and output and put some processors in between to make it possible to perform operations on data (such as transforming and filtering).

The following steps are required to start using Splunk OTEL to collect logs and metrics in Kubernetes cluster:
  1.	Create an index to view the logs.
  2.	Generate a Splunk HTTP Event Collector (HEC) token.
  3.	Use curl to validate that the Splunk host is reachable.
      bash ```
    	curl -k https://prd-p-boa0r.splunkcloud.com:8088/services/collector/raw -H     "Authorization: Splunk 295013c3-49bc-4f7d-bb88-07baa0acf905" -d '{"event":"This is test http event collector"}
    	```
  4. Use the following linux networking troubleshooting commands to validate host resolve to ip address
     bash ```
     nslookup prd-p-boa0r.splunkcloud.com
     host prd-p-boa0r.splunkcloud.com

     ```
  5. Create a namespace for Splunk OTEL installation
     bash ```
     Kubectl create namespace splunk-logging
     ```

  6. Install Splunk OTEL on the cluster and set values for endpoint, HEC token, index, insecureSkipVerify and Cluster name.
  7. Validate the installation via the kubectl cli
     ```
     kubectl get all -n splunk-logging
    NAME                                    READY   STATUS    RESTARTS   AGE
    pod/splunk-otel-collector-agent-fpx8q   1/1     Running   0          20m
    pod/splunk-otel-collector-agent-jv7jf   1/1     Running   0          20m
    pod/splunk-otel-collector-agent-n7dgz   1/1     Running   0          20m
    pod/splunk-otel-collector-agent-w9nsm   1/1     Running   0          20m
    pod/splunk-otel-collector-agent-wbl4x   1/1     Running   0          20m
    
    NAME                                         DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
    daemonset.apps/splunk-otel-collector-agent   5         5         5       5            5           kubernetes.io/os=linux   20m
    ```
