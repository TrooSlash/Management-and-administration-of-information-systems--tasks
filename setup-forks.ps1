# Скрипт для подготовки заданий 2, 5, 7 с форками

Write-Host "===== Подготовка заданий с форками =====" -ForegroundColor Green
Write-Host ""

# Проверка наличия git
if (!(Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "ОШИБКА: Git не установлен!" -ForegroundColor Red
    exit 1
}

$baseDir = "D:\Yandex.Disk\project"
$currentRepo = "p34"

# Задание 2: grpc/grpc
Write-Host "=== Задание 2: Подготовка grpc/grpc ===" -ForegroundColor Cyan
Write-Host "1. Откройте https://github.com/grpc/grpc"
Write-Host "2. Нажмите кнопку 'Fork' в правом верхнем углу"
Write-Host "3. Создайте форк в вашем аккаунте TrooSlash"
Write-Host ""
Write-Host "После создания форка нажмите Enter для продолжения..."
$null = Read-Host

Write-Host "Клонирование форка grpc..." -ForegroundColor Yellow
Set-Location $baseDir
if (Test-Path "grpc-task2") {
    Write-Host "Папка grpc-task2 уже существует. Пропускаем клонирование." -ForegroundColor Yellow
} else {
    git clone https://github.com/TrooSlash/grpc.git grpc-task2
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ОШИБКА: Не удалось клонировать репозиторий. Убедитесь, что форк создан!" -ForegroundColor Red
        exit 1
    }
}

Set-Location "grpc-task2"
Write-Host "Создание workflow для задания 2..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path ".github/workflows" | Out-Null
Copy-Item "$baseDir\$currentRepo\.github\workflows\task2.yml" -Destination ".github\workflows\task2.yml" -Force

Write-Host "Коммит и пуш workflow..." -ForegroundColor Yellow
git add .github/workflows/task2.yml
git commit -m "Add Trivy CRITICAL vulnerability scan workflow"
git push origin main

Write-Host "✅ Задание 2 настроено!" -ForegroundColor Green
Write-Host ""

# Задание 5 и 7: openssl/openssl
Write-Host "=== Задание 5 и 7: Подготовка openssl/openssl ===" -ForegroundColor Cyan
Write-Host "1. Откройте https://github.com/openssl/openssl"
Write-Host "2. Нажмите кнопку 'Fork' в правом верхнем углу"
Write-Host "3. Создайте форк в вашем аккаунте TrooSlash"
Write-Host ""
Write-Host "После создания форка нажмите Enter для продолжения..."
$null = Read-Host

Write-Host "Клонирование форка openssl..." -ForegroundColor Yellow
Set-Location $baseDir
if (Test-Path "openssl-tasks") {
    Write-Host "Папка openssl-tasks уже существует. Пропускаем клонирование." -ForegroundColor Yellow
} else {
    git clone https://github.com/TrooSlash/openssl.git openssl-tasks
    if ($LASTEXITCODE -ne 0) {
        Write-Host "ОШИБКА: Не удалось клонировать репозиторий. Убедитесь, что форк создан!" -ForegroundColor Red
        exit 1
    }
}

Set-Location "openssl-tasks"
Write-Host "Создание workflows для заданий 5 и 7..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path ".github/workflows" | Out-Null
Copy-Item "$baseDir\$currentRepo\.github\workflows\task5.yml" -Destination ".github\workflows\task5.yml" -Force
Copy-Item "$baseDir\$currentRepo\.github\workflows\task7.yml" -Destination ".github\workflows\task7.yml" -Force

Write-Host "Коммит и пуш workflows..." -ForegroundColor Yellow
git add .github/workflows/
git commit -m "Add Trivy secret and HIGH vulnerability scan workflows"
git push origin master

Write-Host "✅ Задания 5 и 7 настроены!" -ForegroundColor Green
Write-Host ""

Write-Host "===== Все готово! =====" -ForegroundColor Green
Write-Host ""
Write-Host "Перейдите в GitHub Actions для каждого репозитория:"
Write-Host "- https://github.com/TrooSlash/grpc/actions"
Write-Host "- https://github.com/TrooSlash/openssl/actions"
Write-Host ""
Write-Host "Запустите workflows вручную или сделайте пуш для автоматического запуска."
Write-Host ""
