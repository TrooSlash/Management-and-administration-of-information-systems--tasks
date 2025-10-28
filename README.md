# Задание 5: Сканирование секретов в репозитории OpenSSL# Задания на экзамен по GitHub Actions и Docker Security



## 📋 Описание проекта## 📋 Обзор проекта



Этот репозиторий содержит реализацию GitHub Actions workflow для автоматического сканирования секретов в исходном коде проекта OpenSSL с использованием сканера безопасности Trivy.Этот репозиторий содержит реализацию всех 10 экзаменационных заданий по автоматизации CI/CD с использованием GitHub Actions, Docker и сканера безопасности Trivy.



**Статус:** ✅ Задание реализовано и протестировано**Статус:** ✅ Все 10 заданий реализованы и протестированы



---## 🎯 Список заданий



## 🎯 Задание| № | Название | Тип | Статус | Workflow |

|---|----------|-----|--------|----------|

Создать GitHub Actions workflow, который:| 0 | GitHub Secrets для Docker Hub | CI/CD | ✅ Готово | `task0.yml` |

- Запускает сканер безопасности Trivy с командой `trivy fs --scanners secret`| 1 | CI-пайплайн с unit-тестами | CI/CD | ✅ Готово | `task1.yml` |

- Сканирует исходники проекта https://github.com/openssl/openssl| 2 | Сканирование уязвимостей исходников (grpc CRITICAL) | Security | ✅ Готово | `task2.yml` |

- При наличии секретов — завершает пайплайн с ошибкой| 3 | Сканирование Docker-образа (grpc CRITICAL) | Security | ✅ Готово | `task3.yml` |

| 4 | Автоматическая сборка Docker-образа | CI/CD | ✅ Готово | `task4.yml` |

### Требования:| 5 | Сканирование секретов (openssl) | Security | ✅ Готово | `task5.yml` |

1. ✅ Сканируются исходники проекта openssl| 6 | Линтинг flake8 перед сборкой | CI/CD | ✅ Готово | `task6.yml` |

2. ✅ **Проект форкнут:** https://github.com/TrooSlash/openssl| 7 | Сканирование уязвимостей исходников (openssl HIGH) | Security | ✅ Готово | `task7.yml` |

3. ✅ При наличии секретов — workflow завершается с exit code 1| 8 | Сканирование Docker-образа (alpine HIGH) | Security | ✅ Готово | `task8.yml` |

| 9 | Сканирование лицензий Docker-образа | Security | ✅ Готово | `task9.yml` |

---

---

## 🚀 Как работает workflow

## 📚 Подробное описание заданий

### Шаги выполнения:

### 🔒 Задание 0: Использование GitHub Secrets для аутентификации

1. **Checkout code** - скачивает текущий репозиторий

2. **Install Trivy via APT** - устанавливает сканер безопасности Trivy**Цель:** Создать GitHub Actions workflow, который логинится в Docker Hub с секретами без раскрытия учетных данных в коде.

3. **Clone openssl repository** - клонирует форк OpenSSL

4. **Scan for secrets in openssl source code** - сканирует исходный код на наличие секретов**Что сделано:**

- ✅ Исправлен Dockerfile (заменен несуществующий пакет на Flask)

### Команда сканирования:- ✅ Создан requirements.txt

- ✅ Создан workflow с использованием `docker/login-action`

```bash- ✅ Настроена безопасная работа с GitHub Secrets

trivy fs --scanners secret --exit-code 1 openssl/

```**Технологии:** GitHub Actions, Docker Hub, GitHub Secrets



**Параметры:****Как работает workflow:**

- `fs` - сканирование файловой системы (исходного кода)1. Checkout кода из репозитория

- `--scanners secret` - включить только детектор секретов2. Логин в Docker Hub через секреты (`DOCKERHUB_USERNAME`, `DOCKERHUB_PASSWORD`)

- `--exit-code 1` - завершить с кодом ошибки 1 при обнаружении секретов3. Сборка Docker-образа

- `openssl/` - путь к склонированной папке openssl4. Публикация образа в Docker Hub



---**Запуск:**

- 🔄 Автоматически: при пуше в ветку `main` (изменения в `tasks/task0/`)

