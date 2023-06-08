
USE AdmFincas
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
INNER JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;