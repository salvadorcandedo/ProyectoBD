---
layout: single

excerpt: "Apuntes"title: Apuntes MongoDB
excerpt: 
date: 2023-03-10
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

/** Hace un backup de la DB "sample_airbnb" desde la nube a la maquina local */
/** Restaura una DB en la nube desde los datos en local */

```

mongodump --uri mongodb+srv://salvadorcabdedo:Abc123.@mcs.ojlmoig.mongodb.net/sample_airbnb

```

Exportar desde cmd en la nuve
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