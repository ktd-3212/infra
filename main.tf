terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.20"
    }
  }

# Provider Kubernetes kết nối tới EKS cluster sẵn có
provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Lấy thông tin EKS cluster đã có
data "aws_eks_cluster" "cluster" {
  name = "daidh-eks-cluster"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "daidh-eks-cluster"
}

# Resource test: tạo namespace trong EKS
resource "kubernetes_namespace" "daidh-namespace" {
  metadata {
    name = "daidh-namespace"
  }
}
