---
layout: single
title: Instalar Instancia de SSMS (MICROSOFT SQL) En docker y conectarnos por visual Studio
excerpt: "Modelo Lógico Conceptual."
date: 2023-01-15
classes: wide
header:
  teaser: 
  teaser_home_page: true
  icon: 
categories:
  - Datamodeler
  - ssms
  - sql server
tags:
  - 
  - 
  - 
  - 
  - 
  - 
  - 
---




# Requisitos
* La imagen de Mssql requiere Docker Engine 1.8+ 

* Al menos 2 GB de RAM en la VM

* Requerimos los siguientes Parámetros 

-"ACCEPT_EULA=Y"

> Aceptamos la política "eula"


"MSSQL_SA_PASSWORD=<TuCoNtRaSeÑa_SeGuRa>"

> Introducimos la Contraseña que usaremos para el usuario SA

"MSSQL_PID=<your_product_id | edition_name> (default: Developer)"


# Parámetros de instalación

* MSSQL_PID  
Es la ID del producto (PID) o edición que el contenedor usará 
Existen diferentes opciones que podemos usar :

         -Developer : This will run the container using the Developer Edition (this is the default if no MSSQL_PID environment variable is supplied)
       - Express : This will run the container using the Express Edition
       - Standard : This will run the container using the Standard Edition
       - Enterprise : This will run the container using the Enterprise Edition
       - EnterpriseCore : This will run the container using the Enterprise Edition Core



---
## Comienzo de la instalación
-- Especificaciones del ubuntu que usaremos a modo de "server" para hostear el contenedor de Docker 

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/1.png">
</p>



### Comandos 

> docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=abc123." -p 1433:1433 -d mcr.microsoft.com/mssql/server:2019-CU14-ubuntu-20.04

    - Parametros
        -p Puertos que se van a abrir para permitir la comunicación , en este caso el puerto 1433 del contenedor se compartirá por el puerto 1433 del Server Ubuntu
    -d Especificamos el nombre de la imagen de docker en nuestro caso el mssql2019 para ubuntu 20.4

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/2.png">
</p>

En este caso debemos añadir sudo al comiendo del comando para pedir permiso de super usuario (super user do) ya que mi usuario scp no es el usuario root pero si se encuentra en el sudoers y puede ejecutar sudo .

El comando 
> sudo docker images

Nos muestra un listado de las imágenes descargadas que existen en nuestro sistema

--
Ejecutamos el contenedor 

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/3.png">
</p>

El comando
> Sudo docker ps 

Nos muestra un listado de los contenedores que están levantados (up) y nos aporta información adicional sobre el contenedor 

Ahora ya estaría funcionando nuestro servidor MSSQL dentro de un contenedor de docker (Asi de facil! )

---

A continuación vamos a conectarnos a la shell de mssql desde nuestro servidor de ubuntu con el siguiente comando 

> sudo docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>

En nuestro caso:

> sudo docker exec -it 0d5d2081dbb8 /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P abc123. 

Ponemos el ID de nuestro contenedor así como la contraseña de nuestro usuario SA, el comando usa el ejecutable dentro del contenedor "sqlcmd" y establece una conexión en localhost (dentro del contenedor) con el usuario SA y nuestra contraseña

Una vez dentro de la Query de mssql podemos usar TRANSACT-SQL para permitir el login en remoto para SA, lo más seguro sería crear roles de servidor y usuarios específicos pero por el momento vamos a saltarnos ese paso

```sql
ALTER LOGIN sa ENABLE;
GO
ALTER LOGIN sa WITH PASSWORD = '<enterStrongPasswordHere>';
GO

```

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/4.png">
</p>

Si todo salió bien vemos cómo podemos ingresar comandos en nuestro servidor mssql pero no de la manera más cómoda.

Vamos a conectarnos a nuestro servidor mssql desde otra máquina en la misma red usando el Visual Studio Code para ello necesitaremos instalar una extensión y saber la ip de nuestro servidor :

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/5.png">
</p>
Nos interesa la interfaz de red enp3s0 ya que la interfaz de docker sólo se usa para comunicarse entre los contenedores y además el puerto 1433 está "fowarded"


<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/6.png">
</p>

Nos debemos instalar esa extensión de visual estudio code para establecer una conexión con el servidor sql 

---

Podemos iniciar la conexión una vez instalada la extensión y escribiendo en la terminal >SQL:Add Conection 



<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/7.png">
</p>
Nos pedirá autenticar con SQL o AZURE, ya que permitimos el login con el usuario SA le decimos que nos autenticaremos cómo un usuario de SQL , introduciremos nuestra contraseña y un nombre para nuestro servidor, en mi caso SalvaDB.




<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/8.png">
</p>



# MSSQL FUNCIONANDO Y TRABAJANDO CON EL VISUAL STUDIO CODE 

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql2/9.png">
</p>