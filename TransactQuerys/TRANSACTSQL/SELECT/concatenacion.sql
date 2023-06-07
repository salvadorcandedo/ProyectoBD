USE AdmFincas
GO
SELECT Nombre + '||' + Email AS 'Información Inquilino'
FROM Inquilinos
GO



-- Otro con pubs 

USE pubs
Select fname + ' , ' +lname as [Nombre Completo]
From employee
Go 



--- ejemplo sin comillas
use AdmFincas
Select GastoID,Descripcion,CAST(Monto as VARCHAR(20)) + '50' 
AS Precio
From Gastos
Go