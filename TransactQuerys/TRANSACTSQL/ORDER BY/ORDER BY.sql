-- Order by ascendiente
USE AdmFincas
SELECT FincaId, Monto
From Alquileres
Order by Monto
Go
-- Order by Descendiente
SELECT FincaId, Monto
From Alquileres
Order by Monto DESC
Go