-- Menor que

USE AdmFincas
GO
SELECT FincaID, Monto FROM alquileres
WHERE Monto < 1000.00

--- Mayor que 

USE AdmFincas
GO
SELECT FincaID, Monto FROM Alquileres
WHERE Monto > 1050.00
GO

-- Igual que
USE AdmFincas
GO
SELECT FincaID, Monto FROM Alquileres
WHERE FincaID = 1
GO
