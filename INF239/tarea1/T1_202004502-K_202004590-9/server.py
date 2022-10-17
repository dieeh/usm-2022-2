import pyodbc
#import pandas as pd
import re

def opciones():
    print("1.- Mostrar mi carrito") ##listo
    print("2.- Agregar productos al carrito") ##listo
    print("3.- Mostrar top 5 productos más caros") ##listo
    print("4.- Mostrar los 5 productos más caros según categoría especificada") ##listo
    print("5.- Finalizar compra")
    print("6.- Mostrar mi boleta") ##listo
    print("7.- Mostrar valor total") ##listo
    print("8.- Buscar producto segun nombre") ##listo
    print("9.- Eliminar todos los productos del carrito") ##listo
    print("10.- Eliminar un producto del carrito") ##listo
    print("11.- Crear tablas y cargar archivo")
    print("12.- Borrar tablas")
    print("13.- Salir del programa")


def obtener_ofertas():
    cursor.execute("CREATE VIEW CarritoDesc AS SELECT prod_id,prod_description FROM Productos WHERE prod_id IN (SELECT prod_id FROM Carrito)")
    cursor.execute("SELECT * FROM CarritoDesc WHERE prod_description LIKE '%pague%' AND prod_description LIKE '%lleve%[^undmlg]'")
    cursor.execute("SELECT prod_descripcion FROM CarritoDesc WHERE prod_id = ")
    ##obtener ofertas y llenar tabla oferta
    ## usar regex [Pp]ague [0-9]+ [Ll]leve [0-9]+[^undmglx]

def ofertas_fin():
    print("")
    ##calcular los precios finales con ofertas

server = 'DIEGOPC\SQLEXPRESS'
database = 'MultiUSM' 
#username = 'root' 
#password = 'diego123' 

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+'; DATABASE='+database+';Trusted_Connection=yes')
cursor = cnxn.cursor()
print("Conexión exitosa a la base de datos.\n")

