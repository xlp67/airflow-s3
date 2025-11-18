#!/bin/bash
set -e

# Atualizar sistema
apt-get update -y
apt-get upgrade -y

# Instalar dependências
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    software-properties-common

# Adicionar repositório oficial do Docker
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Instalar Docker e Docker Compose Plugin
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Habilitar Docker
systemctl enable docker
systemctl start docker
usermod -aG docker ubuntu

# Criar diretório do Airflow e mover docker-compose.yaml
mkdir -p /airflow
cp ../../../airflow/docker-compose.yaml /airflow/docker-compose.yaml
chown -R ubuntu:ubuntu /airflow

# Subir containers do Airflow
cd /airflow
sudo -u ubuntu docker compose up -d

# Criar log de inicialização
echo "EC2 inicializada com Docker, Docker Compose e containers do Airflow!" > /home/ubuntu/startup.log
