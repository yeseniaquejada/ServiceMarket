/*CREACION DE LA BASE DE DATOS DEL PROYECTO -- SERVICE MARKET*/
CREATE DATABASE SERVICE_MARKET
USE SERVICE_MARKET

-----------------------------------------------------------------------------------------------------------------------

/*CREACION DE LA TABLA CIUDAD*/
CREATE TABLE CIUDAD(
ID_CIUDAD INT PRIMARY KEY IDENTITY(1,1),
NOMBRE_CIUDAD VARCHAR(50) NOT NULL)

/*PROCEDIMIENTO ALMACENADO PARA CREAR REGISTROS DE LA TABLA CIUDAD*/
CREATE PROCEDURE CREAR_CIUDAD(
@NOMBRE_CIUDAD VARCHAR(50))
AS
BEGIN
	INSERT INTO CIUDAD(NOMBRE_CIUDAD) VALUES (@NOMBRE_CIUDAD)
END

EXEC CREAR_CIUDAD 'Medellin'
EXEC CREAR_CIUDAD 'Caldas'
EXEC CREAR_CIUDAD 'Barbosa'
EXEC CREAR_CIUDAD 'Sabaneta'
EXEC CREAR_CIUDAD 'La estrella'
EXEC CREAR_CIUDAD 'Itagui'
EXEC CREAR_CIUDAD 'Envigado'
EXEC CREAR_CIUDAD 'Bello'
EXEC CREAR_CIUDAD 'Girardota'
EXEC CREAR_CIUDAD 'Copacabana'

/*PROCEDIMIENTO ALMACENADO PARA LEER REGISTROS DE LA TABLA CIUDAD */
CREATE PROCEDURE LEER_CIUDAD
AS
BEGIN
	SELECT * FROM CIUDAD 
END

EXEC LEER_CIUDAD

/*PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR REGISTROS DE LA TABLA CIUDAD */
CREATE PROCEDURE ACTUALIZAR_CIUDAD(
@ID_CIUDAD INT,
@NOMBRE_CIUDAD VARCHAR(50))
AS
BEGIN
	UPDATE CIUDAD SET NOMBRE_CIUDAD = @NOMBRE_CIUDAD WHERE ID_CIUDAD = @ID_CIUDAD
END

EXEC ACTUALIZAR_CIUDAD 10,'Copacabana'

/*PROCEDIMIENTO ALMACENADO PARA BORRAR REGISTROS DE LA TABLA CIUDAD */
CREATE PROCEDURE BORRAR_CIUDAD(
@ID_CIUDAD INT)
AS
BEGIN
	DELETE FROM CIUDAD WHERE ID_CIUDAD = @ID_CIUDAD
END

EXEC BORRAR_CIUDAD 10

/*CREACION DE DISPARADOR QUE PERMITA INSERTAR UNA CIUDAD SIEMPRE Y CUANDO EL NOMBRE SEA UNICO*/
CREATE TRIGGER TR_CIUDAD_INSERTAR
ON CIUDAD
FOR INSERT
AS
	IF (SELECT COUNT (*) FROM INSERTED, CIUDAD WHERE INSERTED.NOMBRE_CIUDAD = CIUDAD.NOMBRE_CIUDAD) > 1
	BEGIN
	ROLLBACK TRANSACTION
	PRINT 'LA CIUDAD SE ENCUENTRA REGISTRADA'
END
	ELSE
	PRINT 'LA CIUDAD FUE INGRESADA EN LA BASE DE DATOS'
GO

EXEC CREAR_CIUDAD 'Medellin'

/*REINICIAR CONTADOR DEL ID*/
DBCC CHECKIDENT (CIUDAD, RESEED, 0)
-----------------------------------------------------------------------------------------------------------------------

/*CREACION DE LA TABLA USUARIOS*/
CREATE TABLE USUARIOS(
N_IDENTIFICACION_USU VARCHAR(15) PRIMARY KEY,
TIPO_DOC_USU VARCHAR(40) NOT NULL,
FECHA_NACIMIENTO_USU DATE NOT NULL,
FECHA_EXPEDICION_USU DATE NOT NULL,
NOMBRE_USU VARCHAR(60) NOT NULL,
APELLIDOS_USU VARCHAR(70) NOT NULL,
CELULAR_USU VARCHAR(20) NOT NULL,
CORREO_ELECTRONICO_USU VARCHAR(100) NOT NULL,
CONTRASENA_USU VARCHAR(500) NOT NULL,
GENERO_USU VARCHAR(80) NOT NULL,
ID_CIUDAD_FK INT REFERENCES CIUDAD(ID_CIUDAD),
DIRECCION_USU VARCHAR(200) NOT NULL
)

