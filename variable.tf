variable "splunk_endpoint" {}
variable "hec_token" {}
variable "index" {}
variable "insecure_skip_verify" {}
variable "fluentd_repo" {}
variable "fluentd_tag" {}
variable "fluentd_pullPolicy" {}
variable "otelcol_repo" {}
variable "otelcol_tag" {}
variable "otelcol_pullPolicy" {}
variable "cluster_name" {}

locals {
    aws_region   = "us-east-1"
}
