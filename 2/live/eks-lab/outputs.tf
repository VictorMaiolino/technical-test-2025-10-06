output "cluster_name" {
  value       = module.eks_stack.cluster_name
  description = "EKS cluster name"
}

output "cluster_endpoint" {
  value       = module.eks_stack.cluster_endpoint
  description = "EKS API endpoint"
}

output "oidc_provider" {
  value       = module.eks_stack.oidc_provider
  description = "IRSA OIDC provider URL (sem https://)"
}

output "oidc_provider_arn" {
  value       = module.eks_stack.oidc_provider_arn
  description = "IRSA OIDC provider ARN"
}

output "autoscaler_role_arn" {
  value       = module.eks_stack.autoscaler_role_arn
  description = "IAM Role ARN usada pelo Cluster Autoscaler (IRSA)"
}
