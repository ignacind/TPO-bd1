SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
Go
--CREATE
CREATE PROCEDURE INSERTA_DOCENTE
	@dni int,
	@nombre varchar(30),
	@apellido varchar(30),
	@domicilio varchar(40),
	@fechaNacimiento date, 
	@materiaClases varchar(100),
	@fkServidor float,
	@fkComputadora int,
	@fkEscuela int

AS BEGIN
INSERT INTO Docente 
	(
	dni,
	nombre,
	apellido,
	domicilio,
	fechaNacimiento,
	materiaClases,
	fkServidor,
	fkComputadora,
	fkEscuela
	)
	VALUES
	(
	@dni,
	@nombre,
	@apellido,
	@domicilio,
	@fechaNacimiento,
	@materiaClases,
	@fkServidor,
	@fkComputadora,
	@fkEscuela
	)
END
EXEC INSERTA_DOCENTE
321432, 'Suarez', 'Garcia', 'San Miguel 12', '2001/02/05', Quimica, 123.75,1 ,1
Go
CREATE PROCEDURE INSERTA_COMPUTADORA
	@id int,
	@memoria int
AS BEGIN
INSERT INTO Computadora 
	(
	id,
	memoria
	)
	VALUES
	(
	@id,
	@memoria
	)
end
EXEC INSERTA_COMPUTADORA
9, 40
Go
CREATE PROCEDURE INSERTA_DISCORIGIDO
	@fkDiscoRigido int,
	@marca varchar(30),
	@capacidad int
AS BEGIN
INSERT INTO DiscoRigido 
	(
	fkDiscoRigido,
	marca, 
	capacidad 
	)
	VALUES
	(
	@fkDiscoRigido,
	@marca, 
	@capacidad 
	)
end
EXEC INSERTA_DISCORIGIDO
2, 'Trovo', 40
Go
CREATE PROCEDURE INSERTA_APLICACION
	@fkAplicaciones int,
	@nombre varchar(30),
	@numeroVersion float,
	@distribuidorOficial varchar(30),
	@capacidadDisco int
AS BEGIN
INSERT INTO Aplicaciones 
	(
	fkAplicaciones,
	nombre,
	numeroVersion,
	distribuidorOficial,
	capacidadDisco
	)
	VALUES
	(
	@fkAplicaciones,
	@nombre,
	@numeroVersion,
	@distribuidorOficial,
	@capacidadDisco
	)
end
EXEC INSERTA_APLICACION
3, 'Snapchat', 4.2, Alfa, 1
Go
CREATE PROCEDURE INSERTA_ESCUELA
	@idEscuela int,
	@numero int,
	@localidad varchar(30),
	@orientacion varchar(100),
	@domicilio varchar(30),
	@nombreDirector varchar(30)
AS BEGIN
INSERT INTO Escuela 
	(
	idEscuela,
	numero,
	localidad,
	orientacion,
	domicilio,
	nombreDirector
	)
	VALUES
	(
	@idEscuela,
	@numero,
	@localidad,
	@orientacion,
	@domicilio,
	@nombreDirector
	)
end
EXEC INSERTA_ESCUELA
7, 450, 'Quilmes', Tecnico, 'San Miguel 60', Pedro
Go
CREATE PROCEDURE INSERTA_TALLER
	@fkDocente int,
	@fkEscuela int,
	@nombre varchar(30),
	@duracion float, 
	@fechaRealizacion date,
	@recursosNecesarios varchar(40)
AS BEGIN
INSERT INTO Taller 
	(
	fkDocente,
	fkEscuela,
	nombre,
	duracion, 
	fechaRealizacion ,
	recursosNecesarios
	)
	VALUES
	(
	@fkDocente,
	@fkEscuela,
	@nombre,
	@duracion, 
	@fechaRealizacion ,
	@recursosNecesarios
	)
end
EXEC INSERTA_TALLER
232423, 1, 'Algebra I', 500, '2022/02/08', 'Calculadora Compas'
Go
CREATE PROCEDURE INSERTA_SERVIDOR
	@ip_ float,
	@nombre varchar(30),
	@capacidad int,
	@marca varchar(30),
	@oficina varchar(20),
	@reemplazoInicio date,
	@reemplazoFinal date
AS BEGIN
INSERT INTO Servidor 
	(
	ip_,
	nombre,
	capacidad,
	marca,
	oficina,
	reemplazoInicio,
	reemplazoFinal
	)
	VALUES
	(
	@ip_,
	@nombre,
	@capacidad,
	@marca,
	@oficina,
	@reemplazoInicio,
	@reemplazoFinal
	)
