#!/bin/bash

# Atualiza os pacotes e instala dependências
apt update && apt install -y sshpass ssh python3-pip

# Instala o Ansible
pip install ansible

# Cria o usuário ansible e define a senha
useradd -m ansible && echo "ansible:ansible" | chpasswd

# Gera a chave SSH sem senha
su - ansible -c "ssh-keygen -t rsa -f ~/.ssh/id_rsa -N ''"

# Copia a chave para os nós
su - ansible -c "sshpass -p ansible ssh-copy-id -o StrictHostKeyChecking=no ansible@node1"
su - ansible -c "sshpass -p ansible ssh-copy-id -o StrictHostKeyChecking=no ansible@node2"
su - ansible -c "sshpass -p ansible ssh-copy-id -o StrictHostKeyChecking=no ansible@node3"

echo "Configuração concluída!"

