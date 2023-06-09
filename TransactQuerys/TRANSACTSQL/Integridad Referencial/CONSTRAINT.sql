USE AdmFincas
SELECT * FROM Fincas

-- CREO LA TABLA ENCARGADOS CON CONSTRAINT Y CLAVE FORANEA DE LA TABLA FINCAS
CREATE TABLE Encargados (
    ID_Encargado INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(30),
    FincaID INT,
   CONSTRAINT FK_REFERENCIADA_FincaID FOREIGN KEY (FincaID) REFERENCES Fincas(FincaID)
);


-- INSERTO DATOS EN LA TABLA ENCARGADOS
INSERT INTO Encargados (Nombre, FincaID)
VALUES ('Roberto Carlos', 1),
         ('Elena Pazos', 1);


SELECT * FROM Encargados

--INTENTO DE HACERLE UN DROP A LA TABLA PADRE (FINCAS)

DROP TABLE Fincas
--	Msg 3726, Level 16, State 1, Line 2
--- Could not drop object 'Fincas' because it is referenced by a FOREIGN KEY constraint.

--- Quitamos el constraint
ALTER TABLE Encargados
DROP CONSTRAINT FK_REFERENCIADA_FincaID;
GO
--	Los comandos se han completado correctamente. 
	
--	Total execution time: 00:00:00.052

## Ahora podemos hacerle un drop a fincas

DROP TABLE Fincas