terraform {
    backend "s3" {
        bucket = "swimlane_logging"
        key = "project/swimlane/dev/logs"
        region = "us-east-1"
    }

    required_providers {

      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }

       kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">= 2.23.0"
      }

      helm = {
        source = "hashicorp/helm"
        version = ">= 2.11.0"
      }
    }

}


module "dev_splunk_otel" {
    
    source          = "../../"
    cluster_name    = "test"
    splunk_endpoint = ""
    hec_token       = ""
    index           = "eks"
    insecure_skip_verify = true
    fluentd_repo    = "splunk/fluentd-hec"
    fluentd_tag     = "1.3.3"
    fluentd_pullPolicy = "IfNotPresent"
    otelcol_repo    = "quay.io/signalfx/splunk-otel-collector"
    otelcol_tag     = "0.91.3"
    otelcol_pullPolicy = "IfNotPresent"

}
