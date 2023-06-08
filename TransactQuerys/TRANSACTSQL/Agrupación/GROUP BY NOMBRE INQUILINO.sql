USE ADMFincas
SELECT COUNT(AlquilerID) AS 'NUMERO DE FINCAS' , I.Nombre 
FROM ContratosAlquiler CA

INNER JOIN Inquilinos I ON CA.InquilinoID = I.InquilinoID
GROUP BY I.Nombre, CA.InquilinoID
GO


