#!/bin/bash
set -e

APP_DIR="/opt/pos/backend"
SERVICE_NAME="pos-backend"
GITHUB_REPO="technoMaxa/apiTiendaLocal"
ENV_FILE="/etc/pos-backend.env"
JAR_FINAL="$APP_DIR/pos-backend.jar"

echo "🔄 Actualizando Backend POS"

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
# VERSION LOCAL
# ===============================
LOCAL_VERSION=$(cat "$APP_DIR/version.txt" 2>/dev/null || echo "0.0.0")

# ===============================
# OBTENER RELEASE JSON
# ===============================
RELEASE_JSON=$(curl -s -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "User-Agent: pos-updater" \
  https://api.github.com/repos/$GITHUB_REPO/releases/latest)

# ===============================
# VERSION REMOTA
# ===============================
REMOTE_VERSION=$(echo "$RELEASE_JSON" \
  | sed -n 's/.*"tag_name":[[:space:]]*"\(v[^"]*\)".*/\1/p' \
  | head -n 1 | sed 's/^v//')

if [ -z "$REMOTE_VERSION" ]; then
  echo "❌ No se pudo obtener versión remota"
  exit 1
fi

echo "Local : $LOCAL_VERSION"
echo "Remota: $REMOTE_VERSION"

if [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ]; then
  echo "✅ Backend ya actualizado"
  exit 0
fi

# ===============================
# OBTENER ASSET_ID DEL JAR
# ===============================
ASSET_ID=$(echo "$RELEASE_JSON" \
  | sed -n 's/.*"id":[[:space:]]*\([0-9]\+\).*"name":[[:space:]]*"[^"]*\.jar".*/\1/p' \
  | head -n 1)

if [ -z "$ASSET_ID" ]; then
  echo "❌ No se pudo obtener asset_id del JAR"
  exit 1
fi

echo "📦 Asset ID: $ASSET_ID"

# ===============================
# STOP SERVICIO
# ===============================
systemctl stop "$SERVICE_NAME" || true

# ===============================
# BACKUP
# ===============================
if [ -f "$JAR_FINAL" ]; then
  cp "$JAR_FINAL" "$JAR_FINAL.bak"
fi

# ===============================
# DESCARGA REAL (CORRECTA)
# ===============================
echo "⬇️ Descargando nuevo JAR..."

curl -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/octet-stream" \
  -o "$JAR_FINAL" \
  "https://api.github.com/repos/$GITHUB_REPO/releases/assets/$ASSET_ID"

# ===============================
# VALIDAR DESCARGA
# ===============================
FILE_SIZE=$(stat -c%s "$JAR_FINAL")

if [ "$FILE_SIZE" -lt 1000000 ]; then
  echo "❌ JAR inválido ($FILE_SIZE bytes), rollback"
  mv "$JAR_FINAL.bak" "$JAR_FINAL"
  systemctl start "$SERVICE_NAME"
  exit 1
fi

chmod 755 "$JAR_FINAL"

# ===============================
# VERSION
# ===============================
echo "$REMOTE_VERSION" > "$APP_DIR/version.txt"

# ===============================
# START SERVICIO
# ===============================
systemctl start "$SERVICE_NAME"
sleep 5

if systemctl is-active --quiet "$SERVICE_NAME"; then
  echo "✅ Backend actualizado correctamente"
else
  echo "❌ Falló el arranque, rollback"
  mv "$JAR_FINAL.bak" "$JAR_FINAL"
  systemctl start "$SERVICE_NAME"
  exit 1
fi
