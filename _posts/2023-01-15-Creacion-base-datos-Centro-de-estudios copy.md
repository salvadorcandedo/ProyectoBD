---
layout: single
title: Creación de la base de datos Centro de estudios
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

# Enunciado del ejercicio

Un Centro de enseñanza de secundaria desea registrar los datos de los alumnos que han cursado ciclos de FP manteniendo actualizados los datos con los trabajos o formaciones recibidas
porque a menudo en el Centro, se reciben llamadas de empresas solicitando alumnos que hayan
finalizado con un perfil determinado para ocupar una vacante.
Con esta base de datos queremos registrar y así poder obtener a posteriori, la información de las
actividades realizadas por los alumnos en las FCT, y en trabajos anteriores, así como los estudios
que hayan cursado y finalizado consiguiendo de esta manera una selección de alumnos más rápida y
eficaz al perfil solicitado por la empresa.
Además se registrarán los proyectos que entregan los alumnos en el módulo final de Proyectos.
También guardaremos información de las empresas relacionadas con los ciclos con indicación de
las actividades o áreas que desarrollan.

---
## ANALISIS DEL SISTEMA DE INFORMACIÓN 

### (ANÁLISIS PREVIO O DE OPORTUNIDAD)
### Especificaciones y requerimientos:

- De los `alumnos` interesa conocer sus datos personales, académicos y experiencia laboral:
- `Datos personales`: DNI nombre, apellidos, fecha nacimiento, dirección, Municipio, Provincia,Código postal, email y teléfono de contacto.
- `Datos académicos`:
Información de la FCT: Empresa en la que la ha realizado, Convocatoria (JUN o DIC) y año, Areasen las que las ha desarrollado (Programación, Redes, Sistemas Operativos,..)
- `Información del Proyecto del Ciclo actual`: Título del proyecto, Breve descripción, Profesor tutor
(dni,nombre y apellidos, teléfono, email), Fecha presentación, Nota obtenida
Para cada titulación obtenida por el alumno: Título, Nombre del Centro, Municipio del Centro,
Provincia del Centro, Año, Nota obtenida por el alumno en ese título.
Experiencia laboral con indicación para cada una de las empresas en las que ha trabajado de:
- `Nombre de la Empresa`. Fecha inicio de trabajo del alumno en esa empresa, Fecha fin de trabajo del alumno en esa empresa (si sigue trabajando no tendrá información), Areas o actividades en las que
ha trabajado en ese periodo en esa empresa
- `De las empresas interesa conocer`: CIF, Nombre, NumConvenio (Número de convenio con el
Centro en el caso de que exista, para hacer la FCT), Dirección, Municipio, Código Postal, Email,
Teléfono, Sitio Web, Areas o actividades en las que trabaja (Programación, Redes, Sistemas
Operativos,..

---


## Restricciones (Supuestos Semánticos):
Una ver recogidos todos los datos debemos tener en cuenta una serie de restricciones necesarias
para que la base de datos tenga coherencia y no se produzcan errores:
- Los proyectos podrán ser realizados por varios alumnos.
- Un proyecto solo podrá tener asignado un tutor.
- Un tutor podrá tener más de un proyecto.
- Un alumno podrá tener sólamente un proyecto.
- Un alumno podrá haber estudiado en distintos centros, o en el mismo centro, - varias titulaciones
- diferentes.
- Un alumno solo realizará las prácticas en una empresa.
- Un alumno podrá haber trabajado en distintas empresas o en la misma varias veces.
- Una empresa podrá acoger a varios alumnos en prácticas.
- Una empresa podrá contratar a varios alumnos.
- Una empresa puede dedicarse a varias actividades.

---

---












# `Modelo Lógico Conceptual`

# Entidades
Creo las siguientes Entidades en Data Modeler: 
- Proyecto
- Alumno
- Tutor
- Centro
- Área
- Provincia
- Titulación
- Empresa
- Municipio



# Relaciones
> Las Tablas sin PK se las asigna el datamodeler al realizar la ingeniería al modelo relacional 
- En una provincia puede haber varios municipios, pero cada municipio se encuentra en una única provincia. 

- En un municipio pueden existir varios centros, pero cada centro solo puede estar ubicado en un municipio .

- En cuanto a la relación entre alumnos y titulaciones, un alumno puede obtener una o más titulaciones y una titulación puede ser obtenida por uno o más alumnos. 

- Una titulación puede ser impartida en uno o varios centros, y en un centro se pueden impartir una o varias titulaciones.

- En un centro de estudios pueden trabajar uno o varios tutores, y un tutor puede estar asignado a más de un proyecto. 
- Un proyecto puede ser realizado por uno o varios alumnos

- En cuanto a la relación entre alumnos y empresas, un alumno puede tener dos tipos de relaciones:
 > - Por un lado, puede realizar las prácticas en una empresa, y en este caso solo puede realizarlas en una única empresa. 
   En una empresa pueden estar realizando prácticas uno o más alumnos. En esta relación también se incluyeron atributos como la fecha del proyecto. 

> - Por otro lado, un alumno también puede trabajar o haber trabajado en una o varias empresas, y en una empresa pueden estar trabajando uno o varios alumnos. 

-  una empresa está ubicada en un municipio y este a su vez en una provincia, al igual que el centro de estudios.
- una empresa puede tener una o varias áreas, y un área puede estar representada en varias empresas.

---
Una vez realizado el modelo lógico debería verse tal que así: 


<p align="center">
<img src="/ProyectoBD/assets/images/centroestudios/Logical.png">
</p>


![](/assets/images/centroestudios/Logical.png)

---

## Modelo Lógico Relacional

Modelo Lógico Relacional
Al realizar la ingeniería al modelo relacional se generan 13 tablas
En las relaciones N:M se crean nuevas tablas para romper con la 


 | Alumno | `Estudia ` | titulación |


* Decido incluir  Curso como parte de la PK compuesta.


| Area | `Se dedica`   | Empresa |

| Titulación  | `Imparte`   | Centro |

| Alumno   | `Trabaja`   | Empresa  |


 > las relaciónes que sean 1: N propagan su PK 
 
 - En las tablas ` Centro, Municipio, Provincia, Área, Titulación y Proyecto`se crean automáticamente `atributos dentity `autonuméricos

--- 
## Aplicamos la normalización hasta la tercera forma normal
--- 
- Se encuentran ya en 1FN?
>  No existen grupos repetitivos ni tampoco campos
multivaluados.
- En cuanto a la 2FN?

 La 2Fn Nos dice que los atributos no clave son todos aquellos que no forman parte de la clave primária y ningumo de ellos dependerá de una parte de la clave primaria. 

 > 
- Cumplea la 3FN?,

> Si,porque no hay ningún atributo no Primario que dependa de otros atributos no primarios en lugar de su PK 


<p align="center">
<img src="/ProyectoBD/assets/images/centroestudios/Relational_1.png">
</p>

---
### Una vez realizados el modelo Lógico Conceptual y Relacional ya solo queda generar el DLL en Data-Modeler para que podamos usarlo en nuestro smss









```sql
-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-01-15 04:18:44 CET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE Alumno 
    (
     DNI VARCHAR NOT NULL , 
     Apellido1 VARCHAR , 
     Apellido2 VARCHAR , 
     FechaNacimiento DATE , 
     cp VARCHAR , 
     Telefono_1 VARCHAR , 
     telefono VARCHAR , 
     mail VARCHAR , 
     Empresa_cif VARCHAR NOT NULL , 
     Proyecto_Proyecto_ID NUMERIC (28) NOT NULL , 
     Municipio_Municipio_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Alumno ADD CONSTRAINT Alumno_PK PRIMARY KEY CLUSTERED (DNI)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Area 
    (
     Nombre VARCHAR NOT NULL , 
     Descripcion VARCHAR NOT NULL , 
     Area_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Area ADD CONSTRAINT Area_PK PRIMARY KEY CLUSTERED (Area_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE centro 
    (
     Nombre VARCHAR , 
     Direccion VARCHAR , 
     CIP VARCHAR , 
     Telefono VARCHAR , 
     centro_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Municipio_Municipio_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE centro ADD CONSTRAINT centro_PK PRIMARY KEY CLUSTERED (centro_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Empresa 
    (
     cif VARCHAR NOT NULL , 
     Nombre1 VARCHAR , 
     Numconvenio VARCHAR , 
     direccion VARCHAR , 
     cp VARCHAR , 
     email VARCHAR , 
     telefono VARCHAR , 
     sitioweb VARCHAR , 
     Municipio_Municipio_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Empresa ADD CONSTRAINT Empresa_PK PRIMARY KEY CLUSTERED (cif)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Estudia 
    (
     Alumno_DNI VARCHAR NOT NULL , 
     titulacion_ID VARCHAR NOT NULL , 
     Curso UNKNOWN 
--  ERROR: Datatype UNKNOWN is not allowed 
                    NOT NULL 
    )
GO

ALTER TABLE Estudia ADD CONSTRAINT Relation_17_PK PRIMARY KEY CLUSTERED (Alumno_DNI, titulacion_ID, Curso)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Imparte 
    (
     centro_centro_ID NUMERIC (28) NOT NULL , 
     titulacion_ID VARCHAR NOT NULL 
    )
GO

ALTER TABLE Imparte ADD CONSTRAINT Relation_16_PK PRIMARY KEY CLUSTERED (centro_centro_ID, titulacion_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Municipio 
    (
     Nombre VARCHAR , 
     Direccion VARCHAR , 
     CIP VARCHAR , 
     Telefono VARCHAR , 
     Municipio_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Provincia_Provincia_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Municipio ADD CONSTRAINT Municipio_PK PRIMARY KEY CLUSTERED (Municipio_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Profesor 
    (
     DNI_1 VARCHAR NOT NULL , 
     nombre VARCHAR , 
     Apellido1 VARCHAR , 
     Apellido2 VARCHAR , 
     telef VARCHAR , 
     Email VARCHAR , 
     centro_centro_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Profesor ADD CONSTRAINT Profesor_PK PRIMARY KEY CLUSTERED (DNI_1)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Provincia 
    (
     Nombre VARCHAR , 
     Provincia_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Provincia ADD CONSTRAINT Provincia_PK PRIMARY KEY CLUSTERED (Provincia_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Proyecto 
    (
     Titulo VARCHAR NOT NULL , 
     FechaEntregada DATE , 
     nota VARCHAR , 
     cp VARCHAR , 
     email VARCHAR , 
     telefono VARCHAR , 
     sitioweb VARCHAR , 
     Profesor_DNI_1 VARCHAR NOT NULL , 
     Proyecto_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Proyecto ADD CONSTRAINT Proyecto_PK PRIMARY KEY CLUSTERED (Proyecto_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE "Se dedica" 
    (
     Area_Area_ID NUMERIC (28) NOT NULL , 
     Empresa_cif VARCHAR NOT NULL 
    )
GO

ALTER TABLE "Se dedica" ADD CONSTRAINT Relation_7_PK PRIMARY KEY CLUSTERED (Area_Area_ID, Empresa_cif)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE titulacion 
    (
     ID VARCHAR NOT NULL , 
     Titulo VARCHAR 
    )
GO

ALTER TABLE titulacion ADD CONSTRAINT titulacion_PK PRIMARY KEY CLUSTERED (ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Trabaja 
    (
     Alumno_DNI VARCHAR NOT NULL , 
     Empresa_cif VARCHAR NOT NULL 
    )
GO

ALTER TABLE Trabaja ADD CONSTRAINT Relation_9_PK PRIMARY KEY CLUSTERED (Alumno_DNI, Empresa_cif)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Alumno 
    ADD CONSTRAINT Alumno_Empresa_FK FOREIGN KEY 
    ( 
     Empresa_cif
    ) 
    REFERENCES Empresa 
    ( 
     cif 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Alumno 
    ADD CONSTRAINT Alumno_Municipio_FK FOREIGN KEY 
    ( 
     Municipio_Municipio_ID
    ) 
    REFERENCES Municipio 
    ( 
     Municipio_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Alumno 
    ADD CONSTRAINT Alumno_Proyecto_FK FOREIGN KEY 
    ( 
     Proyecto_Proyecto_ID
    ) 
    REFERENCES Proyecto 
    ( 
     Proyecto_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE centro 
    ADD CONSTRAINT centro_Municipio_FK FOREIGN KEY 
    ( 
     Municipio_Municipio_ID
    ) 
    REFERENCES Municipio 
    ( 
     Municipio_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Empresa 
    ADD CONSTRAINT Empresa_Municipio_FK FOREIGN KEY 
    ( 
     Municipio_Municipio_ID
    ) 
    REFERENCES Municipio 
    ( 
     Municipio_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Municipio 
    ADD CONSTRAINT Municipio_Provincia_FK FOREIGN KEY 
    ( 
     Provincia_Provincia_ID
    ) 
    REFERENCES Provincia 
    ( 
     Provincia_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Profesor 
    ADD CONSTRAINT Profesor_centro_FK FOREIGN KEY 
    ( 
     centro_centro_ID
    ) 
    REFERENCES centro 
    ( 
     centro_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Proyecto 
    ADD CONSTRAINT Proyecto_Profesor_FK FOREIGN KEY 
    ( 
     Profesor_DNI_1
    ) 
    REFERENCES Profesor 
    ( 
     DNI_1 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Imparte 
    ADD CONSTRAINT Relation_16_centro_FK FOREIGN KEY 
    ( 
     centro_centro_ID
    ) 
    REFERENCES centro 
    ( 
     centro_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Imparte 
    ADD CONSTRAINT Relation_16_titulacion_FK FOREIGN KEY 
    ( 
     titulacion_ID
    ) 
    REFERENCES titulacion 
    ( 
     ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Estudia 
    ADD CONSTRAINT Relation_17_Alumno_FK FOREIGN KEY 
    ( 
     Alumno_DNI
    ) 
    REFERENCES Alumno 
    ( 
     DNI 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Estudia 
    ADD CONSTRAINT Relation_17_titulacion_FK FOREIGN KEY 
    ( 
     titulacion_ID
    ) 
    REFERENCES titulacion 
    ( 
     ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Se dedica" 
    ADD CONSTRAINT Relation_7_Area_FK FOREIGN KEY 
    ( 
     Area_Area_ID
    ) 
    REFERENCES Area 
    ( 
     Area_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Se dedica" 
    ADD CONSTRAINT Relation_7_Empresa_FK FOREIGN KEY 
    ( 
     Empresa_cif
    ) 
    REFERENCES Empresa 
    ( 
     cif 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Trabaja 
    ADD CONSTRAINT Relation_9_Alumno_FK FOREIGN KEY 
    ( 
     Alumno_DNI
    ) 
    REFERENCES Alumno 
    ( 
     DNI 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Trabaja 
    ADD CONSTRAINT Relation_9_Empresa_FK FOREIGN KEY 
    ( 
     Empresa_cif
    ) 
    REFERENCES Empresa 
    ( 
     cif 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            13
-- CREATE INDEX                             0
-- ALTER TABLE                             29
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

# CREACIÓN BASE DE DATOS EN SQL SERVER 

```` sql

DROP DATABASE IF EXIST Centro_Estudios
GO
CREATE DATABASE Centro_Estudios
GO
USE Centro_Estudios
GO
````
