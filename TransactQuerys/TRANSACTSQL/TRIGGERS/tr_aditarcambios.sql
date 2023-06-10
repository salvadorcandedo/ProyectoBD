USE AdmFincas
CREATE OR ALTER TRIGGER Usuarios_AuditarCambios
ON Usuarios
AFTER UPDATE
AS
BEGIN
    UPDATE Usuarios
    SET UltimaModificacion = GETDATE()
    FROM Usuarios
    INNER JOIN inserted ON Usuarios.UsuarioID = inserted.UsuarioID;
END;