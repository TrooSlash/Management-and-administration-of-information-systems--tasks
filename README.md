# Задание 5: Сканирование секретов (openssl)

## Описание

Создать GitHub Actions workflow, который:
- Клонирует репозиторий https://github.com/TrooSlash/openssl (форк openssl/openssl)
- Запускает сканер безопасности Trivy с командой `trivy fs --scanners secret`
- При наличии секретов — завершает пайплайн с ошибкой

## Требования

1. Сканироваться должны исходники проекта openssl
2. ✅ **Проект форкнут:** https://github.com/TrooSlash/openssl
3. При наличии секретов — workflow завершается с exit code 1

## Что делает workflow

### Шаги выполнения:

1. **Checkout code** - скачивает текущий репозиторий
2. **Install Trivy** - устанавливает сканер безопасности Trivy
3. **Clone openssl repository** - клонирует форк openssl
4. **Scan for secrets** - сканирует исходный код openssl на наличие секретов

### Команда сканирования:

```bash
trivy fs --scanners secret --exit-code 1 openssl/
```

**Параметры:**
- `fs` - сканирование файловой системы (исходного кода)
- `--scanners secret` - включить только детектор секретов
- `--exit-code 1` - завершить с кодом ошибки 1 при обнаружении секретов
- `openssl/` - путь к склонированной папке openssl

## Как запустить

### Автоматический запуск:
```bash
git push origin main
```

### Ручной запуск:
1. Откройте вкладку **Actions** на GitHub
2. Выберите workflow **Task 5 - Scan for Secrets**
3. Нажмите **Run workflow** → **Run workflow**

## Ожидаемый результат

### ✅ Если секретов НЕ найдено:
- Workflow завершается успешно (зелёная галочка)
- Exit code: 0

### ❌ Если найдены секреты:
- Workflow завершается с ошибкой (красный крестик)
- Exit code: 1
- В логах будет список найденных секретов (API keys, tokens, passwords и т.д.)

**Это правильное поведение!** Workflow должен падать при обнаружении секретов.

## Что ищет Trivy (типы секретов)

Trivy может обнаружить:
- AWS Access Keys
- GitHub Tokens
- Private SSH Keys
- Database passwords
- API Keys
- OAuth tokens
- JWT tokens
- И многие другие типы credentials

## Примечание об OpenSSL

OpenSSL — это криптографическая библиотека, поэтому в её репозитории могут содержаться:
- Тестовые приватные ключи
- Примеры сертификатов
- Демонстрационные credentials

Это **нормально** для такого проекта, так как эти файлы используются для тестирования и документации.

## Локальное тестирование

```bash
# Установите Trivy (Windows PowerShell)
choco install trivy

# Клонируйте форк openssl
git clone https://github.com/TrooSlash/openssl.git

# Запустите сканирование
trivy fs --scanners secret openssl/
```

## Проверка соответствия заданию

✅ Workflow клонирует репозиторий openssl (форк TrooSlash/openssl)  
✅ Используется команда `trivy fs --scanners secret`  
✅ Флаг `--exit-code 1` завершает workflow при обнаружении секретов  
✅ Сканируется папка `openssl/` (исходники проекта openssl)

## Полезные ссылки

- [Trivy Secret Scanning Documentation](https://trivy.dev/v0.67/docs/scanner/secret/)
- [Форк openssl](https://github.com/TrooSlash/openssl)
- [Оригинальный репозиторий openssl](https://github.com/openssl/openssl)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
