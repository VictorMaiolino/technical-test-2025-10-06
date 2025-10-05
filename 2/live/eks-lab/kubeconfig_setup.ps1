# kubeconfig_setup.ps1 
param(
  [string]$Region = "us-east-1",
  [string]$Cluster = "vt-eks-lab",
  [string]$Profile = "default"
)
aws eks update-kubeconfig --region $Region --name $Cluster --profile $Profile
kubectl get nodes -o wide
