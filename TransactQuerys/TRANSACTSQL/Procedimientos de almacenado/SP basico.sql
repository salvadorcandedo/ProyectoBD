USE AdmFincas

GO

CREATE OR ALTER PROCEDURE ObtenerInquilinos
AS
BEGIN
    SELECT *
    FROM Inquilinos;
END;


EXEC ObtenerInquilinos
	
--(12 filas afectadas) 
	
--	Total execution time: 00:00:00.016