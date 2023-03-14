---
layout: single
title: Creación del Proyecto Administrador de Fincas
excerpt: "Modelo Lógico Conceptual."
date: 2023-01-16
classes: wide
header:
  teaser: /assets/images/htb-writeup-magic/magic_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.webp
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






# Modelo de base de datos lógico-relacional para un Administrador de fincas

## Introducción

El objetivo de este proyecto es diseñar un modelo de base de datos lógico-relacional para un Administrador de fincas. Este modelo permitirá gestionar los distintos aspectos relacionados con la administración de fincas, como los propietarios, las viviendas, los inquilinos, los contratos, los gastos y los servicios.



- [Modelo de base de datos lógico-relacional para un Administrador de fincas](#modelo-de-base-de-datos-lógico-relacional-para-un-administrador-de-fincas)
  - [Introducción](#introducción)
- [Análisis previo](#análisis-previo)
- [Modelo Lógico Conceptual](#modelo-lógico-conceptual)
  - [Supuestos semanticos](#supuestos-semanticos)
    - [Propietario](#propietario)
    - [Propiedad](#propiedad)
    - [Alquiler](#alquiler)
    - [Cliente](#cliente)
    - [Gasto](#gasto)
  - [Modelo Lógico:](#modelo-lógico)
- [Modelo Relacional](#modelo-relacional)
- [Análisis de las normas de formalización en el modelo de base de datos](#análisis-de-las-normas-de-formalización-en-el-modelo-de-base-de-datos)
  - [Norma 1FN](#norma-1fn)
  - [Norma 2FN](#norma-2fn)
  - [Norma 3FN](#norma-3fn)
- [Crear Base de Datos AdmFincas en SQL Server](#crear-base-de-datos-admfincas-en-sql-server)
- [DDL](#ddl)
- [Administración](#administración)
  - [Creación de una base de datos desde una query](#creación-de-una-base-de-datos-desde-una-query)
    - [Tipos de archivos](#tipos-de-archivos)
- [Modificar base de datos](#modificar-base-de-datos)
  - [Modificar el tamaño](#modificar-el-tamaño)
  - [Añadir FileGroups](#añadir-filegroups)
  - [Creación de tablas](#creación-de-tablas)
  - [Indicar Clave Primaria](#indicar-clave-primaria)
  - [Modificar tabla ALTER](#modificar-tabla-alter)
- [Seguridad y protección SSMS](#seguridad-y-protección-ssms)
- [Eliminar usuario](#eliminar-usuario)
- [Permisos](#permisos)
- [Politica de Recuperación de Desastres](#politica-de-recuperación-de-desastres)
  - [Snapshot](#snapshot)
  - [Backup / Restore](#backup--restore)
    - [Completo](#completo)
    - [Diferencial](#diferencial)
    - [Log](#log)
  - [Restaurar una base de datos a partir de una copia de seguridad](#restaurar-una-base-de-datos-a-partir-de-una-copia-de-seguridad)
    - [Coppy\_only](#coppy_only)
    - [Tail Backup](#tail-backup)





# Análisis previo 

Mi empresa de administridador de fincas busca administrar las propiedades para Alquilarlas a otros inquilinos o realizarles el mantenimiento necesario.

La empresa necesita administrear los datos de las `propiedades,` asi como la de sus respectivos `propietarios` (que pueden ser empresas o individuos ) .

Si se realiza alquiler a algún `cliente` se necesitan saber los datos del cliente asi cómo el método de pago del mismo 

Los administradores de fincas realizan mantenimiento en las propiedades por lo que se necesita recopilar: 
* Datos sobre el `mantenimiento`(Descripción , Fecha de Inicio y fin...)
* `Trabajos` a realizar en el mantenimiento (Descripcion,Fecha de asignación Duración ...)
* Datos sobre el `proveedor de servicios `que administrará los trabajadores para realizar el mantenimiento (Nombre,Email,telefono...).


También interesa Guardar información sobre la propiedad asi cómo su tipo, si tiene aparcamiento o garage, número de habitaciones,baños...


# Modelo Lógico Conceptual
## Supuestos semanticos
- Una propiedad puede tener varios propietarios y un propietario puede tener varias propiedades 
- Un propietario puede ser una empresa o un individuo
- Una empresa o individuo pueden tener varios telefonos pero cada telefono solo puede estar asociado a un individuo o empresa
- la propiedad puede tener varios alquileres a lo largo del tiempo pero cada alquiler solo puede estar asociado a una propiedad
- Una propiedad puede tener un único tipo y un tipo varias propiedades
  
- Un cliente puede tener varios alquileres pero cada alquiler tiene que estar asociado a un único cliente
- Cada pago está asociado a un cliente y a un alquiler pero puede haber varios pagos en un alquiler 
- Cada propiedad puede tener varios mantenimientos pero cada mantenimiento está aspcoado a una única propiedad
- Oueden existir varios gastos por cada mantenimiento pero cáda gasto está registrado por un mantenimiento
- Los mantenimientos pueden tener varios trabajos , un trabajo puede estar asociado a varios mantenimientos
- Cada trabajo está aspcoado a um proovedor pero eñ proovedor puede temer varios trabajos
- La empresa, individuo,propiedad y cliente tienen una única dirección pero en la dirección puede haber varias de estas emtiedades .
  


### Propietario

- Contacto
> Tiene dos Entiidades hijas
  - Individuo
  - Empresa


> Decidi separar los atributos de telefonos de individuo y empresas en otras tablas para evitar redundancia


	

| ID_Propietario|  
|----------|
| 1   | 
| 2  | 


| Dni | Nombre | Apellido 1|Apellido 2|
|----------|----------|----------|----------|
| 1   | Salvador |Candedo |Pazos |
| 2  | Donald |Wayne | Johnson |

| CIF| NombreEmpresa | Numero |Sucursal |
|----------|----------|----------|----------|
| 1   | Starbuks |20 |Don Dolores |
| 2  | Endesa | 32 | Santa elena Peten |


### Propiedad

- IDpropiedad

- AñoConstruccion
- Superficie
- Baños
- Habitaciones
  
| IDpropiedad|  | AñoConstruccion  |Superficie |Baños| Habitaciones |
|----------|----------|----------|----------|----------| ----|
| 1   | Calle Ejemplo1 |Candedo |40|300| 300| 3 | 2 |
| 2  | Calle Ejemplo 2 |Wayne | 45 |450| 300| 2 | 1 |


### Alquiler
- ID_Alquiler
- Fecha_Inicio
- Fecha_Fin
- SeguroDeposito
- Renta mensual
- PrecioTotal
  - ID_Cliente(FK)
  - IDpropiedad(FK)

| ID_Alquiler| Fecha_Inicio | Fecha_Fin|SeguroDeposito |Renta mensual| | PrecioTotal |
|----------|----------|----------|----------|----------|----------|----------|
| 1   | 10/10/2023| 10/10/2023| 100 |300 |  |1000| 
| 2  | 10/10/2023| 10/10/2023| 120| 230 || 1200| 

### Cliente

- ID_Cliente(PK)
- Fecha de inicio
- Fecha de fin
- Precio mensual
- Duración en meses

| ID| Fecha de inicio| Fecha de fin|Precio mensual|Duración en meses| 
|----------|----------|----------|----------|----------|
| 1   | 10/01/02 | 10/02/01   |300|1 | 
| 2  | 10/02/01 |Martinez | 350 | 2  | 

### Gasto
> Esta tabla se usa para calcular el gasto total del mantenimiento
- ID
- Fecha
- Valor
- Coste total
  

| ID| Fecha | Valor |Coste total|
|----------|----------|----------|---------|
| 1   | 10/01/02 | 220-300  |300|
| 2  | 10/02/01 |100-150  | 350 |




Decido añadir las pagas pago, dirección ,trabajos y tipo de propiedad para cumplir con la primera forma normal.



> Las entidades sin Pk Datamodeler genera una PK autoincremental al realizar la ingeniería al modelo relacional


  ## Modelo Lógico:


<p align="center">
<img src="/ProyectoBD/assets/images/AdmfincasBD/Logical.png">
</p>


# Modelo Relacional

Al realizar la ingeniería al  modelo relacional se generan dos tablas más ya que existían dos relaciones N:M


- Mantenimiento-trabajo entre la entidad Mantenimiento y Trabajo
> PK compuesta por la FK de TrabajoID y MantenimientoID , decido no añadirle nada más porque la clave compuesta es única
- Propiedad-Propietario entre la entidad Propietario y Propiedad
> Pk Compuesta la FK de PropietarioID y PropiedadID decido no añadirle nada mas.


El resto de relaciones son 1:N por tanto las PK de las tablas del lado 1 propagarán como FK para las tablas del lado N.




<p align="center">
<img src="/ProyectoBD/assets/images/AdmfincasBD/Relational_1.png">
</p>

# Análisis de las normas de formalización en el modelo de base de datos


## Norma 1FN
 para evitar grupos repetitivos y poder tener una Dirección completa para
las distintas entidades que forman parte del modelo, creé una tabla Dirección relacionada con las demás entidades , ademnás de 

## Norma 2FN

Segunda formal Normal: 
Todos los atributos dependen de la clave primaria en sus respectivas tablas 

## Norma 3FN

no hay ningún atributo no Primario que dependa de otros
atributos no primarios en lugar de su PK en su tabla correspondiente.






# Crear Base de Datos AdmFincas en SQL Server

```sql
USE master
DROP DATABASE IF EXISTS AdmFincas
GO
CREATE DATABASE AdmFincas
GO
USE AdmFincas
GO
```



# DDL 

```sql
-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-13 19:32:31 CET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE Alquiler 
    (
     Fecha_Inicio DATE NOT NULL , 
     Fecha_fin DATE NOT NULL , 
     SeguroDeposito MONEY NOT NULL , 
     Renta_Mensual VARCHAR NOT NULL , 
     Cliente_ID_Cliente VARCHAR NOT NULL , 
     Propiedad_IDpropiedad VARCHAR NOT NULL , 
     Precio MONEY NOT NULL , 
     Alquiler_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Alquiler ADD CONSTRAINT Alquiler_PK PRIMARY KEY CLUSTERED (Alquiler_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Aparcamiento 
    (
     Aparcamiento_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Propiedad_IDpropiedad VARCHAR NOT NULL 
    )
GO

ALTER TABLE Aparcamiento ADD CONSTRAINT Aparcamiento_PK PRIMARY KEY CLUSTERED (Aparcamiento_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Cliente 
    (
     ID_Cliente VARCHAR NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellido VARCHAR NOT NULL , 
     Apellido_2 VARCHAR NOT NULL , 
     Pago_ID_Pago VARCHAR NOT NULL , 
     Direccion_Direccion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Cliente ADD CONSTRAINT Cliente_PK PRIMARY KEY CLUSTERED (ID_Cliente)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Direccion 
    (
     Calle VARCHAR NOT NULL , 
     Ciudad VARCHAR NOT NULL , 
     CodigoPostal VARCHAR NOT NULL , 
     Num INTEGER NOT NULL , 
     Direccion_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Direccion ADD CONSTRAINT Direccion_PK PRIMARY KEY CLUSTERED (Direccion_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Empresa 
    (
     ID_Propietario VARCHAR NOT NULL , 
     CIF NVARCHAR (8) NOT NULL , 
     NombreEmpresa VARCHAR NOT NULL , 
     Sucursal VARCHAR NOT NULL , 
     Direccion_Direccion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Empresa ADD CONSTRAINT Empresa_PK PRIMARY KEY CLUSTERED (ID_Propietario)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Empresa ADD CONSTRAINT Empresa_PKv1 UNIQUE NONCLUSTERED (CIF)
GO

CREATE TABLE FINCA_RÚSTICA 
    (
     Tipo_Propiedad_Tipo_Propiedad_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE FINCA_RÚSTICA ADD CONSTRAINT FINCA_RÚSTICA_PK PRIMARY KEY CLUSTERED (Tipo_Propiedad_Tipo_Propiedad_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FINCA_URBANA 
    (
     Tipo_Propiedad_Tipo_Propiedad_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE FINCA_URBANA ADD CONSTRAINT FINCA_URBANA_PK PRIMARY KEY CLUSTERED (Tipo_Propiedad_Tipo_Propiedad_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Garage 
    (
     Aparcamiento_Aparcamiento_ID NUMERIC (28) NOT NULL , 
     tamaño VARCHAR NOT NULL 
    )
GO

ALTER TABLE Garage ADD CONSTRAINT Garage_PK PRIMARY KEY CLUSTERED (Aparcamiento_Aparcamiento_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE gastos 
    (
     Descripcion VARCHAR NOT NULL , 
     Fecha DATE NOT NULL , 
     Valor MONEY NOT NULL , 
     Coste VARCHAR NOT NULL , 
     Mantenimiento_Mantenimiento_ID NUMERIC (28) NOT NULL 
    )
GO

CREATE TABLE Individuo 
    (
     ID_Propietario VARCHAR NOT NULL , 
     DNi VARCHAR NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellido VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL 
    )
GO

ALTER TABLE Individuo ADD CONSTRAINT Individuo_PK PRIMARY KEY CLUSTERED (ID_Propietario)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE Individuo ADD CONSTRAINT Individuo_PKv1 UNIQUE NONCLUSTERED (DNi)
GO

CREATE TABLE Mantenimiento 
    (
     Descripcion VARCHAR , 
     FechaInicio DATE NOT NULL , 
     FechaAcabado DATE NOT NULL , 
     Propiedad_IDpropiedad VARCHAR NOT NULL , 
     Mantenimiento_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Mantenimiento ADD CONSTRAINT Mantenimiento_PK PRIMARY KEY CLUSTERED (Mantenimiento_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Pago 
    (
     ID_Pago VARCHAR NOT NULL , 
     FechaPago DATE NOT NULL , 
     Alquiler_Alquiler_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Pago ADD CONSTRAINT Pago_PK PRIMARY KEY CLUSTERED (ID_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Parking 
    (
     Aparcamiento_Aparcamiento_ID NUMERIC (28) NOT NULL , 
     Plaza NUMERIC (28) NOT NULL , 
     tamaño VARCHAR NOT NULL 
    )
GO

ALTER TABLE Parking ADD CONSTRAINT Parking_PK PRIMARY KEY CLUSTERED (Aparcamiento_Aparcamiento_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Paypal 
    (
     ID_Pago VARCHAR NOT NULL , 
     Nombreusuario VARCHAR NOT NULL , 
     Correo VARCHAR NOT NULL 
    )
GO

ALTER TABLE Paypal ADD CONSTRAINT Paypal_PK PRIMARY KEY CLUSTERED (ID_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Propiedad 
    (
     IDpropiedad VARCHAR NOT NULL , 
     AñoConstruccion DATE NOT NULL , 
     AñoCompra DATE NOT NULL , 
     PrecioCompra MONEY NOT NULL , 
     AreaMetrosCuadrados CHAR NOT NULL , 
     Baños VARCHAR NOT NULL , 
     Habitaciones VARCHAR NOT NULL , 
     Tipo_Propiedad_Tipo_Propiedad_ID NUMERIC (28) NOT NULL , 
     Direccion_Direccion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Propiedad ADD CONSTRAINT Propiedad_PK PRIMARY KEY CLUSTERED (IDpropiedad)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Propietario 
    (
     ID_Propietario VARCHAR NOT NULL 
    )
GO

ALTER TABLE Propietario ADD CONSTRAINT Propietario_PK PRIMARY KEY CLUSTERED (ID_Propietario)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE "Propietario-propiedad" 
    (
     Propiedad_IDpropiedad VARCHAR NOT NULL , 
     Propietario_ID_Propietario VARCHAR NOT NULL 
    )
GO

ALTER TABLE "Propietario-propiedad" ADD CONSTRAINT Relation_25_PK PRIMARY KEY CLUSTERED (Propiedad_IDpropiedad, Propietario_ID_Propietario)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE ProveedorServicios 
    (
     Nombre VARCHAR NOT NULL , 
     Email VARCHAR NOT NULL , 
     telefono VARCHAR NOT NULL , 
     ProveedorServicios_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Direccion_Direccion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE ProveedorServicios ADD CONSTRAINT ProveedorServicios_PK PRIMARY KEY CLUSTERED (ProveedorServicios_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tarjeta_De_Crédito 
    (
     ID_Pago VARCHAR NOT NULL , 
     NombreCompleto VARCHAR NOT NULL , 
     NumTarjeta NUMERIC (28) NOT NULL , 
     Expira DATE NOT NULL , 
     Cvv VARCHAR NOT NULL 
    )
GO

ALTER TABLE Tarjeta_De_Crédito ADD CONSTRAINT Tarjeta_De_Crédito_PK PRIMARY KEY CLUSTERED (ID_Pago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Telefono_Empresa 
    (
     Num_Empresa VARCHAR NOT NULL , 
     Empresa_CIF NVARCHAR (8) NOT NULL 
    )
GO

CREATE TABLE Telefono_Particular 
    (
     Num_Individuo VARCHAR , 
     Individuo_DNi VARCHAR NOT NULL 
    )
GO

CREATE TABLE Tipo_Propiedad 
    (
     Tipo_Propiedad_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Tipo_Propiedad ADD CONSTRAINT Tipo_Propiedad_PK PRIMARY KEY CLUSTERED (Tipo_Propiedad_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Trabajo 
    (
     DescripciónServicio VARCHAR NOT NULL , 
     FechaAsignacion DATE NOT NULL , 
     FechaCompleta DATE NOT NULL , 
     Coste MONEY NOT NULL , 
     Duración NVARCHAR NOT NULL , 
     Trabajo_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     ProveedorServicios_ProveedorServicios_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Trabajo ADD CONSTRAINT Trabajo_PK PRIMARY KEY CLUSTERED (Trabajo_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE "Trabajo-Mantenimiento" 
    (
     Mantenimiento_Mantenimiento_ID NUMERIC (28) NOT NULL , 
     Trabajo_Trabajo_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE "Trabajo-Mantenimiento" ADD CONSTRAINT Relation_15_PK PRIMARY KEY CLUSTERED (Mantenimiento_Mantenimiento_ID, Trabajo_Trabajo_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Alquiler 
    ADD CONSTRAINT Alquiler_Cliente_FK FOREIGN KEY 
    ( 
     Cliente_ID_Cliente
    ) 
    REFERENCES Cliente 
    ( 
     ID_Cliente 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Alquiler 
    ADD CONSTRAINT Alquiler_Propiedad_FK FOREIGN KEY 
    ( 
     Propiedad_IDpropiedad
    ) 
    REFERENCES Propiedad 
    ( 
     IDpropiedad 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Aparcamiento 
    ADD CONSTRAINT Aparcamiento_Propiedad_FK FOREIGN KEY 
    ( 
     Propiedad_IDpropiedad
    ) 
    REFERENCES Propiedad 
    ( 
     IDpropiedad 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Cliente 
    ADD CONSTRAINT Cliente_Direccion_FK FOREIGN KEY 
    ( 
     Direccion_Direccion_ID
    ) 
    REFERENCES Direccion 
    ( 
     Direccion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Cliente 
    ADD CONSTRAINT Cliente_Pago_FK FOREIGN KEY 
    ( 
     Pago_ID_Pago
    ) 
    REFERENCES Pago 
    ( 
     ID_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_Direccion_FK FOREIGN KEY 
    ( 
     Direccion_Direccion_ID
    ) 
    REFERENCES Direccion 
    ( 
     Direccion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_Propietario_FK FOREIGN KEY 
    ( 
     ID_Propietario
    ) 
    REFERENCES Propietario 
    ( 
     ID_Propietario 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FINCA_RÚSTICA 
    ADD CONSTRAINT FINCA_RÚSTICA_Tipo_Propiedad_FK FOREIGN KEY 
    ( 
     Tipo_Propiedad_Tipo_Propiedad_ID
    ) 
    REFERENCES Tipo_Propiedad 
    ( 
     Tipo_Propiedad_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FINCA_URBANA 
    ADD CONSTRAINT FINCA_URBANA_Tipo_Propiedad_FK FOREIGN KEY 
    ( 
     Tipo_Propiedad_Tipo_Propiedad_ID
    ) 
    REFERENCES Tipo_Propiedad 
    ( 
     Tipo_Propiedad_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Garage 
    ADD CONSTRAINT Garage_Aparcamiento_FK FOREIGN KEY 
    ( 
     Aparcamiento_Aparcamiento_ID
    ) 
    REFERENCES Aparcamiento 
    ( 
     Aparcamiento_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE gastos 
    ADD CONSTRAINT gastos_Mantenimiento_FK FOREIGN KEY 
    ( 
     Mantenimiento_Mantenimiento_ID
    ) 
    REFERENCES Mantenimiento 
    ( 
     Mantenimiento_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Individuo 
    ADD CONSTRAINT Individuo_Propietario_FK FOREIGN KEY 
    ( 
     ID_Propietario
    ) 
    REFERENCES Propietario 
    ( 
     ID_Propietario 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Mantenimiento 
    ADD CONSTRAINT Mantenimiento_Propiedad_FK FOREIGN KEY 
    ( 
     Propiedad_IDpropiedad
    ) 
    REFERENCES Propiedad 
    ( 
     IDpropiedad 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pago 
    ADD CONSTRAINT Pago_Alquiler_FK FOREIGN KEY 
    ( 
     Alquiler_Alquiler_ID
    ) 
    REFERENCES Alquiler 
    ( 
     Alquiler_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Parking 
    ADD CONSTRAINT Parking_Aparcamiento_FK FOREIGN KEY 
    ( 
     Aparcamiento_Aparcamiento_ID
    ) 
    REFERENCES Aparcamiento 
    ( 
     Aparcamiento_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Paypal 
    ADD CONSTRAINT Paypal_Pago_FK FOREIGN KEY 
    ( 
     ID_Pago
    ) 
    REFERENCES Pago 
    ( 
     ID_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Propiedad 
    ADD CONSTRAINT Propiedad_Direccion_FK FOREIGN KEY 
    ( 
     Direccion_Direccion_ID
    ) 
    REFERENCES Direccion 
    ( 
     Direccion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Propiedad 
    ADD CONSTRAINT Propiedad_Tipo_Propiedad_FK FOREIGN KEY 
    ( 
     Tipo_Propiedad_Tipo_Propiedad_ID
    ) 
    REFERENCES Tipo_Propiedad 
    ( 
     Tipo_Propiedad_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE ProveedorServicios 
    ADD CONSTRAINT ProveedorServicios_Direccion_FK FOREIGN KEY 
    ( 
     Direccion_Direccion_ID
    ) 
    REFERENCES Direccion 
    ( 
     Direccion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Trabajo-Mantenimiento" 
    ADD CONSTRAINT Relation_15_Mantenimiento_FK FOREIGN KEY 
    ( 
     Mantenimiento_Mantenimiento_ID
    ) 
    REFERENCES Mantenimiento 
    ( 
     Mantenimiento_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Trabajo-Mantenimiento" 
    ADD CONSTRAINT Relation_15_Trabajo_FK FOREIGN KEY 
    ( 
     Trabajo_Trabajo_ID
    ) 
    REFERENCES Trabajo 
    ( 
     Trabajo_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Propietario-propiedad" 
    ADD CONSTRAINT Relation_25_Propiedad_FK FOREIGN KEY 
    ( 
     Propiedad_IDpropiedad
    ) 
    REFERENCES Propiedad 
    ( 
     IDpropiedad 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Propietario-propiedad" 
    ADD CONSTRAINT Relation_25_Propietario_FK FOREIGN KEY 
    ( 
     Propietario_ID_Propietario
    ) 
    REFERENCES Propietario 
    ( 
     ID_Propietario 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Tarjeta_De_Crédito 
    ADD CONSTRAINT Tarjeta_De_Crédito_Pago_FK FOREIGN KEY 
    ( 
     ID_Pago
    ) 
    REFERENCES Pago 
    ( 
     ID_Pago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Telefono_Empresa 
    ADD CONSTRAINT Telefono_Empresa_Empresa_FK FOREIGN KEY 
    ( 
     Empresa_CIF
    ) 
    REFERENCES Empresa 
    ( 
     CIF 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Telefono_Particular 
    ADD CONSTRAINT Telefono_Particular_Individuo_FK FOREIGN KEY 
    ( 
     Individuo_DNi
    ) 
    REFERENCES Individuo 
    ( 
     DNi 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Trabajo 
    ADD CONSTRAINT Trabajo_ProveedorServicios_FK FOREIGN KEY 
    ( 
     ProveedorServicios_ProveedorServicios_ID
    ) 
    REFERENCES ProveedorServicios 
    ( 
     ProveedorServicios_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            24
-- CREATE INDEX                             0
-- ALTER TABLE                             50
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE DATABASE                          0
-- CREATE DEFAULT                           0
-- CREATE INDEX ON VIEW                     0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE ROLE                              0
-- CREATE RULE                              0
-- CREATE SCHEMA                            0
-- CREATE SEQUENCE                          0
-- CREATE PARTITION FUNCTION                0
-- CREATE PARTITION SCHEME                  0
-- 
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0

```


# Administración

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

## Creación de una base de datos desde una query



### Tipos de archivos   

* Los archivos con extensión `.ndf `son archivos de datos secundarios opcionales. Pueden ser utilizados para almacenar datos en tablas o índices específicos, y permiten una mejor distribución de los datos en varios discos físicos  
  
El archivo con extensión ` .ldf` es el archivo de registro de transacciones.
 * Este archivo contiene información sobre todas las operaciones que se han realizado en la base de datos, como inserciones, actualizaciones y eliminaciones. El archivo de registro de transacciones es importante para garantizar la integridad de los datos en caso de que se produzca una falla en el sistema.
  
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
    (NAME = Bici1,
    FILENAME = 'C:\ProyectoBD\rentdat1.mdf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Bici2,
    FILENAME = 'C:\ProyectoBD\rentdat2.ndf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
    ( NAME = Bici3,
    FILENAME = 'C:\ProyectoBD\rentdat3.ndf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20)
LOG ON 
   (NAME = Bicilog1,
    FILENAME = 'C:\ProyectoBD\rentlog1.ldf',
    SIZE = 100MB,
    MAXSIZE = 200,
    FILEGROWTH = 20),
   (NAME = Bicilog2,
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
ALTER DATABASE Bici_Coruña
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

## Indicar Clave Primaria

```sql

ALTER TABLE Contratos ADD CONSTRAINT Contrato_PK PRIMARY KEY CLUSTERED (ID_Contrato)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO 
```
## Modificar tabla ALTER

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

##Insert

```sql
Insert(Propiedad)(IDpropiedad,Añoconstruccion)
Values (1,12/12/1990),
        (2,01/02/1990),
GO
```

```sql
Select IDpropiedad,Añoconstruccion
From Propiedad;
GO

```


# Seguridad y protección SSMS
Crear Usuario con contraseña
```sql
Create Login [SCP] 
	with password='abc123.',
	default_database=[master],
	check_expiration=off,
	check_policy=off
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
# Eliminar usuario

```sql
alter server role db_executor
    DROP member SCP ;
GO

```



# Permisos 

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
