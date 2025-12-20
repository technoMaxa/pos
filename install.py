#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk
import subprocess
import threading
import os
import sys

# ===============================
# CONFIGURACIÓN
# ===============================
LOGO_PATH = "/opt/pos/img/technomaxa-logo.png"

FRONTEND_SCRIPT = "/opt/pos/frontend/update-frontend.sh"
BACKEND_SCRIPT  = "/opt/pos/backend/update-backend.sh"

WINDOW_TITLE = "TechnoMäxä – Instalación del sistema Mi Tiendita"

MSG_START = "Preparando instalación del sistema POS..."
MSG_FRONT = "Actualizando Frontend (Mi Tiendita)..."
MSG_BACK  = "Actualizando Backend..."
MSG_DONE  = "✅ Instalación completada correctamente"
MSG_ERROR = "❌ Ocurrió un error durante la instalación"

# ===============================
# VALIDACIONES
# ===============================
if os.geteuid() != 0:
    print("❌ Este script debe ejecutarse con sudo")
    sys.exit(1)

# ===============================
# FUNCIÓN PRINCIPAL
# ===============================
def run_install():
    try:
        status_label.config(text=MSG_FRONT)
        subprocess.run(["bash", FRONTEND_SCRIPT], check=True)

        status_label.config(text=MSG_BACK)
        subprocess.run(["bash", BACKEND_SCRIPT], check=True)

        status_label.config(text=MSG_DONE)
        progress.stop()

    except subprocess.CalledProcessError:
        status_label.config(text=MSG_ERROR)
        progress.stop()


# ===============================
# UI
# ===============================
root = tk.Tk()
root.title(WINDOW_TITLE)
root.geometry("440x300")
root.resizable(False, False)

# Logo
if os.path.exists(LOGO_PATH):
    try:
        logo = tk.PhotoImage(file=LOGO_PATH)
        logo_label = tk.Label(root, image=logo)
        logo_label.pack(pady=10)
    except Exception:
        pass

# Texto principal
label = tk.Label(
    root,
    text=MSG_START,
    font=("Arial", 11),
    justify="center"
)
label.pack(pady=10)

# Barra de progreso
progress = ttk.Progressbar(root, mode="indeterminate")
progress.pack(fill="x", padx=40, pady=10)
progress.start(10)

# Estado
status_label = tk.Label(
    root,
    text="⏳ Iniciando...",
    font=("Arial", 10)
)
status_label.pack(pady=5)

# Ejecutar instalación en background
thread = threading.Thread(target=run_install, daemon=True)
thread.start()

root.mainloop()
