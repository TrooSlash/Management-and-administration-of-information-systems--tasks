# Задания - Инструкция по использованию

## Обзор выполненных исправлений

Все 10 заданий (0, 1, 2, 3, 4, 5, 6, 7, 8, 9) реализованы и готовы к использованию.

---

## Задание 0: GitHub Secrets для Docker Hub

### Что исправлено:
- ✅ Dockerfile: заменен несуществующий пакет на Flask
- ✅ Создан requirements.txt
- ✅ Создан GitHub Actions workflow (.github/workflows/task0.yml)

### Инструкция по настройке:
1. Перейдите в Settings вашего репозитория на GitHub
2. Выберите Secrets and variables → Actions
3. Добавьте два секрета:
   - `DOCKERHUB_USERNAME` - ваш логин Docker Hub
   - `DOCKERHUB_PASSWORD` - токен доступа Docker Hub (создайте в Account Settings → Security)

### Запуск:
- Автоматически при пуше в ветку main (изменения в папке `tasks/task0/`)
- Вручную через Actions → Task 0 → Run workflow

---

## Задание 1: CI-пайплайн с тестами

### Что исправлено:
- ✅ Dockerfile: исправлена опечатка requiremens.txt → requirements.txt
- ✅ Создан requirements.txt (Flask + pytest)
- ✅ Исправлены unit-тесты (status_code: 400 → 200)
- ✅ Создан GitHub Actions workflow (.github/workflows/task1.yml)

### Настройка:
Используйте те же секреты, что и в Задании 0:
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_PASSWORD`

### Запуск:
- Автоматически при пуше в ветку main (изменения в папке `tasks/task1/`)
- Вручную через Actions → Task 1 → Run workflow

### Workflow выполняет:
1. Запуск pytest с unit_test.py
2. Если тесты прошли → сборка и пуш Docker-образа

---

## Задание 2: Сканирование уязвимостей исходников (grpc)

### Что реализовано:
- ✅ Создан GitHub Actions workflow (.github/workflows/task2.yml)
- ✅ Использует Trivy для сканирования исходного кода
- ✅ Проверяет наличие CRITICAL уязвимостей
- ✅ Завершается с ошибкой при обнаружении критических уязвимостей

### Настройка:
Требуется форк репозитория https://github.com/grpc/grpc или можно использовать текущий репозиторий для демонстрации.

### Запуск:
- Вручную через Actions → Task 2 → Run workflow
- Автоматически при пуше в main

---

## Задание 3: Сканирование Docker-образа (grpc)

### Что реализовано:
- ✅ Создан GitHub Actions workflow (.github/workflows/task3.yml)
- ✅ Сканирует образ grpc/cxx:latest из Docker Hub
- ✅ Проверяет CRITICAL уязвимости через Trivy
- ✅ Завершается с ошибкой при обнаружении

### Запуск:
- Вручную через Actions → Task 3 → Run workflow
- Автоматически при пуше в main

---

## Задание 4: Автоматическая сборка Docker-образа

### Что исправлено:
- ✅ Dockerfile: исправлена опечатка requiremens.txt → requirements.txt
- ✅ Создан requirements.txt
- ✅ Создан GitHub Actions workflow (.github/workflows/task4.yml)

### Настройка:
Используйте секреты:
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_PASSWORD`

### Запуск:
- Автоматически при пуше в **ЛЮБУЮ** ветку (изменения в папке `tasks/task4/`)
- Вручную через Actions → Task 4 → Run workflow

---

## Задание 6: Линтинг и форматирование перед сборкой

### Что исправлено:
- ✅ app.py: код отформатирован по стандартам PEP8/flake8
- ✅ Dockerfile: исправлено COPY bad_script.py → COPY app.py
- ✅ Создан requirements.txt
- ✅ Создан .flake8 конфигурационный файл
- ✅ Создан GitHub Actions workflow (.github/workflows/task6.yml)

