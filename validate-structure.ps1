Write-Host "Validando estrutura Megan Life..." -ForegroundColor Cyan

$required = @(
  "android-app/pubspec.yaml",
  "android-app/lib/main.dart",
  "android-app/lib/core/brain/megan_brain.dart",
  "android-app/android/app/src/main/AndroidManifest.xml",
  "backend/package.json",
  "backend/server.js",
  "backend/src/services/brain/brain.service.js"
)

foreach ($file in $required) {
  if (!(Test-Path $file)) {
    Write-Host "FALTANDO: $file" -ForegroundColor Red
    exit 1
  }
  Write-Host "OK: $file" -ForegroundColor Green
}

Write-Host "Estrutura validada." -ForegroundColor Green