/*PROCEDIMIENTO ALMACENADO PARA CREAR REGISTROS DE LA TABLA USUARIOS*/
CREATE PROCEDURE REGISTRAR_USUARIO(
@TIPO_DOC_USU VARCHAR(40),
@N_IDENTIFICACION_USU VARCHAR(15),
@FECHA_NACIMIENTO_USU DATE,
@FECHA_EXPEDICION_USU DATE,
@NOMBRE_USU VARCHAR(60),
@APELLIDOS_USU VARCHAR(70),
@CELULAR_USU VARCHAR(20),
@GENERO_USU VARCHAR(80),
@ID_CIUDAD_FK INT,
@DIRECCION_USU VARCHAR(200),
@CORREO_ELECTRONICO_USU VARCHAR(100),
@CONTRASENA_USU VARCHAR(500),
@REGISTRADO BIT OUTPUT,
@MENSAJE VARCHAR(100) OUTPUT)
AS 
BEGIN
	IF(NOT EXISTS(SELECT * FROM USUARIOS WHERE CORREO_ELECTRONICO_USU = @CORREO_ELECTRONICO_USU))
	BEGIN 
		INSERT INTO USUARIOS(N_IDENTIFICACION_USU, TIPO_DOC_USU, FECHA_NACIMIENTO_USU, FECHA_EXPEDICION_USU, NOMBRE_USU, APELLIDOS_USU, CELULAR_USU, CORREO_ELECTRONICO_USU, CONTRASENA_USU, GENERO_USU, ID_CIUDAD_FK, DIRECCION_USU)
		VALUES (@N_IDENTIFICACION_USU, @TIPO_DOC_USU, @FECHA_NACIMIENTO_USU, @FECHA_EXPEDICION_USU, @NOMBRE_USU, @APELLIDOS_USU, @CELULAR_USU, @CORREO_ELECTRONICO_USU, @CONTRASENA_USU, @GENERO_USU, @ID_CIUDAD_FK, @DIRECCION_USU)
		SET @REGISTRADO = 1
		SET @MENSAJE = 'Usuario registrado'
	END
	ELSE
	BEGIN
		SET @REGISTRADO = 0
		SET @MENSAJE = 'Correo ya existe'
	END
END

/*DECLARAR VARIABLES DE SALIDA*/
DECLARE @REGISTRADO BIT, @MENSAJE VARCHAR(100)
/*REGISTRO DE ADMINISTRADORES*/
EXEC REGISTRAR_USUARIO 'Cedula de ciudadania','70877770','1967-12-23','1985-01-01','Fidel','Quejada Montoya','573145165653','Masculino',8,'Calle 22 carrera 61aa51','fidel@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',@REGISTRADO OUTPUT,@MENSAJE OUTPUT
EXEC REGISTRAR_USUARIO 'Cedula de ciudadania','31793795','1980-10-15','1999-12-03','Monica','Rojas Arango','573145165653','Femenino',8,'Calle 22 carrera 61aa51','arangomoni15@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',@REGISTRADO OUTPUT,@MENSAJE OUTPUT

/*PROCEDIMIENTO ALMACENADO PARA LEER REGISTROS DE LA TABLA USUARIOS */
CREATE PROCEDURE LEER_USUARIOS
AS
BEGIN
	SELECT * FROM USUARIOS
END 

EXEC LEER_USUARIOS

/*PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR REGISTROS DE LA TABLA USUARIOS */
CREATE PROCEDURE ACTUALIZAR_USUARIOS(
@TIPO_DOC_USU VARCHAR(40),
@N_IDENTIFICACION_USU VARCHAR(15),
@FECHA_NACIMIENTO_USU DATE,
@FECHA_EXPEDICION_USU DATE,
@NOMBRE_USU VARCHAR(60),
@APELLIDOS_USU VARCHAR(70),
@CELULAR_USU VARCHAR(20),
@GENERO_USU VARCHAR(80),
@ID_CIUDAD_FK INT,
@DIRECCION_USU VARCHAR(200),
@CORREO_ELECTRONICO_USU VARCHAR(100),
@CONTRASENA_USU VARCHAR(500))
AS
BEGIN
	UPDATE USUARIOS SET 
	TIPO_DOC_USU = @TIPO_DOC_USU, FECHA_NACIMIENTO_USU = @FECHA_NACIMIENTO_USU, FECHA_EXPEDICION_USU = @FECHA_EXPEDICION_USU, NOMBRE_USU = @NOMBRE_USU, APELLIDOS_USU = @APELLIDOS_USU, CELULAR_USU = @CELULAR_USU, GENERO_USU = @GENERO_USU, ID_CIUDAD_FK = @ID_CIUDAD_FK, DIRECCION_USU = @DIRECCION_USU, CORREO_ELECTRONICO_USU = @CORREO_ELECTRONICO_USU, CONTRASENA_USU = @CONTRASENA_USU
	WHERE N_IDENTIFICACION_USU = @N_IDENTIFICACION_USU
