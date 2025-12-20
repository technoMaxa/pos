#!/bin/bash

# Script de instalación/actualización para Mi Tiendita
# Ejecutar con: sudo ./install.sh

APP_NAME="punto-venta"
INSTALL_DIR="/opt/pos/frontend"
DESKTOP_DIR="/usr/share/applications"
ICON_DIR="/usr/share/icons/hicolor/512x512/apps"
BACKUP_DIR="/opt/pos/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "🔧 Instalando/Actualizando Mi Tiendita..."

# Función para limpiar instalaciones anteriores
clean_previous_installation() {
    echo "🗑️  Limpiando instalaciones anteriores..."
    
    # Detener la aplicación si está en ejecución
    echo "⏹️  Deteniendo la aplicación..."
    pkill -f "punto-venta" || true
    pkill -f "MiTiendita" || true
    sleep 2
    
    # Crear backup de datos si existe
    if [ -d "$INSTALL_DIR" ]; then
        echo "📦 Creando backup de la instalación anterior..."
        mkdir -p "$BACKUP_DIR"
        tar -czf "$BACKUP_DIR/pos-backup-$TIMESTAMP.tar.gz" "$INSTALL_DIR" 2>/dev/null || true
    fi
    
    # Eliminar instalación anterior
    echo "🧹 Eliminando archivos anteriores..."
    rm -rf "$INSTALL_DIR"
    rm -f "$DESKTOP_DIR/pos-app.desktop"
    rm -f "$DESKTOP_DIR/MiTiendita.desktop"
    rm -f "$ICON_DIR/pos-app.png"
    rm -f "$ICON_DIR/MiTiendita.png"
    rm -f "/usr/local/bin/pos-app"
    rm -f "/usr/local/bin/MiTiendita"
    
    # Limpiar posibles archivos residuales de versiones anteriores
    find /opt -name "*Tiendita*" -type f 2>/dev/null | while read -r file; do
        echo "    Eliminando: $file"
        rm -f "$file"
    done
    
    # Limpiar directorios vacíos
    find /opt/pos -type d -empty -delete 2>/dev/null || true
}

# Función para verificar si hay procesos en ejecución
check_running_processes() {
    local processes
    processes=$(pgrep -f "punto-venta\|MiTiendita" || true)
    
    if [ -n "$processes" ]; then
        echo "⚠️  Se encontraron procesos en ejecución:"
        echo "$processes"
        read -p "¿Forzar terminación? (s/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Ss]$ ]]; then
            pkill -9 -f "punto-venta\|MiTiendita" || true
            sleep 1
        else
            echo "❌ No se puede continuar con la aplicación en ejecución"
            exit 1
        fi
    fi
}

# Función para verificar archivo AppImage
verify_appimage() {
    if [ ! -f "dist/MiTiendita-0.1.0.AppImage" ]; then
        echo "❌ No se encontró el archivo AppImage: dist/MiTiendita-0.1.0.AppImage"
        echo "   Ejecuta primero: npm run dist"
        exit 1
    fi
    
    # Verificar que el AppImage es ejecutable
    if [ ! -x "dist/MiTiendita-0.1.0.AppImage" ]; then
        chmod +x "dist/MiTiendita-0.1.0.AppImage"
    fi
}

# Función para configurar el sandbox
configure_sandbox() {
    echo "🔧 Configurando sandbox..."
    
    # Crear script wrapper para manejar sandbox
    echo "📜 Creando script wrapper..."
    cat > "$INSTALL_DIR/pos-app-wrapper" << 'EOF'
#!/bin/bash
# Wrapper script para Mi Tiendita - Soluciona problemas de sandbox

# Deshabilitar sandbox de Electron/Chromium
export ELECTRON_DISABLE_SANDBOX=1
export NO_SANDBOX=1
export QTWEBENGINE_DISABLE_SANDBOX=1

# Configurar rutas temporales seguras
export TMPDIR="/tmp/pos-app-$USER"
mkdir -p "$TMPDIR"

# Ejecutar la aplicación con flags de sandbox deshabilitado
exec "$(dirname "$0")/pos-app" \
    --no-sandbox \
    --disable-setuid-sandbox \
    --disable-gpu-sandbox \
    --disable-features=VizDisplayCompositor \
    "$@"
EOF

    chmod +x "$INSTALL_DIR/pos-app-wrapper"
    echo "✅ Script wrapper creado: $INSTALL_DIR/pos-app-wrapper"
}

