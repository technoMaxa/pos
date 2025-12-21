#!/bin/bash
set -e

# ======================================
# Instalador Frontend - MiTiendita
# ======================================

APP_NAME="MiTiendita"
INSTALL_DIR="/opt/pos/frontend"
DESKTOP_DIR="/usr/share/applications"
ICON_DIR="/usr/share/icons/hicolor/512x512/apps"
BACKUP_DIR="/opt/pos/backups"
VERSION_FILE="$INSTALL_DIR/version.txt"

echo "======================================"
echo "🔧 Instalando Frontend - MiTiendita"
echo "======================================"

# --------------------------------------
# Validaciones básicas
# --------------------------------------
if [ "$EUID" -ne 0 ]; then
  echo "❌ Este script debe ejecutarse con sudo"
  exit 1
fi

if [ ! -f "$VERSION_FILE" ]; then
  echo "❌ No se encontró version.txt"
  exit 1
fi

VERSION=$(cat "$VERSION_FILE")

APPIMAGE="$INSTALL_DIR/MiTiendita-$VERSION.AppImage"

if [ ! -f "$APPIMAGE" ]; then
  echo "❌ No se encontró el AppImage:"
  echo "   $APPIMAGE"
  exit 1
fi

chmod +x "$APPIMAGE"

# --------------------------------------
# Detener procesos en ejecución
# --------------------------------------
echo "⏹️  Deteniendo procesos en ejecución..."
pkill -f "MiTiendita" || true
pkill -f "pos-app" || true
sleep 2

# --------------------------------------
# Backup
# --------------------------------------
echo "📦 Creando backup..."
mkdir -p "$BACKUP_DIR"
cp -f "$INSTALL_DIR/pos-app" \
  "$BACKUP_DIR/pos-app.bak.$(date +%Y%m%d_%H%M%S)" 2>/dev/null || true

# --------------------------------------
# Instalar AppImage
# --------------------------------------
echo "📦 Instalando AppImage..."
cp -f "$APPIMAGE" "$INSTALL_DIR/pos-app"
chmod +x "$INSTALL_DIR/pos-app"

# --------------------------------------
# Wrapper para Electron (NO sandbox)
# --------------------------------------
echo "🔧 Configurando wrapper Electron..."

cat > "$INSTALL_DIR/pos-app-wrapper" << 'EOF'
#!/bin/bash
export ELECTRON_DISABLE_SANDBOX=1
export NO_SANDBOX=1
export QTWEBENGINE_DISABLE_SANDBOX=1

export TMPDIR="/tmp/pos-app-$USER"
mkdir -p "$TMPDIR"

exec "$(dirname "$0")/pos-app" \
  --no-sandbox \
  --disable-setuid-sandbox \
  --disable-gpu-sandbox \
  "$@"
EOF

chmod +x "$INSTALL_DIR/pos-app-wrapper"

# --------------------------------------
# Icono
# --------------------------------------
ICON_SOURCE="/opt/pos/img/technomaxa-pos.png"

if [ -f "$ICON_SOURCE" ]; then
  echo "🎨 Instalando icono..."
  mkdir -p "$ICON_DIR"
  cp -f "$ICON_SOURCE" "$ICON_DIR/pos-app.png"
else
  echo "⚠️  Icono no encontrado en $ICON_SOURCE"
  echo "    El sistema usará un icono genérico"
fi


# --------------------------------------
# Desktop entry
# --------------------------------------
echo "📝 Creando lanzador..."

cat > "$DESKTOP_DIR/pos-app.desktop" << EOF
[Desktop Entry]
Name=Mi Tiendita
Comment=Sistema de Punto de Venta
Exec=$INSTALL_DIR/pos-app-wrapper
Icon=pos-app
Terminal=false
Type=Application
Categories=Office;Finance;
StartupNotify=true
EOF

# --------------------------------------
# Symlink
# --------------------------------------
ln -sf "$INSTALL_DIR/pos-app-wrapper" /usr/local/bin/pos-app

# --------------------------------------
# Permisos finales
# --------------------------------------
chown -R root:root "$INSTALL_DIR"
chmod 755 "$INSTALL_DIR"

echo "======================================"
echo "✅ Frontend instalado correctamente"
echo "📦 Versión: $VERSION"
echo "======================================"
