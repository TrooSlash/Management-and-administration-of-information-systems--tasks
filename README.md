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

## Результаты сканирования

### Фактические результаты для OpenSSL:

При сканировании исходников openssl было обнаружено **28 файлов с секретами**:

📊 **Статистика:**
- **Всего найдено секретов:** 31 (28 файлов + 3 в исходном коде)
- **Уровень критичности:** HIGH (высокий)
- **Тип секретов:** AsymmetricPrivateKey (приватные ключи)

📁 **Расположение найденных секретов:**

| Категория | Файлов | Описание |
|-----------|--------|----------|
| `apps/*.pem` | 11 | Тестовые ключи для приложений |
| `demos/bio/*.pem` | 2 | Примеры для BIO API |
| `demos/certs/apps/*.pem` | 5 | Демо-сертификаты |
| `demos/cms/*.pem` | 3 | Примеры для CMS |
| `demos/guide/*.pem` | 2 | Демонстрационные ключи |
| `demos/smime/*.pem` | 3 | Примеры для S/MIME |
| `demos/sslecho/key.pem` | 1 | Ключ для SSL Echo |
| `fuzz/dtlsserver.c` | 1 файл (3 ключа) | Жестко закодированные тестовые ключи |

### Примеры найденных секретов:

```
HIGH: AsymmetricPrivateKey (private-key)
════════════════════════════════════════
Asymmetric Private Key
────────────────────────────────────────
 apps/ca-key.pem:2-15 (offset: 28 bytes)
 apps/server.pem:21-46 (offset: 1179 bytes)
 demos/guide/rootkey.pem:2-27 (offset: 28 bytes)
 fuzz/dtlsserver.c:141-166 (offset: 10130 bytes)
```

### Почему это ожидаемо для OpenSSL:

✅ **OpenSSL - криптографическая библиотека**, содержащая:
- Тестовые данные для unit-тестов
- Примеры использования для документации
- Демонстрационные ключи и сертификаты для туториалов

✅ **Все найденные ключи:**
- Являются частью официальной кодовой базы openssl
- Используются для тестирования функционала
- Не представляют реальной угрозы безопасности
- Документированы и общедоступны

✅ **Workflow успешно выполнил задачу:**
- Обнаружил все потенциально опасные данные
- Корректно завершился с exit code 1
- Предоставил детальный отчет о находках

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
- Тестовые приватные ключи (RSA, DSA, EC)
- Примеры сертификатов для демонстрации
- Демонстрационные credentials в исходном коде

Это **нормально** для такого проекта, так как эти файлы используются для тестирования и документации.

### Типы найденных ключей:

🔑 **RSA Private Keys** - наиболее распространенный тип
- Размеры: 512, 1024, 2048, 8192 бит
- Формат: PEM (BEGIN RSA PRIVATE KEY)
- Примеры: `apps/server.pem`, `apps/client.pem`, `demos/bio/server.pem`

🔑 **DSA Private Keys** - цифровая подпись
- Формат: PEM (BEGIN DSA PRIVATE KEY)  
- Примеры: `apps/dsa-ca.pem`, `apps/dsa-pca.pem`

🔑 **EC Private Keys** - эллиптические кривые
- Формат: PEM (BEGIN EC PRIVATE KEY)
- Примеры: `demos/bio/server-ec.pem`

🔑 **Generic Private Keys** - универсальный формат PKCS#8
- Формат: PEM (BEGIN PRIVATE KEY)
- Примеры: `apps/ca-key.pem`, `demos/guide/rootkey.pem`

### Где используются эти ключи:

| Директория | Назначение |
|------------|------------|
| `apps/` | Утилиты командной строки OpenSSL (тестовые данные) |
| `demos/` | Демонстрационные примеры для разработчиков |
| `test/` | Unit-тесты и интеграционные тесты |
| `fuzz/` | Фаззинг-тесты для поиска уязвимостей |

## Локальное тестирование

### Установка Trivy

**Windows (PowerShell):**
```powershell
# Через Chocolatey
choco install trivy

# Через Scoop
scoop install trivy

# Проверка установки
trivy --version
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install -y wget apt-transport-https gnupg lsb-release
curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpg
echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install -y trivy
```

### Запуск сканирования локально

**Базовое сканирование:**
```bash
# Перейдите в корневую папку репозитория
cd D:\Yandex.Disk\project\p34

# Запустите сканирование (без остановки при находках)
trivy fs --scanners secret task5/openssl/

# С завершением при обнаружении секретов (как в CI)
trivy fs --scanners secret --exit-code 1 task5/openssl/
```

