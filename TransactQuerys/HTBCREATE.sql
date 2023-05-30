CREATE DATABASE HTB
// Tabla Maquinas
CREATE TABLE Machines (
    MachineID INT IDENTITY(1,1) PRIMARY KEY,
    MachineName NVARCHAR(50) NOT NULL,
    Description NVARCHAR(MAX),
    CONSTRAINT UQ_MachineName UNIQUE (MachineName)
);
// Tabla CVES 
CREATE TABLE CVEs (
    CVEID INT IDENTITY(1,1) PRIMARY KEY,
    MachineID INT,
    CVE NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_MachineID FOREIGN KEY (MachineID) REFERENCES Machines(MachineID)
);
//tabla OpenPorts
CREATE TABLE OpenPorts (
    PortID INT IDENTITY(1,1) PRIMARY KEY,
    MachineID INT,
    PortNumber INT,
    CONSTRAINT FK_OpenPorts_MachineID FOREIGN KEY (MachineID) REFERENCES Machines(MachineID)
);



// añadimos columna con ALTER TABLE 
ALTER TABLE Machines
ADD RootFlag NVARCHAR(MAX);

ALTER TABLE Machines
ADD UserFlag NVARCHAR(MAX);

-- Actualizar la User Flag de una máquina
UPDATE Machines
SET UserFlag = 'User Flag de la máquina 1'
WHERE MachineID = 1;

-- Actualizar la Root Flag de una máquina
UPDATE Machines
SET RootFlag = 'Root Flag de la máquina 1'
WHERE MachineID = 1;

-- Insertar una máquina
INSERT INTO Machines (MachineName, Description)
VALUES ('Nombre de la máquina 1', 'Descripción de la máquina 1');

-- Insertar un CVE para la máquina 1
INSERT INTO CVEs (MachineID, CVE)
VALUES (1, 'CVE-XXXX-XXXX');

-- Insertar otra máquina
INSERT INTO Machines (MachineName, Description)
VALUES ('Nombre de la máquina 2', 'Descripción de la máquina 2');

-- Insertar un CVE para la máquina 2
INSERT INTO CVEs (MachineID, CVE)
VALUES (2, 'CVE-YYYY-YYYY');

DROP TABLE IF EXISTS CVEs

-- Insertar los puertos abiertos para la máquina 1
INSERT INTO OpenPorts (MachineID, PortNumber)
VALUES
    (1, 80),
    (1, 22);



////

INSERT INTO Machines (MachineName, Description)
VALUES ('MonitorsTwo', 'Descripción de la máquina 1');

-- Insertar múltiples CVEs para la máquina 1
INSERT INTO CVEs (MachineID, CVE)
VALUES
    (1, 'CVE-2020-33033'),
    (1, 'CVE-2020-25706'),
    (1, 'CVE-2021-41091');

SELECT * FROM  CVEs

INSERT INTO CVEs (CVE)
VALUES
    ('CVE-2020-33033')

DELETE CVE FROM CVEs
WHERE MachineID is NULL
    
DELETE FROM CVEs
WHERE MachineID IS NULL;

UPDATE Machines
SET Description = 'ssh marcus:funkymonkey'
WHERE MachineID = 1;

SELECT * FROM OpenPorts

SELECT * FROM Machines

UPDATE Machines
Set UserFlag='bc9d1622539089c5f2164144a98ba06a'
WHERE MachineID = 1;

UPDATE Machines
SET UserFlag= 'bc9d1622539089c5f2164144a98ba06a'
WHERE MachineID = 1;


ALTER TABLE Machines
ADD Difficulty VARCHAR(10);


UPDATE Machines
SET Difficulty = 'Easy'
WHERE MachineID = 1;

UPDATE Machines
SET Difficulty = 'Medium'
WHERE MachineID = 2;

UPDATE Machines
SET Difficulty = 'Hard'
WHERE MachineID = 3;



INSERT INTO Machines (Dificulty),
VALUES ('easy'),
WHERE MachineName=('PC');

UPDATE Machines
SET Difficulty = 'easy'
WHERE MachineName = 'MonitorsTwo';

-- Obtener el ID de la máquina con nombre "PC"
DECLARE @MachineID INT;

SELECT @MachineID = MachineID
FROM Machines
WHERE MachineName = 'PC';
INSERT INTO Machines (MachineID, Difficulty)
VALUES (@MachineID, 'easy');

-- Habilitar IDENTITY_INSERT para la tabla Machines
SET IDENTITY_INSERT Machines ON;

-- Realizar la inserción con valor explícito en la columna de identidad
INSERT INTO Machines (MachineID, Difficulty)
VALUES (1, 'easy');

-- Deshabilitar IDENTITY_INSERT
SET IDENTITY_INSERT Machines OFF;