END

/*PROCEDIMIENTO ALMACENADO PARA BORRAR REGISTROS DE LA TABLA USUARIOS */
CREATE PROCEDURE BORRAR_USUARIOS(
@N_IDENTIFICACION_USU VARCHAR(15))
AS
BEGIN
	DELETE FROM USUARIOS WHERE N_IDENTIFICACION_USU = @N_IDENTIFICACION_USU
END

EXEC BORRAR_USUARIOS '1001228354'

/*PROCEDIMIENTO ALMACENADO PARA VALIDAR USUARIOS*/
CREATE PROCEDURE VALIDAR_USUARIO(
@CORREO_ELECTRONICO_USU VARCHAR(100),
@CONTRASENA_USU VARCHAR(500))
AS
BEGIN
	IF(EXISTS(SELECT * FROM USUARIOS WHERE CORREO_ELECTRONICO_USU = @CORREO_ELECTRONICO_USU AND CONTRASENA_USU = @CONTRASENA_USU))
		SELECT * FROM USUARIOS WHERE CORREO_ELECTRONICO_USU = @CORREO_ELECTRONICO_USU AND CONTRASENA_USU = @CONTRASENA_USU
	ELSE
		SELECT '0'
END

EXEC VALIDAR_USUARIO 'arangomoni15@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'

/*CREACION DE DISPARADOR QUE BLOQUEE ACTUALIZAR EL NUMERO DE DOCUMENTO DE UN USUARIO*/
CREATE TRIGGER TR_USUARIOS_ACTUALIZAR
ON USUARIOS
FOR UPDATE
AS
IF UPDATE(N_IDENTIFICACION_USU)
BEGIN
PRINT 'NO SE PUEDE ACTUALIZAR EL NUMERO DE IDENTIFICACION DE UN USUARIO'
ROLLBACK TRANSACTION
END

-----------------------------------------------------------------------------------------------------------------------

/*CREACION DE LA TABLA CATEGORIAS*/
CREATE TABLE CATEGORIAS(
ID_CATEGORIA INT IDENTITY(1,1) PRIMARY KEY,
NOMBRE_CAT VARCHAR(MAX) NOT NULL,
DESCRIPCION_CAT VARCHAR(MAX) NOT NULL)

/*PROCEDIMIENTO ALMACENADO PARA CREAR REGISTROS DE LA TABLA CATEGORIAS*/
CREATE PROCEDURE CREAR_CATEGORIAS(
@NOMBRE_CAT VARCHAR(MAX),
@DESCRIPCION_CAT VARCHAR(MAX))
AS
BEGIN
	INSERT INTO CATEGORIAS(NOMBRE_CAT,DESCRIPCION_CAT) VALUES (@NOMBRE_CAT,@DESCRIPCION_CAT)
END

EXEC CREAR_CATEGORIAS 'Mantenimiento', 'Orientada a solucionar y prevenir las posibles averías que pueda haber en equipos, máquinas e instalaciones para conservar y garantizar su óptimo funcionamiento.'
EXEC CREAR_CATEGORIAS 'Trabajos domésticos', 'Toda la ayuda doméstica que necesitas en casa con expertas en orden, limpieza y desinfección.'
EXEC CREAR_CATEGORIAS 'Remodelación y abañilería', 'Orientada en la construcción, renovación y reparación de estructuras, paredes, muros, partes de edificios, casas y más.'
EXEC CREAR_CATEGORIAS 'Salud y belleza', 'Orientada a la prestación de servicios desde los diferentes campos de la salud y la belleza como lo son cortes, peinados, maquillajes, manicure, pedicura, masajes, etc.'

/*PROCEDIMIENTO ALMACENADO PARA LEER REGISTROS DE LA TABLA CATEGORIAS */
CREATE PROCEDURE LEER_CATEGORIAS
AS
BEGIN
	SELECT * FROM CATEGORIAS 
END

EXEC LEER_CATEGORIAS

/*PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR REGISTROS DE LA TABLA CATEGORIAS */
CREATE PROCEDURE ACTUALIZAR_CATEGORIAS(
@ID_CATEGORIA INT,
@NOMBRE_CAT VARCHAR(MAX),
@DESCRIPCION_CAT VARCHAR(MAX))
AS
BEGIN
	UPDATE CATEGORIAS SET NOMBRE_CAT = @NOMBRE_CAT, DESCRIPCION_CAT = @DESCRIPCION_CAT WHERE ID_CATEGORIA = @ID_CATEGORIA
END