## 📁 Структура проекта- ▶️ Вручную: Actions → Task 0 → Run workflow



```**Ожидаемый результат:** ✅ Образ опубликован в Docker Hub без раскрытия credentials

.

├── .github/---

│   └── workflows/

│       └── task5.yml          # Workflow для сканирования секретов### 🧪 Задание 1: CI-пайплайн с тестами

│

├── tasks/**Цель:** Создать workflow, который запускает unit-тесты и при успехе билдит Docker-образ.

│   └── task5/

│       └── README.md          # Подробная документация задания**Что сделано:**

│- ✅ Исправлен Dockerfile (опечатка `requiremens.txt` → `requirements.txt`)

├── Билеты.md                  # Исходное описание задания- ✅ Создан requirements.txt (Flask==3.0.0, pytest==7.4.3)

└── README.md                  # Этот файл- ✅ Исправлены unit-тесты (status_code: 400 → 200)

```- ✅ Создан workflow с условной сборкой



---**Технологии:** pytest, Flask, Docker, GitHub Actions



## 🔧 Запуск workflow**Как работает workflow:**

1. Checkout кода

### Автоматический запуск:2. Установка Python и зависимостей

Workflow запускается автоматически при пуше в ветку `main`:3. Запуск тестов: `pytest unit_test.py`

```bash4. **Если тесты прошли** → сборка и пуш образа

git add .5. **Если тесты упали** → workflow останавливается с ошибкой

git commit -m "Update files"

git push origin main**Запуск:**

```- 🔄 Автоматически: при пуше в `main` (изменения в `tasks/task1/`)

- ▶️ Вручную: Actions → Task 1 → Run workflow

### Ручной запуск:

1. Откройте вкладку **Actions** на GitHub**Ожидаемый результат:** ✅ Тесты пройдены → образ в Docker Hub

2. Выберите workflow **Task 5 - Scan for Secrets**

3. Нажмите **Run workflow** → **Run workflow**---



---### 🔍 Задание 2: Сканирование уязвимостей исходников (grpc)



## 📊 Ожидаемые результаты**Цель:** Запустить Trivy для сканирования исходного кода на CRITICAL уязвимости.



### ✅ Если секретов НЕ найдено:**Что сделано:**

- Workflow завершается успешно (зелёная галочка)- ✅ Создан workflow с установкой Trivy

- Exit code: 0- ✅ Настроено сканирование: `trivy fs --severity CRITICAL --exit-code 1`

- Статус: Success- ✅ Workflow завершается с ошибкой при обнаружении уязвимостей



### ❌ Если найдены секреты:**Технологии:** Trivy, GitHub Actions

- Workflow завершается с ошибкой (красный крестик)

- Exit code: 1**Команда сканирования:**

- В логах отображается список найденных секретов```bash

- **Это правильное поведение!** Workflow должен падать при обнаружении секретов.trivy fs --severity CRITICAL --exit-code 1 .

```

---

**Условия:**

## 🔍 Что ищет Trivy- Должен быть форк https://github.com/grpc/grpc

- Или демонстрация на текущем репозитории

Trivy автоматически обнаруживает следующие типы секретов:

**Запуск:**

- **AWS Access Keys** - ключи доступа Amazon Web Services- 🔄 Автоматически: при пуше в `main`

- **GitHub Tokens** - токены GitHub API- ▶️ Вручную: Actions → Task 2 → Run workflow

- **Private SSH Keys** - приватные SSH ключи

- **Database Passwords** - пароли баз данных**Ожидаемый результат:** 

- **API Keys** - API ключи различных сервисов- ✅ Нет CRITICAL уязвимостей → workflow успешен

- **OAuth Tokens** - токены OAuth аутентификации- ❌ Есть CRITICAL уязвимости → workflow завершается с exit code 1

- **JWT Tokens** - JSON Web Tokens

- **Azure Credentials** - учётные данные Azure---

- **Google Cloud Keys** - ключи Google Cloud Platform

- **Slack Tokens** - токены Slack API### 🐳 Задание 3: Сканирование Docker-образа (grpc)

- **И многие другие типы credentials**

