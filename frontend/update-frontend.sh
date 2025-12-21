#!/bin/bash
set -e

# ==================================================
# CONFIGURACIÓN
# ==================================================
APP_DIR="/opt/pos/frontend"
BIN="$APP_DIR/pos-app"
VERSION_FILE="$APP_DIR/version.txt"

GITHUB_OWNER="technoMaxa"
GITHUB_REPO="miTiendita"
ENV_FILE="/etc/pos-frontend.env"

GITHUB_API="https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases/latest"
USER_AGENT="pos-frontend-updater"

TMP_DIR="/tmp"
MIN_SIZE_BYTES=50000000   # 50 MB mínimo esperado

echo "======================================"
echo "🔄 Actualizando Frontend - MiTiendita"
echo "======================================"

# ==================================================
# VALIDAR TOKEN
# ==================================================
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

# ==================================================
# VERSION LOCAL
# ==================================================
LOCAL_VERSION=$(cat "$VERSION_FILE" 2>/dev/null || echo "0.0.0")
echo "📦 Versión local:  $LOCAL_VERSION"

# ==================================================
# OBTENER RELEASE
# ==================================================
echo "🔍 Consultando GitHub Releases..."

RELEASE_JSON=$(curl -s -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "User-Agent: $USER_AGENT" \
  "$GITHUB_API")

# ==================================================
# VERSION REMOTA
# ==================================================
REMOTE_VERSION=$(echo "$RELEASE_JSON" \
  | sed -n 's/.*"tag_name":[[:space:]]*"v\([^"]*\)".*/\1/p' \
  | head -n 1)

if [ -z "$REMOTE_VERSION" ]; then
  echo "❌ No se pudo obtener versión remota"
  exit 1
fi

echo "🌐 Versión remota: $REMOTE_VERSION"

if [ "$LOCAL_VERSION" = "$REMOTE_VERSION" ]; then
  echo "✅ Frontend ya está actualizado"
  exit 0
fi

# ==================================================
# OBTENER ASSET_ID DEL AppImage
# ==================================================
ASSET_ID=$(echo "$RELEASE_JSON" \
  | sed -n 's/.*"id":[[:space:]]*\([0-9]\+\).*"name":[[:space:]]*"MiTiendita-.*\.AppImage".*/\1/p' \
  | head -n 1)

if [ -z "$ASSET_ID" ]; then
  echo "❌ No se encontró el AppImage en el release"
  exit 1
fi

echo "📦 Asset ID: $ASSET_ID"

TMP_FILE="$TMP_DIR/MiTiendita-$REMOTE_VERSION.AppImage"

# ==================================================
# DESCARGA DEL ASSET (FORMA CORRECTA)
# ==================================================
echo "⬇️  Descargando AppImage..."

curl -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/octet-stream" \
  -H "User-Agent: $USER_AGENT" \
  -o "$TMP_FILE" \
  "https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/releases/assets/$ASSET_ID"

# ==================================================
# VALIDACIONES
# ==================================================
FILE_SIZE=$(stat -c%s "$TMP_FILE")

if [ "$FILE_SIZE" -lt "$MIN_SIZE_BYTES" ]; then
  echo "❌ Descarga inválida (${FILE_SIZE} bytes)"
  rm -f "$TMP_FILE"
  exit 1
fi

if ! file "$TMP_FILE" | grep -q "ELF 64-bit"; then
  echo "❌ El archivo descargado no es un AppImage válido"
  rm -f "$TMP_FILE"
  exit 1
fi

chmod +x "$TMP_FILE"

# ==================================================
# BACKUP
# ==================================================
if [ -f "$BIN" ]; then
  echo "📦 Creando backup del binario actual..."
  cp "$BIN" "$BIN.bak"
fi



# ==================================================
# INSTALACIÓN (USANDO install.sh)
# ==================================================
echo "🚀 Preparando instalación..."

FINAL_APPIMAGE="$APP_DIR/MiTiendita-$REMOTE_VERSION.AppImage"

echo "📦 Moviendo AppImage a $FINAL_APPIMAGE"
mv "$TMP_FILE" "$FINAL_APPIMAGE"
chmod +x "$FINAL_APPIMAGE"

echo "🧹 Ejecutando uninstall.sh..."
AUTO_MODE=true /opt/pos/frontend/uninstall.sh || true

echo "📦 Ejecutando install.sh versión $REMOTE_VERSION..."
/opt/pos/frontend/install.sh "$REMOTE_VERSION"


# ==================================================
# VERIFICACIÓN FINAL
# ==================================================
if [ ! -x "$BIN" ]; then
  echo "❌ El binario instalado no es ejecutable, rollback"
  [ -f "$BIN.bak" ] && mv "$BIN.bak" "$BIN"
  exit 1
fi

rm -f "$BIN.bak"


echo "======================================"
echo "✅ Frontend actualizado a $REMOTE_VERSION"
echo "======================================"
