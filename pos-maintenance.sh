#!/bin/bash
set -e

REPO_DIR="/opt/pos"
BRANCH="master"

echo "🔄 Actualizando repositorio POS"
echo "📂 Directorio: $REPO_DIR"
echo "🌿 Rama: $BRANCH"
echo "🕒 $(date)"

# ===============================
# VALIDACIONES
# ===============================
if [ ! -d "$REPO_DIR/.git" ]; then
  echo "❌ $REPO_DIR no es un repositorio git"
  exit 1
fi

cd "$REPO_DIR"

# ===============================
# ACTUALIZACIÓN
# ===============================
echo "📥 Ejecutando git pull..."

git pull

echo "✅ Repo actualizado correctamente"

