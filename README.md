# Задание 5: Сканирование секретов (openssl)

## Описание

Создать GitHub Actions workflow, который:
- Сканирует локальную копию исходников openssl, находящуюся в репозитории
- Запускает сканер безопасности Trivy с командой `trivy fs --scanners secret`
- При наличии секретов — завершает пайплайн с ошибкой

## Требования

1. Сканироваться должны исходники проекта openssl
2. ✅ **Проект форкнут:** https://github.com/TrooSlash/openssl
3. ✅ **Исходники скопированы локально** в папку `task5/openssl/`
4. При наличии секретов — workflow завершается с exit code 1

## Что делает workflow

### Шаги выполнения:

1. **Checkout code** - скачивает текущий репозиторий (включая все исходники openssl из `task5/openssl/`)
2. **Install Trivy** - устанавливает сканер безопасности Trivy через APT
3. **Scan for secrets** - сканирует локальные исходники openssl на наличие секретов

### Команда сканирования:

```bash
trivy fs --scanners secret --exit-code 1 task5/openssl/
```

**Параметры:**
- `fs` - сканирование файловой системы (исходного кода)
- `--scanners secret` - включить только детектор секретов
- `--exit-code 1` - завершить с кодом ошибки 1 при обнаружении секретов
- `task5/openssl/` - путь к локальной копии исходников openssl

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

# Перейдите в корневую папку репозитория
cd D:\Yandex.Disk\project\p34

# Запустите сканирование локальных исходников
trivy fs --scanners secret task5/openssl/
```

## Структура проекта

```
p34/
├── .github/
│   └── workflows/
│       └── task5.yml          # GitHub Actions workflow
├── task5/
│   └── openssl/               # Локальная копия исходников openssl (~8000+ файлов)
│       ├── crypto/
│       ├── ssl/
│       ├── test/
│       └── ...
├── README.md                  # Этот файл
└── Билеты.md                  # Задания на экзамен
```

## Проверка соответствия заданию

✅ Исходники openssl находятся в репозитории (скопированы из форка)  
✅ Используется команда `trivy fs --scanners secret`  
✅ Флаг `--exit-code 1` завершает workflow при обнаружении секретов  
✅ Сканируется папка `task5/openssl/` (локальная копия исходников openssl)  
✅ Workflow можно запустить вручную через `workflow_dispatch`

## Полезные ссылки

- [Trivy Secret Scanning Documentation](https://trivy.dev/v0.67/docs/scanner/secret/)
- [Форк openssl](https://github.com/TrooSlash/openssl)
- [Оригинальный репозиторий openssl](https://github.com/openssl/openssl)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
