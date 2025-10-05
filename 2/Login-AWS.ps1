# Login-AWS-IAM.ps1
# Configura a AWS CLI para um usuário IAM via prompts e testa com STS.

# ---- Prompts ----
$AccessKeyId = Read-Host "AWS Access Key ID (IAM user)"

# Secret em modo oculto
$SecretSecure = Read-Host "AWS Secret Access Key (IAM user)" -AsSecureString
$BSTR = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($SecretSecure)
$SecretPlain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($BSTR)
[Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

$Profile = Read-Host "Profile (ENTER = default)"
if ([string]::IsNullOrWhiteSpace($Profile)) { $Profile = "default" }

$Region = Read-Host "Região (ENTER = us-east-1)"
if ([string]::IsNullOrWhiteSpace($Region)) { $Region = "us-east-1" }

# ---- Limpa env vars que poderiam interferir ----
$env:AWS_ACCESS_KEY_ID  = $null
$env:AWS_SECRET_ACCESS_KEY = $null
$env:AWS_SESSION_TOKEN  = $null
$env:AWS_DEFAULT_REGION = $null
$env:AWS_PROFILE        = $Profile

# ---- Checagem AWS CLI ----
try { aws --version | Out-Null }
catch {
  Write-Error "AWS CLI não encontrada. Instale e tente novamente (aws --version)."
  exit 1
}

# ---- Grava no profile da AWS CLI ----
aws configure set aws_access_key_id     $AccessKeyId     --profile $Profile
aws configure set aws_secret_access_key $SecretPlain     --profile $Profile
aws configure set region                $Region          --profile $Profile
aws configure set output                json             --profile $Profile

# Apaga cópia em texto claro por segurança
$SecretPlain = $null

# ---- Teste ----
Write-Host ""
Write-Host "Testando credenciais (profile '$Profile')..."
try {
  $id = aws sts get-caller-identity --profile $Profile | ConvertFrom-Json
  Write-Host "OK ✅  Account: $($id.Account) | ARN: $($id.Arn)"
} catch {
  Write-Error "Falha no STS. Confira Access Key/Secret e permissões do IAM user."
  exit 2
}
