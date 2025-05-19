import tkinter as tk
from tkinter import messagebox
import pyodbc

def get_connection():
    conn = pyodbc.connect(
        'DRIVER={SQL Server};'
        r'SERVER=WIN-DBFHEB1G4A7\SQLEXPRESS;'
        'DATABASE=BankDB;'
        'Trusted_Connection=yes;'
    )
    return conn

def add_customer():
    fullname = entry_fullname.get()
    address = entry_address.get()
    phone = entry_phone.get()
    email = entry_email.get()
    salary = entry_salary.get()

    if not fullname or not address or not phone or not email or not salary:
        messagebox.showwarning("Boş xanalar", "Zəhmət olmasa bütün xanaları doldurun.")
        return

    try:
        salary_float = float(salary)
    except ValueError:
        messagebox.showerror("Xəta", "Salary üçün düzgün ədədi daxil edin.")
        return

    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.execute(
            """
            INSERT INTO Customers_New (FullName, Address, Phone, Email, Salary)
            VALUES (?, ?, ?, ?, ?)
            """,
            (fullname, address, phone, email, salary_float)
        )
        conn.commit()
        conn.close()

        messagebox.showinfo("Uğurla", "Müştəri əlavə olundu!")
        entry_fullname.delete(0, tk.END)
        entry_address.delete(0, tk.END)
        entry_phone.delete(0, tk.END)
        entry_email.delete(0, tk.END)
        entry_salary.delete(0, tk.END)

    except Exception as e:
        messagebox.showerror("Xəta", f"Müştəri əlavə olunmadı:\n{e}")

# Tkinter pəncərə yaradılması
window = tk.Tk()
window.title("Bank Management System")
window.geometry("350x350")

tk.Label(window, text="Ad Soyad:").pack(pady=(10, 0))
entry_fullname = tk.Entry(window, width=40)
entry_fullname.pack()

tk.Label(window, text="Ünvan:").pack(pady=(10, 0))
entry_address = tk.Entry(window, width=40)
entry_address.pack()

tk.Label(window, text="Telefon:").pack(pady=(10, 0))
entry_phone = tk.Entry(window, width=40)
entry_phone.pack()

tk.Label(window, text="Email:").pack(pady=(10, 0))
entry_email = tk.Entry(window, width=40)
entry_email.pack()

tk.Label(window, text="Salary:").pack(pady=(10, 0))
entry_salary = tk.Entry(window, width=40)
entry_salary.pack()

tk.Button(window, text="Müştəri Əlavə Et", command=add_customer).pack(pady=20)

window.mainloop()
