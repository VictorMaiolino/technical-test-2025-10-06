# terraform_apply_bootstrap.ps1
param(
  [string]$Path    = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\00-bootstrap",
  [string]$Region  = "us-east-1",
  [string]$Project = "vt-eks-lab"
)

Set-Location -Path $Path

Write-Host ">> terraform apply (backend bootstrap: S3 + DynamoDB) ..."
terraform apply -no-color -input=false -auto-approve `
  -var="aws_region=$Region" `
  -var="project=$Project"

Write-Host "`n>> Outputs esperados:"
terraform output -no-color state_bucket
terraform output -no-color dynamodb_table