**Дополнительные опции:**
```bash
# Сохранить результаты в файл
trivy fs --scanners secret -o results.txt task5/openssl/

# Формат JSON для автоматической обработки
trivy fs --scanners secret -f json -o results.json task5/openssl/

# Показать только HIGH и CRITICAL находки
trivy fs --scanners secret --severity HIGH,CRITICAL task5/openssl/

# Подробный вывод с дополнительной информацией
trivy fs --scanners secret -d task5/openssl/
```

### Интерпретация результатов

**Уровни серьезности:**
- 🔴 **CRITICAL** - критические (требуют немедленного действия)
- 🟠 **HIGH** - высокие (требуют быстрого исправления)
- 🟡 **MEDIUM** - средние (рекомендуется исправить)
- 🟢 **LOW** - низкие (желательно исправить)
- ⚪ **UNKNOWN** - неизвестные (требуют анализа)

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

### Документация Trivy:
- [Trivy Secret Scanning Documentation](https://trivy.dev/v0.67/docs/scanner/secret/)
- [Trivy CLI Reference](https://trivy.dev/v0.67/docs/references/cli/)
- [Trivy Configuration](https://trivy.dev/v0.67/docs/references/configuration/)

### Проект OpenSSL:
- [Форк openssl](https://github.com/TrooSlash/openssl)
- [Оригинальный репозиторий openssl](https://github.com/openssl/openssl)
- [OpenSSL Documentation](https://www.openssl.org/docs/)

### GitHub Actions:
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/writing-workflows/workflow-syntax-for-github-actions)
- [GitHub Secrets](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)

### Репозиторий с заданием:
- [Management-and-administration-of-information-systems--tasks](https://github.com/TrooSlash/Management-and-administration-of-information-systems--tasks)
- [GitHub Actions Runs](https://github.com/TrooSlash/Management-and-administration-of-information-systems--tasks/actions)

## Troubleshooting (решение проблем)

### Проблема: "Trivy not found"

**Решение:**
```bash
# Проверьте, установлен ли Trivy
trivy --version

# Если не установлен, установите согласно инструкции выше
choco install trivy  # Windows
```

### Проблема: "Permission denied" при сканировании

**Решение:**
```bash
# Windows: Запустите PowerShell от имени администратора
# Linux: Используйте sudo или проверьте права доступа
chmod -R 755 task5/openssl/
```

### Проблема: Workflow завершается с ошибкой

**Это ожидаемое поведение!** Если Trivy находит секреты, он завершается с exit code 1.

**Что делать:**
1. Проверьте логи workflow в GitHub Actions
2. Убедитесь, что найденные секреты - это тестовые данные
3. Для реальных проектов - удалите или замените найденные секреты
4. Для учебного проекта (как этот) - это нормально

### Проблема: Слишком долгое сканирование

**Решение:**
```bash
# Сканируйте только конкретную папку
trivy fs --scanners secret task5/openssl/apps/

# Или используйте параллельное сканирование
trivy fs --scanners secret --parallel 8 task5/openssl/
```

## FAQ (Часто задаваемые вопросы)

**Q: Почему workflow падает с ошибкой?**  
A: Это правильное поведение! Флаг `--exit-code 1` заставляет Trivy завершаться с ошибкой при обнаружении секретов. Это нужно для CI/CD пайплайнов.

**Q: Можно ли игнорировать определенные файлы?**  
A: Да, используйте `.trivyignore` файл или флаг `--skip-files`:
```bash
trivy fs --scanners secret --skip-files "apps/*.pem" task5/openssl/
```

**Q: Как сканировать только HIGH и CRITICAL?**  
A: Используйте флаг `--severity`:
```bash
trivy fs --scanners secret --severity HIGH,CRITICAL task5/openssl/
```

**Q: Можно ли запустить сканирование для других репозиториев?**  
A: Да! Замените путь `task5/openssl/` на любую другую папку с исходниками.

**Q: Что делать, если найдены реальные секреты?**  
A: 
1. Немедленно отозвать/изменить скомпрометированные credentials
2. Удалить секреты из истории git (используйте git filter-branch или BFG)
3. Использовать GitHub Secrets или переменные окружения
4. Внедрить pre-commit хуки для предотвращения коммитов с секретами

**Q: Сколько времени занимает сканирование?**  
A: Для OpenSSL (~8000+ файлов) - около 3-5 секунд локально и 10-15 секунд в GitHub Actions.

**Q: Можно ли интегрировать Trivy в pre-commit?**  
A: Да! Создайте `.pre-commit-config.yaml`:
```yaml
repos:
  - repo: local
    hooks:
      - id: trivy
        name: Trivy secret scanner
        entry: trivy fs --scanners secret --exit-code 1 .
        language: system
        pass_filenames: false
```
