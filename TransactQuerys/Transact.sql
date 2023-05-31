






-- Select desde pubs

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



---------------------------------------------
-------------------------Funciones del sistema 

Print original_login()

---- Timestamp	Message	
---- [8:47:51 PM]	Started executing query at Line 27
---- 	
---- 	sa 
---- 	
---- 	Total execution time: 00:00:00.002

select db_name()
Go

--- 	Started executing query at Line 35
--- 	
--- 	(1 fila afectada) 
	
--- 	Total execution time: 00:00:00.020

Print system_user
--- Started executing query at Line 45
	
--	sa

Print current_user
--- dbo 


----- CONCATENACION
SELECT * FROM employee
-- STRING VACIO
Select job_id + ' , ' +job_lvl as [Info del job]
From employee
Go

#### Error valor 
--- Msg 245, Level 16, State 1, Line 1
--- Conversion failed when converting the varchar value ' , ' to data type smallint.
El error se da por estás intentando concatenar una cadena de texto (' , ') 
con una columna de tipo smallint (job_lvl).


Select fname + ' , ' +lname as [Nombre Completo]
From employee
Go


-- Where

Select lname,fname
From employee
Where minit is null
Go
-- 	(0 filas afectadas)

-- Operador de igualdad 
--  Ver el nombre de usuario "Cruz"

Select lname,fname
From employee
Where lname= 'Cruz';
Go

---(1 fila afectada) 
-- 

 -- podemos hacer el contrario del comando,con la expresion "!"


Select lname,fname
From employee
Where lname != 'Cruz';
Go
--- (42 filas afectadas)


Select lname,fname
From employee
Where not lname= 'Cruz';
Go

---42 filas afectadas) 
---Total execution time: 00:00:00.022

SELECT * FROM employee
Select lname,fname,job_id
From employee
Where (job_id='13')
and lname= 'Cruz'
or fname = 'Paolo';
Go
---(1 fila afectada)

Use AdmFincas
Select Monto From Gastos
--- 200.00
--- 300.00
--- 400.00
--- 150.00
--- 500.00
--- 300.00
Select GastoID,Descripcion,Monto + 50 as Precio
From Gastos
Go
---200.00
---300.00
---400.00
---150.00
---500.00
---300.00


SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES


SELECT * FROM Inquilinos

Select InquilinoID,ContratoID,FechaInicio
FROM ContratosAlquiler
WHERE FechaInicio BETWEEN '2023-01-1' and '2023-04-01'
---	(3 filas afectadas) 
	
	

Select Direccion AS CallesDeInteres
From Fincas
Where Direccion in ('Avenida Central 456','Calle Principal 123')
Go
-- 	(2 filas afectadas)


Sacar los usuarios cuyo nombre empiece por A

select Nombre,Email
from Inquilinos
where Email like '%example.com'

Los nombres de los usuarios que empiecen por a,b,c,d

SELECT Nombre,Email
FROM Inquilinos
WHERE Email LIKE '%@gmail.com' OR Email LIKE '%@yahoo.es';
GO




Select * from Inquilinos

INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES (7, 'Carlos Ramírez', 'Avenida Libertad 789', 'carlos@yahoo.es', '555-1234');

INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES (8, 'Ana Martínez', 'Calle Sol 456', 'ana@gmail.com', '555-5678');

INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES (9, 'Luisa Torres', 'Paseo Marítimo 123', 'luisa@yahoo.es', '555-9012');

INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES (10, 'Sergio Ramos', 'Calle Mayor 987', 'sergio@gmail.com', '555-4444');

INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES (11, 'Ana López', 'Avenida del Sol 654', 'ana@yahoo.es', '555-5555');

INSERT INTO Inquilinos (InquilinoID, Nombre, Direccion, Email, Telefono)
VALUES (12, 'Pedro Jiménez', 'Paseo Marítimo 321', 'pedro@gmail.com', '555-6666');


SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES

SELECT Telefono,Nombre FROM Inquilinos


Select Nombre,Telefono
FROM Inquilinos
WHERE telefono LIKE '555-[^1-4]%'
GO
---(8 filas afectadas)






