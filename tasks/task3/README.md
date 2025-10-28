# Задание 3: Сканирование Docker-образа (grpc)

## Описание задания
Создать GitHub Actions workflow, который:
- Использует официальный публичный Docker-образ из https://hub.docker.com/u/grpc
- Запускает сканер Trivy командой `trivy image`
- Завершает workflow с ошибкой при обнаружении критических уязвимостей

## Требования
- Сканируется официальный образ grpc из Docker Hub
- Проверяются CRITICAL уязвимости
- Workflow завершается с ошибкой при их наличии

## Реализация

Workflow уже создан: `.github/workflows/task3.yml`

```yaml
name: Task 3 - Scan Docker Image for Critical Vulnerabilities (grpc)

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
      
      - name: Scan Docker image for CRITICAL vulnerabilities
        run: |
          trivy image --severity CRITICAL --exit-code 1 grpc/cxx:latest
```

## Доступные образы grpc

На Docker Hub доступны следующие образы:
- `grpc/cxx:latest` - C++ образ
- `grpc/go:latest` - Go образ
- `grpc/java:latest` - Java образ
- `grpc/node:latest` - Node.js образ
- `grpc/python:latest` - Python образ

## Как запустить

1. Перейдите в GitHub Actions
2. Выберите workflow "Task 3 - Scan Docker Image"
3. Нажмите "Run workflow"
4. Выберите ветку `main`
5. Нажмите "Run workflow"

Или сделайте пуш в ветку main - workflow запустится автоматически.

## Проверка выполнения

✅ Workflow использует публичный образ grpc  
✅ Trivy сканирует образ командой `trivy image`  
✅ Проверяются CRITICAL уязвимости  
✅ Workflow завершается с ошибкой при обнаружении (`--exit-code 1`)

## Ожидаемый результат

- Trivy загружает и сканирует Docker-образ
- Если найдены CRITICAL уязвимости → workflow завершается с ошибкой
- Если не найдены → workflow успешен

## Примечание

Если образ `grpc/cxx:latest` недоступен или содержит критические уязвимости, можно изменить на другой образ из списка выше.

## Полезные ссылки

- [Docker Hub grpc](https://hub.docker.com/u/grpc)
- [Документация Trivy](https://aquasecurity.github.io/trivy/)
- [Триvy сканирование образов](https://aquasecurity.github.io/trivy/latest/docs/target/container_image/)
