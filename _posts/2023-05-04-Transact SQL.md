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

- [Entorno de trabajo](#entorno-de-trabajo)
  - [Informacion sobre la instalacion](#informacion-sobre-la-instalacion)
- [Apuntes Transact SQL](#apuntes-transact-sql)
  - [Funciones del sistema](#funciones-del-sistema)
- [Concatenación](#concatenación)
  - [Where](#where)
- [Operador de igualdad](#operador-de-igualdad)
- [Operador Not](#operador-not)
- [Operadores and/or](#operadores-andor)
- [Campos calculados](#campos-calculados)
- [Predicados](#predicados)
  - [Between](#between)
  - [In](#in)
  - [Like %](#like-)
    - [Expresión "^"](#expresión-)
    - [Expresión "\_"](#expresión-_)
  - [Distinct](#distinct)
  - [Order by](#order-by)
    - [Ordenar por `campos calculados`](#ordenar-por-campos-calculados)
  - [Datepart](#datepart)
  - [OFFSET](#offset)
- [Funciones de Agregación](#funciones-de-agregación)
  - [MAX/MIN](#maxmin)
    - [Max](#max)
    - [Min](#min)
  - [Count](#count)
  - [AVG (average)](#avg-average)
  - [Sum](#sum)
  - [GROUP BY](#group-by)
  - [HAVING](#having)
- [Criterios de agrupamiento](#criterios-de-agrupamiento)
  - [GROUP BY ROLLUP](#group-by-rollup)
  - [Grouping sets ( )](#grouping-sets--)
- [UNION / INTERSECT / EXCEPT](#union--intersect--except)
  - [Union (Union de dos tablas diferentes)](#union-union-de-dos-tablas-diferentes)
  - [Intersect (campos comunes)](#intersect-campos-comunes)
  - [Except (campos no comunes)](#except-campos-no-comunes)
- [Join](#join)
  - [INNER JOIN](#inner-join)
  - [LEFT OUTER JOIN](#left-outer-join)
  - [RIGHT OUTER JOIN](#right-outer-join)
- [Operadores de relacion](#operadores-de-relacion)
  - [= (Igual que)](#-igual-que)
  - [!= (no es igual)](#-no-es-igual)
  - [\< (menor que)](#-menor-que)
  - [\>= (mayor que)](#-mayor-que)
  - [\<= (menor o igual que)](#-menor-o-igual-que)
- [Procedimientos de almacenado](#procedimientos-de-almacenado)
  - [Con Update](#con-update)
- [Con variables](#con-variables)
- [Vistas](#vistas)
- [Subqueries](#subqueries)
- [Output](#output)
- [Truncate](#truncate)
- [Merge](#merge)
  - [MERGE INTO](#merge-into)
- [Bloques de instruciones](#bloques-de-instruciones)
  - [BEGIN \& END](#begin--end)
  - [BEGIN TRANSACTION](#begin-transaction)
  - [BEGIN TRY](#begin-try)
  - [BEGIN CATH](#begin-cath)
- [RollBack](#rollback)
- [Tablas temporales](#tablas-temporales)
- [Ejemplos procedimientos almacenados](#ejemplos-procedimientos-almacenados)
- [Triggers](#triggers)
- [AFTER INSERT CON ROLLBACK](#after-insert-con-rollback)
- [Campo contrasena segura](#campo-contrasena-segura)



# Entorno de trabajo
Ya que trabajo desde casa y mi portátil no tiene los requisitos necesarios para manejar mi máquina de Windows con MS SQL, opté por instalar una instancia de MS SQL dockerizada en mi Raspberry Pi y conectarme a ella desde mi host Windows 10 desde Visual Studio Code.

<p align="center">
<img src="/ProyectoBD/assets/images/Transact/1.png">
</p>

##  Informacion sobre la instalacion






#  Apuntes Transact SQL
```sql

Use pubs
Select * from dbo.authors
Go
--- 	(23 filas afectadas) 

```


## Funciones del sistema

Sacar el nombre de la base de datos
```sql
select db_name()
Go
```
Nombre Inicio de sesion original 
```sql
Print original_login()
```

----------------------------------

#  Concatenación

---
> Vamos a concatenar dos columnas de la tabla employess y que nos los separe con una coma :

```sql
Select fname + ' , ' +lname as [Nombre Completo]
From employee
Go 
```

<p align="center">
<img src="/ProyectoBD/assets/images/Transact/2.png">
</p>


## Where
```sql
Select lname,fname
From employee
Where minit is null
Go
-- 	(0 filas afectadas)
```

# Operador de igualdad 
```sql
--  Ver el nombre de usuario "Cruz"

Select lname,fname
From employee
Where lname= 'Cruz';
Go

---(1 fila afectada) 
-- 

 -- podemos hacer el contrario del comando,con la expresion -- "!="


Select lname,fname
From employee
Where lname != 'Cruz';
Go
--- (42 filas afectadas)
```

# Operador Not

```sql
Select lname,fname
From employee
Where not lname= 'Cruz';
Go

---42 filas afectadas) 
---Total execution time: 00:00:00.022
```


#  Operadores and/or

```sql
Select lname,fname,job_id
From employee
Where (job_id='13')
and lname= 'Cruz'
or fname = 'Paolo';
Go
---(1 fila afectada)

```

# Campos calculados
> Es temporal,no se guarda el resultado de la operación

```sql
Use AdmFincas
Select Monto From Gastos
```

| Monto   |
|---------|
| 200.00  |
| 300.00  |
| 400.00  |
| 150.00  |
| 500.00  |
| 300.00  |

```sql
Select GastoID,Descripcion,Monto + 50 
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

# Predicados
  * Añadir shorcuts!!!!!!!

## Between
> Vamos a sacar el Id del inquilino y el id del contrato de los contratos que se realizaron entre el primer mes del año y el cuarto.

```sql
SELECT * FROM ContratosAlquiler
Select InquilinoID,ContratoID,FechaInicio
FROM ContratosAlquiler
WHERE FechaInicio BETWEEN '2023-01-1' and '2023-04-01'
---	(3 filas afectadas) 
```

| InquilinoID | ContratoID | FechaInicio |
|-------------|------------|-------------|
| 1           | 1          | 2023-01-01  |
| 2           | 2          | 2023-02-01  |
| 3           | 3          | 2023-03-01  |

---

## In

>Ejemplo donde filtramos por dos calles de interés con el predicado  `in` 

```sql
Select Direccion 
From Fincas
Where Direccion in ('Avenida Central 456','Calle Principal 123')
Go
-- 	(2 filas afectadas)
```

| CallesDeInteres |
|------------------|
| Calle Principal 123 |
| Avenida Central 456 |


## Like %
>Sacamos todos Emails que contengan "example.com" puede sernos útil para filtrar por empresas de correo electróniuco cómo "yahoo.es" o "gmail.com"

```sql
select Nombre,Email
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
OR Email LIKE '%@yahoo.es';
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
Select Nombre,Telefono
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

### Expresión "^"

Podemos indicar el contrario de la siguiente forma

```sql
Select Nombre,Telefono
FROM Inquilinos
WHERE telefono LIKE '555-[^1-4]%'
GO
---(8 filas afectadas)
```

### Expresión "_"

Podemos usar el guion bajo para indicar que no sabemos el caracter que ocupa en ese segmento

```sql
select Nombre,Telefono 
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

## Distinct

Se utiliza para evitar títulos duplicados
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
Select distinct nombre
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


## Order by
> Ordenamos De manera Ascendente(alfabéticamente) las direcciones de todos los Inquilinos 

```sql
Select*
From Inquilinos
Order by Direccion
Go
---(12 filas afectadas)
```


| InquilinoID | Nombre         | Direccion            | Email              | Telefono  |
|-------------|----------------|----------------------|--------------------|-----------|
| 5           | Ana López      | Avenida del Sol 654  | ana@example.com    | 555-5555  |
| 11          | Ana López      | Avenida del Sol 654  | ana@yahoo.es       | 555-5555  |
| 1           | Carlos Ramírez | Avenida Libertad 789 | carlos@example.com | 555-1234  |
| 7           | Carlos Ramírez | Avenida Libertad 789 | carlos@yahoo.es    | 555-1234  |
| 4           | Sergio Ramos   | Calle Mayor 987      | sergio@example.com | 555-4444  |
| 10          | Sergio Ramos   | Calle Mayor 987      | sergio@gmail.com   | 555-4444  |
| 8           | Ana Martínez   | Calle Sol 456        | ana@gmail.com      | 555-5678  |
| 2           | Ana Martínez   | Calle Sol 456        | ana@example.com    | 555-5678  |
| 3           | Luisa Torres   | Paseo Marítimo 123   | luisa@example.com  | 555-9012  |
| 9           | Luisa Torres   | Paseo Marítimo 123   | luisa@yahoo.es     | 555-9012  |
| 6           | Pedro Jiménez  | Paseo Marítimo 321   | pedro@example.com  | 555-6666  |
| 12          | Pedro Jiménez  | Paseo Marítimo 321   | pedro@gmail.com    | 555-6666  |

Podemos ordenarlos de manera descencente

```sql
Select*
From Inquilinos
Order by Direccion desc
Go
---(12 filas afectadas)
```

###  Ordenar por `campos calculados`
```sql
Select GastoID,Descripcion,Monto from Gastos
```

| GastoID | Descripcion               | Monto   |
|---------|---------------------------|---------|
| 1       | Mantenimiento de jardín   | 200.00  |
| 2       | Reparación de fontanería  | 300.00  |
| 3       | Pintura de fachada        | 400.00  |
| 4       | Limpieza común            | 150.00  |
| 5       | Reparación de ascensor    | 500.00  |
| 6       | Mantenimiento de piscina  | 300.00  |

> Pongamos que necesitamos sumarle 100 euros a todos los montos de la tabla gastos y ordenarlos de forma ascendente:

```sql
Select GastoID,Descripcion,Monto + 100 as PrecioFinal
From Gastos
Order by  PrecioFinal
Go
```

| GastoID | Descripcion              | PrecioFinal |
|---------|--------------------------|-------------|
| 4       | Limpieza común           | 250.00      |
| 1       | Mantenimiento de jardín  | 300.00      |
| 2       | Reparación de fontanería | 400.00      |
| 6       | Mantenimiento de piscina | 400.00      |
| 3       | Pintura de fachada       | 500.00      |
| 5       | Reparación de ascensor   | 600.00      |


## Datepart 
Podemos Dividir las fechas con datepart y hacer que nos las muestre con columnas personalizadas

```sql
Select FincaID,FechaFin,
Datepart(year,FechaFin) as 'Año Final',
Datepart(month,FechaFin) as 'Mes Final',
Datepart(day,FechaFin) as 'Dia Final'
From Alquileres

Order By Datepart(year,FechaFin), Datepart(month,FechaFin), Datepart(day,FechaFin) desc
Go
---	(3 filas afectadas)
```

| FincaID | FechaFin   | Año Final | Mes Final | Dia Final |
|---------|------------|-----------|-----------|-----------|
| 2       | 2023-07-31 | 2023      | 7         | 31        |
| 3       | 2023-09-30 | 2023      | 9         | 30        |
| 1       | 2023-12-31 | 2023      | 12        | 31        |


Podemos crear un procedimiento de almacenado para ejecutarlo cuando nos haga falta

```sql
Create or alter procedure fecha_FIN
As 
    Select FechaFin,
        Datepart(year,FechaFin) as 'Año Final',
        Datepart(month,FechaFin) as 'Mes Final',
        Datepart(day,FechaFin) as 'Dia Final'
    From Alquileres
    Order By Datepart(year,FechaFin), Datepart(month,FechaFin), Datepart(day,FechaFin) desc
Go
---Total execution time: 00:00:00.020
```

```sql
Execute fecha_FIN
---	(3 filas afectadas)
```

## OFFSET 

Con offset podemos saltarnos filas 
```sql
Select InquilinoID from Inquilinos
order by InquilinoID
Offset 1 Rows fetch next 5 rows only
Go
```
> Nos muestra la columna a partir del ID 2 y nos printea las 5 siguientes



# Funciones de Agregación

## MAX/MIN

### Max

Filtramos por la fila que contenga el número más alto en la columna monto
```sql
select Max(monto) as COSTEMAXIMO
from Gastos
```

| COSTEMAXIMO |
|-------------|
|   500.00    |

Podemos sacarlo junto con otra columna con un where

```sql
SELECT Descripcion, Monto AS COSTEMAXIMO 
FROM Gastos
WHERE Monto = (SELECT MAX(Monto) FROM Gastos) 
```

| Descripcion             | COSTEMAXIMO |
|-------------------------|-------------|
| Reparación de ascensor | 500.00      |

### Min

Filtramos por la fila que contanga el menor valor en la columna de Monto.
```sql
SELECT Descripcion, Monto AS COSTEMINIMO
FROM Gastos
WHERE Monto = (SELECT MIN(Monto) FROM Gastos) 
```

| Descripcion   | COSTEMINIMO |
|---------------|-------------|
| Limpieza común | 150.00      |

## Count

> Supongamos que nos interesa saber el número de Inquilinos que hay actualmente instalados, con Count(*) contamos todas las filas de esa columna.

```sql
Select Count(InquilinoID) as [Numero de Inquilinos]
From Inquilinos 
Go
---Total execution time: 00:00:00.114
```

## AVG (average)

AVG lo usamos para sacar medias 
> Imaginemos que queremos sacar la media de nuestros gastos de nuestra base de datos, con la siguiente query seleccionamos todos los gastos y realiza una media

```sql
SELECT Monto FROM Gastos
SELECT AVG(Monto) AS MediaGastos FROM Gastos;
--- (6 filas afectadas) 
--- 	
--- 	(1 fila afectada)
```

| MediaGastos |
|-------------|
| 308.333333  |


| Monto     |
| --------- |
| 200.00    |
| 300.00    |
| 400.00    |
| 150.00    |
| 500.00    |
| 300.00    |
| 290.00    |

## Sum

> Sum se utiliza para sumar los datos de una columna, por ejemplo, vamos a sumar el monto para obtener los gastos totales 

```sql
SELECT SUM(Monto) AS TotalGastos
FROM Gastos;
---(1 fila afectada)
```


## GROUP BY


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

## HAVING

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

# Criterios de agrupamiento 

## GROUP BY ROLLUP

con GROUP BY WITH ROLLUP podemos obtener un resumen completo de los datos agrupados, mostrando tanto los resultados específicos de cada grupo como los totales parciales y el total general.

```sql
SELECT Monto,SUM(Monto) as sumamonto 
FROM Pagos
group by ROLLUP (Monto) 
```

Por ejemplo, podemos sacar la suma total del monto 


| Monto   | sumamonto |
|---------|-----------|
| 800.00  | 800.00    |
| 1000.00 | 1000.00   |
| 1200.00 | 1200.00   |
| NULL    | 3000.00   |

> El valor null contiene la suma de toda la columna monto 

Podemos filtrar solo por esa fila del resultado con HAVING:

```sql
SELECT Monto, SUM(Monto) AS sumamonto
FROM Gastos
GROUP BY ROLLUP(Monto)
HAVING Monto IS NULL; 
```
## Grouping sets ( )


Select codigoprecio,sum(codigoprecio) as sumaprecio
from precio
group by GROUPING SETS (CodigoPrecio,())
Go



# UNION / INTERSECT / EXCEPT 

## Union (Union de dos tablas diferentes)

```sql

SELECT InquilinoID as ID, Nombre FROM Inquilinos
UNION
SELECT ClienteID, Nombre From Clientes

```

| ID | Nombre          |
|----|-----------------|
| 1  | Carlos Ramírez  |
| 1  | Laura Rodríguez |
| 2  | Ana Martínez    |
| 2  | Roberto Sánchez |
| 3  | Luisa Torres    |
| 3  | María González  |
| 4  | Sergio Ramos    |
| 5  | Ana López       |
| 6  | Pedro Jiménez   |

> Unimos el valor del las columnas seleccionadas de la la tabla segunda en la tabla primera. En este caso unimos los IDs de los clientes junto a los nombres de la tabla Clientes en las dos columnas de la tabla Inquilinos.

## Intersect (campos comunes)

La operación INTERSECT se utiliza para combinar los resultados de dos consultas y obtener solo las filas que sean comunes a ambas consultas. Es decir, devuelve los registros que se encuentran en ambas consultas.


```sql
SELECT Nombre as nombreClientes
	FROM Clientes
```

| Nombre           |
|------------------|
| Laura Rodríguez  |
| Roberto Sánchez  |
| María González   |

```sql
SELECT Nombre as NombreInquilinos
	FROM Inquilinos
```


| NombreInquilinos |
|------------------|
| Carlos Ramírez   |
| Ana Martínez     |
| Luisa Torres     |
| Sergio Ramos     |
| Ana López        |
| Pedro Jiménez    |

 que Nombres no están en la tabla Inquilinos

```sql
SELECT Nombre AS 'NombreNoestan'
	FROM Clientes
EXCEPT
SELECT Nombre
	FROM Inquilinos;
```

| NombreNoestan    |
|------------------|
| Laura Rodríguez  |
| Roberto Sánchez  |
| María González   |

## Except (campos no comunes)
> Queremos saber que Inquilinos no tienen Contrato
```sql
SELECT InquilinoID  as [InquilinosSinContrato] FROM Inquilinos 
    EXCEPT
Select InquilinoID  FROM ContratosAlquiler 
--- InquilinosSinContrato
--- 5
--- 7
--- 8
```
Podemos sacar el nombre del inquilino al lado con una subquery:
```sql
SELECT I.InquilinoID, I.Nombre as [InquilinosSinContrato]
FROM Inquilinos I
WHERE I.InquilinoID IN (
    SELECT InquilinoID
    FROM Inquilinos
    EXCEPT
    SELECT InquilinoID
    FROM ContratosAlquiler
);
```

| InquilinoID | InquilinosSinContrato |
|-------------|-----------------------|
| 5           | Ana López             |
| 7           | Carlos Ramírez        |
| 8           | Ana Martínez          |






# Join
  ## INNER JOIN
> Supongamos que queremos  una consulta que nos muestre los nombres de los inquilinos y la fecha de inicio del contrato junto con la de la fecha de finalizacion: 
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



  ## LEFT OUTER JOIN

Queremos obtener una lista de todos los inquilinos junto con los contratos de alquiler correspondientes, incluso aquellos inquilinos que `no` tengan contratos de alquiler. 
  
```sql
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
LEFT OUTER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;
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

## RIGHT OUTER JOIN

```sql
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
RIGHT OUTER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;
```

RIGHT OUTER JOIN hace lo mismo que left outer join solo que devuelve los campos de la tabla derech (contratos de alquiler) y los registros que coincidan en la tabla de la izquierda (Inquilinos), en esete caso, InquilinoID en la tabla Contratos De alquiler solo tiene 3 filas mientras que en la de Inquilinos hay 6, en este caso no se nos devuelven valores `Null`.

# Operadores de relacion 



## = (Igual que) 




```sql
SELECT F.Nombre AS NombrePropiedad
FROM Fincas F, ContratosAlquiler CA
WHERE F.FincaID = CA.ContratoID
AND CA.FechaInicio > '2023-02-01';
```



## != (no es igual)


## < (menor que)



## >= (mayor que)


## <= (menor o igual que)






# Procedimientos de almacenado 

Un procedimiento almacenado en SQL Server es un objeto de la base de datos que contiene un conjunto de instrucciones SQL agrupadas bajo un nombre.

```sql
CREATE PROCEDURE ObtenerInquilinos
AS
BEGIN
    SELECT *
    FROM Inquilinos;
END;

EXEC ObtenerInquilinos
```
## Con Update

>Este procedimiento nos sirve para descubir el nombre de aquellos inquilinos que no estan alquilados. Ademas se encarga de modificar la columna Alquilado en la tabla Alquileres 


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

---

| No Alquilados     |
|-------------------|
| Carlos Ramírez    |
| Ana Martínez      |



# Con variables 

En el siguiente procedimiento de almacenado comprobamos que el Nombre de usuario  y la contrasena proporcionadas coincidan con el de la tabla 

```sql
CREATE OR ALTER PROCEDURE sp_loguin
    @NombreUsuario VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
   
	IF NOT EXISTS (SELECT * FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
    BEGIN
        PRINT 'Error: El usuario no existe';
        RETURN;
    END

    ELSE IF NOT EXISTS (SELECT * FROM Usuarios
							WHERE NombreUsuario = @NombreUsuario
								AND Contrasena = @Password)
    BEGIN
        PRINT 'La contraseña es incorrecta';
        RETURN;
    END
	 
   --- Aqui tengo que convertir el ID en un VARCHAR ya que me da error al displayear el int en una string
	DECLARE @ID_DELUsuario INT;

    SELECT @ID_DELUsuario = UsuarioID
    FROM Usuarios
    WHERE Nombreusuario = @NombreUsuario;

    PRINT 'Buenas, Tu ID es: ' + CAST(@ID_DELUsuario AS VARCHAR(3));

end
GO
```
Prueba
```sql
Exec sp_Loguin @NombreUsuario ='Pirata' , @password='YoSoyColaTuPegamento'
Go
-- Buenas, Tu ID es: 1 
```
Otro ejemplo pero proporcionando las ID 
```sql
CREATE OR ALTER PROCEDURE sp_loguin
    @Codigousuario INT,
    @Password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
   
	IF NOT EXISTS (SELECT * FROM Usuarios WHERE UsuarioID = @codigousuario)
    BEGIN
        PRINT 'Error: El usuario no existe';
        RETURN;
    END

    ELSE IF NOT EXISTS (SELECT * FROM Usuarios
							WHERE UsuarioId = @Codigousuario
								AND Contrasena = @Password)
    BEGIN
        PRINT 'La contraseña es incorrecta';
        RETURN;
    END
	 
	DECLARE @nombreUsuario VARCHAR(100);

    SELECT @nombreUsuario = NombreUsuario
    FROM Usuarios
    WHERE UsuarioID = @codigousuario;

    PRINT 'Buenas, Tu nombre de usuario es: ' + @nombreUsuario;

end
GO

--- PRUEBAS


Exec sp_Loguin @codigousuario ='1' , @password='YoSoyColaTuPegamento'
Go
-- Buenas, Tu nombre de usuario es: Pirata 
	

Exec sp_Loguin @codigousuario='2' , @password ='12345'
Go
--La contraseña es incorrecta

Exec sp_Loguin @codigousuario='55' , @password ='Who?'
Go
--Error: El usuario no existe

```



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
Ahora cuando hagamos un select a la Vista nos aparecera el numero de contratos que tiene cada Inquilino

| InquilinoID | Nombre          | CantidadContratos |
|-------------|-----------------|------------------:|
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






# Subqueries
 Una subquery o subconsulta anidada, es una consulta SQL que se encuentra dentro de otra consulta principal
 se usa para  aportar valores o resultados que se utilizan en la consulta principal.

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
Drop TABLE Prueba
SELECT * FROM Prueba
--Msg 208, Level 16, State 1, Line 1
--Invalid object name 'Prueba'.
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
Select top 3 FincaID,Monto FROM Alquileres
```

| FincaID | Monto    |
|---------|----------|
| 1       | 1000.00  |
| 2       | 2000.00  |
| 3       | 1200.00  |


## MERGE INTO

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
Select FincaID, Monto from Alquileres
Where FincaID = 3;
```

| FincaID | Monto    |
|---------|----------|
| 3       | 1000.00  |

Este Script revisara los datos en la tabla `ActualizacionPrecios` y los compara con la tabla `Alquileres`
Cuando ejecutamos el MERGE INTO se compara las columnas de FincaID y Monto con los de FincaID y Precionuevo de la otra tabla, si son iguales entonces realiza un update de ambos campos, si no son iguales actualiza los datos de la tabla `ActualizacionPrecios` en nuesto caso (FincaID=3 Precionuevo=1000.00) en `Alquileres`



# Bloques de instruciones 

  ## BEGIN & END
Permiten agrupar varias instrucciones SQL juntas y ejecutarlas como una unidad lógica. 

```sql
BEGIN
    UPDATE Inquilinos
    SET Direccion = 'Calle Nueva 123',
        Email = 'NuevoCorreo@gmail.com'
    WHERE InquilinoID = 1;

    UPDATE ContratosAlquiler
    SET Monto = 1200.00
    WHERE InquilinoID = 1;
END;
```
>Además de BEGIN y END, existen otras palabras clave para controlar la transacción y manejar excepciones en bloques de código. 
  ## BEGIN TRANSACTION
  + Indica el inicio de una transacción. Una transacción es una unidad lógica de trabajo que consiste en una serie de operaciones de base de datos que deben ser tratadas como una entidad única. 

  ## BEGIN TRY
  + Indica el inicio de un bloque TRY-CATCH,. Se utiliza para encapsular el código que puede generar excepciones y proporciona una estructura en caso de que se produzca un error.
  ## BEGIN CATH
  + Se utiliza para capturar y manejar las excepciones que se producen dentro del bloque TRY. 
  (aquí se puede definir el código que se ejecutará en caso de que se produzca una excepción)
 
  ```sql
BEGIN TRANSACTION;
  BEGIN TRY
    -- Actualizar el nombre de un propietario de una finca
    UPDATE Fincas
    SET Propietario = 'Ana Perez'
    WHERE FincaID = 1;

    -- Insertar un nuevo contrato de alquiler
    INSERT INTO ContratosAlquiler (AlquilerID,FechaInicio, FechaFin)
    VALUES (4, '2023-06-01', '2023-12-31');

    -- Confirmar la transacción
    COMMIT;
  END TRY

  BEGIN CATCH
    -- Deshacer la transacción en caso de error
    ROLLBACK;

    
    PRINT 'Se produjo un error. Se ha realizado un rollback.';

  
  END CATCH;


---	Started executing query at Line 849
--- 	
--- 	(1 fila afectada) 
--- 	
--- 	(0 filas afectadas) 
--- 	
--- 	Se produjo un error. Se ha realizado un rollback. 
--- 	
--- 	Msg 515, Level 16, State 2, Line 10
--- Cannot insert the value NULL into column 'ContratoID', table 'AdmFincas.dbo.ContratosAlquiler'; column does not allow nulls. INSERT fails. 
--- 	
--- 	Total execution time: 00:00:00.008
```
> En este script observamos como se intenta aplicar cambios en la tabla Fincas y en la tabla ContratosAlquiler.

En caso de producirse un error en la query se ejecuta un `rollback` y se deshacen los cambios realizados en ambas tablas, ya que no pudo realizarse el cambio en `ContratosAlquiler` por la clave `ContratoID` tampoco se guardan los cambios en la tabla `Fincas` Por lo que el propietario de la Finca con ID 1 no se cambia .

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
        -- Insertar el pago en la tabla Pagos
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
        -- Registramos el error en una tabla temporal *errores
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



# Ejemplos procedimientos almacenados



```sql
EXEC ObtenerInformeInquilinosAlquiler
CREATE OR ALTER PROCEDURE ObtenerInformeInquilinosAlquiler
AS
BEGIN
    
DECLARE @NombreInquilino NVARCHAR(50);
    DECLARE @DireccionInquilino NVARCHAR(100);
    DECLARE @FechaInicioContrato DATE;
    DECLARE @FechaFinContrato DATE;

    -- Tabla temporal 
    CREATE TABLE #InformeInquilinosAlquiler (
        NombreInquilino NVARCHAR(50),
        DireccionInquilino NVARCHAR(100),
        FechaInicioContrato DATE,
        FechaFinContrato DATE
    );

    -- Consigo los Inquilinos con Contratos de alquiler activos 
    INSERT INTO #InformeInquilinosAlquiler
    SELECT I.Nombre, I.Direccion, CA.FechaInicio, CA.FechaFin
    FROM Inquilinos I
    INNER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID
    WHERE CA.FechaInicio <= GETDATE() AND CA.FechaFin >= GETDATE();

        -- Print las variables convierto a varchar las fechas
        PRINT 'Información del inquilino:';
        PRINT 'Nombre: ' + @NombreInquilino;
        PRINT 'Dirección: ' + @DireccionInquilino;
        PRINT 'Fecha de inicio del contrato: ' + CONVERT(NVARCHAR, @FechaInicioContrato, 103);
        PRINT 'Fecha de fin del contrato: ' + CONVERT(NVARCHAR, @FechaFinContrato, 103);
        PRINT '--------------------------------------';

        SET @FilasContador += 1;
    END;
```


# Triggers


```sql
-- Listar Triggers
Use AdmFincas;
SELECT * FROM Sys.triggers

--ListarBonito
SELECT name AS TriggerName, OBJECT_NAME(parent_id) AS TableName, create_date AS CreatedDate
FROM sys.triggers
```
Un trigger es un objeto de base de datos que se activa automáticamente en respuesta a un evento específico, como una operación de inserción, actualización o eliminación en una tabla.

```sql

CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsuario VARCHAR(50),
    Contrasena VARCHAR(50),
    UltimaModificacion DATETIME
);
-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (NombreUsuario, Contrasena, UltimaModificacion)
VALUES ('usuario1', 'contrasena1', GETDATE()),
       ('usuario2', 'contrasena2', GETDATE()),
       ('usuario3', 'contrasena3', GETDATE());



CREATE TRIGGER Usuarios_AuditarCambios
ON Usuarios
AFTER UPDATE
AS
BEGIN
    UPDATE Usuarios
    SET UltimaModificacion = GETDATE()
    FROM Usuarios
    INNER JOIN inserted ON Usuarios.UsuarioID = inserted.UsuarioID;
END;

 ## AFTER UPDATE 
```
 Creamos la tabla "Usuarios" con las columnas UsuarioID, NombreUsuario, Contrasena y UltimaModificacion. 

Luego, creamos un trigger llamado "Usuarios_AuditarCambios" que se activa después de realizar una operación de actualización en la tabla "Usuarios".

```sql
CREATE TRIGGER Usuarios_AuditarCambios
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

Proof:

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



# AFTER INSERT CON ROLLBACK

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

```sql
INSERT INTO Usuarios (NombreUsuario, Contrasena)
VALUES ('Link', '12345678');
--	Started executing query at Line 1054
	--	Total execution time: 00:00:00.066
```

# Campo contrasena segura