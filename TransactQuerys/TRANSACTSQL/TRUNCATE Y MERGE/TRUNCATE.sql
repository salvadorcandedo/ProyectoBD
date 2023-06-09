Use AdmFincas
CREATE TABLE dbo.Prueba
(
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- primary key column
    Nombre [NVARCHAR](50),
    Apellido [NVARCHAR](50) 
    
);
GO
---Inserto Valores 
SELECT * FROM Prueba

INSERT INTO PRUEBA (Nombre, Apellido)
VALUES ('Salva', 'Candedo'),
       ('Andrea', 'Candedo');
---
SELECT count(*) [NUMERO DE PRUEBAS]FROM PRUEBA 
--NUMERO DE PRUEBAS 
--2
TRUNCATE TABLE Prueba
SELECT * FROM Prueba
-- Me lo muestra vacio pero la tabla sigue ahi
