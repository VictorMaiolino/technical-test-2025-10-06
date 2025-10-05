param(
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\modules\eks"
)

Set-Location -Path $Path

# Formata (apenas estética)
terraform fmt -recursive

# Relaxa erro só durante o validate para capturar tudo
$old = $ErrorActionPreference; $ErrorActionPreference = "Continue"
$out = terraform validate -no-color *>&1
$code = $LASTEXITCODE
$ErrorActionPreference = $old

$out | Write-Host
Write-Host "`nExit code:" $code
if ($code -eq 0) { Write-Host "✅ Validate OK" } else { Write-Host "❌ Validate FAILED" }
