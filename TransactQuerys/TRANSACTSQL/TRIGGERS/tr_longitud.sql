USE AdmFincas


CREATE OR ALTER TRIGGER tr_ValidarLongitudContrasena
ON Usuarios
AFTER UPDATE
AS
BEGIN
   IF UPDATE(Contrasena)
    BEGIN
        -- Verificar la longitud de la nueva contraseña
        IF (SELECT LEN(Contrasena) FROM inserted) < 8
        BEGIN
            RAISERROR('La nueva contraseña debe tener 8 o más caracteres.', 16, 1);
            ROLLBACK TRANSACTION; 
        END
    END
END;