EXEC ACTUALIZAR_CATEGORIAS 2, 'Tabajos domésticos', 'Toda la ayuda doméstica que necesitas en casa con expertas en orden, limpieza y desinfección.'

/*PROCEDIMIENTO ALMACENADO PARA BORRAR REGISTROS DE LA TABLA CATEGORIAS */
CREATE PROCEDURE BORRAR_CATEGORIAS(
@ID_CATEGORIA INT)
AS
BEGIN
	DELETE FROM CATEGORIAS WHERE ID_CATEGORIA = @ID_CATEGORIA
END

EXEC BORRAR_CATEGORIAS 2

/*CREACION DE DISPARADOR QUE PERMITA INSERTAR UNA CATEGORIA SIEMPRE Y CUANDO EL NOMBRE SEA UNICO*/
CREATE TRIGGER TR_CATEGORIAS_INSERTAR
ON CATEGORIAS
FOR INSERT
AS
IF (SELECT COUNT (*) FROM INSERTED, CATEGORIAS
WHERE INSERTED.NOMBRE_CAT = CATEGORIAS.NOMBRE_CAT) > 1
BEGIN
ROLLBACK TRANSACTION
PRINT 'LA CATEGORIA SE ENCUENTRA REGISTRADA'
END
ELSE
PRINT 'LA CATEGORIA FUE INGRESADA EN LA BASE DE DATOS'
GO

EXEC CREAR_CATEGORIAS 'Mantenimiento', 'Orientada a solucionar y prevenir las posibles averias que pueda haber en equipos, maquinas e instalaciones para conservar y garantizar su optimo funcionamiento.'

/*REINICIAR CONTADOR DEL ID*/
DBCC CHECKIDENT (CATEGORIAS, RESEED, 0)

-----------------------------------------------------------------------------------------------------------------------

/*CREACION DE LA TABLA ADMINISTRADORES*/
CREATE TABLE ADMINISTRADORES(
N_IDENTIFICACION_ADMIN VARCHAR(15) PRIMARY KEY,
TIPO_DOC_ADMIN VARCHAR(40) NOT NULL,
FECHA_NACIMIENTO_ADMIN DATE NOT NULL,
FECHA_EXPEDICION_ADMIN DATE NOT NULL,
NOMBRE_ADMIN VARCHAR(60) NOT NULL,
APELLIDOS_ADMIN VARCHAR(70) NOT NULL,
CELULAR_ADMIN VARCHAR(20) NOT NULL,
CORREO_ELECTRONICO_ADMIN VARCHAR(100) NOT NULL,
CONTRASENA_ADMIN VARCHAR(500) NOT NULL,
GENERO_ADMIN VARCHAR(80) NOT NULL
)

/*PROCEDIMIENTO ALMACENADO PARA CREAR REGISTROS DE LA TABLA ADMINISTRADORES*/
CREATE PROCEDURE REGISTRAR_ADMINISTRADORES(
@TIPO_DOC_ADMIN VARCHAR(40),
@N_IDENTIFICACION_ADMIN VARCHAR(15),
@FECHA_NACIMIENTO_ADMIN DATE,
@FECHA_EXPEDICION_ADMIN DATE,
@NOMBRE_ADMIN VARCHAR(60),
@APELLIDOS_ADMIN VARCHAR(70),
@CELULAR_ADMIN VARCHAR(20),
@GENERO_ADMIN VARCHAR(80),
@CORREO_ELECTRONICO_ADMIN VARCHAR(100),
@CONTRASENA_ADMIN VARCHAR(500),
@REGISTRADO BIT OUTPUT,
@MENSAJE VARCHAR(100) OUTPUT)
AS 
BEGIN
	IF(NOT EXISTS(SELECT * FROM ADMINISTRADORES WHERE CORREO_ELECTRONICO_ADMIN = @CORREO_ELECTRONICO_ADMIN))
	BEGIN 
		INSERT INTO ADMINISTRADORES(N_IDENTIFICACION_ADMIN, TIPO_DOC_ADMIN, FECHA_NACIMIENTO_ADMIN, FECHA_EXPEDICION_ADMIN, NOMBRE_ADMIN,APELLIDOS_ADMIN, CELULAR_ADMIN, CORREO_ELECTRONICO_ADMIN, CONTRASENA_ADMIN, GENERO_ADMIN)
		VALUES (@N_IDENTIFICACION_ADMIN, @TIPO_DOC_ADMIN, @FECHA_NACIMIENTO_ADMIN, @FECHA_EXPEDICION_ADMIN, @NOMBRE_ADMIN, @APELLIDOS_ADMIN, @CELULAR_ADMIN, @CORREO_ELECTRONICO_ADMIN, @CONTRASENA_ADMIN, @GENERO_ADMIN)
		SET @REGISTRADO = 1
		SET @MENSAJE = 'Administrador registrado'
	END
	ELSE
	BEGIN
		SET @REGISTRADO = 0
		SET @MENSAJE = 'Correo ya existe'
	END
