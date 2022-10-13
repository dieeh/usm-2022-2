import pyodbc

server = 'DIEGOPC\SQLEXPRESS'
database = 'MultiUSM' 
username = 'root' 
password = 'diego123' 

cnxn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';ENCRYPT=yes;UID='+username+';PWD='+ password)
cursor = cnxn.cursor()


