# POS – Scripts de Instalación y Actualización

Este repositorio contiene los scripts necesarios para **instalar, actualizar y mantener**
el sistema POS de TechnoMäxä, compuesto por:

- Frontend: Aplicación Electron distribuida como AppImage
- Backend: Aplicación Spring Boot distribuida como JAR

⚠️ Este repositorio NO contiene binarios  
Los ejecutables se descargan automáticamente desde GitHub Releases.

---

## 📁 Estructura del sistema

/opt/pos/
├── bd/
│   ├── backup-mysql.sh            
│   ├── tienda.sql            # Script inicial de la BD
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
├── systemd/
│   ├── pos-backend.service
│   ├── pos-update.service
│   ├── pos-update.timer
│   ├── backup-mysql.service
│   └── backup-mysql.timer
├── install.py             # Instalación inicial del sistema
├── update.py              # Actualización con interfaz visual
└── README.md

---

## 📂 Script inicial de Base de Datos (INCLUIDO EN EL REPOSITORIO)

El repositorio **incluye el script SQL inicial** de la base de datos del POS.

## 🖥️ Requisitos del sistema

- Ubuntu / Lubuntu 20.04 o superior
- systemd
- curl
- git
- python3
- libfuse2
- MySQL 8+
- Java 17

### Instalar dependencias básicas

sudo apt update  
sudo apt install -y curl git libfuse2 python3  
sudo apt install -y python3-pil python3-pil.imagetk  
sudo apt install -y openjdk-17-jdk  

---

## 🌐 Configuración de hosts (OBLIGATORIO)

Para entorno local y consistencia de dominios:

sudo nano /etc/hosts

Agregar:

127.0.0.1   techno-maxa.com

---

## 🚀 Instalación inicial (ingenieros de campo)

⚠️ ESTE PROCESO SE EJECUTA SOLO UNA VEZ POR EQUIPO

### 1️⃣ Clonar repositorio

cd /opt  
sudo git clone https://github.com/technoMaxa/pos.git  

### 2️⃣ Asignar permisos al usuario local

Sustituye POS por el usuario del equipo (ej. fulano)

sudo chown -R POS:POS /opt/pos  

---

## 🔐 Variables de entorno (OBLIGATORIO)

### Backend

sudo nano /etc/pos-backend.env

Contenido:

GITHUB_TOKEN=YOUR_GITHUB_READONLY_TOKEN  
SPRING_DATASOURCE_URL=jdbc:mysql://techno-maxa.com:3306/tienda  
SPRING_DATASOURCE_USERNAME=api_user
SPRING_DATASOURCE_PASSWORD=Un_Password_seguro90  

Permisos:

sudo chmod 600 /etc/pos-backend.env  
sudo chown root:root /etc/pos-backend.env  

### Frontend

sudo nano /etc/pos-frontend.env

Contenido:

GITHUB_TOKEN=YOUR_GITHUB_READONLY_TOKEN  

Permisos:

sudo chmod 600 /etc/pos-frontend.env  
sudo chown root:root /etc/pos-frontend.env  

---

## 🐬 Configuración de Base de Datos (MySQL 8+)

Instalar MySQL:

sudo apt install -y mysql-server  
sudo systemctl enable mysql  
sudo systemctl start mysql  

### Crear base de datos

CREATE DATABASE tienda  
CHARACTER SET utf8mb4  
COLLATE utf8mb4_unicode_ci;  

### Crear usuario para la API

CREATE USER 'api_user'@'localhost'  
IDENTIFIED BY 'Un_Password_seguro90';  

GRANT  
  SELECT, INSERT, UPDATE, DELETE,  
  CREATE, DROP, ALTER,  
  INDEX,  
  REFERENCES,  
  CREATE TEMPORARY TABLES,  
  LOCK TABLES,  
  EXECUTE,  
  SHOW VIEW  
ON tienda.* TO 'api_user'@'localhost';  

GRANT SELECT ON mysql.* TO 'api_user'@'localhost';  

FLUSH PRIVILEGES;  

### Cargar estructura inicial

mysql -u api_user -p tienda < /opt/pos/tienda/tienda.sql  

---

## ⚙️ Servicios systemd

### Backend

sudo cp /opt/pos/systemd/pos-backend.service /etc/systemd/system/  
sudo chmod 644 /etc/systemd/system/pos-backend.service  

sudo systemctl daemon-reexec  
sudo systemctl daemon-reload  
sudo systemctl enable pos-backend  
sudo systemctl start pos-backend  

Ver estado:

sudo systemctl status pos-backend  

---

### Actualizaciones automáticas

sudo cp /opt/pos/systemd/pos-update.* /etc/systemd/system/  

sudo systemctl daemon-reload  
sudo systemctl enable pos-update.timer  
sudo systemctl start pos-update.timer  

---

### Backups automáticos (opcional)

sudo cp /opt/pos/systemd/backup-mysql.* /etc/systemd/system/  

sudo systemctl daemon-reload  
sudo systemctl enable backup-mysql.timer  
sudo systemctl start backup-mysql.timer  

systemctl list-timers | grep backup  

---

## 🔄 Actualización manual

Frontend:

sudo /opt/pos/frontend/update-frontend.sh  

Backend:

sudo /opt/pos/backend/update-backend.sh  

---

## 🛠️ Troubleshooting

Ver versión instalada:

cat /opt/pos/frontend/version.txt  
cat /opt/pos/backend/version.txt  

Ver logs del backend:

journalctl -u pos-backend -f  

---

## 📌 Notas finales

- Los binarios NO viven en Git
- version.txt es la fuente de verdad
- MySQL 8+ requiere privilegios adicionales
- El backend SIEMPRE usa variables del sistema
- El servicio debe estar habilitado, no solo iniciado

---

## 🧠 Contacto

Equipo TechnoMäxä  
techno.maxa@gmail.com