select Nombre,Telefono 
from Inquilinos
where Telefono like '555-5___'
GO
---(4 filas afectadas)

SELECT distinct nombre
From Inquilinos
Go


| nombre         |
|----------------|
| Ana López      |
| Ana Martínez   |
| Carlos Ramírez |
| Luisa Torres   |
| Pedro Jiménez  |
| Sergio Ramos   |


---	(	(6 filas afectadas)

Select * from Inquilinos



Select*
From Inquilinos
Order by Direccion
Go

Select GastoID,Descripcion,Monto from Gastos

Select GastoID,Descripcion,Monto + 100 as PrecioFinal
From Gastos
Order by  PrecioFinal
Go


### Ordenar por fecha fin por año,mes y día
SELECT * FROM sys.tables

SELECT * FROM Alquileres

Select FechaFin,
Datepart(year,FechaFin) as 'Año Final',
Datepart(month,FechaFin) as 'Mes Final',
Datepart(day,FechaFin) as 'Dia Final'
From Alquileres

Order By Datepart(year,FechaFin), Datepart(month,FechaFin), Datepart(day,FechaFin) desc
Go


Create or alter procedure fecha_FIN
As 
    Select FechaFin,
        Datepart(year,FechaFin) as 'Año Final',
        Datepart(month,FechaFin) as 'Mes Final',
        Datepart(day,FechaFin) as 'Dia Final'
    From Alquileres
    Order By Datepart(year,FechaFin), Datepart(month,FechaFin), Datepart(day,FechaFin) desc
Go
---Total execution time: 00:00:00.020

Execute fecha_FIN


Use AdmFincas
SELECT *
FROM sys.tables


Select InquilinoID from Inquilinos
order by InquilinoID
Offset 1 Rows fetch next 5 rows only
Go

select Max(monto) as COSTEMAXIMO
from Gastos




SELECT Descripcion, Monto AS COSTEMAXIMO 
FROM Gastos
WHERE Monto = (SELECT MAX(Monto) FROM Gastos) 

SELECT Descripcion, Monto AS COSTEMINIMO
FROM Gastos
WHERE Monto = (SELECT MIN(Monto) FROM Gastos) 

go


Select Count(*) as [Numero de Inquilinos]
From Inquilinos 
Go

SELECT * FROM Gastos
use AdmFincas


SELECT Monto FROM Gastos
SELECT AVG(Monto) AS MediaGastos FROM Gastos;


SELECT Monto,(SELECT AVG(Monto) FROM Gastos) AS MediaGastos,
FROM Gastos;

SELECT SUM(Monto) AS TotalGastos
FROM Gastos;

SELECT * from Inquilinos


SELECT Email, COUNT(*) AS TotalInquilinos
FROM Inquilinos
GROUP BY Email;


SELECT Email, COUNT(*) AS TotalInquilinos
FROM Inquilinos
GROUP BY Email
HAVING COUNT(*) > 1;

SELECT * FROM Pagos


SELECT Monto,SUM(Monto) as sumamonto 
FROM Pagos
group by ROLLUP (Monto) 

SELECT Monto, SUM(Monto) AS sumamonto
FROM Gastos
GROUP BY ROLLUP(Monto)
HAVING Monto IS NULL; 



SELECT Monto, Descripcion, SUM(Monto) AS sumamonto
FROM Gastos
GROUP BY GROUPING SETS ((Monto), (Descripcion), ());


SELECT * FROM Inquilinos
SELECT * FROM Clientes

SELECT  InquilinoID,Nombre FROM Inquilinos
UNION
SELECT  InquilinoID,FechaInicio FROM ContratosAlquiler


SELECT InquilinoID as ID, Nombre FROM Inquilinos
UNION
SELECT ClienteID, Nombre From Clientes


-- Primera consulta
SELECT EmpleadoID, Nombre
FROM Empleados
WHERE Departamento = 'Ventas'

INTERSECT

-- Segunda consulta
SELECT EmpleadoID, Nombre
FROM Empleados
WHERE Departamento = 'Marketing';

Except

Queremos saber que Nombres no están en la tabla Inquilinos

SELECT Nombre AS 'NombreNoestan'
	FROM Clientes
EXCEPT
SELECT Nombre
	FROM Inquilinos;

GROUP BY ClienteID

Use AdmFincas
SELECT *
From Inquilinos


DELETE FROM Inquilinos
WHERE InquilinoID NOT IN (
    SELECT MIN(InquilinoID)
    FROM Inquilinos
    GROUP BY Nombre
);

BACKUP DATABASE AdmFincas
TO DISK = 'AdmFincas.bak'
use master
DROP DATABASE AdmFincas

RESTORE DATABASE AdmFincas
FROM DISK = 'AdmFincas.bak'
WITH REPLACE;

DELETE t1
FROM Inquilinos t1
JOIN Inquilinos t2 ON t1.Nombre = t2.Nombre
WHERE t1.InquilinoID < t2.InquilinoID;

USE AdmFincas

--JOIN
SELECT CA.ContratoID, F.Nombre AS NombreFinca, I.Nombre AS NombreInquilino
FROM ContratosAlquiler CA
JOIN Alquileres A ON CA.AlquilerID = A.AlquilerID
JOIN Fincas F ON A.FincaID = F.FincaID
JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID;
SELECT * FROM ContratosAlquiler
SELECT * FROM Inquilinos
SELECT * FROM  Alquileres
SELECT * FROM Clientes

---Inner join


SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
INNER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;
--- VARIANTE con where




SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
INNER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;

WHERE I.Nombre like 'Car%'


---Left Outer Join

SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
LEFT OUTER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;


---Right outer Join

SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
RIGHT OUTER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.AlquilerID;


SELECT * FROM Inquilinos
SELECT * FROM ContratosAlquiler

--- OPERADORES DE relacion  =,!=,<,<=,>,>=
--- EXCEPT
SELECT InquilinoID  as [InquilinosSinContrato] FROM Inquilinos 
    EXCEPT
Select InquilinoID  FROM ContratosAlquiler 
--- InquilinosSinContrato
--- 5
--- 7
--- 8
SELECT I.InquilinoID, I.Nombre as [InquilinosSinContrato]
FROM Inquilinos I
WHERE I.InquilinoID IN (
    SELECT InquilinoID
    FROM Inquilinos
    EXCEPT
    SELECT InquilinoID
    FROM ContratosAlquiler
);





UPDATE ContratosAlquiler

SELECT * FROM Alquileres
SELECT * FROM Pagos
SELECT * FROM ContratosAlquiler
SELECT F.Nombre AS NombrePropiedad
FROM Fincas F, ContratosAlquiler CA
WHERE F.FincaID = CA.ContratoID
AND CA.FechaInicio > '2023-02-01';

SELECT FechaInicio     From ContratosAlquiler
SELECT GETDATE()


SELECT * FROM sys.tables

SELECT C.EMAIL as CorreoElectronico, C.Nombre, CA.FechaInicio,CA.FechaFin
FROM  Clientes C, ContratosAlquiler CA
WHERE C.ClienteID =  CA.InquilinoID


SELECT * FROM Facturas F
UNION
SELECT * FROM Pagos P
WHERE F.FacturaID = P.ContratoID


 
SELECT * FROM Clientes
Select * from Pagos
SELECT * FROM Facturas

SELECT * FROM Inquilinos
SELECT * FROM ContratosAlquiler


use AdmFincas


SELECT Nombre AS NombreInquilino
FROM Inquilinos
WHERE InquilinoID IN (SELECT InquilinoID FROM ContratosAlquiler WHERE FechaFin > GETDATE());

SELECT FechaFIn from ContratosAlquiler

Select * from Inquilinos
ALTER TABLE Inquilinos
ADD Edad INT;
UPDATE Inquilinos
SET Edad = 30
WHERE InquilinoID = 1;

UPDATE Inquilinos
SET Edad = 25
WHERE InquilinoID = 2;

UPDATE Inquilinos
SET Edad = 30
WHERE InquilinoID = 3;

UPDATE Inquilinos
SET Edad = 52
WHERE InquilinoID = 4;
UPDATE Inquilinos
SET Edad = 36
WHERE InquilinoID = 5;

UPDATE Inquilinos
SET Edad = 21
WHERE InquilinoID = 6;
UPDATE Inquilinos
SET Edad = 32
WHERE InquilinoID = 7;

UPDATE Inquilinos
SET Edad = 25
WHERE InquilinoID = 8;

select * from Inquilinos


UPDATE Inquilinos
SET Edad = Edad + 1
OUTPUT inserted.Nombre AS NombreInquilino
WHERE InquilinoID > 3;
-- hacer que inquilino id sea autoincremental

ALTER TABLE Inquilinos
ALTER COLUMN InquilinoID INT ;


CREATE TABLE Inquilinos_New (
    InquilinoID INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50),
    Direccion VARCHAR(100),
    Email VARCHAR(100),
    Telefono VARCHAR(20),
    Edad INT
);
INSERT INTO Inquilinos_New (Nombre, Direccion, Email, Telefono,Edad)
SELECT Nombre, Direccion, Email, Telefono,Edad
FROM Inquilinos;
DROP TABLE Inquilinos;

