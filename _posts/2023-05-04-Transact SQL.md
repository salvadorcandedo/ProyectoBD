---
layout: single
title: Instalar Instancia de SSMS (MICROSOFT SQL) En docker y conectarnos por visual Studio
excerpt: "Modelo Lógico Conceptual."
date: 2023-01-15
classes: wide
header:
  teaser: 
  teaser_home_page: true
  icon: 
categories:
  - Datamodeler
  - ssms
  - sql server
tags:
  - 
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

# 7. Predicados
  * Añadir shorcuts!!!!!!!

## 7.1. Between
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

###  ordenar por `campos calculados`
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

Pongamos que necesitamos sumarle 100 euros a todos los montos de la tabla gastos y ordenarlos de forma ascendente:
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
Nos muestra la columna a partir del ID 2 y nos printea las 5 siguientes



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