### Настройка:
Используйте секреты:
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_PASSWORD`

### Запуск:
- Автоматически при пуше в любую ветку (изменения в папке `tasks/task6/`)
- Вручную через Actions → Task 6 → Run workflow

### Workflow выполняет:
1. Запуск flake8 для проверки стиля кода
2. Если линтинг прошел → сборка и пуш Docker-образа

---

## Задание 5: Сканирование секретов (openssl)

### Что реализовано:
- ✅ Создан GitHub Actions workflow (.github/workflows/task5.yml)
- ✅ Использует Trivy с параметром --scanners secret
- ✅ Сканирует исходный код на наличие секретов
- ✅ Завершается с ошибкой при обнаружении

### Настройка:
Требуется форк репозитория https://github.com/openssl/openssl или можно использовать текущий репозиторий.

### Запуск:
- Вручную через Actions → Task 5 → Run workflow
- Автоматически при пуше в main

---

## Задание 7: Сканирование HIGH уязвимостей (openssl)

### Что реализовано:
- ✅ Создан GitHub Actions workflow (.github/workflows/task7.yml)
- ✅ Использует Trivy для сканирования на HIGH уязвимости
- ✅ Завершается с ошибкой при обнаружении

### Настройка:
Требуется форк репозитория https://github.com/openssl/openssl или можно использовать текущий репозиторий.

### Запуск:
- Вручную через Actions → Task 7 → Run workflow
- Автоматически при пуше в main

---

## Задание 8: Сканирование HIGH уязвимостей Docker-образа (alpine/openssl)

### Что реализовано:
- ✅ Создан GitHub Actions workflow (.github/workflows/task8.yml)
- ✅ Сканирует образ alpine/openssl:latest
- ✅ Проверяет HIGH уязвимости
- ✅ Завершается с ошибкой при обнаружении

### Запуск:
- Вручную через Actions → Task 8 → Run workflow
- Автоматически при пуше в main

---

## Задание 9: Сканирование лицензий Docker-образа (alpine/openssl)

### Что реализовано:
- ✅ Создан GitHub Actions workflow (.github/workflows/task9.yml)
- ✅ Сканирует образ alpine/openssl:latest на лицензии
- ✅ Использует --scanners license
- ✅ Завершается с ошибкой при обнаружении лицензий

### Запуск:
- Вручную через Actions → Task 9 → Run workflow
- Автоматически при пуше в main

---

## Общие инструкции

### Первоначальная настройка GitHub Secrets:

1. **Создайте токен Docker Hub:**
   - Войдите в Docker Hub
   - Перейдите в Account Settings → Security
   - Создайте новый Access Token
   - Скопируйте токен (он больше не будет показан)

2. **Добавьте секреты в GitHub:**
   ```
   Repository → Settings → Secrets and variables → Actions → New repository secret
   ```
   
   Создайте два секрета:
   - Name: `DOCKERHUB_USERNAME`, Secret: ваш_логин
   - Name: `DOCKERHUB_PASSWORD`, Secret: созданный_токен

### Проверка работы workflows:

1. Закоммитьте и запушьте изменения в репозиторий
2. Перейдите во вкладку Actions на GitHub
3. Выберите нужный workflow
4. Проверьте статус выполнения

### Структура проекта:
```
.github/
  workflows/
    task0.yml   # Задание 0
    task1.yml   # Задание 1
    task4.yml   # Задание 4
    task6.yml   # Задание 6
tasks/
  task0/
    app.py
    Dockerfile
    requirements.txt
  task1/
    app.py
    Dockerfile
    requirements.txt
    unit_test.py
  task4/
    app.py
    Dockerfile
    requirements.txt
  task6/
    app.py
    Dockerfile
    requirements.txt
    .flake8
```

---

## Устранение неполадок

### Workflow не запускается:
- Проверьте, что изменения находятся в правильной папке задания
- Убедитесь, что workflow файл находится в `.github/workflows/`
- Проверьте синтаксис YAML файла

### Ошибка аутентификации Docker Hub:
- Убедитесь, что секреты созданы с правильными именами
- Проверьте, что токен Docker Hub активен
- Используйте Access Token, а не пароль от аккаунта

### Тесты не проходят (Задание 1):
- Проверьте, что все зависимости установлены
- Убедитесь, что код в app.py не изменился
- Проверьте путь к файлу unit_test.py

### Flake8 выдает ошибки (Задание 6):
- Убедитесь, что код соответствует PEP8
- Проверьте наличие файла .flake8
- Запустите flake8 локально для отладки

### Trivy не находит уязвимости (Задания 2, 3, 5, 7, 8, 9):
- Это нормально, если код/образ безопасен
- Workflow завершится успешно
- Для тестирования можно использовать известно уязвимый образ

---

## Дополнительные ресурсы

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Hub](https://hub.docker.com/)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [PEP 8 Style Guide](https://peps.python.org/pep-0008/)
- [Flake8 Documentation](https://flake8.pycqa.org/)
- [pytest Documentation](https://docs.pytest.org/)

