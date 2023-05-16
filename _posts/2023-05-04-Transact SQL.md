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
Ya que trabajo desde casa y mi portatil no tiene los requisitos necesarios para manejar mi maquina de Windows con mssql opte por instalar una instancia de mssql dockerizada en mi raspberry pi y conectarme a ella desde mi host windows 10 con el visual studio code.


<p align="center">
<img src="/ProyectoBD/assets/images/Transact/1.png">
</p>

## Informacion sobre la instalacion






# Apuntes Transact SQL
```sql

Use pubs
Select * from dbo.authors
Go

--
--- Timestamp	Message	
--- [8:36:45 PM]	Started executing query at Line 10
--- 	
--- 	(23 filas afectadas) 
--- 	
--- 	Total execution time: 00:00:00.080
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

# Concatenación

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
#### Error valor 
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


# Operadores and/or

```sql
Select lname,fname,job_id
From employee
Where (job_id='13')
and lname= 'Cruz'
or fname = 'Paolo';
Go
---(1 fila afectada)

```

## Campos calculados
> Es temporal no se guarda el resultado de la operación

