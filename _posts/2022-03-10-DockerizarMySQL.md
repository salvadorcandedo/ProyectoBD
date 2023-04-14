---
layout: single
title: Dockerizamos MySQL en Ubuntu y conectamos con interfaz Web
excerpt: "Proyecto Modelado y Administración Base de Datos "
date: 2023-03-10
classes: wide
header:
  teaser: /assets/images/htb-writeup-magic/magic_logo.png
  teaser_home_page: true
  icon: /assets/images/hackthebox.webp
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


- [Que son los contenedores?](#que-son-los-contenedores)
- [Instalar Docker](#instalar-docker)
  - [Install using the apt repository](#install-using-the-apt-repository)
    - [Update the apt package index and install packages to allow apt to use a repository over HTTPS:](#update-the-apt-package-index-and-install-packages-to-allow-apt-to-use-a-repository-over-https)
    - [Add Docker’s official GPG key:](#add-dockers-official-gpg-key)
    - [Use the following command to set up the repository:](#use-the-following-command-to-set-up-the-repository)
  - [Install Docker Engine](#install-docker-engine)
- [Crear Volumen para MySQL](#crear-volumen-para-mysql)
- [Dockerizar PhpMyAdmin para conectarse a la base de datos Mysql](#dockerizar-phpmyadmin-para-conectarse-a-la-base-de-datos-mysql)
- [Entrar en la Web de PhpMyadmin](#entrar-en-la-web-de-phpmyadmin)





## Introducción

Apuntes para configurar una instancia de MySQL en un contenedor de docker y conectarlo con una interfaz web (PhpMyadmin) dockerizada tambien

       
    







# Que son los contenedores?

Los contenedores son un software estandarizado que se usa para isolar aplicaciones de la propia maqina en si creando un entorno virtual dedicado.

Otra ventaja de Docker es que un desarrollador puede descargar y ejecutar cualquier aplicación en contenedor sin instalarla directamente en su máquina local. Docker ayuda a probar y ejecutar aplicaciones mientras mantiene su sistema operativo limpito y eficiente.





# Instalar Docker

> https://docs.docker.com/engine/install/

Seguiremos el tutorial para instalarlo en Ubuntu

## Install using the apt repository

Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.
Set up the repository

   
   
   
### Update the apt package index and install packages to allow apt to use a repository over HTTPS:
  
```bash
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg

```

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker1.png">
</p>


### Add Docker’s official GPG key:
```bash
 sudo install -m 0755 -d /etc/apt/keyrings

 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

 sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

### Use the following command to set up the repository:
```bash
 echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## Install Docker Engine
```bash
sudo apt update 
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```
Verify that the Docker Engine installation is successful by running the hello-world image:


```bash
 sudo docker run hello-world
```

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker1.png">
</p>
Docker esta ya instalado y corriendo en nuestra maquina ubuntu


# Crear Volumen para MySQL

The following command will create the volume in your local machine which you can connect with MySQL container later:
```bash
sudo docker volume create mysql-volume
```
Podemos hacerle un ls
```bash
scp@Ubuntu:~$ sudo docker volume ls
DRIVER    VOLUME NAME
local     mysql-volume
```

The following command will pull the MySQL server version 8.0.20 from the Docker registry and then instantiate a Docker container with the name “scp-mysql.” It will also attach the previously created volume “mysql-volume” with the Database and will expose the port 3306 so that you can reach the MySQL database outside the container, ademas le creara una contrasena para el root:
```bash
sudo docker run --name=scp-mysql -p3306:3306 -v mysql-volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=scp123 -e MYSQL_ROOT_HOST=% -d mysql/mysql-server:8.0.20
```
> add explciacion!!~~~~

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker3.png">
</p>

Con el comando Docker ps podremos ver informacion sobre el estado de nuestros contenedores como si se tratase de un "panel de control"

En nuestro caso nos aparece informacion sobre el contenedor que acabamos de crear asi como su nombre, la imagen que estamos usando el tiempo que lleva "Up" (Tiempo de ejecucion del programa) Puertos abiertos...
<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker4.png">
</p>

Con el siguiente comando podremos invocar una terminal de bash dentro de nuestro contenedor de docker y conectarlos a la base de mysql desde la terminal.

```
sudo docker exec -it (nombrecontainer) bash 

```

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker5.png">
</p>

 este paso es necesario ya que mysql no permite las conexiones desde fuera de la maquina local de primeras asi que realizaremos unas configuaciones para poder conectarnos desde nuestro ubuntu 

 <p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker6.png">
</p>

Para permitir las conexiones en remoto para el usuario que escojamos podemos usar el siguiente comando dentro de la query

```sql
mysql>update mysql.user set host = ‘%’ where user=’root’;
```
# Dockerizar PhpMyAdmin para conectarse a la base de datos Mysql

Creamos un nuevo volumen donde almacenaremos la instancia de phpmyadmin dokerizada 

```bash
scp@Ubuntu:~$ sudo docker volume create phpmyadmin-volume
phpmyadmin-volume
```
Usaremos el siguiente comando para 
* parametro --name
  >  --name scpphpmyadmin: especifica el nombre que se le dará al contenedor que se creará. En este caso, el nombre es scpphpmyadmin.

* parametro -v 
   > -v phpmyadmin-volume:/etc/phpmyadmin/config.user.inc.php
   
   se utiliza para montar un volumen en el contenedor. Se especifica el nombre del volumen (phpmyadmin-volume) y la ruta dentro del contenedor en la que se montará el volumen (/etc/phpmyadmin/config.user.inc.php).
* parametro --link
   >  --link scpmysql:db
    
    se utiliza para crear un enlace entre dos contenedores, de modo que el contenedor que estamos creando pueda acceder a un servicio que se ejecuta en otro contenedor. En este caso, se está creando un enlace entre el contenedor que estamos creando (scpphpmyadmin) y el contenedor llamado scpmysql. El enlace se establece con el nombre de host db, que será el nombre que se utilizará para acceder al servicio en el contenedor scpmysql.

* parametro -p
    > -p 82:80: 
    
    se utiliza para publicar un puerto del contenedor en el host. En este caso, se está publicando el puerto 80 del contenedor en el puerto 82 del host.
* parametro -d 
    > -d phpmyadmin/phpmyadmin 
    
    se utiliza para especificar la imagen de Docker que se utilizará para crear el contenedor. En este caso, se está utilizando la imagen phpmyadmin/phpmyadmin para crear el contenedor.

```bash
sudo docker run --name scpphpmyadmin -v phpmyadmin-volume:/etc/phpmyadmin/config.user.inc.php --link scpmysql:db -p 82:80 -d phpmyadmin/phpmyadmin
```

 <p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker7.png">
</p>

# Entrar en la Web de PhpMyadmin
Si ha salido todo bien en principio deberiamos poder acceder a la gui de phphmyadmin desde cualquier buscador direccionando al localhost en el puerto 82 en nuestro host de ubuntu.

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker8.png">
</p>

<p align="center">
<img src="/ProyectoBD/assets/images/Dockersql/docker9.png">
</p>

Desde aqui podemos administrar la base de datos de Mysql igual que podriamos hacer con el SqlManager de Windows.