END

/*DECLARAR VARIABLES DE SALIDA*/
DECLARE @REGISTRADO BIT, @MENSAJE VARCHAR(100)
/*REGISTRO DE ADMINISTRADORES*/
EXEC REGISTRAR_ADMINISTRADORES 'Cedula de ciudadania','1013376602','2004-01-13','2022-01-14','Yesenia','Quejada Rojas','573135293264','Femenino','yeyerojas1308@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3',@REGISTRADO OUTPUT,@MENSAJE OUTPUT

/*PROCEDIMIENTO ALMACENADO PARA LEER REGISTROS DE LA TABLA ADMINISTRADORES*/
CREATE PROCEDURE LEER_ADMINISTRADORES
AS
BEGIN
	SELECT * FROM ADMINISTRADORES
END 

EXEC LEER_ADMINISTRADORES

/*PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR REGISTROS DE LA TABLA ADMINISTRADORES */
CREATE PROCEDURE ACTUALIZAR_ADMINISTRADORES(
@TIPO_DOC_ADMIN VARCHAR(40),
@N_IDENTIFICACION_ADMIN VARCHAR(15),
@FECHA_NACIMIENTO_ADMIN DATE,
@FECHA_EXPEDICION_ADMIN DATE,
@NOMBRE_ADMIN VARCHAR(60),
@APELLIDOS_ADMIN VARCHAR(70),
@CELULAR_ADMIN VARCHAR(20),
@GENERO_ADMIN VARCHAR(80),
@CORREO_ELECTRONICO_ADMIN VARCHAR(100),
@CONTRASENA_ADMIN VARCHAR(500))
AS
BEGIN
	UPDATE ADMINISTRADORES SET 
	TIPO_DOC_ADMIN = @TIPO_DOC_ADMIN, FECHA_NACIMIENTO_ADMIN = @FECHA_NACIMIENTO_ADMIN, FECHA_EXPEDICION_ADMIN = @FECHA_EXPEDICION_ADMIN, NOMBRE_ADMIN = @NOMBRE_ADMIN, APELLIDOS_ADMIN = @APELLIDOS_ADMIN, CELULAR_ADMIN = @CELULAR_ADMIN, GENERO_ADMIN = @GENERO_ADMIN, CORREO_ELECTRONICO_ADMIN = @CORREO_ELECTRONICO_ADMIN, CONTRASENA_ADMIN = @CONTRASENA_ADMIN
	WHERE N_IDENTIFICACION_ADMIN = @N_IDENTIFICACION_ADMIN
END


/*PROCEDIMIENTO ALMACENADO PARA BORRAR REGISTROS DE LA TABLA ADMINISTRADORES */
CREATE PROCEDURE BORRAR_ADMINISTRADORES(
@N_IDENTIFICACION_ADMIN VARCHAR(15))
AS
BEGIN
	DELETE FROM ADMINISTRADORES WHERE N_IDENTIFICACION_ADMIN = @N_IDENTIFICACION_ADMIN
END

EXEC BORRAR_ADMINISTRADORES '1013376602'

/*PROCEDIMIENTO ALMACENADO PARA VALIDAR ADMINISTRADORES*/
CREATE PROCEDURE VALIDAR_ADMINISTRADORES(
@CORREO_ELECTRONICO_ADMIN VARCHAR(100),
@CONTRASENA_ADMIN VARCHAR(500))
AS
BEGIN
	IF(EXISTS(SELECT * FROM ADMINISTRADORES WHERE CORREO_ELECTRONICO_ADMIN = @CORREO_ELECTRONICO_ADMIN AND CONTRASENA_ADMIN = @CONTRASENA_ADMIN))
		SELECT * FROM ADMINISTRADORES WHERE CORREO_ELECTRONICO_ADMIN = @CORREO_ELECTRONICO_ADMIN AND CONTRASENA_ADMIN = @CONTRASENA_ADMIN
	ELSE
		SELECT '0'
END

EXEC VALIDAR_ADMINISTRADORES 'yeyerojas1308@gmail.com','a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3'

/*CREACION DE DISPARADOR QUE BLOQUEE ACTUALIZAR EL NUMERO DE DOCUMENTO DE UN ADMINISTRADOR*/
CREATE TRIGGER TR_ADMINISTRADORES_ACTUALIZAR
ON ADMINISTRADORES
FOR UPDATE
AS
IF UPDATE(N_IDENTIFICACION_ADMIN)
BEGIN
PRINT 'NO SE PUEDE ACTUALIZAR EL NUMERO DE IDENTIFICACION DE UN ADMINISTRADOR'
ROLLBACK TRANSACTION
END

