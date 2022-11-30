use master
go 

Create database TPO_CIdb
use TPO_CIdb
go
/*
drop table Docente
drop table Computadora
drop table Aplicaciones
drop table DiscoRigido
drop table Escuela
drop table Taller
drop table Servidor
*/
Create table Docente (
	dni int primary key not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	domicilio varchar(40) not null,
	fechaNacimiento date not null check(fechaNacimiento < '2004/01/01' and fechaNacimiento > '1904/01/01'), --Tiene que ser mayor de 18 a�os el profesor y 100 a�os es el maximo
	materiaClases varchar(100)  not null,
	fkServidor float foreign key(fkServidor) references Servidor(ip_),
	fkComputadora int foreign key(fkComputadora) references Computadora(id),
	fkEscuela int foreign key (fkEscuela) references Escuela(idEscuela)
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
	check (reemplazoInicio < reemplazoFinal)
)

-- INSERTAR DATOS

insert into Docente values
	(232423, 'Maria', 'Fernandez', 'Lima 12', '2001/12/04', 'Literatura',123.75,1,1),
	(534671, 'Santiago', 'Exec', 'Independencia 400', '1994/01/23', 'Matematica', null,2,2),
	(978754, 'Lucia', 'Maira', 'Chile 257', '1992/06/15', 'Ingles', null,3,3),
	(345365, 'Micaela', 'Cassina', 'Salta 1500', '1968/08/03', 'Educacion Fisica', null,4,4),
	(446543, 'Rodolfo', 'Borges', 'Mitre 340', '1994/1/23', 'Quimica',123.23,5,5)

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
	(141.63, 'Microsoft ', 50, 'Nike', 'WeWork', null, null),
	(123.75, 'DNS', 25, 'Highlands', 'Techspace', null, null),
	(183.56, 'Telnet', 42, 'Adidas', 'Knotel', '2005/08/17', '2021/10/03'),
	(184.92, 'FTP', 37, 'Newline', 'Vores', null, null)

--CONSULTA DE DATOS
--Devuelve todos los docentes
Select * from Docente;

--Mostrar escuelas que empiecen con P con orientacion Bachillerato
Select idEscuela, numero, localidad from Escuela 
where orientacion = 'Bachillerato' and localidad like 'P%';

-- Mostrar los nombres de las aplicaciones
Select nombre from Aplicaciones;

-- Informacion de las computadoras
Select id, memoria, DiscoRigido.marca from Computadora
inner join DiscoRigido
On id = DiscoRigido.fkDiscoRigido;

-- Aplicaciones en las computadoras
Select Computadora.id, fkAplicaciones, nombre,  numeroVersion, distribuidorOficial from Aplicaciones
inner join Computadora
On id = Aplicaciones.fkAplicaciones;

-- Talleres con la duracion ordenada de forma descendente
Select * from Taller
Order by duracion DESC;

-- Mostrar servidores en oficina especifica
Select nombre, capacidad from Servidor
where oficina = 'Trueblue' or oficina = 'Knotel';


