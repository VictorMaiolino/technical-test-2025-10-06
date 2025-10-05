# tf_apply_eks.ps1
param(
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\live\eks-lab"
)

Set-Location -Path $Path

Write-Host ">> terraform apply (EKS + node group + IRSA p/ Autoscaler) ..."
terraform apply -no-color -input=false -auto-approve

Write-Host "`n>> Outputs do módulo EKS:"
terraform output -no-color module.eks_stack.cluster_name
terraform output -no-color module.eks_stack.cluster_endpoint
terraform output -no-color module.eks_stack.oidc_provider
terraform output -no-color module.eks_stack.oidc_provider_arn
terraform output -no-color module.eks_stack.autoscaler_role_arn
