---Like % (wildcard)

USE AdmFincas
SELECT Nombre,Email
from Inquilinos
WHERE Email like '%example.com'


--- LIKE CON OR
USE AdmFincas
SELECT Nombre,Email
FROM Inquilinos
WHERE Email LIKE '%@gmail.com' 
OR Email LIKE '%@yahoo.es';
GO
---	(6 filas afectadas)



--LIKE  CON CORCHETES []

USE AdmFincas
SELECT Nombre,Telefono
FROM Inquilinos
WHERE telefono LIKE '555-[1-4]%'
GO
---(4 filas afectadas)



--- LIKE con Expresión "^"


USE AdmFincas
SELECT Nombre,Telefono
FROM Inquilinos
WHERE telefono LIKE '555-[^1-4]%'
GO
---(8 filas afectadas)


--- LIke con Expresión "_"

Podemos usar el guion bajo para indicar que no sabemos el caracter que ocupa en ese segmento

USE AdmFincas
SELECT Nombre,Telefono 
from Inquilinos
where Telefono like '555-5___'
GO