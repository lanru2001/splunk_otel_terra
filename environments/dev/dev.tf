terraform {
    backend "s3" {
        bucket = "dlframe-tf-remote-dev-bkt"
        key    = "project/splunk-otel/ds"
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
    splunk_endpoint = "https://prd-p-boa0r.splunkcloud.com:8088/services/collector/raw"
    hec_token       = "6e81bca3-fe7a-4a0e-930a-1c2e3a52698f"
    index           = "eks"
    insecure_skip_verify = true
    fluentd_repo    = "splunk/fluentd-hec"
    fluentd_tag     = "1.3.3"
    fluentd_pullPolicy = "IfNotPresent"
    otelcol_repo    = "quay.io/signalfx/splunk-otel-collector"
    otelcol_tag     = "0.105.0"
    otelcol_pullPolicy = "IfNotPresent"

}
