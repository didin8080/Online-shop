FROM python:3.11-slim

# Prevent Python from writing .pyc files and buffer outputs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Copy requirements for dependency installation
COPY requirements.txt /app/

# Install system dependencies needed for building Pillow
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        zlib1g-dev \
        libjpeg-dev && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip then install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY . /app/

EXPOSE 8000

CMD python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000
