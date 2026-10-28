#!/bin/bash
# Modo estrito do Bash:
set -euo pipefail

# Definção dos caminhos utilizados no processo
REPO=/home/docs/repo   # Diretório do repositório Git local
OUT=/var/www/docs      # Diretório público onde o site/documentação é servido
TMP=$(mktemp -d)       # Cria uma pasta temporária única no sistema (ex: /tmp/tmp.XXXXXX)

# Garante a limpeza: remove o diretório temporário automaticamente ao sair do script (mesmo após erro)
trap 'rm -rf "$TMP"' EXIT

# Controle de execução concorrente (evita execuções simultâneas do deploy)
exec 9>/tmp/docs-deploy.lock # Associa o arquivo de lock ao File Descriptor 9
flock -n 9 || exit 0         # Tenta obter a trava sem bloquear (-n). Se já houver outro deploy rodando, sai com status 0

# Atualização do repositório de código
cd "$REPO"
git fetch -q origin main # Busca o estado mais recente da branch remota 'main' silenciosamente (-q)

# Comparação entre o commit local (HEAD) e o commit remoto (origin/main)
if [ "$(git rev-parse HEAD)" = "$(git rev-parse origin/main)" ]; then
  exit 0   # Encerra a execução se o código já estiver na versão mais recente
fi

# Força o repositório local a ficar exatamente igual ao remoto, descartando alterações locais
git reset -q --hard origin/main

# Instalação de dependências e Build do projeto
/home/docs/venv/bin/pip install -q -r requirements.txt # Atualiza os pacotes Python dentro do ambiente virtual (venv)
/home/docs/venv/bin/mkdocs build -q -d "$TMP"          # Compila o site estático com o MkDocs salvando o resultado em $TMP

# Publicação do site
rsync -a --delete "$TMP"/ "$OUT"/

# Exibe registro de log com data no formato ISO-8601 (-Is) e o hash resumido do commit publicado
echo "$(date -Is) publicado $(git rev-parse --short HEAD)"