data "aws_eks_cluster"  "my_cluster" {
   name         = "test"
}

# obtain a cluster token for providers, tokens are short lived (15 minutes)
data "aws_eks_cluster_auth" "cluster_auth" {
  name = data.aws_eks_cluster.my_cluster.name
}


output "endpoint" {
  value = data.aws_eks_cluster.my_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = data.aws_eks_cluster.my_cluster.certificate_authority[0].data
}

output "identity-oidc-issuer" {
  value = data.aws_eks_cluster.my_cluster.identity[0].oidc[0].issuer
}

######################################################################################
#K8S and Helm Provider
######################################################################################

provider "kubernetes" {
  host                   = "${data.aws_eks_cluster.my_cluster.endpoint}"
  cluster_ca_certificate = base64decode("${data.aws_eks_cluster.my_cluster.certificate_authority[0].data}")
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}

provider "helm" {
  kubernetes {
    host                   = "${data.aws_eks_cluster.my_cluster.endpoint}"
    cluster_ca_certificate = base64decode("${data.aws_eks_cluster.my_cluster.certificate_authority[0].data}")
    token                  = data.aws_eks_cluster_auth.cluster_auth.token
  }
}  

provider "aws" {
  region = "us-east-1"
}
