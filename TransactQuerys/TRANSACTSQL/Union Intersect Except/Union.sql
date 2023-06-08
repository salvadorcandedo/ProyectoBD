
USE AdmFincas 
--- Duplico la tabla usuarios de mi pagina web de AdministracionFincas para realizar pruebas
SELECT * 
    INTO UsuariosDuplicado
    FROM Usuarios
GO
  
-- Modifico e inserto datos en la nueva tabla 
INSERT INTO UsuariosDuplicado (NombreUsuario, Contrasena, UltimaModificacion)
VALUES ('Manuel', '1234', GETDATE())
VALUES ('Administrator', 'Supersecurepassw0rd', GETDATE())
GO

UPDATE UsuariosDuplicado
SET NombreUsuario = 'Uriel'
WHERE UsuarioID = '2'
GO

-- Con union se nos suman a la tabla los campos diferentes en ambas tablas y nos lo devuelve como una única consulta

SELECT * FROM Usuarios
UNION 
SELECT * FROM UsuariosDuplicado

-- Con union ALL se nos muestran todos los datos de ambas tablas aunque estén duplicados
SELECT * FROM Usuarios
UNION ALL
SELECT * FROM UsuariosDuplicado


-- Intersect devuelve solo los campos comunes en ambas tablas 
Select * FROM Usuarios
INTERSECT
SELECT * FROM UsuariosDuplicado

-- Except nos muestra los campos distintos entre ambas tablas 
tablas
SELECT * FROM Usuarios
EXCEPT 
SELECT * FROM UsuariosDuplicado
