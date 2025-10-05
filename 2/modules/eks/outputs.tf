# Informações principais do cluster
output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS API server endpoint"
  value       = module.eks.cluster_endpoint
}

output "cluster_ca" {
  description = "Cluster CA (certificate_authority)"
  value       = module.eks.cluster_certificate_authority_data
}

# OIDC/IRSA
output "oidc_provider" {
  description = "OIDC provider URL (sem https://)"
  value       = module.eks.oidc_provider
}

output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = module.eks.oidc_provider_arn
}

# Role usada pelo Cluster Autoscaler (IRSA)
output "autoscaler_role_arn" {
  description = "IAM Role ARN para o Cluster Autoscaler (via IRSA)"
  value       = aws_iam_role.cluster_autoscaler.arn
}
