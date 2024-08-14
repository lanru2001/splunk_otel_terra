data "aws_eks_cluster" "my_cluster" {
   name = "test"
}

output "endpoint" {
  value = data.aws_eks_cluster.my_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = data.aws_eks_cluster.my_cluster.certificate_authority[0].data
}

# Only available on Kubernetes version 1.13 and 1.14 clusters created or upgraded on or after September 3, 2019.
output "identity-oidc-issuer" {
  value = data.aws_eks_cluster.my_cluster.identity[0].oidc[0].issuer
}

provider "kubernetes" {
    host = "${data.aws_eks_cluster.my_cluster.endpoint}"
    cluster_ca_certificate = "${data.aws_eks_cluster.my_cluster.certificate_authority[0].data}"
    exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        args    = [ "eks", "get-token", "--cluster-name", "${data.aws_eks_cluster.my_cluster.name}", "--region", "us-east-1" ]
        command = aws
    } 
}

provider "helm" {
    kubernetes {
        host = "${data.aws_eks_cluster.my_cluster.endpoint}"
        cluster_ca_certificate = "${data.aws_eks_cluster.my_cluster.certificate_authority[0].data}"
        exec {
            api_version = "client.authentication.k8s.io/v1beta1"
            args    = [ "eks", "get-token", "--cluster-name", "${data.aws_eks_cluster.my_cluster.name}", "--region", "us-east-1" ]
            command = aws
        } 
    }    
}

provider "aws" {
    region = "us-east-1"
}
