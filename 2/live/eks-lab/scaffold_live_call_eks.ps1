param(
  [string]$Live = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\live\eks-lab",
  # valores copiados do output da VPC:
  [string]$VpcId = "vpc-0a351e6a983fe1041",
  [string[]]$PrivSubnets = @("subnet-01793be5a9d4ea319","subnet-0380bf2c03238c966")
)

# Constrói o literal HCL: ["subnet-...","subnet-..."]
$subnetsLiteral = '[' + (($PrivSubnets | ForEach-Object { '"' + $_ + '"' }) -join ', ') + ']'

$eksTf = @"
# Chama o módulo EKS que criamos em modules/eks
module "eks_stack" {
  source = "../../modules/eks"

  # Básico do cluster
  cluster_name    = "vt-eks-lab"
  cluster_version = "1.30"  # ajuste se necessário

  # Rede (da VPC criada no passo anterior)
  vpc_id             = "$VpcId"
  private_subnet_ids = $subnetsLiteral

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
"@

$eksPath = Join-Path $Live "eks.tf"
$eksTf | Set-Content -Path $eksPath -Encoding UTF8
Write-Host ">> Criado: $eksPath"
