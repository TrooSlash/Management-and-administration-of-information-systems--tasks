# Задание 5: Сканирование секретов (openssl)

## Описание задания
Создать GitHub Actions workflow, который:
- Запускает Trivy с параметром `--scanners secret` на исходниках openssl/openssl
- Завершает пайплайн с ошибкой при обнаружении секретов

## Требования
- Сканируются исходники проекта https://github.com/openssl/openssl
- Проект должен быть форкнут или скопирован в репозиторий
- Используется команда `trivy fs --scanners secret`

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
   Создайте файл `.github/workflows/trivy-secrets.yml`:
   ```yaml
   name: Trivy Secret Scan
   
   on:
     push:
       branches: [master, main]
     workflow_dispatch:
   
   jobs:
     secret-scan:
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
         
         - name: Scan for secrets
           run: trivy fs --scanners secret --exit-code 1 .
   ```

4. **Закоммитьте и запушьте:**
   ```bash
   git add .github/workflows/trivy-secrets.yml
   git commit -m "Add Trivy secret scan"
   git push
   ```
   
   ⚠️ **Важно:** OpenSSL использует ветку `master`, а не `main`

5. **Проверьте результат:**
   - Откройте вкладку **Actions** в вашем форке
   - Workflow должен запуститься автоматически

### Способ 2: Демонстрация на текущем репозитории

Workflow `task5.yml` уже создан в основном репозитории.

Для запуска:
1. Перейдите в Actions → Task 5
2. Нажмите "Run workflow"

## Что ищет Trivy

Trivy ищет следующие типы секретов:
- API ключи (AWS, GCP, Azure, etc.)
- Токены доступа
- Пароли в коде
- Private keys
- Сертификаты
- Database connection strings
- И другие чувствительные данные

## Проверка выполнения

✅ Workflow создан  
✅ Trivy установлен  
✅ Используется параметр `--scanners secret`  
✅ Workflow завершается с ошибкой при обнаружении секретов (`--exit-code 1`)

## Ожидаемый результат

- Workflow успешно запускается
- Trivy сканирует исходники на наличие секретов
- Если найдены секреты → workflow завершается с ошибкой (красный статус)
- Если не найдены → workflow успешен (зелёный статус)

## Примечание

В проекте OpenSSL могут быть найдены тестовые ключи и сертификаты - это нормально для библиотеки криптографии. В реальном проекте такие файлы должны быть исключены из сканирования.

## Полезные ссылки

- [Документация Trivy Secret Scanning](https://aquasecurity.github.io/trivy/latest/docs/scanner/secret/)
- [Репозиторий openssl/openssl](https://github.com/openssl/openssl)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
