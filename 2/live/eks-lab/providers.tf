variable "aws_region" {
  type    = string
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

/*
 Os providers kubernetes/helm só entram depois que o EKS existir,
 pois precisam do endpoint/credenciais do cluster.
*/