end
EXEC INSERTA_SERVIDOR
123.65, 'Benitez', 23, 'Floro', 'Knoteles', null, null



Go
--READ
CREATE PROCEDURE READ_DOCENTE
AS
SELECT * from Docente

EXEC READ_DOCENTE


Go
CREATE PROCEDURE READ_COMPUTADORA
@memoria int
AS
SELECT id from Computadora
where @memoria < 20
EXEC READ_COMPUTADORA 13

Go
CREATE PROCEDURE READ_DISCORIGIDO
@fkDiscoRigido int
AS
Select marca from DiscoRigido
inner join Computadora
On @fkDiscoRigido = Computadora.id 
EXEC READ_DISCORIGIDO 3

Go
CREATE PROCEDURE READ_APLICACION
@capacidadDisco int
AS
SELECT numeroVersion from Aplicaciones
where @capacidadDisco > 2
EXEC READ_APLICACION 5

Go
CREATE PROCEDURE READ_ESCUELA
@orientacion varchar(100)
AS
Select idEscuela, numero, localidad from Escuela
where @orientacion = 'Tecnico'
EXEC READ_ESCUELA 'Tecnico'

Go
CREATE PROCEDURE READ_TALLER
@nombre varchar(30)
AS
SELECT * from Taller
where @nombre like '%a%'
order by duracion
EXEC READ_TALLER 'Literatura Acustica'

Go
CREATE PROCEDURE READ_SERVIDOR
AS
SELECT * from Servidor
EXEC READ_SERVIDOR


Go
--DELETE
CREATE PROCEDURE ELIMINA_DOCENTE
	@dni int,
	@nombre varchar(30),
	@apellido varchar(30),
	@domicilio varchar(40),
	@fechaNacimiento date, 
	@materiaClases varchar(100),
	@fkServidor float,
	@fkComputadora int,
	@fkEscuela int
AS BEGIN
DELETE FROM Docente 
Where dni = @dni
end
select * from Docente

EXEC ELIMINA_DOCENTE
321432, 'Suarez', 'Garcia', 'San Miguel 12', '2001/02/05', Quimica, 123.75,1 ,1
Go

CREATE PROCEDURE ELIMINA_COMPUTADORA
	@id int
AS BEGIN
DELETE FROM Computadora 
Where @id > 10
end
EXEC ELIMINA_COMPUTADORA
11
Go
CREATE PROCEDURE ELIMINA_DISCORIGIDO
	@marca varchar(30),
	@capacidad int
AS
Begin
Delete from DiscoRigido
where @marca = 'Nike' or @capacidad > 10
END
EXEC ELIMINA_DISCORIGIDO 
'Nike', 8
Go
CREATE PROCEDURE ELIMINA_APLICACION
	@fkAplicaciones int,
	@capacidadDisco int
AS BEGIN
Delete From Aplicaciones
Where @fkAplicaciones = 1 and @capacidadDisco between 5 AND 20
end
EXEC ELIMINA_APLICACION
3, 12
Go
CREATE PROCEDURE ELIMINA_ESCUELA
	@localidad varchar(30)
AS BEGIN
Delete from Escuela 
where @localidad = 'Quilmes'
end
EXEC ELIMINA_ESCUELA
'Quilmes'
Go
CREATE PROCEDURE ELIMINA_TALLER
	@fkDocente int,
	@fkEscuela int,
	@nombre varchar(30),
	@duracion float, 
	@fechaRealizacion date,
	@recursosNecesarios varchar(40)
AS BEGIN
Delete from Taller
where fkDocente = @fkDocente
AND fkEscuela = @fkEscuela
AND nombre = @nombre
AND duracion = @duracion
AND fechaRealizacion = @fechaRealizacion
AND recursosNecesarios = @recursosNecesarios
end
EXEC ELIMINA_TALLER
232423, 1, 'Algebra I', 500, '2022/02/08', 'Calculadora Compas'

Go 
CREATE PROCEDURE ELIMINA_SERVIDOR
	@nombre varchar(30)
AS BEGIN
Delete from Servidor 
where @nombre = 'Omega'
end
EXEC ELIMINA_SERVIDOR
'Omega'


go
CREATE PROCEDURE UPDATE_DOCENTE
	
AS BEGIN
declare @dni int
select @dni from Docente
If (@dni > 99999999)
PRINT 'EL DNI ES MAYOR A 99999999 NO SE ACTUALIZA' + dni
else 
update Docente
set nombre = 'Rodolfo'
where nombre = 'Maria'
END
EXEC UPDATE_DOCENTE
