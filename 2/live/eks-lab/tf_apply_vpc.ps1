# tf_apply_vpc.ps1
param(
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\live\eks-lab"
)

Set-Location -Path $Path

Write-Host ">> terraform apply (VPC + NAT) ..."
terraform apply -no-color -input=false -auto-approve

Write-Host "`n>> Outputs (copie para usar no EKS):"
terraform output -no-color vpc_id
terraform output -no-color private_subnets
