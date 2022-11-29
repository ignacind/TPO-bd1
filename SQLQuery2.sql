use master
go 

Create database ConectarIgualdad
use ConectarIgualdad
go


Create table Docente (
	dni int primary key not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	domicilio varchar(40) not null,
	fechaNacimiento date not null check(fechaNacimiento < '2004/01/01' and fechaNacimiento > '1904/01/01'), --Tiene que ser mayor de 18 a�os el profesor y 100 a�os es el maximo
	materiaClases varchar(100)  not null,
	fkServidor int  foreign key(fkServidor) references Servidor(ip_)
)


Create table Computadora (
	id int primary key not null,
	memoria int not null, --Se asume que son GB
)

Create table DiscoRigido (
	fkDiscoRigido int foreign key(fkDiscoRigido) references Computadora(id),
	marca varchar(30) not null,
	capacidad int not null, --Se asume que son GB
)

Create table Aplicaciones (
	fkAplicaciones int foreign key(fkAplicaciones) references Computadora(id),
	nombre varchar(30) not null,
	numeroVersion float not null,
	distribuidorOficial varchar(30) not null,
	capacidadDisco int not null,
	CONSTRAINT uc_Aplicaciones unique(Nombre, NumeroVersion)
)

Create table Escuela (
	idEscuela int primary key,
	numero int not null,
	localidad varchar(30) not null,
	orientacion varchar(100) not null,
	domicilio varchar(30) not null,
	nombreDirector varchar(30) not null,
	CONSTRAINT uc_Escuela unique(numero, localidad)
) 

Create table Taller (
	fkDocente int foreign key (fkDocente) references Docente(dni),
	fkEscuela int foreign key (fkEscuela) references Escuela(idEscuela),
	nombre varchar(30) not null,
	duracion float not null, -- Minutos y lo que esta despues del punto son segundos
	fechaRealizacion date,
	recursosNecesarios varchar(40)
) 

Create table Servidor (
	ip_ float primary key not null, 
	nombre varchar(30) not null, 
	capacidad int not null, 
	marca varchar(30) not null,
	oficina varchar(20) not null, 
	reemplazoInicio date,
	reemplazoFinal date,
	check(reemplazoInicio < reemplazoFinal),
	check(reemplazoFinal < reemplazoInicio)
)

-- INSERTAR DATOS

insert into Docente values
	(232423, 'Maria', 'Fernandez', 'Lima 12', '2001/12/04', 'Literatura'),
	(534671, 'Santiago', 'Exec', 'Independencia 400', '1994/01/23', 'Matematica'),
	(978754, 'Lucia', 'Maira', 'Chile 257', '1992/06/15', 'Ingles'),
	(345365, 'Micaela', 'Cassina', 'Salta 1500', '1968/08/03', 'Educacion Fisica'),
	(446543, 'Rodolfo', 'Borges', 'Mitre 340', '1994/1/23', 'Quimica')

insert into Computadora values
	(1, 12),
	(2, 4),
	(3, 65),
	(4, 32),
	(5, 20)

insert into DiscoRigido values
	(1, 'Intel', 2),
	(1, 'Intel', 5),
	(3, 'Intel', 34),
	(4, 'Intel', 12),
	(3, 'Intel', 8)

insert into Aplicaciones values 
	(2, 'Angry Birds', 1.3, 'Jhonsson', 2),
	(3, 'Google', 3.6, 'Nike', 6),
	(3, 'Instagram', 4, 'Alfa', 10),
	(5, 'Whatsapp', 1.1, 'Omega', 18),
	(5, 'Twitter', 2.5, 'Beta', 1)

insert into Escuela values
	(1, 100, 'Puerto Madero', 'Bachillerato', 'San Juan 120', 'Pedro'),
	(2, 250, 'Quilmes', 'Comercial', 'Rio 75', 'Juan'),
	(3, 370, '9 de Julio', 'Comercial', 'Constitucion 630', 'Romina'),
	(4, 700, 'Berazategui', 'Bachillerato', 'Videla 241', 'Maria'),
	(5, 450, 'Puerto Madero', 'Tecnico', 'Rambo 10', 'Lucas')

insert into Taller values
	(232423, 1, 'Acustica', 150.12, '2022/11/23', 'Proyector Pantalla'),
	(232423, 1, 'Matematica Avanzada', 200, '2022/11/29', 'Regla Wifi'),
	(534671, 2, 'Algebra Relacional', 10, '2022/02/05', 'Pantalla'),
	(534671, 2, 'Fisica', 50, '2022/06/16', 'Calculadora'),
	(978754, 3, 'Literatura S.XX', 100.10, '2022/10/26', 'Libro Resaltador')

insert into Servidor values
	(123.23, 'Apache', 18, 'Adidas', 'Trueblue', '2001/02/05', '2022/11/29'),
	(141.63, 'Microsoft ', 50, 'Nike', 'WeWork', '', ''),
	(123.75, 'DNS', 25, 'Highlands', 'Techspace', '', ''),
	(183.56, 'Telnet', 42, 'Adidas', 'Knotel', '2005/08/17', '2021/10/03'),
	(184.92, 'FTP', 37, 'Newline', 'Vores', '', '')

--CONSULTA DE DATOS

Select * from Docente; --Devuelve todos los docentes

Select idEscuela, numero, localidad from Escuela
where orientacion = 'Bachillerato' and localidad like 'P%';

Select nombre from Aplicaciones;

Select id, memoria, DiscoRigido.marca from Computadora
inner join DiscoRigido
On id = DiscoRigido.fkDiscoRigido;

Select Computadora.id, fkAplicaciones, nombre,  numeroVersion, distribuidorOficial from Aplicaciones
inner join Computadora
On id = Aplicaciones.fkAplicaciones;

Select * from Taller
Order by duracion DESC;

Select nombre, capacidad from Servidor
where oficina = 'Trueblue' or oficina = 'Knotel';

--PROCESAMIENTO ALMACENADO



--CREATE
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


