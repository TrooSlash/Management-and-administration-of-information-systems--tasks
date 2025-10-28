FROM python:3

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir nonexistent-package-222

EXPOSE 5000

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
