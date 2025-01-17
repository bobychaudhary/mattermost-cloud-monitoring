
data "helm_repository" "gitlab" {
  name = "gitlab"
  url  = "https://charts.gitlab.io"
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.deployment_name
}

data "aws_eks_cluster" "cluster" {
  name = var.deployment_name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}

provider "helm" {

  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster_auth.token
    load_config_file       = false
  }
}


