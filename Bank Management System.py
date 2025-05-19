import pyodbc

conn = pyodbc.connect(
    'DRIVER={SQL Server};'
    'SERVER=WIN-DBFHEB1G4A7\SQLEXPRESS\\SQLEXPRESS;'   
    'DATABASE=BankDB;'          
    'Trusted_Connection=yes;'
)


