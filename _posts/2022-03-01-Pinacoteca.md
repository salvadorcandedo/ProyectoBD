---
layout: single
title: Creación de la base de datos Pinacoteca
excerpt: "Modelo Lógico Conceptual."
date: 2023-01-16
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
- [Modelo Lógico Conceptual](#modelo-lógico-conceptual)
- [Relaciones](#relaciones)
  - [Modelo relacional](#modelo-relacional)
  - [Normalización](#normalización)
- [Crear Base de Datos Pinacoteca en SQL Server](#crear-base-de-datos-pinacoteca-en-sql-server)
- [DDL](#ddl)
 




---

# Modelo Lógico Conceptual

Creo las siguientes Entidades :
- Obra, con tres entidades hijas :
  - Obra propia (que la posee el museo)
  - Obra prestada por institución
  - Obra prestada por coleccionista
- Pintor
- Restaurador
- Conservador
- Fondo permanente
- Planta
- Sala
- Estilo pictórico
- Exposición temporal
- Préstamo a otro museo
- Periodo restauración
---
- También creé la entidad `Teléfono` para relacionarla con Otros museos (puesto que se indica en el enunciado que pueden tener varios teléfonos y así evito tener campos multivaluados, que sería lo que pasaría si la metiera como atributo dentro de Otros museos).
  
- Creo la entidad `Dirección `y así no la meto como un atributo dentro de otros museos
  

> En las tablas donde no ponga atributos ID o códigos incrementales cómo PK (Primary key) Data Modeler los crea automáticamente al realizar la ingeniería al modelo relacional 

# Relaciones
- Un estilo pictórico puede comprender varias salas pero  una sala sólo puede exponer de un estilo pictórico.
- Un conservador sólo se puede encargar de un estilo pictórico y el museo sólo cuenta con uno para cada estilo (1:1).
- Un conservador se encargará de una exposición temporal y una exposición temporal estará asignada a un único conservador .
- Un pintor sólo tiene un restaurador especializado en él y un restaurador puede estar especializado en varios pintores.
- Un pintor puede pintar varios cuadros pero  un cuadro es pintado por un único pintor. 
- Un Pintor puede tener varios estilos pictóricos durante toda su carrera y los estilos pictóricos están representados por varios pintores.
- Un restaurador puede encargarse de varios Periodos de restauración
- Un cuadro puede tener varios periodos de restauración pero durante el mismo periodo de restauración sólo puede trabajar en un sólo cuadro.
  

- La exposición temporal puede tener expuestas más de una obra de cualquiera de los tres tipos (propia , institución o prestada por un coleccionista)
  
  
- Los dos posibles proveedores de cuadros ( institución o coleccionista) tienen relaciones 1:N con las Direcciones y los posibles telefonos que puedan tener
  

----

El modelo Lógico realizado se ve tal que asi:


<p align="center">
<img src="/ProyectoBD/assets/images/PinacotecaBD/Logical.png">
</p>




## Modelo relacional 
Al realizar la ingeniería al modelo relacional se generan 16 tablas, 2 más que en el modelo lógico porque había 4 relaciones N:M , por tanto estas 4 nuevas tablas serían:



- Pintor-Estilo
   (entre la relación Pintor y estilo pictórico) 
   > dos FK que actúan como PK
compuesta.
- Obra-Expo temporal 
- (entre la relación obra y Exposición temporal),
  > Incluyo el atriuto fecha entra_exposición_temporal como parte de la PK compuesta.


- Hay una relación 1:1 entre Conservador y exposición temporal y se propagan
mutuamente sus PK haciendo de FK.


> El resto de relaciones son 1: N por tanto propagan su PK 


<p align="center">
<img src="/ProyectoBD/assets/images/PinacotecaBD/Relational_1.png">
</p>




## Normalización
- Se encuentran ya en 1FN, ya que no existen grupos repetitivos ni tampoco campos multivaluados.
- En cuanto a la 2FN: las tablas que tienen PK compuestas y atributos no primarios son:
  - La tabla Obra museo- Préstamo otro museo que tiene el atributo no primario Fecha fin préstamo que depende sólo de una parte de la PK (fecha inicio préstamo), pero  opto por no sacarlo para otra tabla.
  - La tabla Obra-Expo temporal que tiene el atributo no primario Fecha sale exposición temporal que depende sólo de una parte de la PK. pero  opto por no sacarlo para otra tabla.
  - Sala que tiene una PK compuesta por Número de sala y Piso planta y tiene un atributo no primario que ya depende de toda la clave compuesta.
  
- Se cumple la 3F
  
  
  Porque no hay ningún atributo no Primario que dependa de otros
atributos no primarios en lugar de su PK en su tabla correspondiente.




# Crear Base de Datos Pinacoteca en SQL Server

```sql
DROP DATABASE IF EXISTS Pinacoteca
GO
CREATE DATABASE Pinacoteca
GO
USE Pinacoteca
GO
```



# DDL 
```sql

-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-12 06:33:12 CET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE Conservador 
    (
     Codigo CHAR NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellido1 VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL , 
     Estilo_pictorico_Estilo_pictorico_ID NUMERIC (28) NOT NULL , 
     Exposicion_temporal_Exposicion_temporal_ID NUMERIC (28) NOT NULL 
    )
GO 

    


CREATE UNIQUE NONCLUSTERED INDEX 
    Conservador__IDX ON Conservador 
    ( 
     Estilo_pictorico_Estilo_pictorico_ID 
    ) 
GO 


CREATE UNIQUE NONCLUSTERED INDEX 
    Conservador__IDXv1 ON Conservador 
    ( 
     Exposicion_temporal_Exposicion_temporal_ID 
    ) 
GO

ALTER TABLE Conservador ADD CONSTRAINT Conservador_PK PRIMARY KEY CLUSTERED (Codigo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Direccion 
    (
     Calle VARCHAR NOT NULL , 
     Numero INTEGER NOT NULL , 
     Piso CHAR NOT NULL , 
     Puerta CHAR NOT NULL , 
     Codigo_postal VARCHAR NOT NULL , 
     Poblacion VARCHAR NOT NULL , 
     Provincia VARCHAR NOT NULL , 
     Direccion_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Direccion ADD CONSTRAINT Direccion_PK PRIMARY KEY CLUSTERED (Direccion_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Estilo_pictorico 
    (
     Nombre VARCHAR NOT NULL , 
     Fecha_inicio DATE NOT NULL , 
     Fecha_fin DATE NOT NULL , 
     Conservador_Codigo CHAR NOT NULL , 
     Estilo_pictorico_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO 

    


CREATE UNIQUE NONCLUSTERED INDEX 
    Estilo_pictorico__IDX ON Estilo_pictorico 
    ( 
     Conservador_Codigo 
    ) 
GO

ALTER TABLE Estilo_pictorico ADD CONSTRAINT Estilo_pictorico_PK PRIMARY KEY CLUSTERED (Estilo_pictorico_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Exposicion_temporal 
    (
     Titulo VARCHAR NOT NULL , 
     Fecha_inicio DATE NOT NULL , 
     Fecha_fin DATE NOT NULL , 
     Conservador_Codigo CHAR NOT NULL , 
     Exposicion_temporal_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO 

    


CREATE UNIQUE NONCLUSTERED INDEX 
    Exposicion_temporal__IDX ON Exposicion_temporal 
    ( 
     Conservador_Codigo 
    ) 
GO

ALTER TABLE Exposicion_temporal ADD CONSTRAINT Exposicion_temporal_PK PRIMARY KEY CLUSTERED (Exposicion_temporal_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Obra 
    (
     Obra_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Titulo VARCHAR NOT NULL , 
     Fecha DATE NOT NULL , 
     Periocidad_restauracion VARCHAR NOT NULL , 
     Característica VARCHAR , 
     Pintor_Pintor_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Obra ADD CONSTRAINT Obra_PK PRIMARY KEY CLUSTERED (Obra_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Obra_de_coleccionista 
    (
     Obra_Obra_ID NUMERIC (28) NOT NULL , 
     Nombre_prestamista VARCHAR NOT NULL , 
     Apellido1 VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL , 
     Direccion_Direccion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Obra_de_coleccionista ADD CONSTRAINT Obra_de_coleccionista_PK PRIMARY KEY CLUSTERED (Obra_Obra_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Obra_de_institucion 
    (
     Obra_Obra_ID NUMERIC (28) NOT NULL , 
     Nombre_institucion VARCHAR NOT NULL , 
     Direccion_Direccion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Obra_de_institucion ADD CONSTRAINT Obra_de_institucion_PK PRIMARY KEY CLUSTERED (Obra_Obra_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Obra_propia 
    (
     Obra_Obra_ID NUMERIC (28) NOT NULL , 
     Sala_Num_sala INTEGER NOT NULL 
    )
GO

ALTER TABLE Obra_propia ADD CONSTRAINT Obra_propia_PK PRIMARY KEY CLUSTERED (Obra_Obra_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE "Obra-Expo_temporal" 
    (
     Exposicion_temporal_Exposicion_temporal_ID NUMERIC (28) NOT NULL , 
     Obra_Obra_ID NUMERIC (28) NOT NULL , 
     Fecha_entra_expo_temporal DATE NOT NULL , 
     "Fecha-sale_expo_temporal" DATE NOT NULL 
    )
GO

ALTER TABLE "Obra-Expo_temporal" ADD CONSTRAINT "Obra-Expo_temporal_PK" PRIMARY KEY CLUSTERED (Exposicion_temporal_Exposicion_temporal_ID, Obra_Obra_ID, Fecha_entra_expo_temporal)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Periodo_restauracion 
    (
     Restaurador_Codigo CHAR NOT NULL , 
     Fecha_inicio DATE NOT NULL , 
     Fecha_fin DATE NOT NULL , 
     Obra_Obra_ID NUMERIC (28) NOT NULL 
    )
GO

CREATE TABLE "Pinto-Estilo" 
    (
     Pintor_Pintor_ID NUMERIC (28) NOT NULL , 
     Estilo_pictorico_Estilo_pictorico_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE "Pinto-Estilo" ADD CONSTRAINT "Pinto-Estilo_PK" PRIMARY KEY CLUSTERED (Pintor_Pintor_ID, Estilo_pictorico_Estilo_pictorico_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Pintor 
    (
     Nombre_artistico DATE NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellido VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL , 
     Fecha_nacimiento DATE NOT NULL , 
     Fecha_fallecimiento DATE NOT NULL , 
     Nacionalidad VARCHAR NOT NULL , 
     Restaurador_Codigo CHAR NOT NULL , 
     Pintor_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Pintor ADD CONSTRAINT Pintor_PK PRIMARY KEY CLUSTERED (Pintor_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Planta 
    (
     Piso INTEGER NOT NULL 
    )
GO

ALTER TABLE Planta ADD CONSTRAINT Planta_PK PRIMARY KEY CLUSTERED (Piso)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Restaurador 
    (
     Codigo CHAR NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellido1 VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL 
    )
GO

ALTER TABLE Restaurador ADD CONSTRAINT Restaurador_PK PRIMARY KEY CLUSTERED (Codigo)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Sala 
    (
     Num_sala INTEGER NOT NULL , 
     Planta_Piso INTEGER NOT NULL , 
     Estilo_pictorico_Estilo_pictorico_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Sala ADD CONSTRAINT Sala_PK PRIMARY KEY CLUSTERED (Num_sala)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Telefono 
    (
     "Numero-telefono" VARCHAR NOT NULL , 
     Obra_de_institucion_Obra_Obra_ID NUMERIC (28) NOT NULL , 
     Obra_de_coleccionista_Obra_Obra_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Telefono ADD CONSTRAINT Telefono_PK PRIMARY KEY CLUSTERED ("Numero-telefono")
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Conservador 
    ADD CONSTRAINT Conservador_Estilo_pictorico_FK FOREIGN KEY 
    ( 
     Estilo_pictorico_Estilo_pictorico_ID
    ) 
    REFERENCES Estilo_pictorico 
    ( 
     Estilo_pictorico_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Conservador 
    ADD CONSTRAINT Conservador_Exposicion_temporal_FK FOREIGN KEY 
    ( 
     Exposicion_temporal_Exposicion_temporal_ID
    ) 
    REFERENCES Exposicion_temporal 
    ( 
     Exposicion_temporal_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Estilo_pictorico 
    ADD CONSTRAINT Estilo_pictorico_Conservador_FK FOREIGN KEY 
    ( 
     Conservador_Codigo
    ) 
    REFERENCES Conservador 
    ( 
     Codigo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Exposicion_temporal 
    ADD CONSTRAINT Exposicion_temporal_Conservador_FK FOREIGN KEY 
    ( 
     Conservador_Codigo
    ) 
    REFERENCES Conservador 
    ( 
     Codigo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Obra_de_coleccionista 
    ADD CONSTRAINT Obra_de_coleccionista_Direccion_FK FOREIGN KEY 
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

ALTER TABLE Obra_de_coleccionista 
    ADD CONSTRAINT Obra_de_coleccionista_Obra_FK FOREIGN KEY 
    ( 
     Obra_Obra_ID
    ) 
    REFERENCES Obra 
    ( 
     Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Obra_de_institucion 
    ADD CONSTRAINT Obra_de_institucion_Direccion_FK FOREIGN KEY 
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

ALTER TABLE Obra_de_institucion 
    ADD CONSTRAINT Obra_de_institucion_Obra_FK FOREIGN KEY 
    ( 
     Obra_Obra_ID
    ) 
    REFERENCES Obra 
    ( 
     Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Obra 
    ADD CONSTRAINT Obra_Pintor_FK FOREIGN KEY 
    ( 
     Pintor_Pintor_ID
    ) 
    REFERENCES Pintor 
    ( 
     Pintor_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Obra_propia 
    ADD CONSTRAINT Obra_propia_Obra_FK FOREIGN KEY 
    ( 
     Obra_Obra_ID
    ) 
    REFERENCES Obra 
    ( 
     Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Obra_propia 
    ADD CONSTRAINT Obra_propia_Sala_FK FOREIGN KEY 
    ( 
     Sala_Num_sala
    ) 
    REFERENCES Sala 
    ( 
     Num_sala 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Obra-Expo_temporal" 
    ADD CONSTRAINT "Obra-Expo_temporal_Exposicion_temporal_FK" FOREIGN KEY 
    ( 
     Exposicion_temporal_Exposicion_temporal_ID
    ) 
    REFERENCES Exposicion_temporal 
    ( 
     Exposicion_temporal_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Obra-Expo_temporal" 
    ADD CONSTRAINT "Obra-Expo_temporal_Obra_FK" FOREIGN KEY 
    ( 
     Obra_Obra_ID
    ) 
    REFERENCES Obra 
    ( 
     Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Periodo_restauracion 
    ADD CONSTRAINT Periodo_restauracion_Obra_FK FOREIGN KEY 
    ( 
     Obra_Obra_ID
    ) 
    REFERENCES Obra 
    ( 
     Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Periodo_restauracion 
    ADD CONSTRAINT Periodo_restauracion_Restaurador_FK FOREIGN KEY 
    ( 
     Restaurador_Codigo
    ) 
    REFERENCES Restaurador 
    ( 
     Codigo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Pinto-Estilo" 
    ADD CONSTRAINT "Pinto-Estilo_Estilo_pictorico_FK" FOREIGN KEY 
    ( 
     Estilo_pictorico_Estilo_pictorico_ID
    ) 
    REFERENCES Estilo_pictorico 
    ( 
     Estilo_pictorico_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Pinto-Estilo" 
    ADD CONSTRAINT "Pinto-Estilo_Pintor_FK" FOREIGN KEY 
    ( 
     Pintor_Pintor_ID
    ) 
    REFERENCES Pintor 
    ( 
     Pintor_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Pintor 
    ADD CONSTRAINT Pintor_Restaurador_FK FOREIGN KEY 
    ( 
     Restaurador_Codigo
    ) 
    REFERENCES Restaurador 
    ( 
     Codigo 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Sala 
    ADD CONSTRAINT Sala_Estilo_pictorico_FK FOREIGN KEY 
    ( 
     Estilo_pictorico_Estilo_pictorico_ID
    ) 
    REFERENCES Estilo_pictorico 
    ( 
     Estilo_pictorico_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Sala 
    ADD CONSTRAINT Sala_Planta_FK FOREIGN KEY 
    ( 
     Planta_Piso
    ) 
    REFERENCES Planta 
    ( 
     Piso 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Telefono 
    ADD CONSTRAINT Telefono_Obra_de_coleccionista_FK FOREIGN KEY 
    ( 
     Obra_de_coleccionista_Obra_Obra_ID
    ) 
    REFERENCES Obra_de_coleccionista 
    ( 
     Obra_Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Telefono 
    ADD CONSTRAINT Telefono_Obra_de_institucion_FK FOREIGN KEY 
    ( 
     Obra_de_institucion_Obra_Obra_ID
    ) 
    REFERENCES Obra_de_institucion 
    ( 
     Obra_Obra_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             4
-- ALTER TABLE                             37
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








