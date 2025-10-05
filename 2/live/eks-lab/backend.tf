terraform {
  backend "s3" {
    bucket         = "tfstate-vt-eks-lab-921292479360-us-east-1"  # <- seu state_bucket
    key            = "eks-lab/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tfstate-lock-vt-eks-lab"                    # <- sua dynamodb_table
    encrypt        = true
  }
}
