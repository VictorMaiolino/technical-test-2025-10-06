# Chama o módulo EKS que criamos em modules/eks
module "eks_stack" {
  source = "../../modules/eks"

  # Básico do cluster
  cluster_name    = "vt-eks-lab"
  cluster_version = "1.30"  # ajuste se necessário

  # Rede (da VPC criada no passo anterior)
  vpc_id             = "vpc-0a351e6a983fe1041"
  private_subnet_ids = ["subnet-01793be5a9d4ea319", "subnet-0380bf2c03238c966"]

  # Node group gerenciado (valores modestos p/ lab)
  node_min_size     = 1
  node_desired_size = 1
  node_max_size     = 2
  instance_types    = ["t3.small"]

  # IRSA do Cluster Autoscaler (ServiceAccount/Namespace)
  autoscaler_sa_name   = "cluster-autoscaler"
  autoscaler_namespace = "kube-system"

  # Tags
  tags = {
    Project   = "vt-eks-lab"
    Env       = "lab"
    ManagedBy = "Terraform"
  }
}
