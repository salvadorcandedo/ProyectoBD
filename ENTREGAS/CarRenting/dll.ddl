-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-03-12 19:39:20 CET
--   sitio:      SQL Server 2012
--   tipo:      SQL Server 2012



CREATE TABLE ALQUILER 
    (
     CodigoAlquiler INTEGER NOT NULL , 
     FechaInicio DATE NOT NULL , 
     Observaciones VARCHAR , 
     VEHICULO_Matrícula VARCHAR NOT NULL , 
     PAGO_CodigoPago VARCHAR NOT NULL , 
     Ubicacion_Ubicacion_ID NUMERIC (28) NOT NULL , 
     COMBUSTIBLE_COMBUSTIBLE_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE ALQUILER ADD CONSTRAINT ALQUILER_PK PRIMARY KEY CLUSTERED (CodigoAlquiler)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE CATEGORIA 
    (
     Nombre CHAR NOT NULL , 
     CATEGORIA_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE CATEGORIA ADD CONSTRAINT CATEGORIA_PK PRIMARY KEY CLUSTERED (CATEGORIA_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE CLIENTE 
    (
     DNI NUMERIC (8) NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Apellidos VARCHAR NOT NULL , 
     Telefono NUMERIC (12) NOT NULL , 
     ALQUILER_CodigoAlquiler INTEGER NOT NULL , 
     Direccion VARCHAR NOT NULL , 
     LicenciaConducir VARCHAR NOT NULL 
    )
GO

ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_PK PRIMARY KEY CLUSTERED (DNI)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE COMBUSTIBLE 
    (
     COMBUSTIBLE_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     Nombre VARCHAR NOT NULL 
    )
GO

ALTER TABLE COMBUSTIBLE ADD CONSTRAINT COMBUSTIBLE_PK PRIMARY KEY CLUSTERED (COMBUSTIBLE_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Diesel 
    (
     COMBUSTIBLE_COMBUSTIBLE_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Diesel ADD CONSTRAINT Diesel_PK PRIMARY KEY CLUSTERED (COMBUSTIBLE_COMBUSTIBLE_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE EQUIPAMIENTO 
    (
     Nombre VARCHAR NOT NULL , 
     Codigo_equipamiento CHAR NOT NULL , 
     Ubicacion_Ubicacion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE EQUIPAMIENTO ADD CONSTRAINT EQUIPAMIENTO_PK PRIMARY KEY CLUSTERED (Codigo_equipamiento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE "equipamiento-coche" 
    (
     EQUIPAMIENTO_Codigo_equipamiento CHAR NOT NULL , 
     VEHICULO_Matrícula VARCHAR NOT NULL 
    )
GO

ALTER TABLE "equipamiento-coche" ADD CONSTRAINT Relation_3_PK PRIMARY KEY CLUSTERED (EQUIPAMIENTO_Codigo_equipamiento, VEHICULO_Matrícula)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE "Equipamiento-reservas" 
    (
     EQUIPAMIENTO_Codigo_equipamiento CHAR NOT NULL , 
     RESERVA_RESERVA_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE "Equipamiento-reservas" ADD CONSTRAINT Relation_18_PK PRIMARY KEY CLUSTERED (EQUIPAMIENTO_Codigo_equipamiento, RESERVA_RESERVA_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE FACTURA 
    (
     IVA VARCHAR NOT NULL , 
     Descuento VARCHAR (32) NOT NULL , 
     Total_alquiler_equipamiento MONEY NOT NULL , 
     Total_coste_seguro MONEY NOT NULL , 
     Impuesto MONEY , 
     Importe_total_a_pagar MONEY NOT NULL , 
     Importe_neto_a_pagar MONEY NOT NULL , 
     ALQUILER_CodigoAlquiler INTEGER NOT NULL 
    )
GO

CREATE TABLE Franquicia 
    (
     CódigoSeguro INTEGER NOT NULL 
    )
GO

ALTER TABLE Franquicia ADD CONSTRAINT Franquicia_PK PRIMARY KEY CLUSTERED (CódigoSeguro)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Gasolina 
    (
     COMBUSTIBLE_COMBUSTIBLE_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE Gasolina ADD CONSTRAINT Gasolina_PK PRIMARY KEY CLUSTERED (COMBUSTIBLE_COMBUSTIBLE_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE GPS 
    (
     Codigo_equipamiento CHAR NOT NULL 
    )
GO

ALTER TABLE GPS ADD CONSTRAINT GPS_PK PRIMARY KEY CLUSTERED (Codigo_equipamiento)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE PAGO 
    (
     CodigoPago VARCHAR NOT NULL , 
     Pago VARCHAR NOT NULL 
    )
GO

ALTER TABLE PAGO ADD CONSTRAINT PAGO_PK PRIMARY KEY CLUSTERED (CodigoPago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE paypal 
    (
     CodigoPago VARCHAR NOT NULL 
    )
GO

ALTER TABLE paypal ADD CONSTRAINT paypal_PK PRIMARY KEY CLUSTERED (CodigoPago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO
ALTER TABLE paypal ADD CONSTRAINT paypal_PKv1 UNIQUE NONCLUSTERED (CodigoPago)
GO

CREATE TABLE Personal 
    (
     CódigoSeguro INTEGER NOT NULL 
    )
GO

ALTER TABLE Personal ADD CONSTRAINT Personal_PK PRIMARY KEY CLUSTERED (CódigoSeguro)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE RESERVA 
    (
     CLIENTE_DNI NUMERIC (8) NOT NULL , 
     Fecha_reserva DATE NOT NULL , 
     RESERVA_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION , 
     CATEGORIA_CATEGORIA_ID NUMERIC (28) NOT NULL , 
     Ubicacion_Ubicacion_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE RESERVA ADD CONSTRAINT RESERVA_PK PRIMARY KEY CLUSTERED (RESERVA_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE SEGURO 
    (
     CódigoSeguro INTEGER NOT NULL , 
     Tipo VARCHAR , 
     ALQUILER_CodigoAlquiler INTEGER NOT NULL 
    )
GO

ALTER TABLE SEGURO ADD CONSTRAINT SEGURO_PK PRIMARY KEY CLUSTERED (CódigoSeguro)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Tarjeta_crédito 
    (
     CodigoPago VARCHAR NOT NULL , 
     Nombre VARCHAR NOT NULL , 
     Nombre2 VARCHAR , 
     Apellido1 VARCHAR NOT NULL , 
     Apellido2 VARCHAR NOT NULL , 
     TarjetaNum VARCHAR NOT NULL , 
     FechaLimite DATE NOT NULL , 
     cvv VARCHAR NOT NULL 
    )
GO

ALTER TABLE Tarjeta_crédito ADD CONSTRAINT Tarjeta_crédito_PK PRIMARY KEY CLUSTERED (CodigoPago)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE Ubicacion 
    (
     Calle VARCHAR NOT NULL , 
     latitud VARCHAR NOT NULL , 
     longitud VARCHAR NOT NULL , 
     Ubicacion_ID NUMERIC (28) NOT NULL IDENTITY NOT FOR REPLICATION 
    )
GO

ALTER TABLE Ubicacion ADD CONSTRAINT Ubicacion_PK PRIMARY KEY CLUSTERED (Ubicacion_ID)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

CREATE TABLE VEHICULO 
    (
     Matrícula VARCHAR NOT NULL , 
     Marca CHAR , 
     Modelo VARCHAR , 
     Ubicacion_Ubicacion_ID NUMERIC (28) NOT NULL , 
     CATEGORIA_CATEGORIA_ID NUMERIC (28) NOT NULL 
    )
GO

ALTER TABLE VEHICULO ADD CONSTRAINT VEHICULO_PK PRIMARY KEY CLUSTERED (Matrícula)
     WITH (
     ALLOW_PAGE_LOCKS = ON , 
     ALLOW_ROW_LOCKS = ON )
GO

ALTER TABLE ALQUILER 
    ADD CONSTRAINT ALQUILER_COMBUSTIBLE_FK FOREIGN KEY 
    ( 
     COMBUSTIBLE_COMBUSTIBLE_ID
    ) 
    REFERENCES COMBUSTIBLE 
    ( 
     COMBUSTIBLE_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE ALQUILER 
    ADD CONSTRAINT ALQUILER_PAGO_FK FOREIGN KEY 
    ( 
     PAGO_CodigoPago
    ) 
    REFERENCES PAGO 
    ( 
     CodigoPago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE ALQUILER 
    ADD CONSTRAINT ALQUILER_Ubicacion_FK FOREIGN KEY 
    ( 
     Ubicacion_Ubicacion_ID
    ) 
    REFERENCES Ubicacion 
    ( 
     Ubicacion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE ALQUILER 
    ADD CONSTRAINT ALQUILER_VEHICULO_FK FOREIGN KEY 
    ( 
     VEHICULO_Matrícula
    ) 
    REFERENCES VEHICULO 
    ( 
     Matrícula 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE CLIENTE 
    ADD CONSTRAINT CLIENTE_ALQUILER_FK FOREIGN KEY 
    ( 
     ALQUILER_CodigoAlquiler
    ) 
    REFERENCES ALQUILER 
    ( 
     CodigoAlquiler 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Diesel 
    ADD CONSTRAINT Diesel_COMBUSTIBLE_FK FOREIGN KEY 
    ( 
     COMBUSTIBLE_COMBUSTIBLE_ID
    ) 
    REFERENCES COMBUSTIBLE 
    ( 
     COMBUSTIBLE_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE EQUIPAMIENTO 
    ADD CONSTRAINT EQUIPAMIENTO_Ubicacion_FK FOREIGN KEY 
    ( 
     Ubicacion_Ubicacion_ID
    ) 
    REFERENCES Ubicacion 
    ( 
     Ubicacion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE FACTURA 
    ADD CONSTRAINT FACTURA_ALQUILER_FK FOREIGN KEY 
    ( 
     ALQUILER_CodigoAlquiler
    ) 
    REFERENCES ALQUILER 
    ( 
     CodigoAlquiler 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Franquicia 
    ADD CONSTRAINT Franquicia_SEGURO_FK FOREIGN KEY 
    ( 
     CódigoSeguro
    ) 
    REFERENCES SEGURO 
    ( 
     CódigoSeguro 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Gasolina 
    ADD CONSTRAINT Gasolina_COMBUSTIBLE_FK FOREIGN KEY 
    ( 
     COMBUSTIBLE_COMBUSTIBLE_ID
    ) 
    REFERENCES COMBUSTIBLE 
    ( 
     COMBUSTIBLE_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE GPS 
    ADD CONSTRAINT GPS_EQUIPAMIENTO_FK FOREIGN KEY 
    ( 
     Codigo_equipamiento
    ) 
    REFERENCES EQUIPAMIENTO 
    ( 
     Codigo_equipamiento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE paypal 
    ADD CONSTRAINT paypal_PAGO_FK FOREIGN KEY 
    ( 
     CodigoPago
    ) 
    REFERENCES PAGO 
    ( 
     CodigoPago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Personal 
    ADD CONSTRAINT Personal_SEGURO_FK FOREIGN KEY 
    ( 
     CódigoSeguro
    ) 
    REFERENCES SEGURO 
    ( 
     CódigoSeguro 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Equipamiento-reservas" 
    ADD CONSTRAINT Relation_18_EQUIPAMIENTO_FK FOREIGN KEY 
    ( 
     EQUIPAMIENTO_Codigo_equipamiento
    ) 
    REFERENCES EQUIPAMIENTO 
    ( 
     Codigo_equipamiento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "Equipamiento-reservas" 
    ADD CONSTRAINT Relation_18_RESERVA_FK FOREIGN KEY 
    ( 
     RESERVA_RESERVA_ID
    ) 
    REFERENCES RESERVA 
    ( 
     RESERVA_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "equipamiento-coche" 
    ADD CONSTRAINT Relation_3_EQUIPAMIENTO_FK FOREIGN KEY 
    ( 
     EQUIPAMIENTO_Codigo_equipamiento
    ) 
    REFERENCES EQUIPAMIENTO 
    ( 
     Codigo_equipamiento 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE "equipamiento-coche" 
    ADD CONSTRAINT Relation_3_VEHICULO_FK FOREIGN KEY 
    ( 
     VEHICULO_Matrícula
    ) 
    REFERENCES VEHICULO 
    ( 
     Matrícula 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE RESERVA 
    ADD CONSTRAINT RESERVA_CATEGORIA_FK FOREIGN KEY 
    ( 
     CATEGORIA_CATEGORIA_ID
    ) 
    REFERENCES CATEGORIA 
    ( 
     CATEGORIA_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE RESERVA 
    ADD CONSTRAINT RESERVA_CLIENTE_FK FOREIGN KEY 
    ( 
     CLIENTE_DNI
    ) 
    REFERENCES CLIENTE 
    ( 
     DNI 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE RESERVA 
    ADD CONSTRAINT RESERVA_Ubicacion_FK FOREIGN KEY 
    ( 
     Ubicacion_Ubicacion_ID
    ) 
    REFERENCES Ubicacion 
    ( 
     Ubicacion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE SEGURO 
    ADD CONSTRAINT SEGURO_ALQUILER_FK FOREIGN KEY 
    ( 
     ALQUILER_CodigoAlquiler
    ) 
    REFERENCES ALQUILER 
    ( 
     CodigoAlquiler 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE Tarjeta_crédito 
    ADD CONSTRAINT Tarjeta_crédito_PAGO_FK FOREIGN KEY 
    ( 
     CodigoPago
    ) 
    REFERENCES PAGO 
    ( 
     CodigoPago 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE VEHICULO 
    ADD CONSTRAINT VEHICULO_CATEGORIA_FK FOREIGN KEY 
    ( 
     CATEGORIA_CATEGORIA_ID
    ) 
    REFERENCES CATEGORIA 
    ( 
     CATEGORIA_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO

ALTER TABLE VEHICULO 
    ADD CONSTRAINT VEHICULO_Ubicacion_FK FOREIGN KEY 
    ( 
     Ubicacion_Ubicacion_ID
    ) 
    REFERENCES Ubicacion 
    ( 
     Ubicacion_ID 
    ) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION 
GO



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            20
-- CREATE INDEX                             0
-- ALTER TABLE                             44
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
