---
layout: single
excerpt: "Apuntes"
title: Apuntes MongoDB
excerpt: 
date: 2023-04-12
classes: wide
header:
  teaser:
  teaser_home_page: true
  icon: 
categories:
  - 
  - 
  - MongoDB
tags:
  - 
  - 
  - 
  - 
  - 
  - 
  - 
---
- [Mongo DB](#mongo-db)
- [Iniciar MongoDB](#iniciar-mongodb)
- [Comandos mongo DB:](#comandos-mongo-db)
- [Creacion base de datos SCP](#creacion-base-de-datos-scp)
  - [Array con dos objetos](#array-con-dos-objetos)
- [Apuntes clase](#apuntes-clase)



# Mongo DB
Principales Diferencias entre Bases de datos NoSql y Sql:
 + Una base de datos NoSql está compuesta de colecciones, lo que equivaldría a tablas en las
SQL.
 + Las colecciones están compuestas por documentos similar a los registros
 + Los documentos están formados por campos similar a las columnas de las filas
 + En las NoSql los campos pueden ser indexados. Funcionan igual que en las SQL
  

# Iniciar MongoDB


En la cmd de Windows una vez instalado el programa podemos ejecutar el conmando mongod para iniciar el servidor 



```c
Microsoft Windows [Versión 10.0.19043.928]
(c) Microsoft Corporation. Todos los derechos reservados.

C:\Users\Salva>mongod

```
Para ejecutar ese comando a secas hace falta una previa configurtacion del PATH para que busque los ejecutables en la ruta donde mongodb se encuentra instalado ; en caso de no tenerla configirada el path es el siguiente 
> C:\Program Files\MongoDB\Server\6.0\bin\


Si nos devuelve un output similar significa que el servidor de mongo se ha iniciado correctamente en nuestra maquina
 <p align="center">
<img src="/ProyectoBD/assets/images/mongodb1/mongo1.png">
</p>
El output nos deberia devolver un mensaje indicando que el servidor esta iniciado y escuchando por el puerto 27017
+ >  waiting for
                connections on port 27017


---
Con el comando mongosh en otra terminal podremos acceder a la cli del servidor de mongo
```c
C:\>mongosh

Current Mongosh Log ID: 643d0d9fe7839d3f7218c681
Connecting to:          mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.6.2
Using MongoDB:          6.0.3
Using Mongosh:          1.6.2

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2023-04-14T10:28:23.561+02:00: Access control is not enabled for the database. Read and write access to data and configuration is unrestricted
------
```
Analizando el output observamos que se ha conectado a nuestro servidor de mongo abierto en el puerto 27017 de nuestri localhost (127.0.0.1)


# Comandos mongo DB:
 - ``help` -> obtener ayuda para el contexto en el que me encuentro
 - `help()` -> mostrar ayuda sobre lista de comandos para una colección 
 
 - `cls` -> borra la pantalla y coloca el cursor en la parte superior
 - `quit()` -> salir de la shell

 - ` CNTRL+C` -> salir de la shell
 - `show dbs` -> mostrar las Bases de Datos del Servidor
 - `db` -> muestra la Base de Datos en la que me encuentro
 - `show collections` -> mostrar colecciones en el actual BD
 - `pwd()` -> mostrar la ruta en la que me encuentro

# Creacion base de datos SCP
Con el input use [Nombre] podemos crear y entrar en la base de datos 
```java
test> use SCP
switched to db SCP
SCP>
```
Vamos a crear una colleccion , que seria similar a crear una tabla en un modelo SQL , vamos a crear la coleccion clientes
```java
SCP> db.createCollection('clientes')
{ ok: 1 }
```
para ver las collecciones creadas
```
show collections
```
Vamos a insertar datos en nuestra colleccion clientes, lo podemos hacer con el siguiente json
```java
db.clientes.insert({
        "nombre":"John",
        "edad":"42",
        "Direccion":{"Calle":"Conchas","Numero":"9","Ciudad":"Ibiza"},
        "Num":"981717171"
})
```

>{
  acknowledged: true,
  insertedIds: { '0': ObjectId("643d16dc9d94897a8be759ff") }
}

Si observamos el campo direccion vemos la clara diferencia entre las bases de datos no sql y las sql , el campo direccion precisaria de dos tablas y relacion entre ellas mientras que en esta base de datos de mongo insertamos todo como un unico documento


  + Con el parametro db.clientes.find().pretty() podemos hacer un "select" y que ademas se vea bonito 
   ```java
  SCP> db.clientes.find().pretty()
[
  {
    _id: ObjectId("643d16dc9d94897a8be759ff"),
    nombre: 'John',
    edad: '42',
    Direccion: { Calle: 'Conchas', Numero: '9', Ciudad: 'Ibiza' },
    Num: '981717171'
  }
]
```
## Array con dos objetos
```java
[
 {
        "nombre":"Pedro",
        "edad":"9",
        "Direccion":{"Calle":"Porto","Numero":"2","Ciudad":"NuncaJamas"},
        "Num":"981717171"
},
{
        "nombre":"Maria",
        "edad":"29",
        "Direccion":{"Calle":"Vereda","Numero":"2","Ciudad":"NuevaYork"},
 }
]
```
 <p align="center">
<img src="/ProyectoBD/assets/imagesdmongodb1/mongo2.png">
</p>









----
