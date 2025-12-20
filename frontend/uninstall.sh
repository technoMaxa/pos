#!/bin/bash
set -e

INSTALL_DIR="/opt/pos/frontend"
DESKTOP_DIR="/usr/share/applications"
ICON_DIR="/usr/share/icons/hicolor/512x512/apps"

echo "🗑️  Desinstalando Mi Tiendita..."

read -p "⚠️  Esto eliminará COMPLETAMENTE el frontend. ¿Continuar? (SI): " CONFIRM
if [ "$CONFIRM" != "SI" ]; then
  echo "❌ Cancelado"
  exit 1
fi

echo "⏹️  Deteniendo procesos..."
pkill -f "pos-app" || true
pkill -f "MiTiendita" || true
sleep 2

echo "🧹 Eliminando archivos instalados..."

rm -f "$INSTALL_DIR/pos-app"
rm -f "$INSTALL_DIR/pos-app-wrapper"
rm -f "$INSTALL_DIR/version.txt"

rm -f "$DESKTOP_DIR/pos-app.desktop"
rm -f "$ICON_DIR/pos-app.png"
rm -f "/usr/local/bin/pos-app"

# ⚠️ NO borrar update.sh / install.sh / uninstall.sh
# ⚠️ NO borrar /opt/pos/frontend completo

echo "🔄 Actualizando caches..."
gtk-update-icon-cache -f -t /usr/share/icons/hicolor >/dev/null 2>&1 || true
update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true

echo "✅ Frontend desinstalado (scripts conservados)"
