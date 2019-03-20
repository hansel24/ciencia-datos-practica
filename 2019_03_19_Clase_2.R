#### 2019_03_19_Clase_2
##Modulo_3_Ciencia_de_datos

#Recomendación R for data Science
## Usar R como un SIG (se verá a lo largo del script), pero antes se ven cosas basicas de manejo de matrices y data.frame


#Asignar una secuencia a un objeto
mi_seq<-seq(from=1, to=100)
mi_seq1<-seq(10,20)
mi_seq2<-seq(20,30)

secuencia<-data.frame(mi_seq1,mi_seq2)
secuencia[3,1:2]

# Hacemos un matriz en R. En R raster son matrices.
matriz<-matrix(seq(1,9),nrow = 3,ncol = 3)
# Ejemplo de indexación
matriz[2,1:3]
matriz[1:2,1:2]
#Cambiar algún valor
matriz[1,1]=2
# Sumarle un valor a los elementos
matriz[2:3,2:3]+111
# Para seleccionar elementos que no son continuos
matriz[c(1,3),c(1,3)]
10>5
# Saber condicionales de la matriz
matriz
matriz>3
# Cambiamos los valores de donde es mayor a tres y le asignamos un nuevo valor
matriz[matriz>3]<-999


# Ejemplo para crear un data frame (data.frame) con valores númericos y string (tabla de datos).

numeros<-c(1,2,3)
texto<-c("Hola","Como","Estas")
booleanos<-c(TRUE,FALSE,TRUE)
data_frame<-data.frame(numeros,texto,booleanos)
data_frame[3,1]
data_frame[3,2:3]

# Existe un paquete de R para manipulación de rasters (ej. manipulación de imagenes satelitales).

install.packages("raster")
library(raster)

#Los rasters son matrices
#Creamos un raster a partir de la matriz vista con anterioridad. Para ello usamos la función raster Instalando con las lineas pasadas. 

matriz<-matrix(seq(1,9),nrow = 3,ncol = 3)
raster_matriz<-raster(matriz)
plot(raster_matriz)
points(0.25,0.75,pch=21, bg="red",cex=2)
#######lon   Lat, corresponden a 0.25 y 0.75 respectivamente

raster_nuevo<-raster_matriz-0.3*(raster_matriz)

# Ahora cargamos un archivo usando la función raster que nos permite cargar archivos raster. Para cargar varias bandas se deben usar las funciones brick, como en el siguiente caso:  

rapid_eye_1<-brick("C:\\Users\\dell\\Documents\\DOCTORADO_EN_CIENCIAS\\HERRAMIENTAS_DESTREZAS_BIG_DATA\\Modulo_3_Ciencia_datos\\curso_r_conabio\\curso_r_conabio\\1crop.tif")

install.packages("rgdal")
library(rgdal)
plotRGB(rapid_eye_1, r=3, g=2, b=1)
?plotRGB
#para ver el número de bandas
nbands(rapid_eye_1)
# Dimensiones de la matriz raster. Si es un raster multiespectral tienen X, Y y número de bandas.
dim(rapid_eye_1)
summary(rapid_eye_1)

# Para cambiar directorios usamos setwd que es la función que apunta a R a una carpeta (esto hace que solo una vez elijamos directorio y despues solo usar el nombre de cada archivo:
#setwd("C:\\Users\\dell\\Documents\\DOCTORADO_EN_CIENCIAS\\HERRAMIENTAS_DESTREZAS_BIG_DATA\\Modulo_3_Ciencia_datos\\curso_r_conabio\\curso_r_conabio")
#Para cargar un archivo basta
# rapid_eye_1<-brick("1crop.tif)

#### Ahora hacemos algebra con el raster, en especifico calcularemos un NDVI###############

#Uilizando la función subset() podemos obtener una o más bandas de una imagen multiespectral. Por ejemplo podemos extraer las bandas red (VIS) y near infrared (NIR).

# B3 Rojo visible y B5 rojo cercano
VIS<-subset(rapid_eye_1,subset=3)
NIR<-subset(rapid_eye_1,subset=5)

par(mfrow=c(1,2))
plot(VIS,main="VIS")
plot(NIR,main="NIR")

######Formula del NDVI
ndvi<-(NIR-VIS)/(VIS+NIR)
par(mfrow=c(1,1))
plot(ndvi, main="NDVI")
ndvi

# Ahora guardamos el raster en el disco duro. Para esto utilizamos la función writeRaster
rf<-writeRaster(ndvi,filename = "C:\\Users\\dell\\Documents\\DOCTORADO_EN_CIENCIAS\\HERRAMIENTAS_DESTREZAS_BIG_DATA\\Modulo_3_Ciencia_datos\\curso_r_conabio\\ndvi.tif",overwrite=TRUE)
# Si ya hay un directorio salvado, simplemente:
writeRaster(ndvi,filename ="ndvi.tif",overwrite=TRUE)
rf

