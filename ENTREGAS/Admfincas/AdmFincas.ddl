-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-13 19:07:24 CET
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
