# Альтернативный способ - копирование исходников в текущий репозиторий

Write-Host "===== Альтернативная подготовка заданий 2, 5, 7 =====" -ForegroundColor Green
Write-Host "Этот скрипт загрузит исходники напрямую в ваш текущий репозиторий" -ForegroundColor Yellow
Write-Host ""

$baseDir = "D:\Yandex.Disk\project\p34"
Set-Location $baseDir

# Создаем папки для исходников
Write-Host "Создание структуры папок..." -ForegroundColor Cyan
New-Item -ItemType Directory -Force -Path "external-sources\grpc" | Out-Null
New-Item -ItemType Directory -Force -Path "external-sources\openssl" | Out-Null

# Загрузка архивов исходников
Write-Host ""
Write-Host "Загрузка исходников grpc/grpc..." -ForegroundColor Cyan
Write-Host "Это может занять несколько минут..." -ForegroundColor Yellow

try {
    $grpcUrl = "https://github.com/grpc/grpc/archive/refs/heads/master.zip"
    $grpcZip = "$baseDir\grpc-master.zip"
    
    if (!(Test-Path $grpcZip)) {
        Invoke-WebRequest -Uri $grpcUrl -OutFile $grpcZip -UseBasicParsing
        Write-Host "✅ grpc загружен" -ForegroundColor Green
    } else {
        Write-Host "Файл grpc уже загружен" -ForegroundColor Yellow
    }
    
    Write-Host "Распаковка grpc..." -ForegroundColor Cyan
    Expand-Archive -Path $grpcZip -DestinationPath "$baseDir\external-sources\grpc" -Force
    Write-Host "✅ grpc распакован" -ForegroundColor Green
} catch {
    Write-Host "ОШИБКА при загрузке grpc: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Загрузка исходников openssl/openssl..." -ForegroundColor Cyan
Write-Host "Это может занять несколько минут..." -ForegroundColor Yellow

try {
    $opensslUrl = "https://github.com/openssl/openssl/archive/refs/heads/master.zip"
    $opensslZip = "$baseDir\openssl-master.zip"
    
    if (!(Test-Path $opensslZip)) {
        Invoke-WebRequest -Uri $opensslUrl -OutFile $opensslZip -UseBasicParsing
        Write-Host "✅ openssl загружен" -ForegroundColor Green
    } else {
        Write-Host "Файл openssl уже загружен" -ForegroundColor Yellow
    }
    
    Write-Host "Распаковка openssl..." -ForegroundColor Cyan
    Expand-Archive -Path $opensslZip -DestinationPath "$baseDir\external-sources\openssl" -Force
    Write-Host "✅ openssl распакован" -ForegroundColor Green
} catch {
    Write-Host "ОШИБКА при загрузке openssl: $_" -ForegroundColor Red
}

# Обновление workflows для сканирования правильных папок
Write-Host ""
Write-Host "Обновление workflows..." -ForegroundColor Cyan

# Task 2: обновляем путь для сканирования
$task2Content = @"
name: Task 2 - Scan Source Code for Critical Vulnerabilities (grpc)

on:
  push:
    branches:
      - main
    paths:
      - 'external-sources/grpc/**'
  workflow_dispatch:

jobs:
  trivy-scan:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Install Trivy via APT
        run: |
          sudo apt-get update
          sudo apt-get install -y wget apt-transport-https gnupg lsb-release
          curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
          echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb `$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list
          sudo apt-get update
          sudo apt-get install -y trivy
      
      - name: Scan grpc source code for CRITICAL vulnerabilities
        run: |
          trivy fs --severity CRITICAL --exit-code 1 ./external-sources/grpc/
"@

Set-Content -Path ".github\workflows\task2.yml" -Value $task2Content -Encoding UTF8
Write-Host "✅ task2.yml обновлен" -ForegroundColor Green

# Task 5: обновляем путь для сканирования
$task5Content = @"
name: Task 5 - Scan for Secrets (openssl)

on:
  push:
    branches:
      - main
    paths:
      - 'external-sources/openssl/**'
  workflow_dispatch:

jobs:
  trivy-scan:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Install Trivy via APT
        run: |
          sudo apt-get update
          sudo apt-get install -y wget apt-transport-https gnupg lsb-release
          curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
          echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb `$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list
          sudo apt-get update
          sudo apt-get install -y trivy
      
      - name: Scan openssl source for secrets
        run: |
          trivy fs --scanners secret --exit-code 1 ./external-sources/openssl/
"@

Set-Content -Path ".github\workflows\task5.yml" -Value $task5Content -Encoding UTF8
Write-Host "✅ task5.yml обновлен" -ForegroundColor Green

# Task 7: обновляем путь для сканирования
$task7Content = @"
name: Task 7 - Scan Source Code for HIGH Vulnerabilities (openssl)

on:
  push:
    branches:
      - main
    paths:
      - 'external-sources/openssl/**'
  workflow_dispatch:

jobs:
  trivy-scan:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
      
      - name: Install Trivy via APT
        run: |
          sudo apt-get update
          sudo apt-get install -y wget apt-transport-https gnupg lsb-release
          curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
          echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb `$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list
          sudo apt-get update
          sudo apt-get install -y trivy
      
      - name: Scan openssl source for HIGH vulnerabilities
        run: |
          trivy fs --severity HIGH --exit-code 1 ./external-sources/openssl/
"@

Set-Content -Path ".github\workflows\task7.yml" -Value $task7Content -Encoding UTF8
Write-Host "✅ task7.yml обновлен" -ForegroundColor Green

# Создаем .gitignore для больших файлов
Write-Host ""
Write-Host "Создание .gitignore для архивов..." -ForegroundColor Cyan
$gitignoreContent = @"
# Архивы исходников
*.zip
grpc-master.zip
openssl-master.zip
"@

Add-Content -Path ".gitignore" -Value $gitignoreContent
Write-Host "✅ .gitignore обновлен" -ForegroundColor Green

Write-Host ""
Write-Host "===== Подготовка завершена! =====" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  ВАЖНО: Папка external-sources очень большая!" -ForegroundColor Yellow
Write-Host "Рекомендации:" -ForegroundColor Cyan
Write-Host "1. НЕ коммитьте папку external-sources в git (слишком большая)"
Write-Host "2. Workflows теперь будут сканировать локальные копии исходников"
Write-Host "3. Для тестирования запустите workflows вручную через GitHub Actions"
Write-Host ""
Write-Host "Чтобы закоммитить только workflows:" -ForegroundColor Yellow
Write-Host "  git add .github/workflows/task2.yml"
Write-Host "  git add .github/workflows/task5.yml"
Write-Host "  git add .github/workflows/task7.yml"
Write-Host "  git add .gitignore"
Write-Host "  git commit -m 'Update workflows for local source scanning'"
Write-Host "  git push"
Write-Host ""
