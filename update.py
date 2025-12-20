#!/usr/bin/env python3
import tkinter as tk
from tkinter import ttk
import subprocess
import threading
import os

LOGO_PATH = "/opt/pos/img/technomaxa-logo.png"
TITLE = "TechnoMäxä – Actualización del sistema"
MESSAGE = "Buscando actualizaciones...\nEsto puede tardar unos minutos."

SCRIPT_FRONT= "/opt/pos/frontend/update-frontend.sh"
# Para backend cambiar a:
SCRIPT_BACK = "/opt/pos/backend/update-backend.sh"

def run_update():
    try:
        subprocess.run(
            ["sudo", SCRIPT_FRONT],
            check=True
        )
        status_label.config(text="✅ Actualización completada")
    except subprocess.CalledProcessError:
        status_label.config(text="❌ Error durante la actualización")
    finally:
        progress.stop()


def run_update():
    try:
        subprocess.run(
            ["sudo", SCRIPT_BACK],
            check=True
        )
        status_label.config(text="✅ Actualización completada")
    except subprocess.CalledProcessError:
        status_label.config(text="❌ Error durante la actualización")
    finally:
        progress.stop()


root = tk.Tk()
root.title(TITLE)
root.geometry("420x260")
root.resizable(False, False)

# Logo
if os.path.exists(LOGO_PATH):
    logo = tk.PhotoImage(file=LOGO_PATH)
    logo_label = tk.Label(root, image=logo)
    logo_label.pack(pady=10)

label = tk.Label(root, text=MESSAGE, font=("Arial", 11))
label.pack(pady=10)

progress = ttk.Progressbar(root, mode="indeterminate")
progress.pack(fill="x", padx=30, pady=10)
progress.start(10)

status_label = tk.Label(root, text="⏳ En progreso...", font=("Arial", 10))
status_label.pack(pady=5)

thread = threading.Thread(target=run_update, daemon=True)
thread.start()

root.mainloop()
