variable "cluster_name" {
  description = "daidh-eks-cluster"
  type        = string
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}