-----------------------------------------------------------------------------------------------------------------------
/*CREACION DE LA TABLA SERVICIOS*/
CREATE TABLE SERVICIOS(
ID_SERVICIO INT IDENTITY(1,1) PRIMARY KEY,
NOMBRE_SER VARCHAR(70) NOT NULL,
PRECIO_SER DECIMAL NOT NULL,
DESCRIPCION_BREVE VARCHAR(500) NOT NULL,
TERMINOS_SER VARCHAR(MAX) NOT NULL,
ESTADO_DS VARCHAR(20) DEFAULT 'Activo',
TIPO VARCHAR(50) NOT NULL,
FECHA_PUBLICACION DATE NOT NULL DEFAULT GETDATE(),
N_IDENTIFICACION_USU_FK VARCHAR(15) REFERENCES USUARIOS(N_IDENTIFICACION_USU),
N_IDENTIFICACION_ADMIN_FK VARCHAR(15) REFERENCES ADMINISTRADORES(N_IDENTIFICACION_ADMIN),
ID_CATEGORIA_FK INT REFERENCES CATEGORIAS(ID_CATEGORIA)
)

/*PROCEDIMIENTO ALMACENADO PARA CREAR REGISTROS DE LA TABLA SERVICIOS*/
CREATE PROCEDURE CREAR_SERVICIOS(
@NOMBRE_SER VARCHAR(70),
@PRECIO_SER DECIMAL,
@DESCRIPCION_BREVE VARCHAR(500),
@TERMINOS_SER VARCHAR(MAX),
@TIPO VARCHAR(50),
@N_IDENTIFICACION_USU_FK VARCHAR(15),
@ID_CATEGORIA_FK INT
)
AS 
BEGIN
	INSERT INTO SERVICIOS(NOMBRE_SER,PRECIO_SER,DESCRIPCION_BREVE,TERMINOS_SER,TIPO,N_IDENTIFICACION_USU_FK,ID_CATEGORIA_FK) 
	VALUES (@NOMBRE_SER,@PRECIO_SER,@DESCRIPCION_BREVE,@TERMINOS_SER,@TIPO,@N_IDENTIFICACION_USU_FK,@ID_CATEGORIA_FK)
END

EXEC CREAR_SERVICIOS 'Limpieza a vapor baños y cocina',97000,'Quitamos la grasa y gérmenes con equipos y productos especializados, removiendo grasas y desinfectando a profundidad los espacios. Usamos productos amigables con el medio ambiente.','Al tomar el servicio, debes tener los espacios desocupados para el servicio especialmente las alacenas de las cocinas y cajones con el fin de evitar cualquier daño y alterar el tiempo del servicio. Te recomendamos hacer este tipo de limpieza profunda cada 3-6 meses.','Publicacion','31793795', 2
EXEC CREAR_SERVICIOS 'Peluquería',50000,'Realizamos todo tipo de trabajos técnicos de peluquería tanto para mujeres, hombres o niños. Ofrecemos un trato personal y te asesoraremos en todo lo que necesites.','Entre nuestra cartera de servicios, se pueden encontrar: cortes, mechas, puntos de color, balayages, peinados, recogidos, alisados, permanentes. Utilizamos productos naturales, muy demandados actualmente entre nuestros clientes.','Publicacion','31793795', 2

/*PROCEDIMIENTO ALMACENADO PARA LEER REGISTROS DE LA TABLA SERVICIOS */
CREATE PROCEDURE LEER_SERVICIOS
AS
BEGIN
	SELECT * FROM SERVICIOS 
END

EXEC LEER_SERVICIOS

/*PROCEDIMIENTO ALMACENADO PARA ACTUALIZAR REGISTROS DE LA TABLA SERVICIOS */
CREATE PROCEDURE ACTUALIZAR_SERVICIOS(
@ID_SERVICIO INT,
@NOMBRE_SER VARCHAR(70),
@PRECIO_SER DECIMAL,
@DESCRIPCION_BREVE VARCHAR(500),
@TERMINOS_SER VARCHAR(MAX),
@ESTADO_DS  VARCHAR(20),
@ID_CATEGORIA_FK INT)
AS
BEGIN
	UPDATE SERVICIOS SET NOMBRE_SER = @NOMBRE_SER, PRECIO_SER = @PRECIO_SER, DESCRIPCION_BREVE = @DESCRIPCION_BREVE, TERMINOS_SER = @TERMINOS_SER, ESTADO_DS = @ESTADO_DS, ID_CATEGORIA_FK = @ID_CATEGORIA_FK 
	WHERE ID_SERVICIO = @ID_SERVICIO
