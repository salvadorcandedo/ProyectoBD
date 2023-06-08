USE ADMFincas
SELECT COUNT(AlquilerID) AS 'NUMERO DE FINCAS' , InquilinoID
FROM ContratosAlquiler 
GROUP BY InquilinoID
HAVING Count(AlquilerID) > 1
GO


