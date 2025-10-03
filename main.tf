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

  # Lưu state vào S3
  backend "s3" {
    bucket         = "terraform-daidh-state"     
    key            = "eks-demo/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock"            
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
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
resource "kubernetes_namespace" "hello" {
  metadata {
    name = "hello-world"
  }
}