ALTER TABLE Inquilinos
CHECK CONSTRAINT NombreRestriccion;

EXEC sp_rename 'Inquilinos_New', 'Inquilinos';





UPDATE Inquilinos
SET Email = 'cerberus@gmail.com'
WHERE InquilinoID = 10;


INSERT INTO Inquilinos_New (Nombre, Direccion, Email)
OUTPUT inserted.InquilinoID
VALUES ('Diablito Pérez', 'Calle Principal 123', 'juan@yahoo.es');
GO

SELECT * FROM Inquilinos


-- Create a new table called 'TableName' in schema 'SchemaName'
-- Drop the table if it already exists
IF OBJECT_ID('SchemaName.TableName', 'U') IS NOT NULL
DROP TABLE SchemaName.TableName
GO
-- Create the table in the specified schema
CREATE TABLE dbo.Prueba
(
    ID INT IDENTITY(1,1) NOT NULL PRIMARY KEY, -- primary key column
    Nombre [NVARCHAR](50),
    Apellido [NVARCHAR](50) 
    
);
GO
SELECT * FROM Prueba

INSERT INTO PRUEBA (Nombre, Apellido)
VALUES ('Salva', 'Candedo'),
       ('Andrea', 'Candedo');
SELECT count(*) [NUMERO DE PRUEBAS]FROM PRUEBA 
--NUMERO DE PRUEBAS 
--2
TRUNCATE TABLE Prueba
SELECT * FROM Prueba
-- Me lo muestra vacio pero la tabla sigue ahi
Drop TABLE Prueba
SELECT * FROM Prueba
--Msg 208, Level 16, State 1, Line 1
--Invalid object name 'Prueba'.



