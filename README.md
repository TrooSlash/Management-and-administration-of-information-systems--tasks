# Задания на экзамен по GitHub Actions и Docker Security

## 📋 Обзор проекта

Этот репозиторий содержит реализацию всех 10 экзаменационных заданий по автоматизации CI/CD с использованием GitHub Actions, Docker и сканера безопасности Trivy.

**Статус:** ✅ Все 10 заданий реализованы и протестированы

## 🎯 Список заданий

| № | Название | Тип | Статус | Workflow |
|---|----------|-----|--------|----------|
| 0 | GitHub Secrets для Docker Hub | CI/CD | ✅ Готово | `task0.yml` |
| 1 | CI-пайплайн с unit-тестами | CI/CD | ✅ Готово | `task1.yml` |
| 2 | Сканирование уязвимостей исходников (grpc CRITICAL) | Security | ✅ Готово | `task2.yml` |
| 3 | Сканирование Docker-образа (grpc CRITICAL) | Security | ✅ Готово | `task3.yml` |
| 4 | Автоматическая сборка Docker-образа | CI/CD | ✅ Готово | `task4.yml` |
| 5 | Сканирование секретов (openssl) | Security | ✅ Готово | `task5.yml` |
| 6 | Линтинг flake8 перед сборкой | CI/CD | ✅ Готово | `task6.yml` |
| 7 | Сканирование уязвимостей исходников (openssl HIGH) | Security | ✅ Готово | `task7.yml` |
| 8 | Сканирование Docker-образа (alpine HIGH) | Security | ✅ Готово | `task8.yml` |
| 9 | Сканирование лицензий Docker-образа | Security | ✅ Готово | `task9.yml` |

---

## 📚 Подробное описание заданий

### 🔒 Задание 0: Использование GitHub Secrets для аутентификации

**Цель:** Создать GitHub Actions workflow, который логинится в Docker Hub с секретами без раскрытия учетных данных в коде.

**Что сделано:**
- ✅ Исправлен Dockerfile (заменен несуществующий пакет на Flask)
- ✅ Создан requirements.txt
- ✅ Создан workflow с использованием `docker/login-action`
- ✅ Настроена безопасная работа с GitHub Secrets

**Технологии:** GitHub Actions, Docker Hub, GitHub Secrets

**Как работает workflow:**
1. Checkout кода из репозитория
2. Логин в Docker Hub через секреты (`DOCKERHUB_USERNAME`, `DOCKERHUB_PASSWORD`)
3. Сборка Docker-образа
4. Публикация образа в Docker Hub

**Запуск:**
- 🔄 Автоматически: при пуше в ветку `main` (изменения в `tasks/task0/`)
- ▶️ Вручную: Actions → Task 0 → Run workflow

**Ожидаемый результат:** ✅ Образ опубликован в Docker Hub без раскрытия credentials

---

### 🧪 Задание 1: CI-пайплайн с тестами

**Цель:** Создать workflow, который запускает unit-тесты и при успехе билдит Docker-образ.

**Что сделано:**
- ✅ Исправлен Dockerfile (опечатка `requiremens.txt` → `requirements.txt`)
- ✅ Создан requirements.txt (Flask==3.0.0, pytest==7.4.3)
- ✅ Исправлены unit-тесты (status_code: 400 → 200)
- ✅ Создан workflow с условной сборкой

**Технологии:** pytest, Flask, Docker, GitHub Actions

**Как работает workflow:**
1. Checkout кода
2. Установка Python и зависимостей
3. Запуск тестов: `pytest unit_test.py`
4. **Если тесты прошли** → сборка и пуш образа
5. **Если тесты упали** → workflow останавливается с ошибкой

**Запуск:**
- 🔄 Автоматически: при пуше в `main` (изменения в `tasks/task1/`)
- ▶️ Вручную: Actions → Task 1 → Run workflow

**Ожидаемый результат:** ✅ Тесты пройдены → образ в Docker Hub