# Función para intentar reparar el sandbox del AppImage
repair_appimage_sandbox() {
    echo "🛠️  Intentando reparar sandbox del AppImage..."
    
    # Verificar si appimagetool está disponible
    if ! command -v appimagetool >/dev/null 2>&1; then
        echo "⚠️  appimagetool no disponible, usando solución con wrapper"
        return 1
    fi
    
    TEMP_EXTRACT="/tmp/pos-app-extract-$$"
    mkdir -p "$TEMP_EXTRACT"
    
    echo "📂 Extrayendo AppImage..."
    if ! "./dist/MiTiendita-0.1.0.AppImage" --appimage-extract > "$TEMP_EXTRACT/extract.log" 2>&1; then
        echo "❌ Error extrayendo AppImage"
        rm -rf "$TEMP_EXTRACT"
        return 1
    fi
    
    if [ -f "$TEMP_EXTRACT/squashfs-root/chrome-sandbox" ]; then
        echo "✅ Configurando permisos del sandbox..."
        chown root:root "$TEMP_EXTRACT/squashfs-root/chrome-sandbox"
        chmod 4755 "$TEMP_EXTRACT/squashfs-root/chrome-sandbox"
        
        # Reempaquetar AppImage
        echo "🔄 Reempaquetando AppImage..."
        cd "$TEMP_EXTRACT/squashfs-root"
        
        # Crear nuevo AppImage
        appimagetool . "$INSTALL_DIR/pos-app-repaired" > "$TEMP_EXTRACT/repack.log" 2>&1
        
        if [ -f "$INSTALL_DIR/pos-app-repaired" ]; then
            mv "$INSTALL_DIR/pos-app-repaired" "$INSTALL_DIR/pos-app"
            chmod +x "$INSTALL_DIR/pos-app"
            echo "✅ AppImage reparado con sandbox configurado"
            SUCCESS=true
        else
            echo "❌ Error reempaquetando AppImage"
            SUCCESS=false
        fi
        
        cd - >/dev/null
    else
        echo "⚠️  No se encontró chrome-sandbox en el AppImage"
        SUCCESS=false
    fi
    
    # Limpiar extracción temporal
    rm -rf "$TEMP_EXTRACT"
    
    if [ "$SUCCESS" = true ]; then
        return 0
    else
        return 1
    fi
}

# Función principal de instalación
install_application() {
    echo "📁 Creando directorios..."
    mkdir -p "$INSTALL_DIR"
    mkdir -p "$DESKTOP_DIR"
    mkdir -p "$ICON_DIR"
    mkdir -p "$BACKUP_DIR"

    # Copiar la aplicación
    echo "📦 Copiando aplicación..."
    cp "dist/MiTiendita-0.1.0.AppImage" "$INSTALL_DIR/pos-app"
    chmod +x "$INSTALL_DIR/pos-app"

    # Intentar reparar el sandbox del AppImage
    if ! repair_appimage_sandbox; then
        echo "🔄 Usando solución alternativa con wrapper script"
        configure_sandbox
        APP_EXECUTABLE="$INSTALL_DIR/pos-app-wrapper"
    else
        APP_EXECUTABLE="$INSTALL_DIR/pos-app"
    fi

    # Copiar el icono
    echo "🎨 Configurando iconos..."
    if [ -f "build-resources/icon.png" ]; then
        cp "build-resources/icon.png" "$ICON_DIR/pos-app.png"
        echo "✅ Icono copiado: $ICON_DIR/pos-app.png"
    else
        echo "⚠️  No se encontró el icono personalizado en build-resources/icon.png"
        # Intentar extraer icono del AppImage
        echo "🔍 Intentando extraer icono del AppImage..."
        TEMP_ICON="/tmp/pos-app-icon-$$"
        mkdir -p "$TEMP_ICON"
        
        if "$INSTALL_DIR/pos-app" --appimage-extract >/dev/null 2>&1; then
            find . -name "*.png" -type f | head -1 | xargs -I {} cp {} "$ICON_DIR/pos-app.png" 2>/dev/null || true
            rm -rf squashfs-root 2>/dev/null || true
        fi
        
        if [ -f "$ICON_DIR/pos-app.png" ]; then
            echo "✅ Icono extraído del AppImage"
        else
            echo "⚠️  No se pudo obtener icono, la aplicación usará uno por defecto"
        fi
        
        rm -rf "$TEMP_ICON"
    fi

    # Crear archivo .desktop
    echo "📝 Creando lanzador..."
    cat > "$DESKTOP_DIR/pos-app.desktop" << EOF
[Desktop Entry]
Version=1.0
Name=Mi Tiendita
GenericName=Sistema de Punto de Venta
Comment=Sistema de punto de venta para pequeñas empresas
Exec=$APP_EXECUTABLE
Icon=pos-app
Terminal=false
Type=Application
Categories=Office;Finance;Business;
Keywords=pos;ventas;tienda;caja;registro;
StartupWMClass=punto-venta
X-AppImage-Version=0.1.0
MimeType=
StartupNotify=true
EOF

    echo "✅ Lanzador creado: $DESKTOP_DIR/pos-app.desktop"

    # Crear enlace simbólico
    echo "🔗 Creando enlaces..."
    ln -sf "$APP_EXECUTABLE" "/usr/local/bin/pos-app" || true
    echo "✅ Enlace simbólico creado: /usr/local/bin/pos-app → $APP_EXECUTABLE"

    # Establecer permisos
    echo "🔒 Estableciendo permisos..."
    chown -R root:root "$INSTALL_DIR"
    chmod 755 "$INSTALL_DIR"
    chmod 755 "$INSTALL_DIR/pos-app"
    
    if [ -f "$INSTALL_DIR/pos-app-wrapper" ]; then
        chmod 755 "$INSTALL_DIR/pos-app-wrapper"
    fi

    # Crear directorio de datos de usuario
    echo "📁 Configurando directorios de datos..."
    mkdir -p "/var/lib/pos-app"
    chmod 755 "/var/lib/pos-app"
}

