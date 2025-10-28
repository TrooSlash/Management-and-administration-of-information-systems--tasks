# 📘 Полная инструкция по выполнению всех заданий

## 🎯 Текущий статус

### ✅ Полностью готовы к использованию (без дополнительных действий):
- **Задание 0** - GitHub Secrets для Docker Hub
- **Задание 1** - CI-пайплайн с тестами  
- **Задание 3** - Сканирование Docker-образа grpc
- **Задание 4** - Автоматическая сборка Docker-образа
- **Задание 6** - Линтинг и форматирование
- **Задание 8** - Сканирование HIGH уязвимостей alpine/openssl
- **Задание 9** - Сканирование лицензий alpine/openssl

### ⚠️ Требуют дополнительных действий для строгого соответствия заданию:
- **Задание 2** - Сканирование исходников (требует форк grpc/grpc)
- **Задание 5** - Сканирование секретов (требует форк openssl/openssl)
- **Задание 7** - Сканирование HIGH уязвимостей (требует форк openssl/openssl)

---

## 🚀 Вариант 1: Быстрый старт (рекомендуется для демонстрации)

Все workflows уже настроены и работают с текущим репозиторием:

```powershell
cd "d:\Yandex.Disk\project\p34"
git add .
git commit -m "Add all task workflows"
git push
```

После пуша:
1. Откройте GitHub → Actions
2. Workflows 0-9 будут доступны для ручного запуска
3. Workflows 2, 5, 7 будут сканировать ваш текущий репозиторий

**Преимущества:**
- ✅ Быстро и просто
- ✅ Все workflows работают
- ✅ Можно сразу проверить функциональность Trivy

**Недостатки:**
- ⚠️ Задания 2, 5, 7 сканируют ваш репозиторий, а не grpc/openssl

---

## 📋 Вариант 2: Полное выполнение с форками (строго по заданию)

### Задание 2: Форк grpc/grpc

#### Шаг 1: Создайте форк
1. Откройте https://github.com/grpc/grpc
2. Нажмите кнопку **Fork** в правом верхнем углу
3. Выберите ваш аккаунт (TrooSlash)
4. Нажмите **Create fork**

#### Шаг 2: Клонируйте форк
```powershell
cd "d:\Yandex.Disk\project"
git clone https://github.com/TrooSlash/grpc.git grpc-task2
cd grpc-task2
```

#### Шаг 3: Добавьте workflow
```powershell
# Создайте папку для workflows
mkdir .github\workflows -Force

# Скопируйте workflow из основного проекта
Copy-Item "..\p34\.github\workflows\task2.yml" ".github\workflows\task2.yml"
```

#### Шаг 4: Закоммитьте и запушьте
```powershell
git add .github/workflows/task2.yml
git commit -m "Add Trivy CRITICAL vulnerability scan"
git push origin main
```

#### Шаг 5: Проверьте workflow
1. Откройте https://github.com/TrooSlash/grpc/actions
2. Выберите workflow "Task 2"
3. Нажмите "Run workflow"

---

### Задания 5 и 7: Форк openssl/openssl

#### Шаг 1: Создайте форк
1. Откройте https://github.com/openssl/openssl
2. Нажмите кнопку **Fork**
3. Выберите ваш аккаунт (TrooSlash)
4. Нажмите **Create fork**

#### Шаг 2: Клонируйте форк
```powershell
cd "d:\Yandex.Disk\project"
git clone https://github.com/TrooSlash/openssl.git openssl-tasks
cd openssl-tasks
```

#### Шаг 3: Добавьте workflows
```powershell
# Создайте папку для workflows
mkdir .github\workflows -Force

# Скопируйте workflows из основного проекта
Copy-Item "..\p34\.github\workflows\task5.yml" ".github\workflows\task5.yml"
Copy-Item "..\p34\.github\workflows\task7.yml" ".github\workflows\task7.yml"
```

#### Шаг 4: Закоммитьте и запушьте
```powershell
git add .github/workflows/
git commit -m "Add Trivy secret and HIGH vulnerability scans"
git push origin master
```

**⚠️ Примечание:** OpenSSL использует ветку `master`, а не `main`