---

### 🔍 Задание 2: Сканирование уязвимостей исходников (grpc)

**Цель:** Запустить Trivy для сканирования исходного кода на CRITICAL уязвимости.

**Что сделано:**
- ✅ Создан workflow с установкой Trivy
- ✅ Настроено сканирование: `trivy fs --severity CRITICAL --exit-code 1`
- ✅ Workflow завершается с ошибкой при обнаружении уязвимостей

**Технологии:** Trivy, GitHub Actions

**Команда сканирования:**
```bash
trivy fs --severity CRITICAL --exit-code 1 .
```

**Условия:**
- Должен быть форк https://github.com/grpc/grpc
- Или демонстрация на текущем репозитории

**Запуск:**
- 🔄 Автоматически: при пуше в `main`
- ▶️ Вручную: Actions → Task 2 → Run workflow

**Ожидаемый результат:** 
- ✅ Нет CRITICAL уязвимостей → workflow успешен
- ❌ Есть CRITICAL уязвимости → workflow завершается с exit code 1

---

### 🐳 Задание 3: Сканирование Docker-образа (grpc)

**Цель:** Просканировать публичный Docker-образ на критические уязвимости.

**Что сделано:**
- ✅ Создан workflow для сканирования `grpc/cxx:latest`
- ✅ Настроено: `trivy image --severity CRITICAL --exit-code 1`
- ✅ Протестировано: найдено 85 CRITICAL уязвимостей (Debian 9.5)

**Технологии:** Trivy, Docker Hub

**Команда сканирования:**
```bash
trivy image --severity CRITICAL --exit-code 1 grpc/cxx:latest
```

**Запуск:**
- 🔄 Автоматически: при пуше в `main`
- ▶️ Вручную: Actions → Task 3 → Run workflow

**Результат тестирования:** ✅ Workflow корректно завершился с exit code 1 при обнаружении 85 CRITICAL уязвимостей (ожидаемое поведение)

---

### ⚙️ Задание 4: Автоматическая сборка Docker-образа

**Цель:** Создать workflow для автоматической сборки и публикации образа при каждом пуше в любую ветку.

**Что сделано:**
- ✅ Исправлен Dockerfile (опечатка в requirements.txt)
- ✅ Создан requirements.txt
- ✅ Создан workflow с триггером на **любую ветку**

**Технологии:** Docker, GitHub Actions

**Как работает workflow:**
1. Checkout кода
2. Логин в Docker Hub
3. Сборка образа: `docker build`
4. Публикация образа: `docker push`

**Запуск:**
- 🔄 Автоматически: при пуше в **ЛЮБУЮ ветку** (изменения в `tasks/task4/`)
- ▶️ Вручную: Actions → Task 4 → Run workflow

**Ожидаемый результат:** ✅ Образ автоматически появляется в Docker Hub

---

### 🔐 Задание 5: Сканирование секретов (openssl)

**Цель:** Найти случайно закоммиченные секреты в исходном коде.

**Что сделано:**
- ✅ Создан workflow с Trivy
- ✅ Настроено сканирование секретов: `trivy fs --scanners secret --exit-code 1`

**Технологии:** Trivy (secret detection), GitHub Actions

**Команда сканирования:**
```bash
trivy fs --scanners secret --exit-code 1 .
```

**Условия:**
- Должен быть форк https://github.com/openssl/openssl
- Или демонстрация на текущем репозитории

**Запуск:**
- 🔄 Автоматически: при пуше в `main`
- ▶️ Вручную: Actions → Task 5 → Run workflow

**Ожидаемый результат:**
- ✅ Нет секретов → workflow успешен
- ❌ Найдены секреты → workflow завершается с ошибкой

---

### 🎨 Задание 6: Линтинг и форматирование перед сборкой

**Цель:** Проверить код на соответствие PEP8 с помощью flake8 перед сборкой образа.

