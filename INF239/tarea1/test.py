file = open("ProductosVF2.csv", "r", encoding="utf8")
next(file)

len1 = 0
len2 = 0
len3 = 0
len4 = 0

for line in file:
    p_id, p_name, p_desc, p_brand, cat, p_unit_price = line.split(";")

    if len(p_name)>len1:
        len1 = len(p_name)
    if len(p_desc)>len2:
        len2 = len(p_desc)
    if len(p_brand)>len3:
        len3 = len(p_brand)
    if len(cat)>len4:
        len4 = len(cat)

print("Nombre más largo: "+str(len1))
print("Descripcion más larga: "+str(len2))
print("Marca más larga: "+str(len3))
print("Categoria más larga: "+str(len4))
file.close()


#if len(p_name)>len1:
#    len1 = len(p_name)
#if len(p_desc)>len2:
#    len2 = len(p_desc)
#if len(p_brand)>len3:
#    len3 = len(p_brand)
#if len(cat)>len4:
#    len4 = len(cat)