**Цель:** Просканировать публичный Docker-образ на критические уязвимости.

---

**Что сделано:**

## 💡 Примечание об OpenSSL- ✅ Создан workflow для сканирования `grpc/cxx:latest`

- ✅ Настроено: `trivy image --severity CRITICAL --exit-code 1`

OpenSSL — это криптографическая библиотека, поэтому в её репозитории содержатся:- ✅ Протестировано: найдено 85 CRITICAL уязвимостей (Debian 9.5)

- Тестовые приватные ключи

- Примеры сертификатов**Технологии:** Trivy, Docker Hub

- Демонстрационные credentials для документации

**Команда сканирования:**

Это **нормально** для такого проекта, так как эти файлы используются исключительно для тестирования и примеров.```bash

trivy image --severity CRITICAL --exit-code 1 grpc/cxx:latest

---```



## 🛠️ Локальное тестирование**Запуск:**

- 🔄 Автоматически: при пуше в `main`

### Установка Trivy- ▶️ Вручную: Actions → Task 3 → Run workflow



**Windows (PowerShell):****Результат тестирования:** ✅ Workflow корректно завершился с exit code 1 при обнаружении 85 CRITICAL уязвимостей (ожидаемое поведение)

```powershell

# Через Chocolatey---

choco install trivy

### ⚙️ Задание 4: Автоматическая сборка Docker-образа

# Или через Scoop

scoop install trivy**Цель:** Создать workflow для автоматической сборки и публикации образа при каждом пуше в любую ветку.

```

**Что сделано:**

**Linux (Ubuntu/Debian):**- ✅ Исправлен Dockerfile (опечатка в requirements.txt)

```bash- ✅ Создан requirements.txt

sudo apt-get install wget apt-transport-https gnupg lsb-release- ✅ Создан workflow с триггером на **любую ветку**

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list**Технологии:** Docker, GitHub Actions

sudo apt-get update

sudo apt-get install trivy**Как работает workflow:**

```1. Checkout кода

2. Логин в Docker Hub

### Запуск сканирования3. Сборка образа: `docker build`

4. Публикация образа: `docker push`

```bash

# Клонируйте форк openssl**Запуск:**

git clone https://github.com/TrooSlash/openssl.git- 🔄 Автоматически: при пуше в **ЛЮБУЮ ветку** (изменения в `tasks/task4/`)

- ▶️ Вручную: Actions → Task 4 → Run workflow

# Запустите сканирование

trivy fs --scanners secret openssl/**Ожидаемый результат:** ✅ Образ автоматически появляется в Docker Hub



# С флагом exit-code (как в CI)---

trivy fs --scanners secret --exit-code 1 openssl/

```### 🔐 Задание 5: Сканирование секретов (openssl)



---**Цель:** Найти случайно закоммиченные секреты в исходном коде.



## 📚 Технологии**Что сделано:**

- ✅ Создан workflow с Trivy

| Технология | Назначение |- ✅ Настроено сканирование секретов: `trivy fs --scanners secret --exit-code 1`

|------------|------------|

| **GitHub Actions** | CI/CD платформа для автоматизации |**Технологии:** Trivy (secret detection), GitHub Actions

| **Trivy** | Сканер безопасности от Aqua Security |

| **OpenSSL** | Криптографическая библиотека (объект сканирования) |**Команда сканирования:**

| **Git** | Система контроля версий |```bash

trivy fs --scanners secret --exit-code 1 .

---```



## ❓ Часто задаваемые вопросы**Условия:**

- Должен быть форк https://github.com/openssl/openssl

### Q: Почему workflow завершился с exit code 1?- Или демонстрация на текущем репозитории



**A:** Это **ожидаемое поведение**! **Запуск:**

- 🔄 Автоматически: при пуше в `main`

Флаг `--exit-code 1` специально заставляет workflow завершаться с ошибкой при обнаружении секретов. Это необходимо для:- ▶️ Вручную: Actions → Task 5 → Run workflow

- Предотвращения деплоя кода с утечкой credentials

- Уведомления разработчиков о проблеме безопасности**Ожидаемый результат:**

- Блокировки merge request с секретами- ✅ Нет секретов → workflow успешен

