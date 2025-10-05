# Descobre zonas de disponibilidade (AZ = Availability Zone)
data "aws_availability_zones" "available" {
  state = "available"
}

# Vamos usar 2 AZs para simplicidade
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "vt-eks-lab"
  cidr = "10.0.0.0/16"

  azs             = local.azs
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24","10.0.102.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_hostnames   = true
  enable_dns_support     = true

  tags = {
    Project   = "vt-eks-lab"
    Env       = "lab"
    ManagedBy = "Terraform"
  }
}

# Outputs locais úteis (para alimentar o módulo EKS depois)
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}