--- ROLLBACK
BEGIN TRANSACTION;

UPDATE Propiedades
SET ValorAlquiler = ValorAlquiler * 1.1 -- Actualizar el valor de alquiler en todas las propiedades

IF @@ERROR <> 0
BEGIN
    ROLLBACK; -- Deshacer la transacción si ocurre un error
    PRINT 'Se produjo un error. La transacción se ha deshecho.';
END
ELSE
BEGIN
    COMMIT; -- Confirmar la transacción si no hay errores
    PRINT 'La transacción se ha confirmado correctamente.';
END





BEGIN 
    PRINT 'PRUEBA'
        IF @@ERROR !=1 
    PRINT ' Código de error: ' + CAST(@@ERROR AS VARCHAR(10));
END 

SELECT @@ERROR

-- ROLLBACk 

---Creo backup de la base de 
BACKUP DATABASE AdmFincas
TO DISK = 'AdmFincas.bak'
WITH FORMAT;


RESTORE DATABASE AdmFincas
FROM DISK = 'AdmFincas.bak'
WITH REPLACE;

CREATE OR ALTER PROCEDURE TruncateFincas
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        TRUNCATE TABLE Fincas;
        COMMIT;
        PRINT 'TRUNCATE realizado correctamente.';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'La transacción se ha deshecho.';
    END CATCH;
END;

EXEC TruncateFincas

SELECT * FROM Fincas
-- La tabla fincas sigue