END

/*PROCEDIMIENTO ALMACENADO PARA BORRAR REGISTROS DE LA TABLA SERVICIOS */
CREATE PROCEDURE BORRAR_SERVICIOS(
@ID_SERVICIO INT)
AS
BEGIN
	DELETE FROM SERVICIOS WHERE ID_SERVICIO = @ID_SERVICIO
	UPDATE HISTORIAL_SERVICIOS SET ESTADO_DS = 'Desactivo' WHERE ID_SERVICIO = @ID_SERVICIO
END

EXEC BORRAR_SERVICIOS 3

/*PROCEDIMIENTO ALMACENADO PARA CONSULTAR PUBLICACIONES DE SERVICIOS INNER JOIN CON TABLA CATEGORIAS*/
CREATE PROCEDURE CONSULTAR_SERVICIOS
AS 
BEGIN
	SELECT ID_SERVICIO, NOMBRE_SER, PRECIO_SER, DESCRIPCION_BREVE, NOMBRE_CAT 
	FROM SERVICIOS INNER JOIN CATEGORIAS 
	ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA WHERE TIPO = 'Publicacion'
END

EXEC CONSULTAR_SERVICIOS

/*PROCEDIMIENTO ALMACENADO PARA CONSULTAR SOLICITUDES DE SERVICIOS INNER JOIN CON TABLA CATEGORIAS*/
CREATE PROCEDURE CONSULTAR_SOLICITUDES
AS 
BEGIN
	SELECT ID_SERVICIO, NOMBRE_SER, PRECIO_SER, DESCRIPCION_BREVE, NOMBRE_CAT 
	FROM SERVICIOS INNER JOIN CATEGORIAS 
	ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA WHERE TIPO = 'Solicitud'
END

EXEC CONSULTAR_SOLICITUDES

/*PROCEDIMIENTO ALMACENADO PARA CATEGORIZAR PUBLICACIONES DE SERVICIOS */
CREATE PROCEDURE SERVICIOS_CATEGORIAS
(@ID_CATEGORIA INT)
AS
BEGIN
	SELECT ID_SERVICIO, NOMBRE_SER, PRECIO_SER, DESCRIPCION_BREVE, NOMBRE_CAT 
	FROM SERVICIOS INNER JOIN CATEGORIAS 
	ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA WHERE ID_CATEGORIA = @ID_CATEGORIA AND TIPO = 'Publicacion'
END

EXEC SERVICIOS_CATEGORIAS 2

/*PROCEDIMIENTO ALMACENADO PARA CATEGORIZAR SOLICITUDES DE SERVICIOS */
CREATE PROCEDURE CATEGORIAS_SOLICITUDES
(@ID_CATEGORIA INT)
AS
BEGIN
	SELECT ID_SERVICIO, NOMBRE_SER, PRECIO_SER, DESCRIPCION_BREVE, NOMBRE_CAT 
	FROM SERVICIOS INNER JOIN CATEGORIAS 
	ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA WHERE ID_CATEGORIA = @ID_CATEGORIA AND TIPO = 'Solicitud'
END

EXEC CATEGORIAS_SOLICITUDES 2

/*PROCEDIMIENTO ALMACENADO PARA BUSCAR PUBLICACIONES DE SERVICIOS POR NOMBRE*/
CREATE PROCEDURE BUSQUEDAD_SERVICIOS(
@NOMBRE_SER VARCHAR(70))
AS
BEGIN
	SELECT ID_SERVICIO, NOMBRE_SER, PRECIO_SER,DESCRIPCION_BREVE, NOMBRE_CAT 
	FROM SERVICIOS INNER JOIN CATEGORIAS 
	ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA
	WHERE NOMBRE_SER LIKE '%'+@NOMBRE_SER+'%' AND TIPO = 'Publicacion'
END

EXEC BUSQUEDAD_SERVICIOS 'Limpieza'

/*PROCEDIMIENTO ALMACENADO PARA BUSCAR SOLICITUDES DE SERVICIOS POR NOMBRE*/
CREATE PROCEDURE BUSQUEDAD_SOLICITUDES(
@NOMBRE_SER VARCHAR(70))
AS
BEGIN
	SELECT ID_SERVICIO, NOMBRE_SER, PRECIO_SER,DESCRIPCION_BREVE, NOMBRE_CAT 
	FROM SERVICIOS INNER JOIN CATEGORIAS 
	ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA
	WHERE NOMBRE_SER LIKE '%'+@NOMBRE_SER+'%' AND TIPO = 'Solicitud'
END

EXEC BUSQUEDAD_SOLICITUDES 'Remodelacion'

/*REINICIAR CONTADOR DEL ID*/
DBCC CHECKIDENT (SERVICIOS, RESEED, 0)

