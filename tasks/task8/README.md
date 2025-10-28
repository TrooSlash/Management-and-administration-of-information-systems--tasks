# Задание 8: Сканирование HIGH уязвимостей Docker-образа (alpine/openssl)

## Описание задания
Создать GitHub Actions workflow, который:
- Использует официальный образ alpine/openssl:latest
- Запускает Trivy для сканирования на HIGH уязвимости
- Завершает workflow с ошибкой при их обнаружении

## Требования
- Сканируется образ https://hub.docker.com/r/alpine/openssl
- Проверяются HIGH уязвимости
- Workflow завершается с ошибкой при их наличии

## Реализация

Workflow уже создан: `.github/workflows/task8.yml`

```yaml
name: Task 8 - Scan Docker Image for HIGH Vulnerabilities (alpine/openssl)

on:
  push:
    branches:
      - main
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
          echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list
          sudo apt-get update
          sudo apt-get install -y trivy
      
      - name: Scan Docker image for HIGH vulnerabilities
        run: |
          trivy image --severity HIGH --exit-code 1 alpine/openssl:latest
```

## Как запустить

1. Перейдите в GitHub Actions
2. Выберите workflow "Task 8 - Scan Docker Image for HIGH Vulnerabilities"
3. Нажмите "Run workflow"
4. Выберите ветку `main`
5. Нажмите "Run workflow"

Или сделайте пуш в ветку main - workflow запустится автоматически.

## О образе alpine/openssl

Alpine/openssl - это легковесный Docker-образ на базе Alpine Linux с предустановленной библиотекой OpenSSL.

Особенности:
- Очень маленький размер (~5-10 MB)
- Базируется на Alpine Linux
- Содержит утилиты OpenSSL
- Часто используется в production

## Проверка выполнения

✅ Workflow использует публичный образ alpine/openssl:latest  
✅ Trivy сканирует образ командой `trivy image`  
✅ Проверяются HIGH уязвимости  
✅ Workflow завершается с ошибкой при обнаружении (`--exit-code 1`)

## Ожидаемый результат

- Trivy загружает образ alpine/openssl:latest
- Сканирует на наличие HIGH уязвимостей
- Если найдены → workflow завершается с ошибкой (красный статус)
- Если не найдены → workflow успешен (зелёный статус)

## Сравнение с другими заданиями

| Задание | Цель | Severity | Тип сканирования |
|---------|------|----------|------------------|
| Task 2 | grpc source | CRITICAL | Исходники |
| Task 3 | grpc image | CRITICAL | Docker-образ |
| Task 5 | openssl source | Secrets | Исходники |
| Task 7 | openssl source | HIGH | Исходники |
| **Task 8** | **alpine/openssl image** | **HIGH** | **Docker-образ** |
| Task 9 | alpine/openssl image | Licenses | Docker-образ |

## Полезные ссылки

- [Docker Hub: alpine/openssl](https://hub.docker.com/r/alpine/openssl)
- [Документация Trivy](https://aquasecurity.github.io/trivy/)
- [Alpine Linux](https://alpinelinux.org/)
- [Триви сканирование образов](https://aquasecurity.github.io/trivy/latest/docs/target/container_image/)
