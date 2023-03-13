-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-13 20:44:03 CET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE Cambio_tecnico 
    (
     Descripción VARCHAR NOT NULL , 
     Tipo_cambio NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Cambio_tecnico ADD CONSTRAINT Cambio_tecnico_PK PRIMARY KEY CLUSTERED (Tipo_cambio)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Color 
    (
     Nombre_color VARCHAR (20) NOT NULL , 
     Color_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Color ADD CONSTRAINT Color_PK PRIMARY KEY CLUSTERED (Color_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Dirección 
    (
     CodPostal VARCHAR NOT NULL , 
     Ciudad VARCHAR NOT NULL , 
     Numero VARCHAR NOT NULL , 
     Piso INTEGER NOT NULL , 
     Puerta INTEGER NOT NULL , 
     Propietario_DNI VARCHAR (9) NOT NULL 
    )
GO

CREATE TABLE Marca 
    (
     Nombre_marca VARCHAR (20) NOT NULL , 
     Marca_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Marca ADD CONSTRAINT Marca_PK PRIMARY KEY CLUSTERED (Marca_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Modelo 
    (
     Nombre_modelo VARCHAR (20) NOT NULL , 
     Modelo_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Marca_Marca_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Modelo ADD CONSTRAINT Modelo_PK PRIMARY KEY CLUSTERED (Modelo_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Movimiento 
    (
     Fecha DATE NOT NULL , 
     Cambio_tecnico_Tipo_cambio NUMERIC (28) NOT NULL , 
     Vehiculo_Matricula VARCHAR (7) NOT NULL 
    )
GO

CREATE TABLE Nacionalidad 
    (
     Nombre VARCHAR NOT NULL , 
     Nacionalidad_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Nacionalidad ADD CONSTRAINT Nacionalidad_PK PRIMARY KEY CLUSTERED (Nacionalidad_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Profesion 
    (
     Nombre_profesion VARCHAR (20) NOT NULL , 
     Profesion_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Profesion ADD CONSTRAINT Profesion_PK PRIMARY KEY CLUSTERED (Profesion_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Propietario 
    (
     DNI VARCHAR (9) NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellido VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL , 
     Nacionalidad_Nacionalidad_ID NUMERIC (28) NOT NULL , 
     Profesion_Profesion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Propietario ADD CONSTRAINT Propietario_PK PRIMARY KEY CLUSTERED (DNI)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Vehiculo 
    (
     Matricula VARCHAR (7) NOT NULL , 
     Año_fabricación DATE NOT NULL , 
     Serie_motor VARCHAR (23) NOT NULL , 
     Fecha_entrada_CCAA DATE NOT NULL , 
     Color_Color_ID NUMERIC (28) NOT NULL , 
     Modelo_Modelo_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Vehiculo ADD CONSTRAINT Vehiculo_PK PRIMARY KEY CLUSTERED (Matricula)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE Dirección 
    ADD CONSTRAINT Dirección_Propietario_FK FOREIGN KEY 
    ( 
     Propietario_DNI
    ) 
    REFERENCES Propietario 
    ( 
     DNI 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Modelo 
    ADD CONSTRAINT Modelo_Marca_FK FOREIGN KEY 
    ( 
     Marca_Marca_ID
    ) 
    REFERENCES Marca 
    ( 
     Marca_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Movimiento 
    ADD CONSTRAINT Movimiento_Cambio_tecnico_FK FOREIGN KEY 
    ( 
     Cambio_tecnico_Tipo_cambio
    ) 
    REFERENCES Cambio_tecnico 
    ( 
     Tipo_cambio 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Movimiento 
    ADD CONSTRAINT Movimiento_Vehiculo_FK FOREIGN KEY 
    ( 
     Vehiculo_Matricula
    ) 
    REFERENCES Vehiculo 
    ( 
     Matricula 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Propietario 
    ADD CONSTRAINT Propietario_Nacionalidad_FK FOREIGN KEY 
    ( 
     Nacionalidad_Nacionalidad_ID
    ) 
    REFERENCES Nacionalidad 
    ( 
     Nacionalidad_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Propietario 
    ADD CONSTRAINT Propietario_Profesion_FK FOREIGN KEY 
    ( 
     Profesion_Profesion_ID
    ) 
    REFERENCES Profesion 
    ( 
     Profesion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Vehiculo 
    ADD CONSTRAINT Vehiculo_Color_FK FOREIGN KEY 
    ( 
     Color_Color_ID
    ) 
    REFERENCES Color 
    ( 
     Color_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Vehiculo 
    ADD CONSTRAINT Vehiculo_Modelo_FK FOREIGN KEY 
    ( 
     Modelo_Modelo_ID
    ) 
    REFERENCES Modelo 
    ( 
     Modelo_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             0
-- ALTER TABLE                             16
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
