-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
Go
CREATE PROCEDURE INSERTA_DOCENTE
	@dni int,
	@nombre varchar(30),
	@apellido varchar(30),
	@domicilio varchar(40),
	@fechaNacimiento date, 
	@materiaClases varchar(100)
AS BEGIN
INSERT INTO Docente 
	(
	dni,
	nombre,
	apellido,
	domicilio,
	fechaNacimiento,
	materiaClases
	)
	VALUES
	(
	@dni,
	@nombre,
	@apellido,
	@domicilio,
	@fechaNacimiento,
	@materiaClases
	)
END
EXEC INSERTA_DOCENTE
321432, 'Suarez', 'Garcia', 'San Miguel 12', '2001/02/05', Quimica
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
8, 40
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
EXEC INSERTA_DOCENTE
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
EXEC INSERTA_DOCENTE
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
EXEC INSERTA_DOCENTE
123.65, 'Benitez', 23, 'Floro', 'Knoteles', ''


--READ
Go
CREATE PROCEDURE READ_DOCENTE
AS
SELECT * from Docente
EXEC READ_DOCENTE

Go
CREATE PROCEDURE READ_COMPUTADORA
@memoria int
AS
SELECT id from Computadora
where @memoria > 20
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

