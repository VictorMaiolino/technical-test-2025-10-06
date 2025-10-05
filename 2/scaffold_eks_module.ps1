param(
  [string]$Root = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2"
)

$mod = Join-Path $Root "modules\eks"
New-Item -ItemType Directory -Force -Path $mod | Out-Null

# versions.tf
@'
terraform {
  required_version = ">= 1.3.0, < 2.0.0"
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}
'@ | Set-Content -Path (Join-Path $mod "versions.tf") -Encoding UTF8

# variables.tf (multilinha, sem ;)
@'
variable "cluster_name"       { type = string }
variable "cluster_version"    { type = string }
variable "vpc_id"             { type = string }
variable "private_subnet_ids" { type = list(string) }

variable "node_min_size"      { type = number }
variable "node_desired_size"  { type = number }
variable "node_max_size"      { type = number }
variable "instance_types"     { type = list(string) }

variable "autoscaler_sa_name"   { type = string }
variable "autoscaler_namespace" { type = string }
variable "tags"                 { type = map(string) }
'@ | Set-Content -Path (Join-Path $mod "variables.tf") -Encoding UTF8

# main.tf (placeholder — vamos preencher no próximo micro-passo E1)
@'
// Próximo: inserir módulo oficial EKS (enable_irsa = true)
// + IAM Role/Policy para Cluster Autoscaler (IRSA)
'@ | Set-Content -Path (Join-Path $mod "main.tf") -Encoding UTF8

# outputs.tf (placeholder — vamos preencher no E3)
@'
// Próximo: outputs (cluster_name, endpoint, ca, oidc_provider, autoscaler_role_arn, etc.)
'@ | Set-Content -Path (Join-Path $mod "outputs.tf") -Encoding UTF8

Write-Host ">> EKS module scaffold criado em: $mod"
