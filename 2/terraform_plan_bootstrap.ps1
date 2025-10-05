# terraform_plan_bootstrap.ps1
param(
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\00-bootstrap",
  [string]$Region = "us-east-1",
  [string]$Project = "vt-eks-lab",
  [string]$OutFile = "plan-bootstrap.out"
)

Set-Location -Path $Path
terraform plan -no-color -input=false `
  -var="aws_region=$Region" `
  -var="project=$Project" | Tee-Object -FilePath $OutFile

Write-Host ">> Plan salvo em: $Path\$OutFile"