-----------------------------------------------------------------------------------------------------------------------

/*VISTA MAS INFORMACION SOBRE LA PUBLICACION DEL SERVICIO
TABLAS: SERVICIOS // CATEGORIAS // USUARIOS // CIUDAD*/
CREATE VIEW MAS_INFORMACION
AS
SELECT N_IDENTIFICACION_USU, NOMBRE_USU, APELLIDOS_USU, CELULAR_USU, NOMBRE_CIUDAD, ID_SERVICIO, NOMBRE_SER, PRECIO_SER, DESCRIPCION_BREVE, TERMINOS_SER, TIPO, NOMBRE_CAT
FROM 
USUARIOS INNER JOIN CIUDAD
ON USUARIOS.ID_CIUDAD_FK = CIUDAD.ID_CIUDAD
INNER JOIN SERVICIOS
ON USUARIOS.N_IDENTIFICACION_USU = SERVICIOS.N_IDENTIFICACION_USU_FK
INNER JOIN CATEGORIAS
ON SERVICIOS.ID_CATEGORIA_FK = CATEGORIAS.ID_CATEGORIA WHERE ESTADO_DS = 'Activo'

/*PROCEDIMIENTO ALMACENADO PARA CONSULTAR VISTA MAS INFORMACION (PUBLICACIONES)*/
CREATE PROCEDURE INFORMACION_PUBLICACION(
@ID_SERVICIO INT)
AS
BEGIN
	SELECT * FROM MAS_INFORMACION WHERE ID_SERVICIO = @ID_SERVICIO AND TIPO = 'Publicacion'
END

EXEC INFORMACION_PUBLICACION 1

/*PROCEDIMIENTO ALMACENADO PARA CONSULTAR VISTA MAS INFORMACION (SOLICITUDES)*/
CREATE PROCEDURE INFORMACION_SOLICITUD(
@ID_SERVICIO INT)
AS
BEGIN
	SELECT * FROM MAS_INFORMACION WHERE ID_SERVICIO = @ID_SERVICIO AND TIPO = 'Solicitud'
END

EXEC INFORMACION_SOLICITUD 3

----------------------------------------------------------------------------------------------------------------------

/*CREACION DE LA TABLA HISTORIAL DE SERVICIOS ELIMINADOS*/
CREATE TABLE [HISTORIAL_SERVICIOS](
	[ID_SERVICIO] [int] NOT NULL,
	[NOMBRE_SER] [varchar](70) NOT NULL,
	[PRECIO_SER] [decimal](18, 0) NOT NULL,
	[DESCRIPCION_BREVE] [varchar](500) NOT NULL,
	[TERMINOS_SER] [varchar](max) NOT NULL,
	[ESTADO_DS] [varchar](20) NULL,
	[TIPO] [varchar](50) NOT NULL,
	[FECHA_PUBLICACION] [date] NOT NULL,
	[N_IDENTIFICACION_USU_FK] [varchar](15) NULL,
	[N_IDENTIFICACION_ADMIN_FK] [varchar](15) NULL,
	[ID_CATEGORIA_FK] [int] NULL)

/*CREACION DE DISPARADOR PARA QUE AGREGUE SERVICIOS ELIMINADOS AL HISTORIAL*/
CREATE TRIGGER TR_HISTORIAL_SERVICIOS
ON SERVICIOS FOR DELETE
AS 
BEGIN 
	INSERT INTO [HISTORIAL_SERVICIOS]
	SELECT * FROM deleted
END 
GO

/*PROCEDIMIENTO ALMACENADO PARA LEER LOS REGISTROS DE LA TABLA HISTORIAL_SERVICIOS DEPENDIENDO LA IDENTIFICACION DEL USUARIO*/
CREATE PROCEDURE LEER_HISTORIAL_SERVICIOS(
@N_IDENTIFICACION_USU_FK VARCHAR(15))
AS
BEGIN
	SELECT * FROM HISTORIAL_SERVICIOS WHERE @N_IDENTIFICACION_USU_FK = N_IDENTIFICACION_USU_FK
END

EXEC LEER_HISTORIAL_SERVICIOS '31793795' 

----------------------------------------------------------------------------------------------------------------------

/*FUNCION PARA CONTAR SERVICIOS DISPONIBLES*/
CREATE FUNCTION SERVICIOS_DISPONIBLES() 
RETURNS INT
AS
BEGIN
DECLARE @DISPONIBLES INT
SELECT  @DISPONIBLES = COUNT (*) FROM SERVICIOS 
RETURN @DISPONIBLES 

END

PRINT 'SERVICIOS DISPONIBLES'
PRINT DBO.SERVICIOS_DISPONIBLES()