- ❌ Найдены секреты → workflow завершается с ошибкой

### Q: Что делать, если найдены "ложные срабатывания"?

---

**A:** Используйте `.trivyignore` файл для исключения файлов:

```### 🎨 Задание 6: Линтинг и форматирование перед сборкой

# .trivyignore

test/fixtures/test_key.pem**Цель:** Проверить код на соответствие PEP8 с помощью flake8 перед сборкой образа.

demo/example_token.txt

```**Что сделано:**

- ✅ Исправлен код app.py (форматирование по PEP8)

### Q: Можно ли игнорировать определённые типы секретов?- ✅ Исправлен Dockerfile (COPY bad_script.py → app.py)

- ✅ Создан .flake8 конфигурационный файл

**A:** Да, используйте параметр `--skip-files`:- ✅ Создан workflow с проверкой flake8

```bash

trivy fs --scanners secret --skip-files "*/test/*" openssl/**Технологии:** flake8, Python, Docker, GitHub Actions

```

**Как работает workflow:**

### Q: Как запустить сканирование только на изменённых файлах?1. Checkout кода

2. Установка Python и flake8

**A:** Используйте git diff и передайте список файлов в Trivy:3. Запуск линтинга: `flake8 .`

```bash4. **Если линтинг прошел** → сборка и пуш образа

git diff --name-only HEAD~1 | xargs trivy fs --scanners secret5. **Если есть ошибки стиля** → workflow останавливается

```

**Запуск:**

---- 🔄 Автоматически: при пуше в любую ветку (изменения в `tasks/task6/`)

- ▶️ Вручную: Actions → Task 6 → Run workflow

## 🔗 Полезные ссылки

**Ожидаемый результат:** ✅ Код соответствует PEP8 → образ опубликован

### Документация

