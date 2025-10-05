# ======================================================================
# SCRIPT: EKS_PS_Modules_check_and_install.ps1
# OBJETIVO: Verificar e instalar módulos necessários para o exercício EKS
# AUTOR: Victor Maiolino
# ======================================================================


# ────────────────────────────────────────────────
# VERIFICAÇÕES DE INSTALAÇÃO (PASSO 0)
# ────────────────────────────────────────────────

# Terraform - infraestrutura como código
terraform -v

# AWS CLI - autenticação e comandos na AWS
aws --version

# kubectl - cliente do Kubernetes (controla o cluster)
kubectl version --client

# Helm - gerenciador de pacotes/charts do Kubernetes
helm version

# Git - versionamento e repositórios
git --version


# ────────────────────────────────────────────────
# INSTALAÇÃO DOS MÓDULOS (descomente apenas se necessário)
# ────────────────────────────────────────────────

# --- Terraform (Infraestrutura como Código) ---
# winget install -e --id HashiCorp.Terraform -s winget

# --- AWS CLI (autenticação e comandos AWS) ---
# winget install -e --id Amazon.AWSCLI -s winget

# --- kubectl (cliente do Kubernetes) ---
# winget install -e --id Kubernetes.kubectl -s winget

# --- Helm (gerenciador de pacotes para Kubernetes) ---
# winget install -e --id Helm.Helm -s winget

# --- Git (versionamento e GitOps) ---
# winget install -e --id Git.Git -s winget


# ────────────────────────────────────────────────
# DICA FINAL
# ────────────────────────────────────────────────
# 1️⃣ Execute este script no PowerShell:
#     ./EKS_PS_Modules_check_and_install.ps1
#
# 2️⃣ Observe os resultados das verificações de versão.
#     - Se algum comando não for reconhecido, descomente a instalação
#       correspondente e rode novamente.
#
# 3️⃣ Após tudo OK, feche e reabra o PowerShell (para atualizar o PATH).

