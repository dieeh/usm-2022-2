#@title Datos invierno
df1 = bikedf[bikedf['season'] == 1] #winter = 1
df1 = df1[['atemp']]

df11 = df1['atemp'].to_list()
temperaturas = [0,5,10,15,20,25,30,35]

plt.hist(df11, bins=temperaturas, edgecolor='white')
plt.ylabel("count")
plt.xlabel("atemp")
plt.title("WINTER")
plt.show()


#@title Datos verano
df2 = bikedf[bikedf['season'] == 3] #summer = 3
df2 = df2[['atemp']]

df22 = df2['atemp'].to_list()
temperaturas = [10,15,20,25,30,35,40,45,50]

plt.hist(df22, bins=temperaturas, edgecolor='white')
plt.ylabel("count")
plt.xlabel("atemp")
plt.title("SUMMER")
plt.show()


#@markdown esta es la frecuencia de los alquileres a ciertas temperaturas, pero no
#@markdown cacho como hacer que se multiplique por el total de alquileres del dia,
#@markdown o si es necesario hacer eso (??