layout: single
title: Creacion de la base de datos con SQL
excerpt: En este documento se redacta la creacion de la base de datos con el lenguaje de TRANSAC-SQL
date: 2023-01-23
classes: wide
header:
  teaser: /assets/images/htb-writeup-frolic/frolic_logo.png
categories:
  - SQL SERVER 2019
  - Windows
tags:  
  - metasploit
   
   
  - 
  - assets/images/htb-writeup-frolic/frolic_logo.png)



### summary

- PlaySMS is installed and vulnerable to a bug which we can exploit with Metasploit (needs to be authenticated)
- The credentials for PlaySMS are found in an encrypted zip file, which is encoded in Brainfuck, obfuscated in some random directory, then further obfuscated with Ook esoteric programming language
- The priv esc is a SUID binary which we can ROP with one_gadget (ASLR is disabled)

## Creacion base de datos 
Ayudándonos de la sentencia Create Database crearemos la base de datos para Administrador de Fincas.
```` sql
Use master
Go
Create Database AdmFincas
Go
````
Ejecuto la siguiente sentencia para consultar información sobre mi base de datos usando un procedimiento almacenado.
```` sql

sp_helpdb AdmFincas
Go
````
