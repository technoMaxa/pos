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

sudo cp /opt/pos/systemd/backup-mysql.service /etc/systemd/system/
sudo cp /opt/pos/systemd/backup-mysql.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable backup-mysql.timer
sudo systemctl start backup-mysql.timer

systemctl list-timers | grep backup


## Configuración BD

sudo apt update
sudo apt upgrade -y

sudo apt install mysql-server -y

| Acción           | Comando                        |
| ---------------- | ------------------------------ |
| Ver servicio     | `systemctl status mysql`       |
| Entrar como root | `sudo mysql`                   |
| Reiniciar        | `sudo systemctl restart mysql` |
| Logs             | `journalctl -u mysql`          |

base: tienda

## crear BD para la API

CREATE DATABASE tienda
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;



user: admin
pass: admin


## crear usuario para la API BD

CREATE USER 'api_user'@'localhost'
IDENTIFIED BY 'Un_Password_seguro90!';

GRANT ALL PRIVILEGES ON tienda.* TO 'api_user'@'localhost';
FLUSH PRIVILEGES;

EXIT;

## Cargar BD de la API 

mysql -u api_user -p tienda < /opt/pos/tienda/tienda.sql

## validar si se ejecuto 

mysql -u api_user -p tienda

SHOW TABLES;

Si ves tablas → ✅ todo perfecto.

## Verificar permisos (opcional pero recomendado)

SHOW GRANTS FOR 'tienda_api'@'localhost';

## 👤 3️⃣ Usuario para backups (opcional pero recomendado)

CREATE USER 'backup_pos'@'localhost'
IDENTIFIED BY 'BackupPassword123!';

GRANT SELECT, LOCK TABLES, SHOW VIEW
ON tienda.* TO 'backup_pos'@'localhost';

FLUSH PRIVILEGES;

/opt/pos/bd/backup-mysql.sh

## 🔐 Guardar contraseña sin exponerla

nano /root/.my.cnf
---
[client]
user=backup_pos
password=BackupPassword123!
host=localhost
---

sudo chmod 600 /root/.my.cnf




## 🔁 7️⃣ Restaurar un backup (cuando lo necesites)

gunzip < tienda_2025-01-26_02-00.sql.gz | mysql -u tienda_api -p tienda

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
