# Utiliser Python slim
FROM python:3.11-slim

# Installer curl et pip dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copier et installer les requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code source
COPY . .

# Commande pour lancer l'application
CMD ["python", "main.py"]

