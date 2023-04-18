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

# Apuntes clase 

```java
EMPEZAR EJEMPLO CRUD
que significa crud?: 
C REATE
R EAD
U PDATE
D ELETE

use clientes

Si no hay colecciones no ves la BD

show dbs
```java
test>use clientes                               #usado para cambiar de DB
switched to db clientes
#aparece al principio de la sentencia el nombre de la DB
clientes>show dbs                               #nos muestra las bases de datos
admin    40.00 KiB
config  100.00 KiB
local    40.00 KiB
clientes> db.createCollection('customers')      #creamos la coleccion "customers"
{ ok: 1 }
clientes>show dbs
admin    40.00 KiB
clientes  8.00 KiB
config  100.00 KiB
local    40.00 KiB
clientes> db.customers.insert({first_name:'john', last_name:'Doe})
DeprecationWarning: Collection.insert() is deprecated. Use insertOne, insertMany, or bulkWrite.
{
        acknowledfef:true,
        insertedIds: { '0': ObjectId("697898678f6sa7896f8976fas8676fas8976") }
}
clientes> db.customers.find()
[
        {
                _id: ObjectId("697898678f6sa7896f8976fas8676fas8976"),
                first_name: 'John',
                last_name: 'Doe'
        }
]
clientes> db.customers.insertOne({first_name:"William", last_name:"Heart", gender:"male"})
{
        acknowledged:true,
        insertedId: ObjectId("697898678f62107401sauiy1772121421421")
}
clientes> db.customers.insertOne({first_name:"Mary", last_name:"Jackson", gender:"female", age:33, birth date: new Date('Sep 10, 1981')})
{
        acknowledged:true,
        insertedId: ObjectId("13123214542ui41421y4ui21441241f12g")
}
clientes> db.customers.find().pretty()
[
        {
                -id:ObjectId(""),
                first_name: 'John',
                last_name: 'Doe'
        },
        {
                -id:ObjectId(""),
                first_name: 'William',
                last_name: 'Heart',
                gender: 'male'
        }
]


clientes> db.customers.find().count()
3
clientes> db.customers.find().pretty().limit(2)                 #añadimos un numero a .limit, asi añadimos un limite al numero de datos que nos devuelve
[
        {
                -id:ObjectId(""),
                first_name: 'John',
                last_name: 'Doe'
        },
        {
                -id:ObjectId(""),
                first_name: 'William',
                last_name: 'Heart',
                gender: 'male'
        }
]
clientes> db.customers.find({gender: 'male'})
clientes> db.customers.find({gender: 'male'}).pretty()
[
        {
                -id:ObjectId(""),
                first_name: 'William',
                last_name: 'Heart',
                gender: 'male'
        }
]
```

* Hace un backup de la DB "sample_airbnb" desde la nube a la maquina local 
* Restaura una DB en la nube desde los datos en local 

```

mongodump --uri mongodb+srv://salvadorcabdedo:Abc123.@mcs.ojlmoig.mongodb.net/sample_airbnb

```

Exportar desde cmd en la nube
```bash
mongoexport --uri mongodb+srv://salvadorcandedo:Abc123.@mcs.oj1moig.mongodb.net/sample_mflix --collection movies --type json --out C:\Data
```

Exportar desde cmd 
```bash
mongoexport --db=pethotel --collection=pets --type=json --fields=_id,name,type,weight --out=data/pets.json

```

```java
db.pets.insertMany([
    {"_id" : 1, "name" : "Wag", "type" : "Dog"},
    {"_id" : 2, "name" : "Bark", "type" : "Dog"},
    {"_id" : 3, "name" : "Meow", "type" : "Cat"}
])


db.pets.insertMany([
    {"_id" : 1, "weight" : "40"},
    {"_id" : 2, "name" : "Wag", "type" : "Dog", "weight" : "10"},
    {"_id" : 3, "name" : "Bark", "type" : "Dog", "weight" : "7"},
    {"_id" : 4, "name" : "Meow", "type" : "Cat", "weight" : "3"}
])


mongoimport --db=Pethotel --collection=pets --mode=upsert --file="Ruta del archivo"

mongoimport --db=Pethotel --collection=pets --mode=merge --file="Ruta del archivo"

mongoimport --db=Pethotel --collection=pets --mode=upsert --file="Ruta del archivo"

```