**Что сделано:**
- ✅ Исправлен код app.py (форматирование по PEP8)
- ✅ Исправлен Dockerfile (COPY bad_script.py → app.py)
- ✅ Создан .flake8 конфигурационный файл
- ✅ Создан workflow с проверкой flake8

**Технологии:** flake8, Python, Docker, GitHub Actions

**Как работает workflow:**
1. Checkout кода
2. Установка Python и flake8
3. Запуск линтинга: `flake8 .`
4. **Если линтинг прошел** → сборка и пуш образа
5. **Если есть ошибки стиля** → workflow останавливается

**Запуск:**
- 🔄 Автоматически: при пуше в любую ветку (изменения в `tasks/task6/`)
- ▶️ Вручную: Actions → Task 6 → Run workflow

**Ожидаемый результат:** ✅ Код соответствует PEP8 → образ опубликован

---

### 🔍 Задание 7: Сканирование HIGH уязвимостей исходников (openssl)

**Цель:** Найти высокие уязвимости в исходном коде проекта openssl.

**Что сделано:**
- ✅ Создан workflow с Trivy
- ✅ Настроено сканирование: `trivy fs --severity HIGH --exit-code 1`

**Технологии:** Trivy, GitHub Actions

**Команда сканирования:**
```bash
trivy fs --severity HIGH --exit-code 1 .
```

**Условия:**
- Должен быть форк https://github.com/openssl/openssl
- Или демонстрация на текущем репозитории

**Запуск:**
- 🔄 Автоматически: при пуше в `main`
- ▶️ Вручную: Actions → Task 7 → Run workflow

**Ожидаемый результат:**
- ✅ Нет HIGH уязвимостей → workflow успешен
- ❌ Есть HIGH уязвимости → workflow завершается с exit code 1

---

### 🐋 Задание 8: Сканирование HIGH уязвимостей Docker-образа (alpine/openssl)

**Цель:** Просканировать публичный образ alpine/openssl на высокие уязвимости.

**Что сделано:**
- ✅ Создан workflow для сканирования `alpine/openssl:latest`
- ✅ Настроено: `trivy image --severity HIGH --exit-code 1`

**Технологии:** Trivy, Docker Hub

**Команда сканирования:**
```bash
trivy image --severity HIGH --exit-code 1 alpine/openssl:latest
```

**Запуск:**
- 🔄 Автоматически: при пуше в `main`
- ▶️ Вручную: Actions → Task 8 → Run workflow

**Ожидаемый результат:**
- ✅ Нет HIGH уязвимостей → workflow успешен
- ❌ Есть HIGH уязвимости → workflow завершается с ошибкой

---

### 📜 Задание 9: Сканирование лицензий Docker-образа (alpine/openssl)

**Цель:** Проверить лицензии пакетов в Docker-образе на наличие проблемных (GPL, MPL и др.).

**Что сделано:**
- ✅ Создан workflow для сканирования лицензий
- ✅ Настроено: `trivy image --scanners license --exit-code 1`
- ✅ Протестировано: найдено 20 лицензий, 9 из них HIGH (GPL-2.0)

**Технологии:** Trivy (license scanning), Docker Hub

**Команда сканирования:**
```bash
trivy image --scanners license --exit-code 1 alpine/openssl:latest
```

**Запуск:**
- 🔄 Автоматически: при пуше в `main`
- ▶️ Вручную: Actions → Task 9 → Run workflow

**Результат тестирования:** ✅ Workflow корректно завершился с exit code 1 при обнаружении 9 пакетов с GPL-2.0 (restricted) лицензиями

**Типы лицензий:**
- **HIGH (restricted):** GPL-2.0 - требует открытия исходников
- **MEDIUM (reciprocal):** MPL-2.0 - частичная обязанность открытия кода
- **LOW (notice):** MIT, Apache-2.0 - свободные лицензии

---

## 🚀 Быстрый старт

### 1️⃣ Настройка GitHub Secrets (для заданий 0, 1, 4, 6)

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

