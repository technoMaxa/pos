sudo chown -R POS:POS /opt/pos


# POS - Scripts de Instalación y Actualización

## Requisitos
- Ubuntu 20.04+
- curl
- systemd
- libfuse2

## Variables de entorno
Crear:
/etc/pos-frontend.env
/etc/pos-backend.env

Ejemplo:
GITHUB_TOKEN=ghp_xxxxx

## Instalación inicial
sudo ./frontend/install.sh
sudo ./backend/update-backend.sh

## Actualización manual
sudo ./frontend/update.sh
sudo ./backend/update-backend.sh

## Desinstalación
sudo ./frontend/uninstall.sh

## Automatización
- systemd service
- systemd timer (12h)
- update al boot

## Troubleshooting
- logs
- rollback
- verificación de versión
