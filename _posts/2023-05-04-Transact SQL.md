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
----- CONCATENACION
SELECT * FROM employee
-- STRING VACIO
Select job_id + ' , ' +job_lvl as [Info del job]
From employee
Go
```
####  Error valor 
```sql
--- Msg 245, Level 16, State 1, Line 1
--- Conversion failed when converting the varchar value ' , ' to data type smallint.
```
El error se da por estás intentando concatenar una cadena de texto (' , ')  con una columna de tipo smallint (job_lvl).


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
>Ejemplo donde filtramos por dos calles de interés con el predicado `in` 
```sql
Select Direccion AS CallesDeInteres
From Fincas
Where Direccion in ('Avenida Central 456','Calle Principal 123')
Go
-- 	(2 filas afectadas)
```

| CallesDeInteres            |        |
|------------------|-----------------|
| Calle Principal 123   |             |
| Avenida Central 456  |             |
---

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

Tabla: Inquilinos

| InquilinoID | Nombre          | Direccion           | Email                | Telefono   |
|-------------|-----------------|---------------------|----------------------|------------|
| 1           | Carlos Ramírez  | Avenida Libertad 789| carlos@example.com   | 555-1234   |
| 2           | Ana Martínez    | Calle Sol 456       | ana@example.com      | 555-5678   |
| 3           | Luisa Torres    | Paseo Marítimo 123  | luisa@example.com    | 555-9012   |
| 4           | Sergio Ramos    | Calle Mayor 987     | sergio@example.com   | 555-4444   |
| 5           | Ana López       | Avenida del Sol 654 | ana@example.com      | 555-5555   |
| 6           | Pedro Jiménez   | Paseo Marítimo 321  | pedro@example.com    | 555-6666   |

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

# Union

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

## Intersect 

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




SELECT F.Nombre AS NombrePropiedad
FROM Fincas F, ContratosAlquiler CA
WHERE F.FincaID = CA.ContratoID




AND CA.FechaInicio > '2023-02-01';



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
--->Se puede hace la llamada ObtenerInquilinos para ejecutar el procedimiento de almacenado
EXEC ObtenerInquilinos
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

# RollBack

>se puede utilizar la instrucción ROLLBACK para deshacer cambios realizados en la base de datos en caso de que ocurra un error o una condición no deseada. 

Vamos a crear un procedimiento de almacenado donde usemos RollBack para desacer en caso de que ocurra algun error 

C```sql
REATE PROCEDURE RegistrarPago
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
        -- Registrar el error en una tabla de registro de errores
        INSERT INTO Errores (Mensaje, FechaError)
        VALUES (ERROR_MESSAGE(), GETDATE());
    END CATCH;
END;
```
