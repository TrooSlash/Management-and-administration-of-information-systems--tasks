# Задание 9: Сканирование лицензий Docker-образа (alpine/openssl)

## Описание задания
Создать GitHub Actions workflow, который:
- Использует официальный образ alpine/openssl:latest
- Запускает Trivy для сканирования лицензий
- Завершает workflow с ошибкой при обнаружении лицензий

## Требования
- Сканируется образ https://hub.docker.com/r/alpine/openssl
- Используется параметр `--scanners license`
- Workflow завершается с ошибкой при обнаружении лицензий

## Реализация

Workflow уже создан: `.github/workflows/task9.yml`

```yaml
name: Task 9 - Scan Docker Image for Licenses (alpine/openssl)

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
      
      - name: Scan Docker image for licenses
        run: |
          trivy image --scanners license --exit-code 1 alpine/openssl:latest
```

## Как запустить

1. Перейдите в GitHub Actions
2. Выберите workflow "Task 9 - Scan Docker Image for Licenses"
3. Нажмите "Run workflow"
4. Выберите ветку `main`
5. Нажмите "Run workflow"

Или сделайте пуш в ветку main - workflow запустится автоматически.

## Зачем сканировать лицензии?

Сканирование лицензий важно для:
- **Соблюдения лицензионных требований**
- **Избежания юридических проблем**
- **Контроля использования open-source**
- **Корпоративной политики безопасности**

Некоторые лицензии (например, GPL) требуют открытия исходного кода вашего проекта.

## Типы лицензий, которые может найти Trivy

- MIT License
- Apache License 2.0
- GPL (v2, v3)
- BSD License
- Mozilla Public License
- ISC License
- И многие другие

## Проверка выполнения

✅ Workflow использует публичный образ alpine/openssl:latest  
✅ Trivy сканирует образ с параметром `--scanners license`  
✅ Проверяются лицензии пакетов в образе  
✅ Workflow завершается с ошибкой при обнаружении (`--exit-code 1`)

## Ожидаемый результат

- Trivy загружает образ alpine/openssl:latest
- Сканирует все пакеты в образе на наличие лицензий
- Показывает список найденных лицензий
- Если найдены лицензии → workflow завершается с ошибкой (красный статус)
- Если не найдены → workflow успешен (зелёный статус)

⚠️ **Примечание:** В реальных проектах обычно есть лицензии, поэтому workflow часто будет "падать" с ошибкой - это нормально и демонстрирует работу сканера.

## Настройка разрешённых лицензий

В production можно настроить политику лицензий, разрешив определённые типы:

```yaml
- name: Scan with allowed licenses
  run: |
    trivy image \
      --scanners license \
      --license-full \
      --ignored-licenses "MIT,Apache-2.0,BSD-3-Clause" \
      --exit-code 1 \
      alpine/openssl:latest
```

## Полное сканирование

Для детального отчёта о лицензиях используйте:

```bash
trivy image --scanners license --license-full alpine/openssl:latest
```

Это покажет:
- Имя пакета
- Версию
- Тип лицензии
- Уверенность в определении лицензии

## Полезные ссылки

- [Trivy License Scanning](https://aquasecurity.github.io/trivy/latest/docs/scanner/license/)
- [Open Source Licenses](https://opensource.org/licenses)
- [Docker Hub: alpine/openssl](https://hub.docker.com/r/alpine/openssl)
- [Choose a License](https://choosealicense.com/)
