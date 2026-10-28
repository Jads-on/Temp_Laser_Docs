#!/bin/bash
set -euo pipefail

REPO=/home/docs/repo
OUT=/var/www/docs
STATE=/home/docs/.last-deployed   # último commit publicado com sucesso
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

exec 9>/tmp/docs-deploy.lock
flock -n 9 || exit 0

cd "$REPO"
git fetch -q origin main
REMOTE=$(git rev-parse origin/main)
DEPLOYED=$(cat "$STATE" 2>/dev/null || echo "")

# Só pula se esse commit já foi publicado E o site existe
if [ "$REMOTE" = "$DEPLOYED" ] && [ -f "$OUT/index.html" ]; then
  exit 0
fi

git reset -q --hard origin/main

/home/docs/venv/bin/pip install -q -r requirements.txt
/home/docs/venv/bin/mkdocs build -q -d "$TMP"

rsync -a --delete --chmod=D755,F644 "$TMP"/ "$OUT"/

echo "$REMOTE" > "$STATE"
echo "$(date -Is) publicado $(git rev-parse --short HEAD)"