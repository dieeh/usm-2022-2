from matplotlib.backend_bases import cursors
import pyodbc
import pandas as pd
import re

def opciones():
    print("1.- Mostrar mi carrito")
    print("2.- Agregar productos al carrito")
    print("3.- Mostrar top 5 productos más caros")
    print("4.- Mostrar los 5 productos más caros según categoría especificada")
    print("5.- Finalizar compra")
    print("6.- Mostrar mi boleta")
    print("7.- Mostrar valor total")
    print("8.- Buscar producto segun nombre")
    print("9.- Eliminar todos los productos del carrito")
    print("10.- Eliminar producto específico del carrito")
    print("11.- Crear view")
    print("12.- Crear trigger")
    print("13.- Crear procedimiento almacenado")
    print("14.- Crear funcion")
    print("15.- Crear tablas y cargar archivo")
    print("16.- Salir del programa")
    


server = 'DIEGOPC\SQLEXPRESS'
database = 'MultiUSM' 
username = 'root' 
password = 'diego123' 

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+'; DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

option = 0

while option != 16:
    print("Elija una opción:")
    opciones()
    option = int(input())
    
    if option == 1:
        cursor.execute()
    elif option == 2:
        print('15')
    elif option == 3:
        print('15')
    elif option == 4:
        print('15')
    elif option == 5:
        print('15')
    elif option == 6:
        print('15')
    elif option == 7:
        print('15')
    elif option == 8:
        print('15')
    elif option == 9:
        print('15')
    elif option == 10:
        print('15')
    elif option == 11:
        print('15')
    elif option == 12:
        print('15')
    elif option == 13:
        print('15')
    elif option == 14:
        print('15')
    elif option == 15:
        cursor.execute("CREATE TABLE Productos (prod_id PRIMARY KEY INTEGER, prod_name VARCHAR(64), prod_description VARCHAR(128), prod_brand VARCHAR(64), category VARCHAR(64), prod_unit_price INTEGER)")
        cursor.execute("CREATE TABLE Carrito (prod_id INTEGER, prod_name VARCHAR(64), prod_brand VARCHAR(64), quantity INTEGER)")
        cursor.execute("CREATE TABLE Boleta (prod_id INTEGER, offer VARCHAR(32), total_value INTEGER, final_value INTEGER)")
        cursor.execute("CREATE TABLE Oferta (prod_id INTEGER, offer VARCHAR(32))")
    elif option == 16:
        break
    else: 
        print("Opción no válida, intente nuevamente")

    cursor.commit()


cursor.close()
cnxn.close()
