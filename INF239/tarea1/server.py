import pyodbc
#import pandas as pd
#import re

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
    print("16.- Salir del programa\n")
    

server = 'DIEGOPC\SQLEXPRESS'
database = 'MultiUSM' 
username = 'root' 
password = 'diego123' 

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+'; DATABASE='+database+';Trusted_Connection=yes')
cursor = cnxn.cursor()
print("Conexión exitosa a la base de datos.\n")

option = 0
while option != 16:
    print("Elija una opción:")
    opciones()
    option = int(input())


    if option == 1: ## Mostrar mi carrito
        cursor.execute("SELECT prod_brand,prod_name,quantity FROM Carrito")
        for row in cursor.fetchall():
            print(row)

    
    elif option == 2: ## Agregar productos al carrito
        cod = input("Ingrese el código del producto que desea agregar: ")
        quant = input("Ingrese la cantidad: ")
        cursor.execute("INSERT INTO Carrito (SELECT prod_id,prod_name,prod_brand FROM Productos WHERE prod_id="+cod+") AND ")

    
    elif option == 3: ## Mostrar top 5 productos más caros
        cursor.execute("SELECT TOP 5 prod_name, prod_unit_price FROM Productos ORDER BY prod_unit_price DESC, prod_name")
        for row in cursor.fetchall():
            print(row)

    
    elif option == 4: ## Mostrar los 5 productos más caros según categoría especificada
        categ = input("Ingrese la categoría a mostrar: ")
        cursor.execute("SELECT TOP 5 prod_name, prod_unit_price FROM Productos WHERE category = '"+categ+"' ORDER BY prod_unit_price DESC, prod_name")
        for row in cursor.fetchall():
            print(row)
    
    elif option == 5: ## Finalizar compra
        print('Nada todavia')


    elif option == 6: ## Mostrar mi boleta
        print('Nada todavia')


    elif option == 7: ## Mostrar valor total
        print('Nada todavia')


    elif option == 8: ## Buscar producto segun nombre
        print('Nada todavia')


    elif option == 9: ## Eliminar todos los productos del carrito
        cursor.execute("DROP TABLE Carrito")
        cursor.execute("CREATE TABLE Carrito (prod_id BIGINT, prod_name VARCHAR(256), prod_brand VARCHAR(64), quantity INTEGER)")


    elif option == 10: ## Eliminar producto específico del carrito
        print('Nada todavia')


    elif option == 11: ## Crear view
        print('Nada todavia')


    elif option == 12: ## Crear trigger
        print('Nada todavia')


    elif option == 13: ## Crear procedimiento almacenado
        print('Nada todavia')


    elif option == 14: ## Crear funcion
        print('Nada todavia')


    elif option == 15: ## Crear tablas y cargar archivo
        cursor.execute("IF OBJECT_ID('Productos') IS NOT NULL DROP TABLE Productos")
        cursor.execute("IF OBJECT_ID('Carrito') IS NOT NULL DROP TABLE Carrito")
        cursor.execute("IF OBJECT_ID('Boleta') IS NOT NULL DROP TABLE Boleta")
        cursor.execute("IF OBJECT_ID('Oferta') IS NOT NULL DROP TABLE Oferta")

        cursor.execute("CREATE TABLE Productos (prod_id BIGINT, prod_name VARCHAR(256), prod_description VARCHAR(256), prod_brand VARCHAR(64), category VARCHAR(64), prod_unit_price INTEGER, PRIMARY KEY(prod_id))")
        cursor.execute("CREATE TABLE Carrito (prod_id BIGINT, prod_name VARCHAR(256), prod_brand VARCHAR(64), quantity INTEGER)")
        cursor.execute("CREATE TABLE Boleta (prod_id BIGINT, offer VARCHAR(32), total_value INTEGER, final_value INTEGER)")
        cursor.execute("CREATE TABLE Oferta (prod_id BIGINT, offer VARCHAR(32))")

        file = open("ProductosVF2.csv", "r", encoding="utf8")
        next(file)
        for line in file:
            p_id, p_name, p_desc, p_brand, cat, p_unit_price = line.split(";")
            p_name = p_name.replace("'", "''")
            p_desc = p_desc.replace("'", "''")
            p_brand = p_brand.replace("'", "''")
            cursor.execute("INSERT INTO Productos VALUES ("+p_id+", '"+p_name+"', '"+p_desc+"', '"+p_brand+"', '"+cat+"', "+p_unit_price+")")
        file.close() 

        print("Se han creado las tablas y se ha cargado el archivo a la base de datos de manera correcta.\n")

        ##df = pd.read_csv("ProductosVF2.csv", sep=';')
        ##for row in df.itertuples():
        ##    cursor.execute("""
        ##    INSERT INTO Productos (prod_id,prod_name,prod_description,prod_brand,category,prod_unit_price) VALUES (?, ?, ?, ?, ?, ?)
        ##    """,
        ##            row.prod_id,
        ##            row.prod_name,
        ##            row.prod_description,
        ##            row.prod_brand,
        ##            row.category,
        ##            row.prod_unit_price)


    elif option == 16: ## Salir del programa
        cursor.execute("DROP TABLE Productos")
        cursor.execute("DROP TABLE Carrito")
        cursor.execute("DROP TABLE Boleta")
        cursor.execute("DROP TABLE Oferta")
        break


    else:  ## Casos no válidos
        print("Opción no válida, intente nuevamente")

    cursor.commit()


cursor.close()
cnxn.close()
