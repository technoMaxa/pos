# POS – Scripts de Instalación y Actualización

Este repositorio contiene los scripts necesarios para **instalar, actualizar y mantener**
el sistema POS, compuesto por:

- **Frontend**: Aplicación Electron distribuida como AppImage
- **Backend**: Aplicación Spring Boot distribuida como JAR

⚠️ **Este repositorio NO contiene binarios**  
Los ejecutables se descargan automáticamente desde **GitHub Releases**.

---

## 📁 Estructura del proyecto

```text
/opt/pos/
├── frontend/
│   ├── pos-app            # AppImage (NO versionado)
│   ├── version.txt        # Versión instalada del frontend
│   ├── update-frontend.sh
│   ├── install.sh
│   └── uninstall.sh
├── backend/
│   ├── pos-backend.jar    # JAR (NO versionado)
│   ├── version.txt        # Versión instalada del backend
│   └── update-backend.sh
├── install.py             # Instalación inicial del sistema
├── update.py              # Actualización con interfaz visual
└── README.md

---
```

## 🖥️ Requisitos del sistema

Lubuntu / Ubuntu 20.04 o superior

curl

git

systemd

libfuse2

python3

## Instalar dependencias básicas:

sudo apt update
sudo apt install -y curl git libfuse2 python3
sudo apt install -y python3-pil python3-pil.imagetk


## 🚀 Instalación inicial (ingenieros de campo)
1️⃣ Abrir terminal y entrar a /opt
cd /opt

2️⃣ Clonar el repositorio
sudo git clone https://github.com/technoMaxa/pos.git

3️⃣ Asignar permisos al usuario local

Sustituye POS por el usuario del equipo
(por ejemplo: fulano)

sudo chown -R POS:POS /opt/pos

4️⃣ (Opcional) Abrir en Visual Studio Code
code /opt/pos

## 🔐 Variables de entorno (OBLIGATORIO)

Los scripts utilizan tokens de solo lectura para consultar GitHub Releases.

Backend
sudo nano /etc/pos-backend.env


Contenido:

GITHUB_TOKEN=YOUR_GITHUB_READONLY_TOKEN


Permisos:

sudo chmod 600 /etc/pos-backend.env
sudo chown root:root /etc/pos-backend.env

Frontend
sudo nano /etc/pos-frontend.env


Contenido:

GITHUB_TOKEN=YOUR_GITHUB_READONLY_TOKEN


Permisos:

sudo chmod 600 /etc/pos-frontend.env
sudo chown root:root /etc/pos-frontend.env

## 🧩 Instalación inicial del sistema

chmod +x /opt/pos/frontend/update-frontend.sh
chmod +x /opt/pos/backend/update-backend.sh
chmod +x /opt/pos/frontend/install.sh 
chmod +x /opt/pos/frontend/uninstall.sh 


## ⚠️ Este paso se ejecuta SOLO UNA VEZ por equipo

sudo python3 /opt/pos/install.py


Este proceso:

Descarga el frontend (AppImage)

Descarga el backend (JAR)

Crea la estructura /opt/pos

Deja el sistema listo para actualizaciones

🔄 Actualización manual
Frontend
sudo /opt/pos/frontend/update-frontend.sh

Backend
sudo /opt/pos/backend/update-backend.sh

🤖 Actualizaciones automáticas

El sistema soporta:

🔁 Actualización automática cada 12 horas

🔄 Actualización automática al reiniciar el equipo

## 🖥️ Ventana visual para el usuario durante la descarga

Crear servicio systemd
**1️⃣ Copiar archivos de servicio
sudo cp /opt/pos/systemd/pos-update.service /etc/systemd/system/
sudo cp /opt/pos/systemd/pos-update.timer /etc/systemd/system/

**2️⃣ Recargar systemd
sudo systemctl daemon-reexec
sudo systemctl daemon-reload

**3️⃣ Activar temporizador
sudo systemctl enable pos-update.timer
sudo systemctl start pos-update.timer

sudo cp /opt/pos/systemd/pos-backend.service /etc/systemd/system/
sudo chown root:root /etc/systemd/system/pos-backend.service
sudo chmod 644 /etc/systemd/system/pos-backend.service



## ⚠️ Reglas importantes

## ❌ Nunca ejecutar uninstall.sh como parte de una actualización

## ✅ update-frontend.sh solo reemplaza el binario

## 🔐 Los tokens son solo lectura

## 📦 Los binarios NO viven en Git

## 🧠 version.txt es la fuente de verdad

🛠️ Troubleshooting
Ver versión instalada
cat /opt/pos/frontend/version.txt
cat /opt/pos/backend/version.txt

Forzar actualización manual
sudo /opt/pos/frontend/update-frontend.sh
sudo /opt/pos/backend/update-backend.sh



Logs

Backend: /opt/pos/backend/logs/backend.log

Frontend: ejecutar desde terminal para ver salida

## 📌 Notas finales

Este repositorio está diseñado para:

Instalaciones en campo

Actualizaciones seguras

Operación continua

Mantenimiento sencillo

Es un enfoque probado en sistemas POS, kioscos y terminales de autoservicio.

## 🧠 Contacto

Equipo **TechnoMäxä**  
📧 techno.maxa@gmail.com
