---
layout: single
title: Transact SQL
excerpt: "Transact SQL Proyecto"
date: 2023-05-30
classes: wide
header:
  teaser: 
  teaser_home_page: true
  icon: 
categories:
  - ssms
tags:
  - TransactSQL
  - 
  - 
  - 
  - 
  - 
  - 
---

- [1.-  SELECTS](#1---selects)
  - [SELECT CONCATENADO](#select-concatenado)
    - [Excepción campo numeric/decimal/integer](#excepción-campo-numericdecimalinteger)
  - [DEFINIR CABECERAS](#definir-cabeceras)
- [Criterios de Busqueda](#criterios-de-busqueda)
- [And / OR](#and--or)
  - [OFFSET](#offset)
- [Filtros con expresiones lógicas](#filtros-con-expresiones-lógicas)
  - [WHERE](#where)
  - [Where "igual a"](#where-igual-a)
  - [Where "mayor que"](#where-mayor-que)
  - [Where "menor que"](#where-menor-que)
- [Ordenación de datos de salida](#ordenación-de-datos-de-salida)
  - [Order by](#order-by)
    - [con DESC (descendiente)](#con-desc-descendiente)
- [Expresiones regulares](#expresiones-regulares)
  - [Like % (wildcard)](#like--wildcard)
    - [LIKE con Expresión "^"](#like-con-expresión-)
    - [LIKE con Expresión "\_"](#like-con-expresión-_)
- [Funciones de agregación](#funciones-de-agregación)
  - [COUNT](#count)
  - [Sum](#sum)
  - [MAX](#max)
  - [MIN](#min)
  - [AVG](#avg)
  - [DISTINCT](#distinct)
- [Agrupación](#agrupación)
  - [Group by](#group-by)
  - [HAVING](#having)
    - [GROUP BY Ejemplo 2](#group-by-ejemplo-2)
    - [HAVING ejemplo 2](#having-ejemplo-2)
- [Consultas sobre varias tablas](#consultas-sobre-varias-tablas)
  - [UNION](#union)
  - [INTERSECT](#intersect)
  - [EXCEPT](#except)
- [JOIN](#join)
  - [INNER JOIN](#inner-join)
  - [LEFT JOIN](#left-join)
  - [RIGHT  JOIN](#right--join)
- [Subconsultas](#subconsultas)
- [Integridad referencial](#integridad-referencial)
- [Truncate](#truncate)
- [Merge](#merge)
- [Procedimientos de Almacenado](#procedimientos-de-almacenado)
  - [Estructura Case](#estructura-case)
  - [Con Variables](#con-variables)
- [Output](#output)
- [RollBack](#rollback)
- [Tablas temporales](#tablas-temporales)
- [Trigers](#trigers)
  - [Listar Triggers](#listar-triggers)
    - [TR auditar cambios](#tr-auditar-cambios)
    - [TR\_Longitud de contraseña](#tr_longitud-de-contraseña)
- [Vistas](#vistas)




## Comentario previo al trabajo de TransactSQL

<p>
  Proceso de instalacion de 
  <a href="https://salvadorcandedo.github.io/ProyectoBD/DockerizarMssql">MSSQL en docker </a>.
</p>




<p>
  Puedes encontrar mis 
  <a href="https://salvadorcandedo.github.io/ProyectoBD/DockerizarMssql">QUERYS DE SQL</a> en mi repositorio de Github .
</p>



## Funciones del sistema

Sacar el nombre de la base de datos
```sql
SELECT db_name()
Go
```
Nombre Inicio de sesion original 
```sql
Print original_login()
```

----------------------------------



# 1.-  SELECTS


```sql
USE AdmFincas
GO
SELECT * FROM alquileres
GO
--	(12 filas afectadas)
```

  ## SELECT CONCATENADO
> Aquí realizo un SELECT y lo concateno con dos pipes

```sql
USE AdmFincas
GO
SELECT Nombre + '||' + Email 
FROM Inquilinos
GO
```

> Aqui con una coma usando pubs

```sql
USE pubs
SELECT fname + ' , ' +lname 
From employee
Go 
```

<p align="center">
<img src="/ProyectoBD/assets/images/Transact/2.png">
</p>

### Excepción campo numeric/decimal/integer

> Si se trata de un dato tipo numeric,decimal o integer el  número se sumará 
> 
```sql
SELECT GastoID,Descripcion,Monto + 50 
AS Precio
From Gastos
Go
```

| GastoID | Descripción               | Precio   |
|---------|---------------------------|----------|
| 1       | Mantenimiento de jardín   | 250.00   |
| 2       | Reparación de fontanería  | 350.00   |
| 3       | Pintura de fachada        | 450.00   |
| 4       | Limpieza común            | 200.00   |
| 5       | Reparación de ascensor    | 550.00   |
| 6       | Mantenimiento de piscina  | 350.00   |

> podemos evitarlo realizando un cast o un convert sobre el dato que deseemos manipular

```sql
USE AdmFincas
SELECT GastoID,Descripcion,CAST(Monto AS VARCHAR(20)) + '50' 
AS Precio
From Gastos
Go
```



| GastoID | Descripcion                 | Precio    |
| ------- | --------------------------- | --------- |
| 1       | Mantenimiento de jardín     | 200.0050  |
| 2       | Reparación de fontanería    | 300.0050  |
| 3       | Pintura de fachada          | 400.0050  |
| 4       | Limpieza común              | 150.0050  |
| 5       | Reparación de ascensor      | 500.0050  |
| 6       | Mantenimiento de piscina    | 300.0050  |

## DEFINIR CABECERAS 
Podemos definir las cabeceras con el uso de AS

```sql
USE AdmFincas
GO
SELECT Nombre + '||' + Email AS 'Informacion Inquilino'
FROM Inquilinos
GO
USE pubs
SELECT fname + ' , ' +lname AS [Nombre Completo]
From employee
Go 
```
# Criterios de Busqueda
# And / OR

El operador `OR` nos muestra los datos de los inquilinos que tengan 30 O 33 años
```sql
-- OR
USE AdmFincas
GO
SELECT * FROM Inquilinos
WHERE Edad = 30 OR Edad = 33
GO
GO
```
El Operador AND nos mostrará los datos de la coluumna Inquilinos que cumplan con ambas condiciones.

```sql
-- AND
USE AdmFincas
GO
SELECT * FROM Inquilinos
WHERE InquilinoID = 1 AND Direccion  = 'Avenida Libertad 789'
GO
```





## OFFSET 

Con offset podemos saltarnos filas 
```sql
SELECT InquilinoID from Inquilinos
order by InquilinoID
Offset 1 Rows fetch next 5 rows only
Go
```
> Nos muestra la columna a partir del ID 2 y nos printea las 5 siguientes




# Filtros con expresiones lógicas

##  WHERE

 Podemos filtrar los datos de una tabla mediante la cláusula WHERE y una condición lógica. (que el ID de la finca sea 1 , o que muestre los alquileres cuyo monto sea mayor que 1050 euros)

## Where "igual a"

```sql
USE AdmFincas
GO
SELECT FincaID, Monto FROM Alquileres
WHERE FincaID = 1
GO
```
## Where "mayor que"

```sql
  USE AdmFincas
GO
SELECT FincaID, Monto FROM Alquileres
WHERE Monto > 1050.00
GO
```

## Where "menor que"
 
```sql
USE AdmFincas
GO
SELECT FincaID, Monto FROM alquileres
WHERE Monto < 1000.00
```

# Ordenación de datos de salida
Si deseamos ordenar los datos de salida  debemos usar ORDER BY

## Order by

> Ordenamos De manera Ascendente el precio de las fincas en alquiler

```sql
SELECT Monto, FincaID 
From Inquilinos
Order by Monto
Go
```

|Monto   |FincaID|
|--------|-------|
|900.00  |4      |
|900.00  |12     |
|950.00  |7      |
|1000.00 |3      |
|1000.00 |6      |
|1000.00 |1      |
|1000.00 |10     |
|1050.00 |8      |
|1100.00 |5      |
|1150.00 |9      |
|1200.00 |11     |
|2000.00 |2      |


Podemos ordenarlos de manera descencente
### con DESC (descendiente)

```sql
SELECT FincaId, Monto
From Alquileres
Order by Monto DESC
Go
---(12 filas afectadas)
```


# Expresiones regulares
Si queremos filtrar por de texto, combinaciones de caracteres o patrones particulares debemos usar el LIKE junto con WHERE

## Like % (wildcard)
>Sacamos todos Emails que contengan "example.com" puede sernos útil para filtrar por empresas de correo electróniuco cómo "yahoo.es" o "gmail.com"

```sql
SELECT Nombre,Email
from Inquilinos
where Email like '%example.com'
```

| Nombre          | Email                |
|-----------------|----------------------|
| Carlos Ramírez  | carlos@example.com   |
| Ana Martínez    | ana@example.com      |
| Luisa Torres    | luisa@example.com    |
| Sergio Ramos    | sergio@example.com   |
| Ana López       | ana@example.com      |
| Pedro Jiménez   | pedro@example.com    |


Un ejemplo podría ser la siguiente query usando el operador `OR` :

```sql
SELECT Nombre,Email
FROM Inquilinos
WHERE Email LIKE '%@gmail.com' 
OR 
Email LIKE '%@yahoo.es';
GO
---	(6 filas afectadas)
```

| Nombre          | Email              |
|-----------------|--------------------|
| Carlos Ramírez  | carlos@yahoo.es    |
| Ana Martínez    | ana@gmail.com      |
| Luisa Torres    | luisa@yahoo.es     |
| Sergio Ramos    | sergio@gmail.com   |
| Ana López       | ana@yahoo.es       |
| Pedro Jiménez   | pedro@gmail.com    |


Podemos seleccionar filtrando por una cadena de números, por ejemplo ;

> Necesito filtrar por los números que empiecen entre 1 y 4 de una columna donde todos los números empiezan por 555:

```sql
SELECT Telefono,Nombre FROM Inquilinos
```


| Teléfono | Nombre         |
|----------|----------------|
| 555-1234 | Carlos Ramírez |
| 555-5678 | Ana Martínez   |
| 555-9012 | Luisa Torres   |
| 555-4444 | Sergio Ramos   |
| 555-5555 | Ana López      |
| 555-6666 | Pedro Jiménez  |
| 555-1234 | Carlos Ramírez |
| 555-5678 | Ana Martínez   |
| 555-9012 | Luisa Torres   |
| 555-4444 | Sergio Ramos   |
| 555-5555 | Ana López      |
| 555-6666 | Pedro Jiménez  |

```sql
SELECT Nombre,Telefono
FROM Inquilinos
WHERE telefono LIKE '555-[1-4]%'
GO
---(4 filas afectadas)
```

| Nombre         | Teléfono |
|----------------|----------|
| Carlos Ramírez | 555-1234 |
| Sergio Ramos   | 555-4444 |
| Carlos Ramírez | 555-1234 |
| Sergio Ramos   | 555-4444 |

### LIKE con Expresión "^"

Podemos indicar el contrario de la siguiente forma

```sql
SELECT Nombre,Telefono
FROM Inquilinos
WHERE telefono LIKE '555-[^1-4]%'
GO
---(8 filas afectadas)
```

### LIKE con Expresión "_"

Podemos usar el guion bajo para indicar que no sabemos el caracter que ocupa en ese segmento

```sql
SELECT Nombre,Telefono 
from Inquilinos
where Telefono like '555-5___'
GO
---(4 filas afectadas)
```

| Nombre         | Teléfono |
|----------------|----------|
| Ana Martínez   | 555-5678 |
| Ana López      | 555-5555 |
| Ana Martínez   | 555-5678 |
| Ana López      | 555-5555 |



# Funciones de agregación

Toman una serie de registros, efectúan una operación sobre todos ellos y devuelven un único resultado

## COUNT  

> Supongamos que nos interesa saber el número de Inquilinos que hay actualmente instalados, con Count(*) contamos todas las filas de esa columna.

```sql
SELECT Count(InquilinoID) as [Numero de Inquilinos]
From Inquilinos 
Go
---Total execution time: 00:00:00.114
```

## Sum

> Sum se utiliza para sumar los datos de una columna, por ejemplo, vamos a sumar el monto para obtener los gastos totales 

```sql
SELECT SUM(Monto) AS TotalGastos
FROM Gastos;
---(1 fila afectada)
```

## MAX


Filtramos por la fila que contenga el número más alto en la columna monto
```sql
SELECT Max(monto) as COSTE_MAS_ALTO
from Gastos
```

| COSTE_MAS_ALTO |
|-------------|
|   500.00    |

Podemos sacarlo junto con otra columna con un where

```sql
SELECT Descripcion, Monto AS COSTE_MAS_ALTO 
FROM Gastos
WHERE Monto = (SELECT MAX(Monto) FROM Gastos) 
```

| Descripcion             | COSTE_MAS_ALTO |
|-------------------------|-------------|
| Reparación de ascensor | 500.00       |


## MIN 


Filtramos por la fila que contanga el menor valor en la columna de Monto.
```sql
SELECT Descripcion, Monto AS COSTEMINIMO
FROM Gastos
WHERE Monto = (SELECT MIN(Monto) FROM Gastos) 
```

| Descripcion   | COSTEMINIMO |
|---------------|-------------|
| Limpieza común | 150.00     |

## AVG 
Podemos sacar la media (average) de los datos de una columna

```sql
USE AdmFincas
SELECT AVG(Monto) FROM GASTOS as MEDIA_GASTOS
```
| MEDIA_GASTOS  |
|---------------|
| 308.333333    |

## DISTINCT

Se utiliza para Mostrar los campos duplicados

Creo varios campos duplicados en mi tabla nombre para demostrar el ejemplo:
```sql
SELECT Nombre FROM Inquilinos
```

| Nombre          |
|-----------------|
| Carlos Ramírez  |
| Ana Martínez    |
| Luisa Torres    |
| Sergio Ramos    |
| Ana López       |
| Pedro Jiménez   |
| Carlos Ramírez  |
| Ana Martínez    |
| Luisa Torres    |
| Sergio Ramos    |
| Ana López       |
| Pedro Jiménez   |

```sql
SELECT distinct nombre
From usuarios
Go
--- 	(6 filas afectadas)
```

| nombre         |
|----------------|
| Ana López      |
| Ana Martínez   |
| Carlos Ramírez |
| Luisa Torres   |
| Pedro Jiménez  |
| Sergio Ramos   |

> Podemos observar cómo nos filtra solo los campos Duplicados en la columna nombres 

# Agrupación

## Group by

Por ejemplo, si deseamos conocer el número de
fincas correspondientes a un tipo de suelo particular
```sql
USE ADMFincas
SELECT COUNT(AlquilerID) AS 'NUMERO DE FINCAS' , InquilinoID
FROM ContratosAlquiler 
GROUP BY InquilinoID
GO
```
Con este Group by ordenamos los ID delos Inquilinos del 1 al 12 y al lado podemos ver el Número de fincas que posee cada uno .

Ya que tengo el nombre de cada Inquilino en otra tabla se me ocurrió hacerle un JOIN 

```sql
USE ADMFincas
SELECT COUNT(AlquilerID) AS 'NUMERO DE FINCAS' , I.Nombre 
FROM ContratosAlquiler CA

INNER JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID
GROUP BY I.Nombre, CA.InquilinoID
GO
```
| NUMERO DE FINCAS | Nombre          |
|-----------------|------------------|
|                1 | Carlos Ramírez  |
|                2 | Ana Martínez    |
|                1 | Luisa Torres    |
|                3 | Sergio Ramos    |
|                1 | Pedro Jiménez   |
|                1 | Luisa Torres    |
|                1 | Cerberus        |
|                1 | Ana López       |
|                1 | Pedro Jiménez   |

## HAVING

Podemos usar "HAVING" junto con "GROUP BY"

La siguiente query nos muestra los ID´s de los Inquilinos que poseen más de 1 Finca
```sql
USE ADMFincas
SELECT COUNT(AlquilerID) AS 'NUMERO DE FINCAS' , InquilinoID
FROM ContratosAlquiler 
GROUP BY InquilinoID
HAVING Count(AlquilerID) > 1
GO
```
### GROUP BY Ejemplo 2


Podemos observar que el email de ana@example.com se repite varias veces, con un COUNT seguido de un GROUP BY podemos sacar el número del total de inquilinos que usan ese email.

```sql
SELECT Email, COUNT(*) AS TotalInquilinos, Nombre
FROM Inquilinos
GROUP BY Email;
```
> supongamos que queremos saber cuantos inquilinos tienen el mismo correo electrónico repetido en nuestra tabla 

| Email              | TotalInquilinos |
|--------------------|-----------------|
| carlos@example.com | 1               |
| ana@example.com    | 2               |
| luisa@example.com  | 1               |
| sergio@example.com | 1               |
| pedro@example.com  | 1               |

### HAVING ejemplo 2

> Con el mismo ejemplo anterior supongamos que queremos filtrar los resultados después de aplicar el GROUP BY. De esta forma solo se muestran los campos que muestran solo los correos electrónicos que tienen más de un inquilino asociado.

```sql
SELECT Email, COUNT(*) AS TotalInquilinos
FROM Inquilinos
GROUP BY Email
HAVING COUNT(*) > 1;
```

| Email              | TotalInquilinos |
|--------------------|-----------------|
| ana@example.com    | 2               |



# Consultas sobre varias tablas

Para realizar este apartado usaré mi tabla "usuarios" donde registro los datos de los registros en la página web.

## UNION
  * Duplico la tabla usuarios
```sql
SELECT * 
    INTO UsuariosDuplicado
    FROM Usuarios
GO
```
 * Realizo cabios en la tabla duplicada.
  
  Query:
  <p>
  <a href="https://salvadorcandedo.github.io/ProyectoBD/TransactQuerys\TRANSACTSQL\Union Intersect Except\Union.sql"></a> 
</p>

* Tabla Usuarios:
  
| UsuarioID | NombreUsuario | Contrasena              | UltimaModificacion       |
|----------:|--------------|-------------------------|--------------------------|
|         1 | Pirata       | YoSoyColaTuPegaMento    | 2023-05-31 09:04:32.730  |
|         2 | Whom         | 12345A                  | 2023-05-31 13:55:32.360  |
|         3 | Paquita      | NuevaPassword           | 2023-05-31 09:12:23.570  |
|         5 | Link         | 12345678                | NULL                     |



* Tabla UsuariosDuplicado:
  
| UsuarioID | NombreUsuario | Contrasena              | UltimaModificacion       |
|----------:|--------------|-------------------------|--------------------------|
|         1 | Pirata       | YoSoyColaTuPegaMento    | 2023-05-31 09:04:32.730  |
|         2 | Uriel        | 12345A                  | 2023-05-31 13:55:32.360  |
|         3 | Paquita      | NuevaPassword           | 2023-05-31 09:12:23.570  |
|         5 | Link         | 12345678                | NULL                     |
|         6 | Manuel       | 1234                    | 2023-06-07 22:39:19.070  |


Cuando le realizo el union se nos muestran los datos de ambas tablas inclusive los duplicados en una única respuesta

```sql
SELECT * FROM Usuarios
UNION
SELECT * FROM UsuariosDuplicado
```

| UsuarioID | NombreUsuario | Contrasena              | UltimaModificacion       |
|----------:|--------------|-------------------------|--------------------------|
|         1 | Pirata       | YoSoyColaTuPegaMento    | 2023-05-31 09:04:32.730  |
|         2 | Uriel        | 12345A                  | 2023-05-31 13:55:32.360  |
|         2 | Whom         | 12345A                  | 2023-05-31 13:55:32.360  |
|         3 | Paquita      | NuevaPassword           | 2023-05-31 09:12:23.570  |
|         5 | Link         | 12345678                | NULL                     |
|         6 | Manuel       | 1234                    | 2023-06-07 22:39:19.070  |

El usuario con Id 2 al cual se le había realizado el cambio de nombre aparece con el nombre nuevo, también esta el usuario con id 6 que sólo se había añadido en la primera tabla.


## INTERSECT

 Intersect devuelve solo los campos comunes en ambas tablas

```sql
Select * FROM Usuarios
INTERSECT
SELECT * FROM UsuariosDuplicado
```

| UsuarioID | NombreUsuario | Contrasena              | UltimaModificacion       |
|----------:|--------------|-------------------------|--------------------------|
|         1 | Pirata       | YoSoyColaTuPegaMento    | 2023-05-31 09:04:32.730  |
|         3 | Paquita      | NuevaPassword           | 2023-05-31 09:12:23.570  |
|         5 | Link         | 12345678                | NULL                     |



## EXCEPT 
Except nos muestra los campos distintos entre ambas tablas

```sql
SELECT * FROM Usuarios
EXCEPT 
SELECT * FROM UsuariosDuplicado
```

| UsuarioID | NombreUsuario | Contrasena              | UltimaModificacion       |
|----------:|--------------|-------------------------|--------------------------|
|         1 | Pirata       | YoSoyColaTuPegaMento    | 2023-05-31 09:04:32.730  |



# JOIN



  ## INNER JOIN
> Supongamos que queremos  una consulta que nos muestre los nombres de los inquilinos y la fecha de inicio del contrato junto con la de la fecha de finalizacion:
>  
```sql
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
INNER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;
```


> Puedemos usar utilizar la cláusula INNER JOIN para combinar las tablas "ContratosAlquiler" e "Inquilinos" en una sola consulta. 


| NombreInquilino | ContratoID | FechaInicio | FechaFin   |
|-----------------|------------|-------------|------------|
| Carlos Ramírez  | 1          | 2023-01-01  | 2023-12-31 |
| Ana Martínez    | 2          | 2023-02-01  | 2023-07-31 |
| Luisa Torres    | 3          | 2023-03-01  | 2023-09-30 |


 "CA" es el alias de tabla para la tabla "ContratosAlquiler", 
  e "I" es el alias de tabla para la tabla "Inquilinos"



  ## LEFT JOIN

Queremos obtener una lista de todos los inquilinos junto con los contratos de alquiler correspondientes, incluso aquellos inquilinos que `no` tengan contratos de alquiler. 
  
```sql
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
LEFT  JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;
```

| NombreInquilino | ContratoID | FechaInicio | FechaFin   |
|-----------------|------------|-------------|------------|
| Carlos Ramírez  | 1          | 2023-01-01  | 2023-12-31 |
| Ana Martínez    | 2          | 2023-02-01  | 2023-07-31 |
| Luisa Torres    | 3          | 2023-03-01  | 2023-09-30 |

Usamos `LEFT OUTER JOIN` para combinar las tablas "Inquilinos" y "ContratosAlquiler" según la columna "InquilinoID". La cláusula LEFT OUTER JOIN devuelve todos los registros de la tabla izquierda (Inquilinos) y los registros coincidentes de la tabla derecha (ContratosAlquiler). Si no hay coincidencias en la tabla derecha, se mostrarán valores `NULL`

| NombreInquilino | ContratoID | FechaInicio | FechaFin   |
|-----------------|------------|-------------|------------|
| Carlos Ramírez  | 1          | 2023-01-01  | 2023-12-31 |
| Ana Martínez    | 2          | 2023-02-01  | 2023-07-31 |
| Luisa Torres    | 3          | 2023-03-01  | 2023-09-30 |
| Sergio Ramos    | NULL       | NULL        | NULL       |
| Ana López       | NULL       | NULL        | NULL       |
| Pedro Jiménez   | NULL       | NULL        | NULL       |

## RIGHT  JOIN

```sql
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
RIGHT  JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;
```

RIGHT OUTER JOIN hace lo mismo que left outer join solo que devuelve los campos de la tabla derecha (contratos de alquiler) y los registros que coincidan en la tabla de la izquierda (Inquilinos), en esete caso, InquilinoID en la tabla Contratos De alquiler solo tiene 3 filas mientras que en la de Inquilinos hay 6, en este caso no se nos devuelven valores `Null`.


# Subconsultas

 Una subquery  es una consulta dentro de una
consulta.  
la  consulta que se encuentra fuera de los parentesis "()" toma los datos del resultado de la query que está dentro de los paréntesis

> Supongamos que queremos obtener una lista de inquilinos que tienen contratos de alquiler activos

```sql
SELECT Nombre AS NombreInquilino
FROM Inquilinos
WHERE InquilinoID IN (SELECT InquilinoID FROM ContratosAlquiler WHERE FechaFin > GETDATE());

--SELECT fechafin from Inquilinos
--FechaFIn
--2023-12-31
--2023-07-31
--2023-09-30

-- Las fechas de finalizacion de contrato son  mas altas (>) que la fecha actual por lo que se muestran los tres inquilinos en la tabla 
```
La subconsulta `SELECT InquilinoID FROM ContratosAlquiler WHERE FechaFin > GETDATE()` se ejecuta primero para obtener una lista de los Inquilinos (InquilinoID).Luego, la consulta principal selecciona los nombres de los inquilinos cuyo InquilinoID está presente en el resultado de la subconsulta(fecha de finalizacion > fecha actual).

| Nombre        |
|---------------|
| Carlos Ramírez|
| Ana Martínez  |
| Luisa Torres  |

# Integridad referencial

La integridad referencial en una base de datos se compone de restricciones (constraints) que referencian los datos de una tabla y nos permite proteger la base de datos de 
algún drop innecesario.


Vamos a crear la tabla Empleados que contendrá una foreing key de la tabla Fincas ya que cada encargado tendrá asignada el ID de una finca . A su vez creamos una constraint en con nombre "FK_REFERENCIADA_FINCAID"

```sql
USE AdmFincas
SELECT * FROM Fincas

-- CREO LA TABLA ENCARGADOS CON CONSTRAINT Y CLAVE FORANEA DE LA TABLA FINCAS
CREATE TABLE Encargados (
    ID_Encargado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(30),
    FincaID INT,
   CONSTRAINT FK_REFERENCIADA_FincaID FOREIGN KEY (FincaID) REFERENCES Fincas(FincaID)
);


-- INSERTO DATOS EN LA TABLA ENCARGADOS
INSERT INTO Encargados (Nombre, FincaID)
VALUES ('Roberto Carlos', 1),
         ('Elena Pazos', 1);


SELECT * FROM Encargados

--INTENTO DE HACERLE UN DROP A LA TABLA PADRE (FINCAS)

DROP TABLE Fincas
--	Msg 3726, Level 16, State 1, Line 2
--- Could not drop object 'Fincas' because it is referenced by a FOREIGN KEY constraint.

--- Quitamos el constraint
ALTER TABLE Encargados
DROP CONSTRAINT FK_REFERENCIADA_FincaID;
GO
--	Los comandos se han completado correctamente. 
	
--	Total execution time: 00:00:00.052
## Ahora podemos hacerle un drop a fincas
DROP TABLE Fincas
```

# Truncate
Eliminará todos los datos de las tablas mencionadas, pero la estructura de las tablas se mantendrá intacta.
```sql
--- Creo la tabla Prueba
CREATE TABLE dbo.Prueba
(
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- primary key column
    Nombre [NVARCHAR](50),
    Apellido [NVARCHAR](50) 
    
);
GO
---Inserto Valores 
SELECT * FROM Prueba

INSERT INTO PRUEBA (Nombre, Apellido)
VALUES ('Salva', 'Candedo'),
       ('Andrea', 'Candedo');
---
SELECT count(*) [NUMERO DE PRUEBAS]FROM PRUEBA 
--NUMERO DE PRUEBAS 
--2
TRUNCATE TABLE Prueba
SELECT * FROM Prueba
-- Me lo muestra vacio pero la tabla sigue ahi

```

# Merge
La instrucción MERGE se utiliza para combinar operaciones de inserción, actualización y eliminación en una sola consulta.


> En este ejemplo, estamos utilizando MERGE para actualizar los precios de los Alquieres existentes y, si no existen, insertar nuevas propiedades en la tabla "actualizaciondeprecios".

```sql
---crear tabla
DROP TABLE ActualizacionPrecios
CREATE TABLE ActualizacionPrecios (
    FincaID INT,
    PrecioNuevo DECIMAL(10, 2)
);
-- Insertar
INSERT into ActualizacionPrecios(FincaID,PrecioNuevo)
VALUES (3, 1000.00)

SELECT FincaID,Monto FROM Alquileres
```
Tabla Alquileres:
```sql
SELECT top 3 FincaID,Monto FROM Alquileres
```

| FincaID | Monto    |
|---------|----------|
| 1       | 1000.00  |
| 2       | 2000.00  |
| 3       | 1200.00  |


```sql
MERGE INTO Alquileres AS target
USING ActualizacionPrecios AS source
    ON target.FincaID = source.FincaID
WHEN MATCHED THEN
    UPDATE SET target.monto = source.PrecioNuevo , target.FincaID = source.FincaID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (FincaID, Monto)
    VALUES (source.FincaID, source.Precionuevo);
```
```sql
SELECT FincaID, Monto from Alquileres
Where FincaID = 3;
```

| FincaID | Monto    |
|---------|----------|
| 3       | 1000.00  |

Este Script revisará los datos en la tabla `ActualizacionPrecios` y los compara con la tabla `Alquileres`
Cuando ejecutamos el MERGE INTO se compara las columnas de FincaID y Monto con los de FincaID y Precionuevo de la otra tabla, si son iguales entonces realiza un update de ambos campos, si no son iguales actualiza los datos de la tabla `ActualizacionPrecios` en nuesto caso (FincaID=3 Precionuevo=1000.00) en `Alquileres`




# Procedimientos de Almacenado


Un procedimiento almacenado es un objeto de la base de datos que contiene un conjunto de instrucciones SQL agrupadas bajo un nombre.

Un ejemplo de un procedimiento de almacenado básico :
```sql
USE AdmFincas
GO
CREATE OR ALTER PROCEDURE ObtenerInquilinos
AS
BEGIN
    SELECT *
    FROM Inquilinos;
END;
```
En este PROC llamado "ObtenerInquilinos realizamos un select sobre toda la tabla inquilinos . A continuación realizo varios procedimientos de almacenado para demostrar el potencial de los mismos:



## Estructura Case



>Este procedimiento nos sirve para descubir el nombre de aquellos inquilinos que no estan alquilados.
 Además se encarga de modificar la columna Alquilado en la tabla Alquileres 


```sql
CREATE OR ALTER PROCEDURE ActualizarEstadoAlquileres
AS
BEGIN
    UPDATE Alquileres
    SET Alquilado = CASE
        WHEN FechaFin >= GETDATE() THEN 'Alquilado'
        ELSE 'No alquilado'
        END;

    --- Realizamos un update de Alquileres y marcamos si esta alquilado o ya no segun la fecha acutal 


--- Muestro los nombres de los Inquilinos gracias a Inner JOINS
    SELECT I.Nombre as 'No Alquilados'
    FROM Alquileres A
    INNER JOIN ContratosAlquiler CA ON A.AlquilerID = CA.AlquilerID
    INNER JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID
    WHERE A.Alquilado = 'No alquilado';
    
    SELECT I.Nombre as 'Alquilados'
    FROM Alquileres A
    INNER JOIN ContratosAlquiler CA ON A.AlquilerID = CA.AlquilerID
    INNER JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID
    WHERE A.Alquilado = 'Alquilado';
    
  END;
```

```sql
EXEC ActualizarEstadoAlquileres
```

| Alquilados        |
|-------------------|
| Luisa Torres      |
| Sergio Ramos      |
| Sergio Ramos      |
| Pedro Jiménez     |
| Sergio Ramos      |
| Ana Martínez      |
| Luisa Torres      |
| Cerberus          |
| Ana López         |
| Pedro Jiménez     |


| No Alquilados     |
|-------------------|
| Carlos Ramírez    |
| Ana Martínez      |


--- 

## Con Variables

En el siguiente procedimiento de almacenado comprobamos que el Nombre de usuario  y la contraseña proporcionadas y almacenadas en una variable  coincidan con el de la tabla 

```sql
USE AdmFincas

CREATE OR ALTER PROCEDURE sp_loguin
    @NombreUsuario VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
   IF NOT EXISTS (SELECT * FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
    BEGIN
        PRINT 'El usuario no existe';
        RETURN;
    END

    ELSE IF NOT EXISTS (SELECT * FROM Usuarios
		WHERE NombreUsuario = @NombreUsuario
	AND Contrasena = @Password)
    BEGIN
        PRINT 'La contraseña es incorrecta';
        RETURN;
    END
	 
    PRINT 'Buenas, ' + @NombreUsuario + ' Login successful';
END
GO


-- Prueba loguin correcto

EXEC sp_loguin @NombreUsuario=Pirata, @Password=YoSoyColaTuPegamento
-- Buenas, Pirata Login successful 
	
-- Prueba Password mala
EXEC sp_loguin @NombreUsuario=Pirata, @Password=1234
-- La contraseña es incorrecta 
-- 	
-- 	Total execution time: 00:00:00.004

EXEC sp_loguin @NombreUsuario=Marina, @Password=1234
--- El usuario no existe 
	

```


```sql

EXEC CambiarContrasena @NombreUsuario='Whom',@ContrasenaAntigua='1234',@NuevaContrasena='12345'

--	Msg 50000, Level 16, State 1, Procedure CambiarContrasena, Line 28
-- La nueva contraseña debe contener al menos una letra mayúscula y un número
EXEC CambiarContrasena @NombreUsuario='Whom',@ContrasenaAntigua='123456A',@NuevaContrasena='12345'
--CambiarContrasena, Line 40
--LANGUAGE contraseña antigua no coincide.

EXEC CambiarContrasena @NombreUsuario='Whom',@ContrasenaAntigua='1234',@NuevaContrasena='12345A'

--	(1 fila afectada) 
--- 	
--- 	(1 fila afectada) 
--- 	
--- 	Contraseña cambiada correctamente. 
--- 	
--- 	Total execution time: 00:00:00.032

SELECT Contrasena From Usuarios WHERE NombreUsuario='Whom'

--|Contrasena |
--| 12345A    |
```







# Output
La instrucción OUTPUT  se utiliza para devolver los resultados de una operación de inserción(INSERT), actualización(UPDATE) o eliminación(DELETE) en una tabla. 

```sql
INSERT INTO Inquilinos_New (Nombre, Direccion, Email)
OUTPUT inserted.InquilinoID
VALUES ('Diablito Pérez', 'Calle Principal 123', 'juan@yahoo.es');
GO
```
> En este caso nos devuelve el id del Inquilino recien insertado en nuestro caso el 13

```sql
--InquilinoID
--13
```





# RollBack

>se puede utilizar la instrucción ROLLBACK para deshacer cambios realizados en la base de datos en caso de que ocurra un error o una condición no deseada. 

Vamos a crear un procedimiento de almacenado donde usamos rollback RollBack para desacer en caso de que ocurra algun error 


```sql
CREATE PROCEDURE RegistrarPago
    @ContratoID INT,
    @Monto DECIMAL(10, 2),
    @FechaPago DATE
AS

BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        
        INSERT INTO Pagos (ContratoID, Monto, FechaPago)
        VALUES (@ContratoID, @Monto, @FechaPago);

        -- Actualizar el saldo en la tabla ContratosAlquiler
        UPDATE ContratosAlquiler
        SET Saldo = Saldo - @Monto
        WHERE ContratoID = @ContratoID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        -- Registro el error en una tabla temporal #errores
        INSERT INTO #Errores (Mensaje, FechaError)
        VALUES (ERROR_MESSAGE(), GETDATE());
    END CATCH;
END;
```

# Tablas temporales 
Las tablas temporales con"#" en su nombre son útiles cuando necesitas almacenar datos temporales durante la sesion.
son visibles solo para la conexión actual y se eliminan automáticamente cuando la conexión se cierra.

```sql
-- Crear tabla temporal
CREATE TABLE #TempInquilinos (
    InquilinoID INT,
    Nombre VARCHAR(50),
    Email VARCHAR(100)
);

-- Insertar datos en la tabla temporal
INSERT INTO #TempInquilinos (InquilinoID, Nombre, Email)
VALUES (1, 'Juancho', 'juachito@example.com'),
       (2, 'Guybrush Treephood', 'Monkeyisland@example.com'),
       (3, 'Carlos Gómez', 'Carlos@example.com');


SELECT * FROM #TempInquilinos;

DROP TABLE #TempInquilinos;
```



# Trigers 

Un trigger  es un objeto de base de datos que se utiliza para responder automáticamente a eventos específicos que ocurren en una tabla, como inserciones(INSERT), actualizaciones(UPDATE) o eliminaciones (DELETE) de registros.


## Listar Triggers

```sql
-- Listar Triggers
Use AdmFincas;
SELECT * FROM Sys.triggers

--ListarBonito
SELECT name AS TriggerName, OBJECT_NAME(parent_id) AS TableName, create_date AS CreatedDate
FROM sys.triggers
```


> Vamos a crear un trigger que se dispare cada vez que realizamos un update en la tabla "usuarios"


### TR auditar cambios


 Creamos la tabla "Usuarios" con las columnas UsuarioID, NombreUsuario, Contrasena y UltimaModificacion. 

Luego, creamos un trigger llamado "Usuarios_AuditarCambios" que se activa después de realizar una operación de actualización en la tabla "Usuarios".

```sql
CREATE OR ALTER TRIGGER Usuarios_AuditarCambios
ON Usuarios
AFTER UPDATE
AS
BEGIN
    UPDATE Usuarios
    SET UltimaModificacion = GETDATE()
    FROM Usuarios
    INNER JOIN inserted ON Usuarios.UsuarioID = inserted.UsuarioID;
END;
```

Cuando se actualiza una fila en la tabla "Usuarios", el trigger se dispara y ejecuta una consulta de actualización. La columna "UltimaModificacion" en la tabla "Usuarios" se actualiza con la fecha y hora actuales (GETDATE()) 



UsuarioID | NombreUsuario | Contrasena            | UltimaModificacion
--------- | ------------- | --------------------- | ---------------------
1         | Pirata        | YoSoyColaTuPegaMento   | 2023-05-25 09:04:32.730
2         | Whom          | helloWorld             | 2023-05-25 09:04:32.730
3         | Paquita       | Paquitasalas123        | 2023-05-25 09:04:32.730

```sql
SELECT * FROM USUARIOS
UPDATE Usuarios
Set Contrasena = 'NuevaPassword'
WHERE UsuarioID= '3'
```

UsuarioID | NombreUsuario | Contrasena           | UltimaModificacion
--------- | ------------- | -------------------- | --------------------------
1         | Pirata        | YoSoyColaTuPegaMento  | 2023-05-25 09:04:32.730
2         | Whom          | helloWorld            | 2023-05-25 09:04:32.730
3         | Paquita       | NuevaPassword         | 2023-05-25 09:12:23.570



### TR_Longitud de contraseña

> Ahora vamos a crear un trigger que haga que la contrasena deba de tener al menos 8 caracteres cada vez que se realiza un insert

```sql
CREATE TRIGGER tr_ContrasenaLarga
ON usuarios
AFTER INSERT
AS
BEGIN
    
    IF EXISTS (SELECT 1 FROM inserted WHERE LEN(Contrasena) < 8)
    BEGIN
        RAISERROR ('La contraseña debe tener al menos 8 caracteres', 16, 1);
        ROLLBACK;
    END;
END;

SELECT * from usuarios
```

```sql

INSERT INTO Usuarios (NombreUsuario, Contrasena)
VALUES ('Link', '1234');

-- Msg 50000, Level 16, State 1, Procedure tr_ContrasenaLarga, Line 12
-- La contraseña debe tener al menos 8 caracteres 
-- 	
-- 	Msg 3609, Level 16, State 1, Line 1
-- The transaction ended in the trigger. The batch has been aborted.
```

>Al no cumplir con las condiciones del Trigger este realiza un rollback y muestra el error de que la contrasena almenos debe de poseer 8 caracteres .





# Vistas
 las Vistas representan una consulta almacenada como una tabla virtual. Son resultados precalculados de una consulta que se almacenan en la base de datos y se pueden utilizar como tablas normales en otras consultas. 


>Podemos crear una vista para obtener un listado de todos los contratos de alquiler activos junto con la información relevante de los inquilinos y las fincas involucradas:

Vista que nos muestra el numero de contratos que posee cada inquilino
```sql
CREATE VIEW VistaInquilinosConContratos
AS
SELECT I.InquilinoID, I.Nombre, COUNT(CA.ContratoID) AS CantidadContratos
FROM Inquilinos I
LEFT JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID
GROUP BY I.InquilinoID, I.Nombre;
```
Ahora cuando hagamos un SELECT a la Vista nos aparecera el numero de contratos que tiene cada Inquilino

| InquilinoID | Nombre          | CantidadContratos |
|-------------|-----------------|------------------ |
| 1           | Carlos Ramírez  |                 1 |
| 2           | Ana Martínez    |                 2 |
| 3           | Luisa Torres    |                 1 |
| 4           | Sergio Ramos    |                 3 |
| 5           | Ana López       |                 0 |
| 6           | Pedro Jiménez   |                 1 |
| 7           | Carlos Ramírez  |                 0 |
| 8           | Ana Martínez    |                 0 |
| 9           | Luisa Torres    |                 1 |
| 10          | Cerberus        |                 1 |
| 11          | Ana López       |                 1 |
| 12          | Pedro Jiménez   |                 1 |


Con 'Exec sp_helptext VistaInquilinosConContratos' Podemos ver el codigo de la vista una Columna "text"






