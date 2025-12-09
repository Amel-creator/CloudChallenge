FROM python:3.11-slim

# Installer curl et pip si nécessaire
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Démarrer l'API avec Uvicorn sur le port 8081
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8081"]

