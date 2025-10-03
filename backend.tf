terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "eks/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}