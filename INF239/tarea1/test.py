file = open("ProductosVF2.csv", "r")
next(file)
for line in file:
    p_id, p_name, p_desc, p_brand, cat, p_unit_price = line.split(";")
    p_name = p_name.replace('®', '')
    p_desc = p_desc.replace('®', '')
    #cursor.execute("INSERT INTO Productos (prod_id, prod_name, prod_description, prod_brand, category, prod_unit_price) VALUES ("+p_id+", "+p_name+", "+p_desc+", "+p_brand+", "+cat+", "+p_unit_price+")")
file.close()