

-- OR
USE AdmFincas
GO
SELECT * FROM Inquilinos
WHERE Edad = 30 OR Edad = 33
GO

-- AND
USE AdmFincas
GO
SELECT * FROM Inquilinos
WHERE InquilinoID = 1 AND Direccion  = 'Avenida Libertad 789'
GO