# docker/Dockerfile
FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY django_app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY django_app/ .
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--chdir", "/app", "main_project.wsgi:application"]
