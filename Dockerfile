
# official python image(use your python version, but check this in docker documntation)
# подключаем образ питона, посмотрите какие есть на официальном сайте
FROM python:3.11-slim

# set enviroment variables
# устанавливаем переменные окружения
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# set current directory for work
# устанавливаем рабочий каталог
WORKDIR ./

# copy file requirements.txt to workdir
# Копируем файл зависимостей в рабочую директорию внутри контейнера
COPY ./poetry.lock ./poetry.lock
COPY ./pyproject.toml ./pyproject.toml

# Run pip and install requiremnts withous localy saved
# Устанавливаем зависимости и не сохраняем их локально
RUN pip install --no-cache-dir --upgrade poetry==1.4.2 \
    && poetry config virtualenvs.create false \
    && poetry install --without dev,test --no-interaction --no-ansi \
    && rm -rf $(poetry config cache-dir)/{cache,artifacts}

# Copy project file to work directory
# Копируем файлы для работы

COPY . .

# Run
# Запускаем проект

CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "Application.main:app", "--bind", "0.0.0.0:8000"]