Use AdmFincas
---crear tabla
DROP TABLE ActualizacionPrecios
CREATE TABLE ActualizacionPrecios (
    FincaID INT,
    PrecioNuevo DECIMAL(10, 2)
);
-- Insertar en tabla 
INSERT into ActualizacionPrecios(FincaID,PrecioNuevo)
VALUES (3, 1000.00)


-- MERGE

MERGE INTO Alquileres AS target
USING ActualizacionPrecios AS source
    ON target.FincaID = source.FincaID
WHEN MATCHED THEN
    UPDATE SET target.monto = source.PrecioNuevo , target.FincaID = source.FincaID
WHEN NOT MATCHED BY TARGET THEN
    INSERT (FincaID, Monto)
    VALUES (source.FincaID, source.Precionuevo);

SELECT FincaID, Monto from Alquileres
Where FincaID = 3;

