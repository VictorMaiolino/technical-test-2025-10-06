param(
  # Ajuste se seu path for outro
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\live\eks-lab"
)

Set-StrictMode -Version Latest

Write-Host ">> Directory:" $Path
Set-Location -Path $Path

# 0) Mostra versão do Terraform (garante que responde)
terraform version

# 1) INIT - Reconfigura backend e evita cores para não gerar 'NativeCommandError'
Write-Host "`n>> terraform init (reconfigure, no-color) ..."
$old = $ErrorActionPreference; $ErrorActionPreference = "Continue"
terraform init -reconfigure -no-color -input=false *>&1
$code = $LASTEXITCODE
$ErrorActionPreference = $old
if ($code -ne 0) { throw "Terraform init FAILED (exit $code)" }
Write-Host ">> INIT ✅  (backend reconfigurado com sucesso)"

# 2) PROVIDERS - Apenas leitura
Write-Host "`n>> terraform providers ..."
terraform providers -no-color

# 3) STATE LIST - Deve estar vazio (ainda não aplicamos nada)
Write-Host "`n>> terraform state list ..."
terraform state list
if ($LASTEXITCODE -eq 0) {
  Write-Host ">> STATE ✅  (se não listou nada, está vazio — esperado)"
}

Write-Host "`n>> Done."
