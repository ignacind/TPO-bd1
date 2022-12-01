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
GO
-- =============================================
-- Author:		Name
-- Create date: 
-- Description:	
-- =============================================
CREATE PROCEDURE INSERTA_REINO
	-- Add the parameters for the stored procedure here
	@nombreReino varchar(20),
	@idReino int,
	@cantidadHabitantes int,
	@ciudades varchar(100),
	@continente varchar (30),
	@posicion varchar(5)
AS
BEGIN
	INSERT INTO Reino
	(
	nombreReino,
	idReino,
	cantidadHabitantes,
	ciudades,
	continente,
	posicion
	)
	VALUES
	(
	@nombreReino,
	@idReino,
	@cantidadHabitantes,
	@ciudades,
	@continente,
	@posicion
	)
END
EXEC INSERTA_REINO
'Santa Lucia', 10, 3000, 'Buenos Aires - Jujuy', 'America', 'Oeste'



GO
CREATE PROCEDURE INSERTA_GUERRA
	@idGuerra int,
	@lugar varchar(30),
	@anio int,
	@cantidadMuertes int 
AS 
BEGIN
INSERT INTO Guerra 
	(
	idGuerra,
	lugar,
	anio,
	cantidadMuertes
	)
	VALUES
	(
	@idGuerra,
	@lugar,
	@anio,
	@cantidadMuertes
	)
END
EXEC INSERTA_GUERRA
8, 'Argelia', 200, 1000
GO
CREATE PROCEDURE INSERTA_CASA
	@idCasa int,
	@nombre varchar(20),
	@lema varchar(30),
	@animal varchar(20),
	@color varchar(20),
	@fechaFund date,
	@religion varchar(20),
	@fkReino int,
	@fkGuerra int,
	@gano varchar(2)
AS 
BEGIN
INSERT INTO Casa 
	(
	idCasa,
	nombre,
	lema,
	animal,
	color,
	fechaFund,
	religion,
	fkReino,
	fkGuerra,
	gano
	)
	VALUES
	(
	@idCasa,
	@nombre,
	@lema,
	@animal,
	@color,
	@fechaFund,
	@religion,
	@fkReino,
	@fkGuerra,
	@gano,
	)
END
EXEC INSERTA_CASA
10, 'Los Alfa', 'Siempre Ganar', 'Leopardo', 'Verde', '2005/05/12', 'Budismo', 1, 1, 'SI'
GO
CREATE PROCEDURE INSERTA_RELACIONFAMILIAR
	padre varchar(30),
	madre varchar(30),
	idFamilia int
AS 
BEGIN
INSERT INTO relacionFamiliar 
	(
	padre,
	madre,
	idFamilia
	)
	VALUES
	(
	@padre,
	@madre,
	@idFamilia
	)
END
EXEC relacionFamiliar
'Pedro', 'Lucia', 20
GO
CREATE PROCEDURE INSERTA_ESPECIE
	@idEspecie int,
	@nombreCientifico varchar(30),
	@habilidades varchar(100),
	@hostil bit,
	@existe bit
AS 
BEGIN
INSERT INTO Especie 
	(
	idEspecie,
	nombreCientifico,
	habilidades,
	hostil,
	existe
	)
	VALUES
	(
	@idEspecie,
	@nombreCientifico,
	@habilidades,
	@hostil,
	@existe
	)
END
EXEC INSERTA_ESPECIE
15, 'Rumpelstinkin', 'Lanzar Fuego', 1, 0
GO
CREATE PROCEDURE INSERTA_PERSONAJE
	@nombre varchar(30),
	@fechaNacimiento date,
	@bastardo bit,
	@estado varchar(8),
	@fkCasa int,
	@fkEspecie int, 
	@fkrelacionFamiliar int
AS 
BEGIN
INSERT INTO Personaje 
	(
	nombre,
	fechaNacimiento,
	bastardo,
	estado,
	fkCasa,
	fkEspecie, 
	fkrelacionFamiliar
	)
	VALUES
	(
	@nombre,
	@fechaNacimiento,
	@bastardo,
	@estado,
	@fkCasa,
	@fkEspecie, 
	@fkrelacionFamiliar
	)
END
EXEC INSERTA_PERSONAJE
'Guzman', '1998/08/18', 1, 'vivo', 1, 1, 1
GO
CREATE PROCEDURE INSERTA_CASTILLO
	@idCastillo int,
	@nombre varchar(30),
	@tipoFortificacion varchar(30),
	@sirvientes int,
	@fkReino int
AS 
BEGIN
INSERT INTO Castillo 
	(
	idCastillo,
	nombre,
	tipoFortificacion,
	sirvientes,
	fkReino
	)
	VALUES
	(
	@idCastillo,
	@nombre,
	@tipoFortificacion,
	@sirvientes,
	@fkReino
	)
END
EXEC INSERTA_CASTILLO
13, 'Alejandria', 'Piedra', 4, 2
GO
CREATE PROCEDURE INSERTA_PROFESION
	@nombre varchar(30),
	@tipoProfesion varchar(30),
	@nombreMaestre varchar(100),
	@fkPersonaje int,
	@edadProfesion int
AS 
BEGIN
INSERT INTO Profesion 
	(
	nombre,
	tipoProfesion,
	nombreMaestre,
	fkPersonaje,
	edadProfesion
	)
	VALUES
	(
	@nombre,
	@tipoProfesion,
	@nombreMaestre,
	@fkPersonaje,
	@edadProfesion
	)
END
EXEC INSERTA_PROFESION
'Ingeniero', 'Exacta', 'Luis', 1, 10

Go
CREATE PROCEDURE READ_REINO
AS
Select * from Reino

EXEC READ_REINO 


Go
CREATE PROCEDURE READ_GUERRA
	@idGuerra int
AS
Select lugar, anio from Guerra
where @idGuerra > 10
EXEC READ_GUERRA 13


Go
CREATE PROCEDURE READ_CASA
	@idCasa int
AS
Select distinct c.nombre from Casa c
inner join Personaje
On @idCasa = Personaje.fkCasa 

EXEC READ_CASA 2

Go
Create procedure DELETE_ESPECIE
	@idEspecie int
as begin
delete from Especie
where idEspecie = @idEspecie
end

exec DELETE_ESPECIE 102


go
create procedure DELETE_CASTILLO
	@idCastillo int
as begin
delete from Castillo
where idCastillo = @idCastillo
end

exec DELETE_CASTILLO 12005

go
create procedure UPDATE_RELACIONFAMILIAR
	@idFamilia int
as begin

update relacionFamiliar
set padre = 'Rhaegar Targaryen',madre = 'Lyanna Stark' --Spoiler
where idFamilia = @idFamilia
end


exec UPDATE_RELACIONFAMILIAR 3001

go
create procedure UPDATE_PERSONAJE
	@idPersonaje int
as begin

update Personaje
set estado = 'muerto'
where idPersonaje = @idPersonaje
end

exec UPDATE_PERSONAJE 2003

select * from Personaje