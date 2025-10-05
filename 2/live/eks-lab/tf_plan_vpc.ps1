# tf_plan_vpc.ps1
param(
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\live\eks-lab",
  [string]$Out = "plan-vpc.out"
)
Set-Location $Path
terraform plan -no-color -input=false | Tee-Object -FilePath $Out
Write-Host ">> Plan salvo em: $Path\$Out"
