#!/bin/bash
set -e

APP_DIR="/opt/pos/backend"
GITHUB_REPO="technoMaxa/apiTiendaLocal"
ENV_FILE="/etc/pos-backend.env"
JAR_FINAL="$APP_DIR/pos-backend.jar"

echo "🚀 Instalando Backend POS (descarga inicial)"

# ===============================
# VALIDAR ENV
# ===============================
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ No existe $ENV_FILE"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

if [ -z "$GITHUB_TOKEN" ]; then
  echo "❌ GITHUB_TOKEN no definido"
  exit 1
fi

# ===============================
# CREAR DIRECTORIO
# ===============================
echo "📂 Preparando directorio $APP_DIR"
mkdir -p "$APP_DIR"

# ===============================
# OBTENER RELEASE JSON
# ===============================
echo "🔍 Consultando último release..."

RELEASE_JSON=$(curl -s -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "User-Agent: pos-installer" \
  https://api.github.com/repos/$GITHUB_REPO/releases/latest)

# ===============================
# OBTENER URL DEL JAR
# ===============================
JAR_URL=$(echo "$RELEASE_JSON" \
  | sed -n 's/.*"browser_download_url":[[:space:]]*"\([^"]*\.jar\)".*/\1/p' \
  | head -n 1)

if [ -z "$JAR_URL" ]; then
  echo "❌ No se encontró JAR en el release"
  exit 1
fi

echo "⬇️ Descargando JAR:"
echo "$JAR_URL"

# ===============================
# DESCARGA
# ===============================
ASSET_ID=$(echo "$RELEASE_JSON" | \
  sed -n 's/.*"id":[[:space:]]*\([0-9]\+\).*"name":[[:space:]]*"[^"]*\.jar".*/\1/p' | head -n 1)

if [ -z "$ASSET_ID" ]; then
  echo "❌ No se pudo obtener asset_id del JAR"
  exit 1
fi


curl -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/octet-stream" \
  -o "$JAR_FINAL" \
  "https://api.github.com/repos/$GITHUB_REPO/releases/assets/$ASSET_ID"



# ===============================
# VALIDAR
# ===============================
if [ ! -s "$JAR_FINAL" ]; then
  echo "❌ JAR descargado vacío"
  exit 1
fi

FILE_SIZE=$(stat -c%s "$JAR_FINAL")

if [ "$FILE_SIZE" -lt 1000000 ]; then
  echo "❌ Archivo descargado inválido ($FILE_SIZE bytes)"
  rm -f "$JAR_FINAL"
  exit 1
fi


chmod 755 "$JAR_FINAL"

echo "✅ Backend descargado correctamente"
echo "📦 Archivo: $JAR_FINAL"