option = 0
while option != 13:
    print("Elija una opción:")
    opciones()
    option = int(input("\n"))


    if option == 1: ## Mostrar mi carrito
        cursor.execute("SELECT prod_brand,prod_name,quantity FROM Carrito")
        for row in cursor.fetchall():
            print(row)

    
    elif option == 2: ## Agregar productos al carrito
        cod = input("Ingrese el código del producto que desea agregar: ")  
        quant = input("Ingrese la cantidad: ")
        hayono = cursor.execute("SELECT COUNT(*) FROM CARRITO WHERE prod_id="+cod+"")
        if hayono != 0:
            #cursor.execute("UPDATE Carrito SET quantity +="+quant+" WHERE prod_id="+cod+"")
            cursor.execute("EXEC agregar1 "+quant+" "+cod+"")
        else:
            cursor.execute("INSERT INTO Carrito (prod_id,prod_name,prod_brand) SELECT prod_id,prod_name,prod_brand FROM Productos WHERE prod_id="+cod+"")
            cursor.execute("UPDATE Carrito SET quantity="+quant+" WHERE prod_id="+cod+"")

    
    elif option == 3: ## Mostrar top 5 productos más caros
        print("Los productos más caros son:\n")
        cursor.execute("SELECT TOP 5 prod_name, prod_unit_price FROM Productos ORDER BY prod_unit_price DESC, prod_name")
        for row in cursor.fetchall():
            print(row)
        print("")

    
    elif option == 4: ## Mostrar los 5 productos más caros según categoría especificada
        categ = input("Ingrese la categoría a mostrar: ")
        print("Los productos más caros de esta categoría son:\n")
        cursor.execute("SELECT TOP 5 prod_name, prod_unit_price FROM Productos WHERE category = '"+categ+"' ORDER BY prod_unit_price DESC, prod_name")
        for row in cursor.fetchall():
            print(row)
        print("")
    
    elif option == 5: ## Finalizar compra
        #obtener_ofertas()

        print('Intente más tarde')


    elif option == 6: ## Mostrar mi boleta
        cursor.execute("SELECT * FROM Boleta")
        for row in cursor.fetchall():
            print(row)
        print("")

    elif option == 7: ## Mostrar valor total
        cursor.execute("SELECT SUM(final_value) FROM Boleta")
        for row in cursor.fetchall():
            print(row)
        print("")


    elif option == 8: ## Buscar producto segun nombre  ##
        nombrecito = input("Ingrese nombre del producto a buscar: ")
        print("Estos son los resultados cercanos a su busqueda:\n")
        cursor.execute("SELECT * FROM Productos WHERE prod_name LIKE '%"+nombrecito+"%'")
        for row in cursor.fetchall():
            print(row)
        print("")


    elif option == 9: ## Eliminar todos los productos del carrito
        cursor.execute("DROP TABLE Carrito")
        cursor.execute("CREATE TABLE Carrito (prod_id BIGINT FOREIGN KEY REFERENCES Productos(prod_id), prod_name VARCHAR(256), prod_brand VARCHAR(64), quantity INTEGER)")
        print("Elementos del carrito eliminados.\n")


    elif option == 10: ## Eliminar producto específico del carrito
        eli = input("Ingrese nombre del producto a eliminar: ")
        siono = cursor.execute("SELECT COUNT(*) FROM Carrito WHERE prod_name='"+eli+"'")
        if siono == 1:
            cursor.execute("DELETE FROM Carrito WHERE prod_name='"+eli+"'")
        elif siono == 0:
            print("Este producto no se encuentra en el carrito.")
        else:
            #cursor.execute("SELECT prod_id,prod_name,prod_description FROM Carrito WHERE prod_name='"+eli+"'")
            #cursor.execute("SELECT prod_id,prod_name,prod_description FROM Productos WHERE prod_name IN (SELECT prod_name FROM Carrito) ='"+eli+"'")
            cursor.execute("CREATE VIEW CarritoExtended AS SELECT prod_id,prod_name,prod_description FROM Productos WHERE prod_name IN (SELECT prod_name FROM Carrito)")
            cursor.execute("SELECT * FROM CarritoExtended WHERE prod_name='"+eli+"'")
            for row in cursor.fetchall():
                print(row)
            print("")
            id_eli = input("Hay varios productos en el carrito con ese nombre.\nIngrese el ID del producto que desea eliminar: ")
            cursor.execute("DELETE FROM Carrito WHERE prod_id="+id_eli+"")
            print("Producto eliminado.\n")


    elif option == 11: ## Crear tablas y cargar archivo
        cursor.execute("IF OBJECT_ID('Carrito') IS NOT NULL DROP TABLE Carrito")
        cursor.execute("IF OBJECT_ID('Boleta') IS NOT NULL DROP TABLE Boleta")
        cursor.execute("IF OBJECT_ID('Oferta') IS NOT NULL DROP TABLE Oferta")
        cursor.execute("IF OBJECT_ID('Productos') IS NOT NULL DROP TABLE Productos")

        cursor.execute("CREATE TABLE Productos (prod_id BIGINT PRIMARY KEY, prod_name VARCHAR(128), prod_description VARCHAR(256), prod_brand VARCHAR(32), category VARCHAR(64), prod_unit_price INTEGER)")
        cursor.execute("CREATE TABLE Carrito (prod_id BIGINT FOREIGN KEY REFERENCES Productos(prod_id), prod_name VARCHAR(128), prod_brand VARCHAR(64), quantity INTEGER)")
        cursor.execute("CREATE TABLE Boleta (prod_id BIGINT FOREIGN KEY REFERENCES Productos(prod_id), offer VARCHAR(32), total_value INTEGER, final_value INTEGER)")
        cursor.execute("CREATE TABLE Oferta (prod_id BIGINT FOREIGN KEY REFERENCES Productos(prod_id), offer VARCHAR(32))")

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

        cursor.execute("CREATE PROCEDURE agregar1 @canti INTEGER @id BIGINT AS UPDATE Carrito SET quantity += @canti WHERE prod_id= @id")
    
        cursor.execute("CREATE TRIGGER gatilloxd ON ")
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


    elif option == 12: ## Borrar tablas
        cursor.execute("DROP TABLE Carrito")
        cursor.execute("DROP TABLE Boleta")
        cursor.execute("DROP TABLE Oferta")
        cursor.execute("DROP TABLE Productos")
        print("Tablas borradas.\n")


    elif option == 13: ## Salir del programa
        break


    else:  ## Casos no válidos
        print("Opción no válida, intente nuevamente")

    cursor.commit()


cursor.close()
cnxn.close()
