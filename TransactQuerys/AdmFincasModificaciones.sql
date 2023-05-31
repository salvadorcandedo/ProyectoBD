-- Crear la base de datos
CREATE DATABASE AdmFincas;
GO

-- Usar la base de datos recién creada
USE AdmFincas;
GO

-- Crear la tabla de fincas
CREATE TABLE Fincas (
    FincaID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(200),
    Propietario VARCHAR(100),
    -- Agrega más columnas según tus necesidades
);
GO

-- Crear la tabla de alquileres
CREATE TABLE Alquileres (
    AlquilerID INT PRIMARY KEY,
    FincaID INT,
    FechaInicio DATE,
    FechaFin DATE,
    Monto DECIMAL(10, 2),
    CONSTRAINT FK_Alquileres_Fincas FOREIGN KEY (FincaID) REFERENCES Fincas(FincaID)
);
GO

-- Agrega más tablas según los requisitos adicionales de tu negocio de administrador de fincas

-- Ejemplo adicional: Crear una tabla de clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    -- Agrega más columnas según tus necesidades
);
GO
-- Crear la tabla de inquilinos
CREATE TABLE Inquilinos (
    InquilinoID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Direccion VARCHAR(200),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    -- Agrega más columnas según tus necesidades
);
GO

-- Crear la tabla de contratos de alquiler
CREATE TABLE ContratosAlquiler (
    ContratoID INT PRIMARY KEY,
    AlquilerID INT,
    InquilinoID INT,
    FechaInicio DATE,
    FechaFin DATE,
    CONSTRAINT FK_ContratosAlquiler_Alquileres FOREIGN KEY (AlquilerID) REFERENCES Alquileres(AlquilerID),
    CONSTRAINT FK_ContratosAlquiler_Inquilinos FOREIGN KEY (InquilinoID) REFERENCES Inquilinos(InquilinoID)
);
GO

-- Crear la tabla de pagos
CREATE TABLE Pagos (
    PagoID INT PRIMARY KEY,
    ContratoID INT,
    FechaPago DATE,
    Monto DECIMAL(10, 2),
    CONSTRAINT FK_Pagos_ContratosAlquiler FOREIGN KEY (ContratoID) REFERENCES ContratosAlquiler(ContratoID)
);
GO

-- Crear la tabla de gastos
CREATE TABLE Gastos (
    GastoID INT PRIMARY KEY,
    Descripcion VARCHAR(200),
    FechaGasto DATE,
    Monto DECIMAL(10, 2),
    -- Agrega más columnas según tus necesidades
);
GO

-- Crear la tabla de facturas
CREATE TABLE Facturas (
    FacturaID INT PRIMARY KEY,
    ContratoID INT,
    FechaFactura DATE,
    MontoTotal DECIMAL(10, 2),
    -- Agrega más columnas según tus necesidades
    CONSTRAINT FK_Facturas_ContratosAlquiler FOREIGN KEY (ContratoID) REFERENCES ContratosAlquiler(ContratoID)
);
GO
-- Crear la tabla de pagos
CREATE TABLE Pagos (
    PagoID INT PRIMARY KEY,
    ContratoID INT,
    FechaPago DATE,
    Monto DECIMAL(10, 2),
    CONSTRAINT FK_Pagos_ContratosAlquiler FOREIGN KEY (ContratoID) REFERENCES ContratosAlquiler(ContratoID)
);
GO

-- Crear la tabla de gastos
CREATE TABLE Gastos (
    GastoID INT PRIMARY KEY,
    Descripcion VARCHAR(200),
    FechaGasto DATE,
    Monto DECIMAL(10, 2),
    -- Agrega más columnas según tus necesidades
);
GO

-- Crear la tabla de facturas
CREATE TABLE Facturas (
    FacturaID INT PRIMARY KEY,
    ContratoID INT,
    FechaFactura DATE,
    MontoTotal DECIMAL(10, 2),
    -- Agrega más columnas según tus necesidades
    CONSTRAINT FK_Facturas_ContratosAlquiler FOREIGN KEY (ContratoID) REFERENCES ContratosAlquiler(ContratoID)
);
GO

/// INSERTAR DATOS EN LA BASE DE DATOS 
select * from sys.tables
-- Insertar datos en la tabla Fincas
INSERT INTO Fincas (FincaID, Nombre, Direccion, Propietario)
VALUES
    (1, 'Finca 1', 'Calle Principal 123', 'Juan Pérez'),
    (2, 'Finca 2', 'Avenida Central 456', 'María López'),
    (3, 'Finca 3', 'Plaza Mayor 789', 'Pedro Gómez');
    INSERT INTO Fincas (FincaID, Nombre, Direccion, Propietario)
