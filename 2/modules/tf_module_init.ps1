param(
  [string]$Path = "C:\Users\victo\OneDrive\Desktop\Teste_tecnico\2\modules\eks"
)

Set-Location -Path $Path
# init apenas para baixar o module source; sem backend, sem aplicar nada
terraform init -no-color -backend=false
