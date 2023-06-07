USE AdmFincas
SELECT * FROM ContratosAlquiler
SELECT InquilinoID,ContratoID,FechaInicio
FROM ContratosAlquiler
WHERE FechaInicio BETWEEN '2023-01-1' and '2023-04-01'