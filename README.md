# Ansible Lab com Docker Compose

Este laboratório fornece um ambiente leve e isolado para testar automações com **Ansible** utilizando containers Docker. Ele consiste em um controlador e três nós-alvo (nodes), todos baseados em Ubuntu 22.04.

## 📦 Estrutura do Projeto

```
ansible-lab/
├── docker-compose.yml        # Define os containers (controller, node1, node2)
├── Dockerfile                # Imagem base com SSH, Python, etc.
├── setup.sh                  # Script de instalação e configuração SSH
├── playbooks/
│   ├── inventory.ini         # Inventário Ansible (funcional!)
│   └── ping.yml              # Playbook de teste de conectividade
└── hosts                     # (opcional) inventário legado
```

## 🚀 Requisitos

- Docker
- Docker Compose v2+

## ⚙️ Como usar

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/ansible-lab.git
cd ansible-lab
```

### 2. Subir o ambiente

```bash
docker compose build --no-cache
docker compose up -d
```

> 💡 Dica: Use `--remove-orphans` se precisar resetar containers antigos.

### 3. Acessar o container controller & executar o setup

```bash
docker exec -it ansible-controller bash -c "/setup.sh"
docker exec -it ansible-controller bash
```

Esse script:
- Atualiza pacotes e instala dependências
- Instala o Ansible
- Cria o usuário `ansible` com senha `ansible`
- Gera e distribui a chave SSH para os nodes

### 4. Testar conectividade com os nodes

```bash
su - ansible
ansible -i hosts all -m ping
```

Você verá uma saída semelhante a:

```
node2 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node1 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
node3 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## 🧼 Como parar e limpar o lab

```bash
docker compose down --volumes --remove-orphans
```

## 📌 Notas

- Lembre-se: A senha incial do usuário `ansible` é **ansible**
- A imagem é construída a partir de um `Dockerfile` customizado com o OpenSSH Server, Python, Pip, Vim e ferramentas básicas de rede
- O `setup.sh` é copiado diretamente para o container controller, mas **não é executado automaticamente**

---

