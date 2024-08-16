# Deploy the Splunk Open Telemetry using the Helm provider
resource "helm_release" "splunk_otel_collector" {

  name             = "splunk-otel-collector"
  repository       = "https://signalfx.github.io/splunk-otel-collector-chart"
  chart            = "splunk-otel-collector" 
  namespace        = "splunk-logging"
  version          = "0.105.0"
  atomic           = true
  cleanup_on_fail  = true
  create_namespace = false
  timeout          = 300


  set {
    name = "clusterName"
    value = "${var.cluster_name}"
  }

  set {
    name = "splunkPlatform.endpoint"
    value = "${var.splunk_endpoint}"
  }

  set {
    name = "splunkPlatform.token"
    value = "${var.hec_token}" 
  }

  set {
    name = "splunkPlatform.index"
    value = "${var.index}"  
  }

  set {
    name = "splunkPlatform.insecureSkipVerify"
    value = "${var.insecure_skip_verify }" 
  }

  set {
    name = "image.fluentd.repository"
    value = "${var.fluentd_repo}"  
  }

  set {
    name = "image.fluentd.tag"
    value = "${var.fluentd_tag}"
  }

  set {
    name = "image.fluentd.pullPolicy"
    value = "${var.fluentd_pullPolicy}"
  }

  set {
    name = "image.otelcol.repository"
    value = "${var.otelcol_repo}"
  }

  set {
    name = "image.otelcol.tag"
    value = "${var.otelcol_tag}"
  }

  set {
    name = "image.otelcol.pullPolicy"
    value = "${var.otelcol_pullPolicy}"
  }

}
