
USE AdmFincas
SELECT I.Nombre AS NombreInquilino, CA.ContratoID, CA.FechaInicio, CA.FechaFin
FROM Inquilinos I
LEFT JOIN ContratosAlquiler CA ON I.InquilinoID = CA.InquilinoID;