-- Oricedimiento de almacenado con tablas temporales 




EXEC ObtenerInformeInquilinosAlquiler
CREATE OR ALTER PROCEDURE ObtenerInformeInquilinosAlquiler
AS
BEGIN
    
DECLARE @NombreInquilino NVARCHAR(50);
    DECLARE @DireccionInquilino NVARCHAR(100);
    DECLARE @FechaInicioContrato DATE;
    DECLARE @FechaFinContrato DATE;

    -- Tabla temporal 
    CREATE TABLE #InformeInquilinosAlquiler (
        NombreInquilino NVARCHAR(50),
        DireccionInquilino NVARCHAR(100),
        FechaInicioContrato DATE,
        FechaFinContrato DATE
    );

    -- Consigo los Inquilinos con Contratos de alquiler activos 
    INSERT INTO #InformeInquilinosAlquiler
    SELECT I.Nombre, I.Direccion, CA.FechaInicio, CA.FechaFin
    FROM Inquilinos I
    INNER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID
    WHERE CA.FechaInicio <= GETDATE() AND CA.FechaFin >= GETDATE();

    -- Recorrer los resultados y realizar operaciones adicionales si es necesario
    DECLARE @FilasContador INT = 1;
    DECLARE @TotalFilas INT = (SELECT COUNT(*) FROM #InformeInquilinosAlquiler);

    WHILE @FilasContador <= @TotalFilas
    BEGIN
        -- Obtener los datos de cada fila del informe
        SELECT @NombreInquilino = NombreInquilino,
               @DireccionInquilino = DireccionInquilino,
               @FechaInicioContrato = FechaInicioContrato,
               @FechaFinContrato = FechaFinContrato
        FROM (
            SELECT ROW_NUMBER() OVER AS FilaNum,
                   NombreInquilino,
                   DireccionInquilino,
                   FechaInicioContrato,
                   FechaFinContrato
            FROM #InformeInquilinosAlquiler
        ) AS Temp
        WHERE FilaNum = @FilasContador;

        -- Realizar operaciones adicionales con los datos obtenidos
        -- Por ejemplo, imprimir los datos en un formato específico
        PRINT 'Información del inquilino:';
        PRINT 'Nombre: ' + @NombreInquilino;
        PRINT 'Dirección: ' + @DireccionInquilino;
        PRINT 'Fecha de inicio del contrato: ' + CONVERT(NVARCHAR, @FechaInicioContrato, 103);
        PRINT 'Fecha de fin del contrato: ' + CONVERT(NVARCHAR, @FechaFinContrato, 103);
        PRINT '--------------------------------------';

        SET @FilasContador += 1;
END;


    -- Eliminar la tabla temporal
    DROP TABLE #InformeInquilinosAlquiler;
END;

SELECT * FROM #Informe


SELECT * FROM Fincas
--- Vistas 



SELECT Inquilino, DireccionFinca
FROM VistaContratosAlquiler;
SELECT * FROM ContratosAlquiler
SELECT * FROM Inquilinos
SELECT * FROM Fincas
SELECT * FROM ContratosAlquiler


CREATE OR ALTER VIEW VistaInquilinosConContratos
AS
SELECT I.InquilinoID, I.Nombre, COUNT(CA.ContratoID) AS CantidadContratos
FROM Inquilinos I
LEFT JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID
GROUP BY I.InquilinoID, I.Nombre;

SELECT * FROM VistaInquilinosConContratos



SELECT * FROM ContratosAlquiler
SELECT * FROM Facturas
SELECT * FROM Pagos
SELECT * FROM sys.tables
DROP TABLE Facturas

Exec sp_helptext VistaInquilinosConContratos










--- MERGE

---crear tabla
DROP TABLE ActualizacionPrecios
CREATE TABLE ActualizacionPrecios (
    FincaID INT,
    PrecioNuevo DECIMAL(10, 2)
);
-- Insertar
INSERT into ActualizacionPrecios(FincaID,PrecioNuevo)
VALUES (3, 1000.00)

SELECT FincaID,Monto FROM Alquileres

MERGE INTO Alquileres AS target
USING ActualizacionPrecios AS source
    ON target.FincaID = source.FincaID
WHEN MATCHED THEN
    UPDATE SET target.monto = source.PrecioNuevo
WHEN NOT MATCHED BY TARGET THEN
    INSERT (FincaID, Monto)
    VALUES (source.FincaID, source.Precionuevo);

Select * from Alquileres    


MERGE INTO Alquileres AS target
USING ActualizacionPrecios AS source
    ON target.FincaID = source.FincaID
WHEN MATCHED THEN
    UPDATE SET target.monto = source.PrecioNuevo, target.FincaId = source.FincaID
    WHEN NOT MATCHED  THEN
    INSERT (FincaID, Monto)
    VALUES (source.FincaID, source.Precionuevo);

Select * from ActualizacionPrecios






SELECT * FROM Alquileres
ROLLBACK
SELECT * FROM ActualizacionPrecios



Select * from Fincas

BEGIN TRANSACTION;

BEGIN TRY
    -- Actualizar el nombre de un propietario de una finca
    UPDATE Fincas
    SET Propietario = 'Ana Perez'
    WHERE FincaID = 1;

    -- Insertar un nuevo contrato de alquiler
    INSERT INTO ContratosAlquiler (AlquilerID,FechaInicio, FechaFin)
    VALUES (4, '2023-06-01', '2023-12-31');

    -- Confirmar la transacción
    
END TRY

BEGIN CATCH
    -- Deshacer la transacción en caso de error
    ROLLBACK;

    -- Imprimir un mensaje en caso de rollback
    PRINT 'Se produjo un error. Se ha realizado un rollback.';

    -- Lanzar el error
   
END CATCH;


---	Started executing query at Line 849
--- 	
--- 	(1 fila afectada) 
--- 	
--- 	(0 filas afectadas) 
--- 	
--- 	Se produjo un error. Se ha realizado un rollback. 
--- 	
--- 	Msg 515, Level 16, State 2, Line 10
--- Cannot insert the value NULL into column 'ContratoID', table 'AdmFincas.dbo.ContratosAlquiler'; column does not allow nulls. INSERT fails. 
--- 	
--- 	Total execution time: 00:00:00.008


SELECT sp.helpconstraint Fincas;


DROP TABLE Usuarios
-- Crear la tabla Usuarios
CREATE TABLE Usuarios (
    Nombre INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsuario VARCHAR(50),
    Contrasena VARCHAR(50),
    UltimaModificacion DATETIME
);

-- Insertar datos en la tabla Usuarios
INSERT INTO Usuarios (NombreUsuario, Contrasena, UltimaModificacion)
VALUES ('Pirata', 'YoSoyColaTuPegaMento', GETDATE()),
       ('Whom', 'helloWorld', GETDATE()),
       ('Paquita', 'Paquitasalas123', GETDATE());


SELECT * FROM Usuarios

CREATE TRIGGER Usuarios_AuditarCambios
ON Usuarios
AFTER UPDATE
AS
BEGIN
    UPDATE Usuarios
    SET UltimaModificacion = GETDATE()
    FROM Usuarios
    INNER JOIN inserted ON Usuarios.Nombre = inserted.Nombre;
END;

SELECT * FROM USUARIOS
UPDATE Usuarios
Set Contrasena = 'NuevaPassword'
WHERE Nombre= '3'



-- Drop 'ColumnName' from table 'TableName' in schema 'SchemaName'
ALTER TABLE Inquilinos
    DROP COLUMN Alquilado
GO

SELECT Alquilado FROM Alquileres

ALTER TABLE Alquileres
ADD alquilado VARCHAR(10);

UPDATE Alquileres
SET 




ALTER TABLE Alquileres
ADD alquilado VARCHAR(10);


SELECT * FROM ContratosAlquiler
 SELECT * FROM Inquilinos
SELECT * FROM Alquileres


CREATE OR ALTER PROCEDURE ActualizarEstadoAlquileres
AS
BEGIN
    UPDATE Alquileres
    SET Alquilado = CASE
        WHEN FechaFin >= GETDATE() THEN 'Alquilado'
        ELSE 'No alquilado'
        END;

    SELECT I.Nombre as 'No Alquilados'
    FROM Alquileres A
    INNER JOIN ContratosAlquiler CA ON A.AlquilerID = CA.AlquilerID
    INNER JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID
    WHERE A.Alquilado = 'No alquilado';
    
    SELECT I.Nombre as 'Alquilados'
    FROM Alquileres A
    INNER JOIN ContratosAlquiler CA ON A.AlquilerID = CA.AlquilerID
    INNER JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID
    WHERE A.Alquilado = 'Alquilado';
    


END;


EXEC ActualizarEstadoAlquileres

SELECT * FROM Alquileres
SELECT * FROM ContratosAlquiler
SELECT * FROM Inquilinos

ALTER TABLE Alquileres ALTER COLUMN alquilado VARCHAR(20);


UPDATE Alquileres
SET FechaFin = '2023-3-27'
WHERE AlquilerID = 1;

SELECT * FROM ContratosAlquiler



SELECT * FROM usuarios

CREATE TRIGGER tr_Contrasena
BEFORE INSERT ON AdmFincas.Usuarios
FOR EACH ROW
BEGIN




CREATE TRIGGER tr_ContrasenaLarga
ON usuarios
AFTER INSERT
AS
BEGIN
    -- Lógica a realizar después de la inserción
    -- Puede incluir validaciones, cálculos u otras operaciones

    -- Ejemplo: Verificar la complejidad de la contraseña después de la inserción
    IF EXISTS (SELECT 1 FROM inserted WHERE LEN(Contrasena) < 8)
    BEGIN
        RAISERROR ('La contraseña debe tener al menos 8 caracteres', 16, 1);
        ROLLBACK;
    END;
END;

SELECT * from usuarios

INSERT INTO Usuarios (NombreUsuario, Contrasena)
VALUES ('Link', '12345678');

-- Msg 50000, Level 16, State 1, Procedure tr_ContrasenaLarga, Line 12
-- La contraseña debe tener al menos 8 caracteres 
-- 	
-- 	Msg 3609, Level 16, State 1, Line 1
-- The transaction ended in the trigger. The batch has been aborted.


SHOW TRIGGERS 
FROM AdmFincas;

USE AdmFincas;
GO

SELECT name AS TriggerName, OBJECT_NAME(parent_id) AS TableName, create_date AS CreatedDate
FROM sys.triggers
WHERE parent_class = 1;

SELECT * FROM Sys.triggers
SELECT * FROM sys.procedures
EXEC 


Drop proc if exists sp_Loguin
Go

CREATE OR ALTER PROCEDURE sp_loguin
    @NombreUsuario VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
   
	IF NOT EXISTS (SELECT * FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
    BEGIN
        PRINT 'Error: El usuario no existe';
        RETURN;
    END

    ELSE IF NOT EXISTS (SELECT * FROM Usuarios
							WHERE NombreUsuario = @NombreUsuario
								AND Contrasena = @Password)
    BEGIN
        PRINT 'La contraseña es incorrecta';
        RETURN;
    END
	 
	DECLARE @ID_DELUsuario INT;

    SELECT @ID_DELUsuario = UsuarioID
    FROM Usuarios
    WHERE Nombreusuario = @NombreUsuario;

    PRINT 'Buenas, Tu ID es: ' + CAST(@ID_DELUsuario AS VARCHAR(1));

end
GO


select * from usuarios

Exec sp_Loguin @NombreUsuario ='Pirata' , @password='YoSoyColaTuPegamento'
Go
-- Buenas, Tu ID es: 1 
	


Exec sp_Loguin @NombreUsuario='2' , @password ='12345'
Go
--La contraseña es incorrecta

Exec sp_Loguin @NombreUsuario='55' , @password ='Who?'
Go
--Error: El usuario no existe


Exec sp_Loguin @NombreUsuario ='Pirata' , @password='YoSoyColaTuPegamento'
Go
-- Buenas, Tu ID es: 1
Exec sp_Loguin @NombreUsuario='2' , @password ='12345'
Go
--Error: El usuario no existe 
	
Exec sp_Loguin @NombreUsuario='Pirata' , @password ='1234'
Go
--	La contraseña es incorrecta