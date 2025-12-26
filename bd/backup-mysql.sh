#!/bin/bash
set -e

# ===============================
# CONFIGURACIÓN
# ===============================
DB_NAME="tienda"
DB_USER="backup_pos"
DB_HOST="localhost"

BACKUP_DIR="/opt/pos/backups/mysql"
LOG_FILE="/opt/pos/logs/backup-mysql.log"

DATE=$(date +"%Y-%m-%d_%H-%M")
BACKUP_FILE="$BACKUP_DIR/tienda_$DATE.sql.gz"

# ===============================
# PREPARAR
# ===============================
mkdir -p "$BACKUP_DIR"
mkdir -p "$(dirname "$LOG_FILE")"

exec >> "$LOG_FILE" 2>&1

echo "==============================="
echo "🧠 Backup MySQL iniciado: $(date)"
echo "📦 Base: $DB_NAME"

# ===============================
# BACKUP
# ===============================
mysqldump \
  -h "$DB_HOST" \
  -u "$DB_USER" \
  --single-transaction \
  --routines \
  --triggers \
  "$DB_NAME" \
  | gzip > "$BACKUP_FILE"

# ===============================
# VALIDAR
# ===============================
if [ ! -s "$BACKUP_FILE" ]; then
  echo "❌ Backup fallido: archivo vacío"
  exit 1
fi

echo "✅ Backup generado: $BACKUP_FILE"

# ===============================
# ROTACIÓN (7 días)
# ===============================
find "$BACKUP_DIR" -type f -name "*.sql.gz" -mtime +7 -delete

echo "🧹 Backups antiguos limpiados"
echo "🏁 Backup finalizado: $(date)"