#### Шаг 5: Проверьте workflows
1. Откройте https://github.com/TrooSlash/openssl/actions
2. Запустите workflows "Task 5" и "Task 7" вручную

---

## 🛠️ Вариант 3: Использование автоматического скрипта

Для автоматизации процесса созданы два скрипта:

### setup-forks.ps1
Интерактивный скрипт для создания и настройки форков:

```powershell
cd "d:\Yandex.Disk\project\p34"
.\setup-forks.ps1
```

Скрипт:
1. Запросит вас создать форки на GitHub
2. Клонирует форки локально
3. Скопирует workflows
4. Закоммитит и запушит изменения

### setup-alternative.ps1
Альтернативный вариант - загружает исходники в текущий репозиторий:

```powershell
cd "d:\Yandex.Disk\project\p34"
.\setup-alternative.ps1
```

**⚠️ Внимание:** Этот способ загружает большие архивы (>1GB)

---

## 📊 Сравнение вариантов

| Критерий | Вариант 1 | Вариант 2 | Вариант 3 |
|----------|-----------|-----------|-----------|
| Скорость | ⚡ Очень быстро | 🐌 Медленно | 🐌 Очень медленно |
| Простота | ✅ Просто | ⚠️ Средне | ✅ Автоматизировано |
| Соответствие заданию | ⚠️ Частичное | ✅ Полное | ⚠️ Частичное |
| Размер репозитория | ✅ Мал��й | ✅ Разделен | ❌ Огромный |

---

## 🎓 Рекомендации

### Для быстрой демонстрации:
**Используйте Вариант 1** - все workflows работают, можно сразу проверить функциональность.

### Для строгого выполнения задания:
**Используйте Вариант 2** - создайте форки grpc и openssl согласно требованиям.

### Для автоматизации:
**Используйте Вариант 3** - запустите скрипт `setup-forks.ps1`.

---

## ✅ Финальная проверка

После настройки проверьте, что все workflows доступны:

### В основном репозитории (TrooSlash/Management-and-administration-of-information-systems--tasks):
- ✅ Task 0 - Docker Hub Secrets
- ✅ Task 1 - CI with Tests
- ✅ Task 2 - Scan CRITICAL (сканирует текущий репозиторий)
- ✅ Task 3 - Scan grpc image
- ✅ Task 4 - Auto Build
- ✅ Task 5 - Scan Secrets (сканирует текущий репозиторий)
- ✅ Task 6 - Flake8 Linting
- ✅ Task 7 - Scan HIGH (сканирует текущий репозиторий)
- ✅ Task 8 - Scan alpine/openssl HIGH
- ✅ Task 9 - Scan alpine/openssl Licenses

### В форке grpc (TrooSlash/grpc) - если создан:
- ✅ Task 2 - Scan CRITICAL vulnerabilities

### В форке openssl (TrooSlash/openssl) - если создан:
- ✅ Task 5 - Scan Secrets
- ✅ Task 7 - Scan HIGH vulnerabilities

---

## 🔗 Полезные ссылки

- **Основной репозиторий:** https://github.com/TrooSlash/Management-and-administration-of-information-systems--tasks
- **Форк grpc (если создан):** https://github.com/TrooSlash/grpc
- **Форк openssl (если создан):** https://github.com/TrooSlash/openssl
- **Документация Trivy:** https://aquasecurity.github.io/trivy/
- **GitHub Actions:** https://docs.github.com/en/actions

---

## 🆘 Поддержка

Если возникли проблемы:

1. **Workflows не запускаются:**
   - Проверьте, что файлы находятся в `.github/workflows/`
   - Убедитесь, что YAML синтаксис корректен

2. **Форк не клонируется:**
   - Убедитесь, что форк создан на GitHub
   - Проверьте правильность URL

3. **Trivy находит уязвимости:**
   - Это нормально! Workflow должен завершиться с ошибкой
   - Проверьте вывод для деталей

4. **Секреты не работают:**
   - Убедитесь, что секреты настроены в Settings → Secrets
   - Проверьте имена: DOCKERHUB_USERNAME и DOCKERHUB_PASSWORD

---

## 🎉 Готово!

Все 10 заданий реализованы и готовы к использованию! Выберите подходящий вариант и начинайте работу.