VALUES
    (4, 'Finca 4', 'Calle Secundaria 789', 'Luis García'),
    (5, 'Finca 5', 'Avenida del Parque 456', 'Ana Rodríguez'),
    (6, 'Finca 6', 'Paseo Marítimo 123', 'Carlos Martínez'),
    (7, 'Finca 7', 'Calle Mayor 987', 'Laura Torres'),
    (8, 'Finca 8', 'Avenida Libertad 654', 'Javier Ramírez'),
    (9, 'Finca 9', 'Plaza Central 321', 'Isabel Sánchez'),
    (10, 'Finca 10', 'Calle del Sol 555', 'Antonio Fernández'),
    (11, 'Finca 11', 'Avenida Principal 222', 'Carmen Navarro'),
    (12, 'Finca 12', 'Paseo de la Playa 999', 'Roberto Pérez');


    
-- Insertar datos en la tabla Alquileres
INSERT INTO Alquileres (AlquilerID, FincaID, FechaInicio, FechaFin, Monto)
VALUES
    (1, 1, '2023-01-01', '2023-12-31', 1000.00),
    (2, 2, '2023-02-01', '2023-07-31', 800.00),
    (3, 3, '2023-03-01', '2023-09-30', 1200.00);
    INSERT INTO Alquileres (AlquilerID, FincaID, FechaInicio, FechaFin, Monto)
VALUES
    (4, 4, '2023-04-01', '2023-10-31', 900.00),
    (5, 5, '2023-05-01', '2023-11-30', 1100.00),
    (6, 6, '2023-06-01', '2023-12-31', 1000.00),
    (7, 7, '2023-07-01', '2024-01-31', 950.00),
    (8, 8, '2023-08-01', '2024-02-29', 1050.00),
    (9, 9, '2023-09-01', '2024-03-31', 1150.00),
    (10, 10, '2023-10-01', '2024-04-30', 1000.00),
    (11, 11, '2023-11-01', '2024-05-31', 1200.00),
    (12, 12, '2023-12-01', '2024-06-30', 900.00);

    
-- Insertar datos en la tabla Inquilinos
INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES
    (1, 'Carlos Ramírez', 'Avenida Libertad 789', 'carlos@example.com', '555-1234'),
    (2, 'Ana Martínez', 'Calle Sol 456', 'ana@example.com', '555-5678'),
    (3, 'Luisa Torres', 'Paseo Marítimo 123', 'luisa@example.com', '555-9012');




SELECT * FROM ContratosAlquiler
SELECT * FROM Alquileres
Drop table Alquileres
ALTER TABLE alquiler
DROP CONSTRAINT    
SELECT OBJECT_NAME(object_id) AS , name AS ConstraintName
FROM sys.foreign_keys
WHERE referenced_object_id = OBJECT_ID('Alquileres');

TRUNCATE ContratosAlquiler
SELECT * FROM ContratosAlquiler
-- Insertar datos en la tabla ContratosAlquiler
Alter ContratosAlquiler (ContratoID, AlquilerID, InquilinoID, FechaInicio, FechaFin)
VALUES
    
    (4, 4, 4, '2023-04-01', '2023-10-31'),
    (5, 5, 6, '2023-05-01', '2023-11-30'),
    (6, 6, 6, '2023-06-01', '2023-12-31'),
    (7, 7, 7, '2023-07-01', '2023-12-31'),
    (8, 8, 8, '2023-08-01', '2023-12-31'),
    (9, 9, 6, '2023-09-01', '2023-12-31'),
    (10, 10, 10, '2023-10-01', '2023-12-31'),
    (11, 11, 12, '2023-11-01', '2023-12-31'),
    (12, 12, 12, '2023-12-01', '2023-12-31');


UPDATE ContratosAlquiler 
SET InquilinoID = 2
WHERE ContratoID = 8
-- Insertar datos en la tabla Pagos
INSERT INTO Pagos (PagoID, ContratoID, FechaPago, Monto)
VALUES
    (1, 1, '2023-01-05', 1000.00),
    (2, 2, '2023-02-10', 800.00),
    (3, 3, '2023-03-15', 1200.00);

-- Insertar datos en la tabla Gastos
INSERT INTO Gastos (GastoID, Descripcion, FechaGasto, Monto)
VALUES
    (1, 'Mantenimiento de jardín', '2023-01-15', 200.00),
    (2, 'Reparación de fontanería', '2023-02-20', 300.00),
    (3, 'Pintura de fachada', '2023-03-25', 400.00);

-- Insertar datos en la tabla Facturas
INSERT INTO Facturas (FacturaID, ContratoID, FechaFactura, MontoTotal)
VALUES
    (1, 1, '2023-01-31', 1200.00),
    (2, 2, '2023-02-28', 1000.00),
    (3, 3, '2023-03-31', 1500.00);
use AdmFincas
SELECT * FROM Alquileres
SELECT * FROM CLIENTES
SELECT * FROM gastos
SELECT * FROM Facturas
-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (ClienteID, Nombre, Email, Telefono)
VALUES
    (1, 'Laura Rodríguez', 'laura@example.com', '555-1111'),
    (2, 'Roberto Sánchez', 'roberto@example.com', '555-2222'),
    (3, 'María González', 'maria@example.com', '555-3333');

use AdmFincas
SELECT * FROM GASTOS

