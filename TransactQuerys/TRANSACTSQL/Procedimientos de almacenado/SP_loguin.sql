USE AdmFincas

CREATE OR ALTER PROCEDURE sp_loguin
    @NombreUsuario VARCHAR(50),
    @Password VARCHAR(50)
AS
BEGIN
   IF NOT EXISTS (SELECT * FROM Usuarios WHERE NombreUsuario = @NombreUsuario)
    BEGIN
        PRINT 'El usuario no existe';
        RETURN;
    END

    ELSE IF NOT EXISTS (SELECT * FROM Usuarios
							WHERE NombreUsuario = @NombreUsuario
								AND Contrasena = @Password)
    BEGIN
        PRINT 'La contraseña es incorrecta';
        RETURN;
    END
	 
    PRINT 'Buenas, ' + @NombreUsuario + ' Login successful';
END
GO


-- Prueba loguin correcto

EXEC sp_loguin @NombreUsuario=Pirata, @Password=YoSoyColaTuPegamento
-- Buenas, Pirata Login successful 
	
-- Prueba Password mala
EXEC sp_loguin @NombreUsuario=Pirata, @Password=1234
-- La contraseña es incorrecta 
-- 	
-- 	Total execution time: 00:00:00.004

EXEC sp_loguin @NombreUsuario=Marina, @Password=1234
--- El usuario no existe 
	
