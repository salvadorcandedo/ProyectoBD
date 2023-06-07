USE AdmFincas
GO
SELECT Nombre + '||' + Email AS 'Informacion Inquilino'
FROM Inquilinos
GO


USE pubs
SELECT fname + ' , ' +lname AS [Nombre Completo]
From employee
Go 