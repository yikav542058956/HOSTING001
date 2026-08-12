FROM python:3.11-slim

WORKDIR /app

# Install system dependencies (nodejs for JS bot scripts)
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy bot code
COPY HOSTINGBOT.py .

# Create runtime directories (data persistence via /data volume)
RUN mkdir -p /data/upload_bots /data/inf

# Expose port for Flask keep-alive
ENV PORT=8080
EXPOSE 8080

CMD ["python", "HOSTINGBOT.py"]
