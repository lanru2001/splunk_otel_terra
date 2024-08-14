#Deploy the Cluster Autoscaler using the Helm provider
resource "helm_release" "splunk_otel_collector" {
  name = "splunk-otel-collector"
  repository = "https://github.com/signalfx/splunk-otel-collector-chart" 
  chart = "splunk-otel-collector" 
  namespace = "splunk-logging"
  version   = "0.105.0"

  set {
    name = "clusterName"
    value = "${var.cluster_name}"
  }

  set {
    name = "splunkPlatform.endpoint"
    value = "${var.splunk_endpoint}"  #"https://splunk-hec.uscis.dhs.gov:8088"
  }

  set {
    name = "splunkPlatform.token"
    value = "${var.hec_token}" #"FF3063B7-0037-47E6-8401-08074C6C05E0"
  }

  set {
    name = "splunkPlatform.index"
    value = "${var.index}"  #"ess"
  }

  set {
    name = "splunkPlatform.insecureSkipVerify"
    value = "${var.insecure_skip_verify }"  #"true"
  }

  set {
    name = "image.fluentd.repository"
    value = "${var.fluentd_repo}"  #"splunk/fluentd-hec"
  }

  set {
    name = "image.fluentd.tag"
    value = "${var.fluentd_tag}"   #"1.3.3"
  }

  set {
    name = "image.fluentd.pullPolicy"
    value = "${var.fluentd_pullPolicy}"  #"IfNotPresent"
  }

  set {
    name = "image.otelcol.repository"
    value = "${var.otelcol_repo}"  #"quay.io/signalfx/splunk-otel-collector"
  }

  set {
    name = "image.otelcol.tag"
    value = "${var.otelcol_tag}"  #"0.91.3"
  }

  set {
    name = "image.otelcol.pullPolicy"
    value = "${var.otelcol_pullPolicy}"  #"IfNotPresent"
  }

}
