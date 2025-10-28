# Задание 7: Сканирование HIGH уязвимостей (openssl)

## Описание задания
Создать GitHub Actions workflow, который:
- Запускает Trivy на исходниках openssl/openssl
- Проверяет наличие HIGH уязвимостей
- Завершает пайплайн с ошибкой при их обнаружении

## Требования
- Сканируются исходники проекта https://github.com/openssl/openssl
- Проект должен быть форкнут или скопирован
- Используется команда `trivy fs --severity HIGH`

## Как выполнить

### Способ 1: Создание форка (рекомендуется)

1. **Форкните репозиторий:**
   - Перейдите на https://github.com/openssl/openssl
   - Нажмите кнопку **Fork**
   - Создайте форк в вашем аккаунте

2. **Склонируйте форк:**
   ```bash
   git clone https://github.com/ВАШ_ЛОГИН/openssl.git
   cd openssl
   ```

3. **Добавьте workflow:**
   Создайте файл `.github/workflows/trivy-high-vulns.yml`:
   ```yaml
   name: Trivy HIGH Vulnerabilities Scan
   
   on:
     push:
       branches: [master, main]
     workflow_dispatch:
   
   jobs:
     vuln-scan:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v3
         
         - name: Install Trivy
           run: |
             sudo apt-get update
             sudo apt-get install -y wget apt-transport-https gnupg lsb-release
             curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
             echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list
             sudo apt-get update
             sudo apt-get install -y trivy
         
         - name: Scan for HIGH vulnerabilities
           run: trivy fs --severity HIGH --exit-code 1 .
   ```

4. **Закоммитьте и запушьте:**
   ```bash
   git add .github/workflows/trivy-high-vulns.yml
   git commit -m "Add Trivy HIGH vulnerability scan"
   git push
   ```
   
   ⚠️ **Важно:** OpenSSL использует ветку `master`, а не `main`

5. **Проверьте результат:**
   - Откройте вкладку **Actions** в вашем форке
   - Workflow должен запуститься автоматически

### Способ 2: Демонстрация на текущем репозитории

Workflow `task7.yml` уже создан в основном репозитории.

Для запуска:
1. Перейдите в Actions → Task 7
2. Нажмите "Run workflow"

## Уровни серьезности уязвимостей

Trivy использует следующие уровни:
- **CRITICAL** - Критические (самые опасные)
- **HIGH** - Высокие (требуют внимания)
- **MEDIUM** - Средние
- **LOW** - Низкие
- **UNKNOWN** - Неизвестные

В этом задании сканируются только HIGH уязвимости.

## Проверка выполнения

✅ Workflow создан  
✅ Trivy установлен  
✅ Используется параметр `--severity HIGH`  
✅ Workflow завершается с ошибкой при обнаружении HIGH уязвимостей (`--exit-code 1`)

## Ожидаемый результат

- Workflow успешно запускается
- Trivy сканирует исходники на HIGH уязвимости
- Если найдены → workflow завершается с ошибкой (красный статус)
- Если не найдены → workflow успешен (зелёный статус)

## Отличие от Задания 2

- **Задание 2:** Сканирует CRITICAL уязвимости в grpc
- **Задание 7:** Сканирует HIGH уязвимости в openssl

HIGH уязвимости менее критичны, чем CRITICAL, но всё равно требуют исправления.

## Полезные ссылки

- [Документация Trivy](https://aquasecurity.github.io/trivy/)
- [Severity Levels](https://aquasecurity.github.io/trivy/latest/docs/scanner/vulnerability/#severity-selection)
- [Репозиторий openssl/openssl](https://github.com/openssl/openssl)
