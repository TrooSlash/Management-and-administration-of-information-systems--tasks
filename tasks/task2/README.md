# Задание 2: Сканирование уязвимостей исходников (grpc)

## Описание задания
Создать GitHub Actions workflow, который:
- Запускает сканер безопасности Trivy на исходниках проекта grpc/grpc
- Использует команду `trivy fs --severity CRITICAL`
- Завершает пайплайн с ошибкой при наличии критических уязвимостей

## Требования
- Сканируются исходники проекта https://github.com/grpc/grpc
- Проект должен быть форкнут или скопирован в репозиторий

## Как выполнить

### Способ 1: Создание форка (рекомендуется)

1. **Форкните репозиторий:**
   - Перейдите на https://github.com/grpc/grpc
   - Нажмите кнопку **Fork**
   - Создайте форк в вашем аккаунте

2. **Склонируйте форк:**
   ```bash
   git clone https://github.com/ВАШ_ЛОГИН/grpc.git
   cd grpc
   ```

3. **Добавьте workflow:**
   Создайте файл `.github/workflows/trivy-scan.yml`:
   ```yaml
   name: Trivy Security Scan
   
   on:
     push:
       branches: [main, master]
     workflow_dispatch:
   
   jobs:
     trivy-scan:
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
         
         - name: Scan for CRITICAL vulnerabilities
           run: trivy fs --severity CRITICAL --exit-code 1 .
   ```

4. **Закоммитьте и запушьте:**
   ```bash
   git add .github/workflows/trivy-scan.yml
   git commit -m "Add Trivy security scan"
   git push
   ```

5. **Проверьте результат:**
   - Откройте вкладку **Actions** в вашем форке
   - Workflow должен запуститься автоматически

### Способ 2: Демонстрация на текущем репозитории

Workflow `task2.yml` уже создан в основном репозитории и будет сканировать его исходники.

Для запуска:
1. Перейдите в Actions → Task 2
2. Нажмите "Run workflow"

## Проверка выполнения

✅ Workflow создан  
✅ Trivy установлен в workflow  
✅ Сканирование запускается с параметром `--severity CRITICAL`  
✅ Workflow завершается с ошибкой при обнаружении уязвимостей (`--exit-code 1`)

## Ожидаемый результат

- Workflow успешно запускается
- Trivy сканирует исходники
- Если найдены CRITICAL уязвимости → workflow завершается с ошибкой (красный статус)
- Если не найдены → workflow успешен (зелёный статус)

## Полезные ссылки

- [Документация Trivy](https://aquasecurity.github.io/trivy/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Репозиторий grpc/grpc](https://github.com/grpc/grpc)
