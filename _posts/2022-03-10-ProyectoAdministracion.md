---
layout: single
title: Administracion
excerpt: "Proyecto Administración Base de Datos "
date: 2023-04-10
classes: wide
header:
  teaser: /assets/images/htb-writeup-magic/magic_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.webp
categories:
  - SQL
  - ssms
  - sql server
  - 
tags:
  - 
  - 
  - 
  - 
  - 
  - 
  - 
---


# Proyecto Administracion base de Datos desde 0 


- [Proyecto Administracion base de Datos desde 0](#proyecto-administracion-base-de-datos-desde-0)
- [Creacion de la base de datos](#creacion-de-la-base-de-datos)
  - [sp\_help](#sp_help)
- [Tipos de archivos](#tipos-de-archivos)
- [Modificar base de datos](#modificar-base-de-datos)
  - [Modificar el tamaño](#modificar-el-tamaño)
  - [Añadir FileGroups](#añadir-filegroups)
  - [Creación de tablas](#creación-de-tablas)
    - [Indicar Clave Primaria](#indicar-clave-primaria)
    - [anadir datos a una tabla](#anadir-datos-a-una-tabla)
    - [Modificar tabla con ALTER](#modificar-tabla-con-alter)
- [Seguridad y protección SSMS](#seguridad-y-protección-ssms)
  - [Usuarios](#usuarios)
    - [Cambiar la contraseña de un inicio de sesión:](#cambiar-la-contraseña-de-un-inicio-de-sesión)
  - [Crear un usuario de base de datos](#crear-un-usuario-de-base-de-datos)
    - [Crear un usuario de base de datos sin Inicio de Sesión](#crear-un-usuario-de-base-de-datos-sin-inicio-de-sesión)
  - [Eliminar usuario del rol](#eliminar-usuario-del-rol)
- [Permisos](#permisos)
    - [GRANT:](#grant)
    - [REVOKE:](#revoke)
    - [DENY:](#deny)
    - [Ejemplos](#ejemplos)
- [Permisos sobre objetos](#permisos-sobre-objetos)
  - [Permiso SELECT:](#permiso-select)
    - [Ejemplo:](#ejemplo)
    - [Ejemplo:](#ejemplo-1)
  - [Permiso CREATE:](#permiso-create)
- [Schema](#schema)
- [Politica de Recuperación de Desastres](#politica-de-recuperación-de-desastres)
  - [Snapshot](#snapshot)
  - [Backup / Restore](#backup--restore)
    - [Completo](#completo)
    - [Diferencial](#diferencial)
    - [Log](#log)
  - [Restaurar una base de datos a partir de una copia de seguridad](#restaurar-una-base-de-datos-a-partir-de-una-copia-de-seguridad)
    - [Coppy\_only](#coppy_only)
    - [Tail Backup](#tail-backup)








  

# Creacion de la base de datos


Creación de la base de datos AdmFincas:
Creo la Base de Datos IRL_eGarante sin especificar archivos mediante una sentencia tal que :
```sql
USE master;
GO
CREATE DATABASE AdmFincas
GO

```
> MySQL ha devuelto un conjunto de valores vacío 
(es decir: cero columnas). (La consulta tardó 0.1454 segundos.) 

## sp_help
Consultar información sobre mi base de datos usando un procedimiento almacenado.







```sql
sp_helpdb AdmFincas
Go
```
OR
```sql
SELECT * FROM sys.database_files
GO
```



# Tipos de archivos   

* Los archivos con extensión `.ndf `son archivos de datos secundarios opcionales. Pueden ser utilizados para almacenar datos en tablas o índices específicos, y permiten una mejor distribución de los datos en varios discos físicos  
  
El archivo con extensión ` .ldf` es el archivo de registro de transacciones.
 * Este archivo contiene información sobre todas las operaciones que se han realizado en la base de datos, como inserciones, actualizaciones y eliminaciones. El archivo de registro de transacciones es importante para garantizar la integridad de los datos en caso de que se Notasuzca una falla en el sistema.
  
* El archivo cn extensión `.mdf` es el archivo de datos principal de la base de datos. Contiene todos los datos y objetos de la base de datos, como tablas, índices, procedimientos almacenados, funciones, etc

```sql
Use master
Go
CREATE DATABASE Prueba
ON 
( NAME = Rent_dat,
    FILENAME = 'C:\ProyectoBD\rent.ndf',
    SIZE = 10, 
    MAXSIZE = 50,
    FILEGROWTH = 5 )
LOG ON

( NAME = Rent_log,
    FILENAME = 'C:\ProyectoBD\rentlog.ldf',
    SIZE = 5MB,
    MAXSIZE = 25MB,
    FILEGROWTH = 5MB ) ;
GO
```

```sql
Go
CREATE DATABASE Prueba2
ON
PRIMARY  
    (NAME = Fincas1,
    FILENAME = 'C:\ProyectoBD\rentdat1.mdf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Fincas2,
    FILENAME = 'C:\ProyectoBD\rentdat2.ndf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Fincas3,
    FILENAME = 'C:\ProyectoBD\rentdat3.ndf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)
LOG ON 
   (NAME = Fincaslog1,
    FILENAME = 'C:\ProyectoBD\rentlog1.ldf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
   (NAME = Fincaslog2,
    FILENAME = 'C:\ProyectoBD\rentlog2.ldf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20) ;
GO
```




# Modificar base de datos
Para modificar una base de datos se usa la sentencia Alter database

```sql

Alter DATABASE AdmFincas
Modify Name = AdministradordeFincas
Go

```
Con la sentencia `DB_NAME` podemos ver si el nombre se cambió correctamente

## Modificar el tamaño

```sql
Alter Database AdmFincas
Modify File
	(Name = BPri2_dat,
	SIZE = 200MB);
Go
```

- Se puede revertir el cambio anterior con la suguiente query
```sql
ALTER DATABASE AdmFincas_Coruña
REMOVE FILE BPri5_dat; 
Go
```

## Añadir FileGroups

```sql
ALTER DATABASE AdmFincas
ADD FILEGROUP FileGroup_Inquilino;
Go
```
```sql
Select *
From sys.filegroups
WHERE name = 'FileGroup_inquilino'
Go
```





## Creación de tablas


```sql
Use AdmFincas
Go
CREATE TABLE  Contratos
    (
     ID_Contrato INTEGER NOT NULL , 
     FechaInicio Date NOT NULL , 
     FechaFin Date NOT NULL , 
     
    )
GO
```

### Indicar Clave Primaria

```sql

ALTER TABLE Contratos ADD CONSTRAINT Contrato_PK PRIMARY KEY CLUSTERED (ID_Contrato)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO 
```
### anadir datos a una tabla
```sql
INSERT INTO [dbo].[Contratos]
VALUES ('1'  , '2Notas2-02-02' , '2003-02-01' )
GO
```
```sql
SELECT * FROM Contratos
```
<p align="center">
<img src="/ProyectoBD/assets/images/Administracion/adm3.png">
</p>


### Modificar tabla con ALTER

```sql
ALTER TABLE Propiedad
	ADD Altura VARCHAR NOT NULL DEFAULT 25;
GO
```
> Add (Nombre del atributo ) (tipo dato en este caso string) (Null o NOT NULL) (valor, en este caso 25)
```sql
ALTER TABLE Propiedad
	ADD Altura VARCHAR NOT NULL DEFAULT 25;
GO
```




# Seguridad y protección SSMS

## Usuarios


+ Crear Usuario con contraseña para el motor de base de datros
```sql
Create Login [SCP] 
	with password='abc123.',
	default_database=[master],
	check_expiration=off,
	check_policy=off
```



<p align="center">
<img src="/ProyectoBD/assets/images/Administracion/adm1.png">
</p>
Podemos anadir el login al rol del servidor para poder conectarme con el a la base de datos 

```sql
  ALTER SERVER ROLE [sysadmin] add member [SCP] 
```
+ desabilitar el inuicio de sesion
    ```sql
  ALTER LOGIN [SCP] DISABLE
  GO
    ```
+ habilitar el inicio de sesion
    ```sql
  ALTER LOGIN [SCP] Enable
  GO
    ```
CHECK_POLICY especifica que se deben aplicar las directivas de contraseñas de Windows en el servidor SQL
```sql
---ON
ALTER LOGIN SCP WITH CHECK_POLICY = OFF;
GO
---OFF
ALTER LOGIN SCP WITH CHECK_POLICY = ON;
GO
```
+ consultar Inicios de Sesión
```sql
SELECT *
FROM sys.sql_logins
GO
---Mix AUTH
SELECT *
FROM sys.syslogins
GO
```
### Cambiar la contraseña de un inicio de sesión:
```sql
ALTER LOGIN SCP WITH
PASSWORD = 'SUPERSECUREPASSWORD'
OLD_PASSWORD = 'abc123.';
GO
```
Podemos observar los logins creados dentro de ssms en su entorno grafico:
<p align="center">
<img src="/ProyectoBD/assets/images/Administracion/adm2.png">
</p>

## Crear un usuario de base de datos 
```sql
USE AdmFincas;
GO
CREATE USER SCP FOR LOGIN SCP;
GO
```
<p align="center">
<img src="/ProyectoBD/assets/images/Administracion/adm5.png">
</p>

### Crear un usuario de base de datos sin Inicio de Sesión
Creo el usuario Nologin sin permisos pero le otorgo posibilidad de impersonar a un usuario que si los tine 

```sql
CREATE USER Nologin WITHOUT LOGIN;
GO
GRANT IMPERSONATE ON USER::SCP TO Nologin;
GO
```
+ para impersonar a SCP el usuario Nologin debe ejecutar 
    ```sql
    EXECUTE AS USER = 'SCP';
    ```






> Con el procedimiento de almacenado sp_addsrvrolemember podemos añadir a un usuario a un Rol

Algunos de los roles mas comunes son:
* sysadmin: El rol sysadmin es el rol de nivel más alto y tiene control total sobre la instancia de SQL Server y todas las bases de datos.

*   db_owner: Los miembros del rol db_owner tienen control total sobre una base de datos específica, incluyendo la capacidad de realizar tareas de administración de bases de datos y asignar permisos a otros usuarios.

*   db_datareader: Los miembros del rol db_datareader pueden leer cualquier dato en una base de datos específica.

*   db_datawriter: Los miembros del rol db_datawriter pueden agregar, modificar y eliminar datos en una base de datos específica.

*   db_executor: Los miembros del rol db_executor pueden ejecutar cualquier procedimiento almacenado en una base de datos específica.

*   public: El rol public es un rol predefinido que se utiliza como grupo predeterminado para todos los usuarios y roles en una base de datos. Todos los usuarios y roles tienen automáticamente los permisos concedidos al rol public. 
> Añado el usuario SCP a un rol 


```sql
EXEC sp_addsrvrolemember 'SCP', 'db_executor' ;
GO
```

```sql
alter server role db_executor
    add member SCP ;
GO

```
## Eliminar usuario del rol

```sql
alter server role db_executor
    DROP member SCP ;
GO

```



# Permisos 
### GRANT:
Concede permisos sobre un elemento protegible o a una entidad
de seguridad.
```sql
GRANT CONNECT SQL TO SCP;
GO
```
### REVOKE:
Quita un permiso concedido o denegado previamente.
```sql
REVOKE CONNECT SQL TO SCP;
GO
```
### DENY:
Deniega un permiso a una entidad de seguridad. Evita que la entidad de seguridad herede
permisos por su pertenencia a grupos o roles.
```sql
DENY CONNECT SQL TO SCP;
GO
```
---
### Ejemplos
> Concedo permisos a un usuario en una tabla


as sa:
```sql
Grant select on [dbo.][Propiedades] to SCP

```
> Le concedo permiso de select a SCP 
Para Comprobar:

```sql
Execute as user ='SCP'
GO
Print user
GO
select * from [dbo.][Propiedades] 
GO

```
La secuencia es exitosa porque tenemos permisos, probemos con Deny para quitárselos
```sql
Revert
go
```
Para volver al usuario administrador

```sql
Deny select on [dbo.][Propiedades] to SCP

```
> Deniego el permiso select al usuario SCP en la tabla propiedades
# Permisos sobre objetos
---
## Permiso SELECT:
```sql
USE AdmFincas
GO
SELECT *
INTO dbo.Propiedad02
FROM dbo.Propiedad
GO
```
### Ejemplo:
> Doy permiso SELECT en la tabla dbo.Propiedad02 a SCP
```sql
GRANT SELECT ON dbo.Propiedad02 TO SCP;
GO
```
Quito permiso SELECT en la tabla dbo.Propiedad02 a SCP
```sql
REVOKE SELECT ON dbo.Propiedad02 TO SCP;
GO
```
Voy a impersonar a SCP (usar su contexto de seguridad)
```sql
EXECUTE as user = 'SCP';
GO
```
SCP intenta pasarle el permiso SELECT en la tabla dbo.Propiedad02 a Pepe pero no funciona
porque no tiene permiso
```sql
GRANT SELECT ON OBJECT::dbo.Propiedad02 TO Pepe;
GO
```


Vuelvo a mi usuario normal [dbo]
```sql
REVERT;
GO
```
### Ejemplo:
Ahora doy permiso SELECT en la tabla Propiedad02 a SCP con la opción de conceder
permisos sobre la tabla

```sql
GRANT SELECT ON dbo.Propiedad02 TO SCP
WITH GRANT OPTION;
GO
```

Impersono a SCP 
```sql
EXECUTE as user = 'SCP';
GO

Hago una SELECT de comprobación
SELECT *
FROM dbo.Propiedad02;
GO
```
Realizando un Print name deberia devolverme SPC

```sql
RINT user_name();
GO
```
> SCP

## Permiso CREATE:
+ Concedo a SCP el permiso para crear una tabla
```sql
GRANT CREATE TABLE TO SCP
GO
```
Me impersono como SCP
```sql
EXECUTE AS USER = 'SCP';
GO
PRINT user_name();
GO
```
> Intento crear una tabla y no puedo porque no tengo permiso, antes de crear una tabla tengo que
darle permiso para modificar el esquema dbo
```sql
CREATE TABLE Salario
(codigo INT IDENTITY (1,1));
GO
```

<p align="center">
<img src="/ProyectoBD/assets/images/Administracion/adm4.png">
</p>

+ Vuelvo al usuario dbo
+ 
+ Doy permiso a SCP para modificar el esquema dbo
  
```sql
REVERT
GO
GRANT ALTER ON Schema :: dbo TO SCP;
GO
---Ahora ya puedo darle permiso para crear una tabla

GRANT CREATE TABLE TO SCP;
GO
Me impersono como SCP
EXECUTE AS USER='SCP';
GO
```

```sql
PRINT user_name();
GO
```

> Ahora si me permite crear la tabla
```sql
CREATE TABLE Salario
(codigo INT IDENTITY (1,1));
GO
```


# Schema

Un esquema es un contenedor lógico (no físico) que contiene tablas, vistas, procedimientos, etc.
Se encuentra dentro de una base de datos, que a su vez está dentro de un servidor. Estas
entidades se acomodan como cajas anidadas. El servidor es la caja más externa y el esquema la
más interna.

Ejemplo:

Creo el esquema Notas
```sql
CREATE SCHEMA Notas AUTHORIZATION SCP;
GO
---Creo una tabla dentro del esquema Notas
CREATE TABLE Notas.Articulo (
ID INT,
Nombre CHAR(32));
GO
```
Voy a transferir objetos entre esquemas, para ello creo otro esquema
```sql
CREATE SCHEMA Notas2;
GO

---Transfiero objetos entre esquemas

ALTER SCHEMA Notas2 TRANSFER Notas.Articulo;
GO
```
# Politica de Recuperación de Desastres

## Snapshot 

es una vista en tiempo real de una base de datos en un momento específico. Con ella podemos ver el estado de la base de datos en ese momento, pero no es una copia de seguridad real.
```sql
CREATE DATABASE AdmFincas_snapshot ON 
   ( NAME = AdmFincas, FILENAME = 'C:\MSSQL\DATA\AdmFincas_snapshot.ss' )
   AS SNAPSHOT OF AdmFincas;

```

## Backup / Restore
###  Completo

incluye todos los datos de la base de datos y se realiza en un solo archivo. 
```sql
CREATE DATABASE AdmFincas_snapshot ON 
   ( NAME = AdmFincas, FILENAME = 'C:\MSSQL\DATA\AdmFincas_snapshot.ss' )
   AS SNAPSHOT OF AdmFincas;

```

### Diferencial

incluye solo los cambios realizados en la base de datos desde la última copia de seguridad completa.
```sql
BACKUP DATABASE AdmFincas TO DISK = 'C:\MSSQL\BACKUPS\AdmFincas_diff.bak' WITH DIFFERENTIAL;

```
###  Log
```sql
BACKUP LOG AdmFincas TO DISK = 'C:\MSSQL\BACKUPS\AdmFincas_log.bak';
```

## Restaurar una base de datos a partir de una copia de seguridad
```sql
RESTORE DATABASE AdmFincas FROM DISK = 'C:\MSSQL\BACKUPS\AdmFincas.bak';
```
### Coppy_only
 incluye solo los cambios realizados desde la última copia de seguridad completa

```sql 
 BACKUP DATABASE AdmFincas TO DISK = 'C:\MSSQL\BACKUPS\AdmFincas_copy.bak' WITH COPY_ONLY;
 ```

 ###  Tail Backup
 Incluye solo los cambios realizados en la base de datos desde la última copia de seguridad de registro y no incluye los cambios posteriores

```sql 
 BACKUP LOG AdmFincas TO DISK = 'C:\MSSQL\BACKUPS\AdmFincas_tail.bak' WITH NORECOVERY;
 ```