# Función para verificar instalación
verify_installation() {
    echo "🔍 Verificando instalación..."
    
    local errors=0
    
    # Verificar archivo principal
    if [ ! -f "$INSTALL_DIR/pos-app" ]; then
        echo "❌ No se encontró el ejecutable principal"
        errors=$((errors + 1))
    fi
    
    # Verificar que es ejecutable
    if [ ! -x "$INSTALL_DIR/pos-app" ]; then
        echo "❌ El ejecutable no tiene permisos de ejecución"
        errors=$((errors + 1))
    fi
    
    # Verificar lanzador .desktop
    if [ ! -f "$DESKTOP_DIR/pos-app.desktop" ]; then
        echo "❌ No se creó el lanzador .desktop"
        errors=$((errors + 1))
    fi
    
    # Verificar que el wrapper existe si se creó
    if [ -f "$INSTALL_DIR/pos-app-wrapper" ] && [ ! -x "$INSTALL_DIR/pos-app-wrapper" ]; then
        echo "❌ El wrapper no tiene permisos de ejecución"
        errors=$((errors + 1))
    fi
    
    if [ $errors -eq 0 ]; then
        echo "✅ Verificación completada sin errores"
        return 0
    else
        echo "❌ Se encontraron $errors errores en la instalación"
        return 1
    fi
}

# Función para instalar dependencias del sistema
install_system_dependencies() {
    echo "📦 Verificando dependencias del sistema..."
    
    # Verificar y instalar libfuse2 para AppImage
    if ! dpkg -l | grep -q libfuse2; then
        echo "📥 Instalando libfuse2..."
        apt-get update >/dev/null 2>&1 && apt-get install -y libfuse2 >/dev/null 2>&1 || {
            echo "⚠️  No se pudo instalar libfuse2, pero continuando..."
        }
    fi
    
    # Verificar y instalar appimagetool si no está disponible
    if ! command -v appimagetool >/dev/null 2>&1; then
        echo "📥 Intentando instalar appimagetool..."
        wget -q https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage -O /tmp/appimagetool
        chmod +x /tmp/appimagetool
        mv /tmp/appimagetool /usr/local/bin/appimagetool 2>/dev/null || {
            echo "⚠️  No se pudo instalar appimagetool, usando método alternativo"
        }
    fi
}

# Ejecutar el proceso completo
echo "🚀 Iniciando proceso de instalación..."

# Verificar que se está ejecutando como root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Este script debe ejecutarse con sudo:"
    echo "   sudo ./install.sh"
    exit 1
fi

# Verificar prerrequisitos
check_running_processes
verify_appimage
install_system_dependencies

# Limpiar e instalar
clean_previous_installation
install_application

# Verificar
if verify_installation; then
    # Actualizar bases de datos
    echo "🔄 Actualizando bases de datos del sistema..."
    gtk-update-icon-cache -f -t /usr/share/icons/hicolor >/dev/null 2>&1 || true
    update-desktop-database "$DESKTOP_DIR" >/dev/null 2>&1 || true
    
    echo ""
    echo "🎉 ¡Instalación completada exitosamente!"
    echo ""
    echo "📋 Detalles de la instalación:"
    echo "   📂 Ubicación: $INSTALL_DIR/pos-app"
    if [ -f "$INSTALL_DIR/pos-app-wrapper" ]; then
        echo "   🔧 Método: Wrapper script (sandbox deshabilitado)"
    else
        echo "   🔧 Método: AppImage reparado"
    fi
    echo "   🖼️  Icono: $ICON_DIR/pos-app.png"
    echo "   🚀 Lanzador: $DESKTOP_DIR/pos-app.desktop"
    echo ""
    echo "🎯 Formas de ejecutar:"
    echo "   1. Menú de aplicaciones → 'Mi Tiendita'"
    echo "   2. Terminal: pos-app"
    echo "   3. Directo: $APP_EXECUTABLE"
    echo ""
    echo "🔧 Solución de problemas:"
    echo "   Si la aplicación no inicia, ejecuta: $APP_EXECUTABLE"
    echo "   Para ver logs: $APP_EXECUTABLE --verbose"
    echo ""
    echo "📦 Backup creado: $BACKUP_DIR/pos-backup-$TIMESTAMP.tar.gz"
    echo ""
    echo "🔄 Para reinstalar/actualizar: sudo ./install.sh"
    echo "🗑️  Para desinstalar: sudo ./uninstall.sh"
else
    echo "❌ La instalación falló. Revisa los errores arriba."
    echo ""
    echo "💡 Posibles soluciones:"
    echo "   - Verifica que el archivo dist/MiTiendita-0.1.0.AppImage existe"
    echo "   - Ejecuta: npm run dist"
    echo "   - Verifica los permisos del sistema de archivos"
    exit 1
fi
