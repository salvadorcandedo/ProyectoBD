# Modelo de base de datos lógico-relacional para un Administrador de fincas

## Introducción

El objetivo de este proyecto es diseñar un modelo de base de datos lógico-relacional para un Administrador de fincas. Este modelo permitirá gestionar los distintos aspectos relacionados con la administración de fincas, como los propietarios, las viviendas, los inquilinos, los contratos, los gastos y los servicios.






- [Modelo de base de datos lógico-relacional para un Administrador de fincas](#modelo-de-base-de-datos-lógico-relacional-para-un-administrador-de-fincas)
  - [Introducción](#introducción)
    - [Propietario](#propietario)
    - [Vivienda](#vivienda)
    - [Inquilino](#inquilino)
    - [Contrato](#contrato)
    - [Gasto](#gasto)
    - [Servicio](#servicio)
  - [Relaciones](#relaciones)
  - [Atributos](#atributos)
    - [Propietario](#propietario-1)
    - [Vivienda](#vivienda-1)
    - [Inquilino](#inquilino-1)
    - [Contrato](#contrato-1)
    - [Gasto](#gasto-1)
    - [Servicio](#servicio-1)
- [Análisis de las normas de formalización en el modelo de base de datos](#análisis-de-las-normas-de-formalización-en-el-modelo-de-base-de-datos)
  - [Introducción](#introducción-1)
  - [Norma 1FN](#norma-1fn)
  - [Norma 2FN](#norma-2fn)
  - [Norma 3FN](#norma-3fn)
  - [Conclusiones](#conclusiones)
### Propietario

- ID
- Nombre
- Apellidos
- Teléfono
- Email

### Vivienda

- ID
- Dirección
- Número de habitaciones
- Superficie
- Precio mensual

### Inquilino

- ID
- Nombre
- Apellidos
- Teléfono
- Email

### Contrato

- ID
- Fecha de inicio
- Fecha de fin
- Precio mensual
- Duración en meses

### Gasto

- ID
- Fecha
- Descripción
- Importe

### Servicio

- ID
- Nombre
- Descripción
- Precio

## Relaciones

Las relaciones entre las distintas entidades son las siguientes:

- Un propietario puede tener varias viviendas.
- Una vivienda pertenece a un único propietario.
- Una vivienda puede tener varios contratos a lo largo del tiempo.
- Un inquilino puede tener varios contratos en distintas viviendas.
- Un contrato está asociado a una única vivienda y a un único inquilino.
- Un contrato puede tener varios gastos asociados.
- Un servicio puede ser contratado por varios contratos.
- Un contrato puede tener varios servicios contratados.

## Atributos

A continuación se especifican los atributos de cada entidad:

### Propietario

- ID
- Nombre
- Apellidos
- Teléfono
- Email

### Vivienda

- ID
- Dirección
- Número de habitaciones
- Superficie
- Precio mensual

### Inquilino

- ID
- Nombre
- Apellidos
- Teléfono
- Email

### Contrato

- ID
- Fecha de inicio
- Fecha de fin
- Precio mensual
- Duración en meses

### Gasto

- ID
- Fecha
- Descripción
- Importe

### Servicio

- ID
- Nombre
- Descripción
- Precio


# Análisis de las normas de formalización en el modelo de base de datos

## Introducción

El objetivo de este análisis es comprobar si el modelo de base de datos lógico-relacional para un Administrador de fincas cumple las tres normas de formalización: la 1FN, la 2FN y la 3FN.

## Norma 1FN

La primera forma normal (1FN) establece que cada atributo de una entidad debe ser atómico, es decir, no debe contener múltiples valores. En el modelo de base de datos propuesto, todas las entidades cumplen esta norma, ya que no hay atributos compuestos.

## Norma 2FN

La segunda forma normal (2FN) establece que una entidad debe tener una clave primaria única y que todos los demás atributos deben depender directamente de esa clave primaria. En el modelo de base de datos propuesto, todas las entidades tienen una clave primaria única y todos los atributos dependen directamente de ella, por lo que se cumple esta norma.

## Norma 3FN

La tercera forma normal (3FN) establece que todos los atributos que no son clave primaria deben depender únicamente de la clave primaria y no de otros atributos no clave. En el modelo de base de datos propuesto, todas las entidades cumplen esta norma, ya que no hay dependencias transitivas entre los atributos.

## Conclusiones