- [Trivy Documentation](https://aquasecurity.github.io/trivy/)---

- [Trivy Secret Scanning](https://trivy.dev/v0.67/docs/scanner/secret/)

- [GitHub Actions Documentation](https://docs.github.com/en/actions)### 🔍 Задание 7: Сканирование HIGH уязвимостей исходников (openssl)

- [OpenSSL Project](https://www.openssl.org/)

**Цель:** Найти высокие уязвимости в исходном коде проекта openssl.

### Репозитории

- [Форк OpenSSL](https://github.com/TrooSlash/openssl)**Что сделано:**

- [Оригинальный OpenSSL](https://github.com/openssl/openssl)- ✅ Создан workflow с Trivy

- [Trivy GitHub](https://github.com/aquasecurity/trivy)- ✅ Настроено сканирование: `trivy fs --severity HIGH --exit-code 1`



### Статьи и руководства**Технологии:** Trivy, GitHub Actions

- [Secret Detection Best Practices](https://trivy.dev/v0.67/docs/scanner/secret#recommendation)

- [GitHub Actions Security](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)**Команда сканирования:**

```bash

---trivy fs --severity HIGH --exit-code 1 .

```

## 🎓 Дополнительная информация

**Условия:**

### Workflow файл- Должен быть форк https://github.com/openssl/openssl

- Или демонстрация на текущем репозитории

Полный workflow находится в `.github/workflows/task5.yml`

**Запуск:**

```yaml- 🔄 Автоматически: при пуше в `main`

name: Task 5 - Scan for Secrets- ▶️ Вручную: Actions → Task 7 → Run workflow



on:**Ожидаемый результат:**

  push:- ✅ Нет HIGH уязвимостей → workflow успешен

    branches:- ❌ Есть HIGH уязвимости → workflow завершается с exit code 1

      - main

  workflow_dispatch:---



jobs:### 🐋 Задание 8: Сканирование HIGH уязвимостей Docker-образа (alpine/openssl)

  trivy-scan:

    runs-on: ubuntu-latest**Цель:** Просканировать публичный образ alpine/openssl на высокие уязвимости.

    

    steps:**Что сделано:**

      - name: Checkout code- ✅ Создан workflow для сканирования `alpine/openssl:latest`

        uses: actions/checkout@v3- ✅ Настроено: `trivy image --severity HIGH --exit-code 1`

      

      - name: Install Trivy via APT**Технологии:** Trivy, Docker Hub

        run: |

          sudo apt-get update**Команда сканирования:**

          sudo apt-get install -y wget apt-transport-https gnupg lsb-release```bash

          curl -fsSL https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /usr/share/keyrings/trivy.gpgtrivy image --severity HIGH --exit-code 1 alpine/openssl:latest

          echo "deb [signed-by=/usr/share/keyrings/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list```

          sudo apt-get update

          sudo apt-get install -y trivy**Запуск:**

      - 🔄 Автоматически: при пуше в `main`

      - name: Clone openssl repository- ▶️ Вручную: Actions → Task 8 → Run workflow

        run: |

          echo "Cloning openssl repository..."**Ожидаемый результат:**

          git clone https://github.com/TrooSlash/openssl.git- ✅ Нет HIGH уязвимостей → workflow успешен

      - ❌ Есть HIGH уязвимости → workflow завершается с ошибкой

      - name: Scan for secrets in openssl source code

        run: |---

          echo "Scanning openssl repository for secrets..."

          trivy fs --scanners secret --exit-code 1 openssl/### 📜 Задание 9: Сканирование лицензий Docker-образа (alpine/openssl)

```

**Цель:** Проверить лицензии пакетов в Docker-образе на наличие проблемных (GPL, MPL и др.).

---

**Что сделано:**

## 🎯 Заключение- ✅ Создан workflow для сканирования лицензий

- ✅ Настроено: `trivy image --scanners license --exit-code 1`

Задание **полностью реализовано и соответствует требованиям**:- ✅ Протестировано: найдено 20 лицензий, 9 из них HIGH (GPL-2.0)



✅ Workflow клонирует форк OpenSSL репозитория  **Технологии:** Trivy (license scanning), Docker Hub

✅ Используется Trivy с параметром `--scanners secret`  

✅ Флаг `--exit-code 1` завершает workflow при обнаружении секретов  **Команда сканирования:**

✅ Сканируется папка `openssl/` (исходники проекта)  ```bash

✅ Workflow может запускаться вручную или автоматически  trivy image --scanners license --exit-code 1 alpine/openssl:latest

```

**Проект готов к демонстрации и сдаче экзамена! 🚀**

**Запуск:**

---- 🔄 Автоматически: при пуше в `main`

- ▶️ Вручную: Actions → Task 9 → Run workflow

## 📝 Лицензия

**Результат тестирования:** ✅ Workflow корректно завершился с exit code 1 при обнаружении 9 пакетов с GPL-2.0 (restricted) лицензиями

Этот проект создан в образовательных целях для экзаменационного задания по курсу "Управление и администрирование информационных систем".

**Типы лицензий:**

---- **HIGH (restricted):** GPL-2.0 - требует открытия исходников

- **MEDIUM (reciprocal):** MPL-2.0 - частичная обязанность открытия кода

## 👤 Автор- **LOW (notice):** MIT, Apache-2.0 - свободные лицензии



**Repository:** [Management-and-administration-of-information-systems--tasks](https://github.com/TrooSlash/Management-and-administration-of-information-systems--tasks)---



**Owner:** TrooSlash## 🚀 Быстрый старт



**Форк OpenSSL:** [TrooSlash/openssl](https://github.com/TrooSlash/openssl)### 1️⃣ Настройка GitHub Secrets (для заданий 0, 1, 4, 6)


**Создайте токен Docker Hub:**
1. Войдите на https://hub.docker.com
2. Перейдите: Account Settings → Security → New Access Token
3. Название: `GitHub Actions`
4. Скопируйте токен (показывается только один раз!)

**Добавьте секреты в GitHub:**
1. Откройте ваш репозиторий на GitHub
2. Перейдите: Settings → Secrets and variables → Actions
3. Нажмите **New repository secret** и добавьте:
   - Name: `DOCKERHUB_USERNAME` → Value: ваш_логин_dockerhub
   - Name: `DOCKERHUB_PASSWORD` → Value: созданный_токен

### 2️⃣ Проверка работы workflows

**Способ 1: Автоматический запуск**
```bash
git add .
git commit -m "Test workflow"
git push origin main
```

**Способ 2: Ручной запуск**
1. Откройте вкладку **Actions** на GitHub
2. Выберите нужный workflow (например, "Task 0: Docker Hub Secrets")
3. Нажмите **Run workflow** → Run workflow

### 3️⃣ Просмотр результатов

1. Перейдите в **Actions** → выберите workflow run
2. Изучите логи каждого шага
3. Проверьте статус: ✅ зелёная галочка = успех, ❌ красный крестик = ошибка

**Для заданий с Docker Hub (0, 1, 4, 6):**
- Откройте https://hub.docker.com/repositories
- Найдите ваш репозиторий
- Проверьте наличие нового образа с тегом `latest`

**Для заданий с Trivy (2, 3, 5, 7, 8, 9):**
- Изучите лог workflow
- Если найдены уязвимости/секреты/лицензии → exit code 1 ✅ (это правильное поведение!)
- Если ничего не найдено → workflow успешен ✅



---

## 📁 Структура проекта

```
.
├── .github/
│   └── workflows/
│       ├── task0.yml          # Docker Hub Secrets
│       ├── task1.yml          # CI с pytest
│       ├── task2.yml          # Trivy scan (grpc CRITICAL)
│       ├── task3.yml          # Trivy image (grpc CRITICAL)
│       ├── task4.yml          # Auto-build Docker
│       ├── task5.yml          # Trivy secrets (openssl)
│       ├── task6.yml          # flake8 + Docker
│       ├── task7.yml          # Trivy scan (openssl HIGH)
│       ├── task8.yml          # Trivy image (alpine HIGH)
│       └── task9.yml          # Trivy licenses (alpine)
│
├── tasks/
│   ├── task0/
│   │   ├── app.py             # Flask приложение
│   │   ├── Dockerfile         # ✅ Исправлен
│   │   └── requirements.txt   # Flask==3.0.0
│   │
│   ├── task1/
│   │   ├── app.py             # Flask приложение
│   │   ├── unit_test.py       # ✅ Исправлен (assert 200)
│   │   ├── Dockerfile         # ✅ Исправлен
│   │   └── requirements.txt   # Flask + pytest
│   │
│   ├── task2/
│   │   └── README.md          # Инструкции для форка grpc
│   │
│   ├── task3/
│   │   └── README.md          # Инструкции для сканирования образа
│   │
│   ├── task4/
│   │   ├── app.py             # Flask приложение
│   │   ├── Dockerfile         # ✅ Исправлен
│   │   └── requirements.txt   # Flask==3.0.0
│   │
│   ├── task5/
│   │   └── README.md          # Инструкции для форка openssl
│   │
│   ├── task6/
│   │   ├── app.py             # ✅ Отформатирован по PEP8
│   │   ├── .flake8            # Конфигурация линтера
│   │   ├── Dockerfile         # ✅ Исправлен
│   │   └── requirements.txt   # Python 3.11-slim
│   │
│   ├── task7/
│   │   └── README.md          # Инструкции для сканирования HIGH
│   │
│   ├── task8/
│   │   └── README.md          # Инструкции для alpine/openssl
│   │
│   └── task9/
│       └── README.md          # Инструкции для сканирования лицензий
│
├── Билеты.md                  # Исходное описание заданий
└── README.md                  # Этот файл
```

---

## 🔧 Технологии и инструменты

| Технология | Использование | Задания |
|------------|---------------|---------|
| **GitHub Actions** | CI/CD автоматизация | Все задания |
| **Docker** | Контейнеризация приложений | 0, 1, 4, 6 |
| **Docker Hub** | Реестр Docker-образов | 0, 1, 4, 6 |
| **Trivy** | Сканер безопасности | 2, 3, 5, 7, 8, 9 |
| **Python 3.11** | Язык программирования | 0, 1, 4, 6 |
| **Flask 3.0.0** | Web-фреймворк | 0, 1, 4 |
| **pytest 7.4.3** | Unit-тестирование | 1 |
| **flake8** | Линтер для Python (PEP8) | 6 |
| **GitHub Secrets** | Безопасное хранение credentials | 0, 1, 4, 6 |

---

## ❓ Часто задаваемые вопросы (FAQ)

### Q: Почему workflow завершился с exit code 1?

**A:** Это **ожидаемое поведение** для заданий с Trivy (2, 3, 5, 7, 8, 9)!

Флаг `--exit-code 1` специально заставляет workflow завершаться с ошибкой при обнаружении:
- **Задания 2, 3:** CRITICAL уязвимостей
- **Задание 5:** Секретов в коде
- **Задания 7, 8:** HIGH уязвимостей
- **Задание 9:** Проблемных лицензий (GPL, MPL)

**Пример:** Задание 3 нашло 85 CRITICAL уязвимостей в `grpc/cxx:latest` → exit code 1 ✅ **правильно!**

### Q: Workflow не запускается автоматически?

**A:** Проверьте:
1. Изменения должны быть в правильной папке (например, `tasks/task0/` для задания 0)
2. Пуш должен быть в нужную ветку (`main` или любую для заданий 4, 6)
3. Файл workflow находится в `.github/workflows/`
4. YAML синтаксис корректен

### Q: Ошибка "Invalid username or password" при логине в Docker Hub?

**A:** Решение:
1. Используйте **Access Token**, а не пароль от аккаунта
2. Проверьте имена секретов: `DOCKERHUB_USERNAME` и `DOCKERHUB_PASSWORD`
3. Убедитесь, что токен активен и не истёк
4. Пересоздайте токен в Docker Hub → Account Settings → Security

### Q: flake8 выдаёт ошибки (задание 6)?

**A:** Проверьте:
- Код соответствует PEP8 (отступы 4 пробела, максимум 79 символов в строке)
- Нет лишних пустых строк в конце файла
- Есть newline в конце файла
- Используется `.flake8` конфигурация

Запустите локально:
```bash
pip install flake8
flake8 tasks/task6/app.py
```

### Q: Тесты не проходят (задание 1)?

**A:** Убедитесь:
- `app.py` не был изменён (должен возвращать "Hello")
- `unit_test.py` проверяет `status_code == 200` (не 400!)
- Зависимости установлены: `Flask==3.0.0`, `pytest==7.4.3`

### Q: Где увидеть опубликованные Docker-образы?

**A:** 
1. Откройте https://hub.docker.com
2. Войдите в свой аккаунт
3. Перейдите в **Repositories**
4. Найдите репозитории:
   - `<username>/task0-app:latest`
   - `<username>/task1-app:latest`
   - `<username>/task4-app:latest`
   - `<username>/task6-app:latest`

### Q: Можно ли запустить Trivy локально?

**A:** Да! Установка на Windows (PowerShell):
```powershell
# Через Chocolatey
choco install trivy

# Или через Scoop
scoop install trivy
```

Примеры команд:
```bash
# Сканирование Docker-образа
trivy image --severity CRITICAL grpc/cxx:latest

# Сканирование исходников
trivy fs --severity HIGH .

# Поиск секретов
trivy fs --scanners secret .

# Проверка лицензий
trivy image --scanners license alpine/openssl:latest
```

---

## 🎓 Полезные команды

### Git команды
```bash
# Клонирование репозитория
git clone https://github.com/<username>/Management-and-administration-of-information-systems--tasks.git

# Создание новой ветки (для задания 4)
git checkout -b test-branch

# Коммит и пуш
git add .
git commit -m "Update task0"
git push origin main

# Просмотр истории
git log --oneline
```

### Docker команды (локальное тестирование)
```bash
# Сборка образа
docker build -t test-app tasks/task0/

# Запуск контейнера
docker run -p 5000:5000 test-app

# Проверка работы
curl http://localhost:5000

# Просмотр образов
docker images

# Остановка и удаление
docker ps -a
docker stop <container_id>
docker rm <container_id>
```

### Python команды (локальное тестирование)
```bash
# Создание виртуального окружения
python -m venv venv
venv\Scripts\activate  # Windows
source venv/bin/activate  # Linux/Mac

# Установка зависимостей
pip install -r tasks/task1/requirements.txt

# Запуск тестов
pytest tasks/task1/unit_test.py

# Запуск flake8
flake8 tasks/task6/app.py

# Запуск приложения
cd tasks/task0
python app.py
```

---

## 🐛 Устранение неполадок

### Проблема: "Resource not accessible by integration"

**Решение:**
1. Settings → Actions → General
2. Workflow permissions → **Read and write permissions**
3. Сохраните изменения

### Проблема: "No space left on device"

**Решение:** GitHub Actions предоставляет ограниченное пространство. Очистите неиспользуемые образы:
```yaml
- name: Clean up Docker
  run: docker system prune -af
```

### Проблема: Trivy слишком долго скачивает базу уязвимостей

**Решение:** Используйте кэширование:
```yaml
- name: Cache Trivy DB
  uses: actions/cache@v3
  with:
    path: ~/.cache/trivy
    key: ${{ runner.os }}-trivy-${{ github.run_id }}
    restore-keys: |
      ${{ runner.os }}-trivy-
```

### Проблема: Workflow не останавливается при ошибке Trivy

**Решение:** Убедитесь, что используется флаг `--exit-code 1`:
```yaml
run: trivy image --severity CRITICAL --exit-code 1 grpc/cxx:latest
```

---

## 📊 Ожидаемые результаты тестирования

| Задание | Ожидаемый результат | Статус |
|---------|---------------------|--------|
| 0 | Образ в Docker Hub, логин через секреты | ✅ Работает |
| 1 | Тесты прошли → образ опубликован | ✅ Работает |
| 2 | Workflow успешен (или exit 1 при CRITICAL) | ✅ Работает |
| 3 | **Exit code 1** (85 CRITICAL в grpc/cxx:latest) | ✅ **Правильно!** |
| 4 | Образ автоматически билдится на любой ветке | ✅ Работает |
| 5 | Workflow успешен (или exit 1 при секретах) | ✅ Работает |
| 6 | flake8 прошёл → образ опубликован | ✅ Работает |
| 7 | Workflow успешен (или exit 1 при HIGH) | ✅ Работает |
| 8 | Workflow успешен (или exit 1 при HIGH) | ✅ Работает |
| 9 | **Exit code 1** (20 лицензий, 9 HIGH GPL-2.0) | ✅ **Правильно!** |

---

## 📚 Дополнительные ресурсы

### Официальная документация
- [GitHub Actions](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [Flask Documentation](https://flask.palletsprojects.com/)
- [pytest Documentation](https://docs.pytest.org/)
- [flake8 Documentation](https://flake8.pycqa.org/)
- [PEP 8 Style Guide](https://peps.python.org/pep-0008/)

### Полезные статьи
- [GitHub Actions Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)
- [Docker Security Best Practices](https://docs.docker.com/develop/security-best-practices/)
- [Trivy Tutorial](https://aquasecurity.github.io/trivy/latest/tutorials/)

### Примеры workflow
- [GitHub Actions Starter Workflows](https://github.com/actions/starter-workflows)
- [Docker Build and Push Example](https://github.com/docker/build-push-action)

---

## 📝 Лицензия

Этот проект создан в образовательных целях для экзаменационных заданий по курсу "Управление и администрирование информационных систем".

---

## 👤 Автор

**Repository:** [Management-and-administration-of-information-systems--tasks](https://github.com/TrooSlash/Management-and-administration-of-information-systems--tasks)

**Owner:** Тимофеев Кирилл

---

## 🎯 Заключение

Все 10 заданий **полностью реализованы и протестированы**. Каждый workflow работает согласно требованиям задания:

✅ **Задания 0, 1, 4, 6:** Успешно публикуют Docker-образы в Docker Hub  
✅ **Задания 2, 5, 7:** Сканируют исходный код на уязвимости и секреты  
✅ **Задания 3, 8, 9:** Сканируют Docker-образы на уязвимости и лицензии  

**Важно:** Exit code 1 в заданиях с Trivy — это **правильное поведение** при обнаружении проблем безопасности!

---

## Дополнительные ресурсы

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Hub](https://hub.docker.com/)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [PEP 8 Style Guide](https://peps.python.org/pep-0008/)
- [Flake8 Documentation](https://flake8.pycqa.org/)
- [pytest Documentation](https://docs.pytest.org/)

