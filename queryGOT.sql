<<<<<<< HEAD
use master
go 

Create database TPO_GOTdb
use TPO_GOTdb
go


--PRUEBA
Create table Reino (
	nombreReino varchar(60) not null unique,
	idReino int primary key,
	cantidadHabitantes int not null,
	ciudades varchar(100) not null,
	continente varchar (30) not null,
	posicion varchar (5) check (posicion in ('Norte', 'Sur', 'Este', 'Oeste')),
);
/*
drop table Reino
drop table Casa
drop table Especie
drop table Castillo
drop table Guerra
drop table relacionFamiliar
drop table Personaje
drop table Profesion*/

--alter table Reino
--alter column nombreReino varchar(60)not null
Create table Casa (
	idCasa int primary key,
	nombre varchar(20) not null unique,
	lema varchar(30) not null,
	animal varchar(20) not null,
	color varchar(20) not null,
	fechaFund date not null,
	religion varchar(20),
	fkReino int foreign key (fkReino) references Reino(idReino),
	fkGuerra int foreign key (fkGuerra) references Guerra(idGuerra),
	gano bit --Gano guerra? 1 o 0
)

Create table relacionFamiliar (
	padre varchar(30),
	madre varchar(30),
	idFamilia int primary key,
)

Create table Personaje (
	idPersonaje int primary key,
	nombre varchar(30) not null,
	fechaNacimiento date not null,
	bastardo bit not null, -- 1 si es bastardo y 0 si no es bastardo
	estado varchar(8) check(estado in('vivo', 'muerto', 'inactivo')),
	CONSTRAINT uc_Personaje unique(Nombre, fechaNacimiento),
	fkCasa int foreign key (fkCasa) references Casa(idCasa), --Casa a la que pertenece == Apellido
	fkEspecie int foreign key (fkEspecie) references Especie(idEspecie), --Especie del personaje
	fkrelacionFamiliar int foreign key (fkrelacionFamiliar) references relacionFamiliar(idFamilia)
)


Create table Castillo (
	idCastillo int primary key,
	nombre varchar(30) not null unique,
	tipoFortificacion varchar(30) not null,
	sirvientes int not null,
	fkReino int foreign key(fkReino) references Reino(idReino) --Reino donde esta el castillo
)
alter table Castillo
alter column tipoFortificacion varchar(30)

Create table Guerra (
	idGuerra int primary key,
	lugar varchar(30) not null ,
	anio int not null check(anio< 325 AND anio > 0),
	cantidadMuertes int not null,
	CONSTRAINT uc_Guerra unique(Lugar, anio)
)


Create table Profesion (
	nombre varchar(30) not null,
	tipoProfesion varchar(30) not null,
	nombreMaestre varchar(100) not null,
	fkPersonaje int foreign key (fkPersonaje) references Personaje(idPersonaje),
	edadProfesion int --Edad de cuando comenzo 
)
alter table Profesion
alter column nombreMaestre varchar(30)

Create table Especie (
	idEspecie int primary key,
	nombreCientifico varchar(30) not null unique,
	habilidades varchar(100) not null,
	hostil bit not null,
	existe bit not null,
)

insert into Reino(nombreReino, idReino, cantidadHabitantes, ciudades, continente, posicion) values
	('El Reino del Norte', 501,25000, 'Winterfell', 'Westeros', 'Norte'),
	('El Reino de la roca', 502,30000, 'Roca casterly', 'Westeros', 'Oeste'),
	('El Reino de las Islas y los Ríos', 503,17000, 'Pyke', 'Westeros', 'Oeste'),
	('El Reino del Valle', 504, 10000, 'El valle', 'Westeros', 'Este'),
	('El Reino de las Tierras de la Tormenta', 505,8000 , 'Bastion de tormentas', 'Westeros', 'Sur');

insert into Casa(idCasa, nombre, lema, animal, color, fechaFund, religion, fkReino, fkGuerra, gano) values
	(1,'House Stark', 'Winter is coming', 'Lobo huargo', 'Gris','0200.01.01', 'Antiguos Dioses', 501,289, 1),
	(2,'House Lannister', 'Hear me roar', 'Leon', 'Carmesí', '0300.01.01','Fe de los Siete', 502, 289, 1),
	(3,'House Baratheon', 'Ours is the Fury', 'Ciervo', 'Amarillo', '1100.01.01', 'Señor de la Luz', 503, 289, 1),
	(4,'House Greyjoy', 'We Do Not Sow', 'Kraken', 'Negro','0400.01.01', 'Dios Ahogado', 504, 289, 0),
	(5,'House Arryn', 'As High as Honor', 'Pajaro', 'Celeste','0350.01.01', 'Fe de los Siete', 505, 289, 1);

insert into Personaje(idPersonaje,nombre, fechaNacimiento, bastardo, estado, fkCasa, fkEspecie, fkrelacionFamiliar) values
	(2001,'Eddard Stark', '1500.01.01', 0, 'muerto',1,100, 3000),
	(2002,'Jon Snow', '1550.01.01', 1, 'vivo',1,100,3001),
	(2003,'Tywin Lannister', '1490.01.01', 0, 'vivo',2,100,null),
	(2004,'Jamie Lannister', '1510.01.01', 0, 'vivo',2,100,null),
	(2005,'Theon Greyjoy', '1550.01.01', 0, 'vivo',4,100,null);

insert into relacionFamiliar(padre, madre, idFamilia) values
	('Rickard Stark', 'Lyarra Stark', 3000),
	('Eddard Stark', null, 3001)

insert into Castillo(idCastillo, nombre, tipoFortificacion, sirvientes,fkReino) values
	(12001,'Winterfell', null, 670, 501),
	(12005,'Nido de Aguilas', null, 450, 505),
	(12003,'Harrenhal', 'Fortaleza', 200,503),
	(12002,'Casterly Rock', null, 650, 502 ),
	(12004,'Bastion de las Tormentas', null, 505, 504)

insert into Guerra(idGuerra, lugar, anio, cantidadMuertes) values
	(289, 'Las islas del hierro', 289, 350),
	(282, 'La rebelion de Robert', 282, 7500)

insert into Profesion(nombre, tipoProfesion, nombreMaestre,fkPersonaje,edadProfesion) values
	('Forja', 'Herrería', null, null, null),
	('Erudición', 'Consejero', null, null, null),
	('Venta', 'Vendedor', null, null, null),
	('Cientifico', 'Ciencia', null, null, null),
	('Jefe de Guerra', 'Realeza', null, null, null),
	('Señor', 'Realeza', null, 2001, 16)


insert into Especie(idEspecie,nombreCientifico, habilidades, hostil, existe) values
	(100, 'Humano', 'Inteligencia', 1, 1)


-- Consultas

--1) Que casa perdio una guerra?
select c.nombre as Nombre, g.lugar as Guerra, g.cantidadMuertes as Muertos
from Casa as c inner join Guerra as g on c.fkGuerra = g.idGuerra
where c.gano = 0

--2) Integrantes de las casas
select c.nombre as Nombre, count(p.nombre) as Cantidad_Integrantes
from casa as c inner join personaje as p on c.idCasa = p.fkCasa
group by c.nombre
order by Cantidad_Integrantes desc;

--3) Cuantas casas participaron en una misma guerra?
select g.lugar as Guerra, count(c.fkGuerra) as Participantes
from casa as c inner join Guerra as g on c.fkGuerra = g.idGuerra
group by g.lugar


--4) Integrantes de la Casa Stark
select p.nombre as Casa_Stark
from casa as c inner join Personaje as p on c.idCasa = p.fkCasa
where c.nombre = 'House Stark'

--5) Mostrar la relacion familiar de algún bastardo
select p.nombre as Bastardo, rf.padre as Padre, rf.madre as Madre
from Personaje as p inner join relacionFamiliar as rf on p.fkrelacionFamiliar = rf.idFamilia
where p.bastardo = 1

--6) Caracteristicas del personaje "Eddard Stark" 
select rf.padre as Padre, rf.madre as Madre, p.fechaNacimiento as Nacimiento, 
p.estado as Estado, e.nombreCientifico, prof.nombre as Rol, prof.tipoProfesion as Tipo_Profesion
from Personaje p inner join relacionFamiliar rf on rf.idFamilia = p.fkrelacionFamiliar
inner join Especie e on p.fkEspecie = e.idEspecie
inner join Profesion prof on prof.fkPersonaje = p.idPersonaje
where p.nombre = 'Eddard Stark'

--7) Cantidad de muertos total en el total de guerras que hubo
select count(g.lugar) as Total_Guerras ,sum(g.cantidadMuertes) as Total_Muertos
from Guerra g
=======
use master
go 

Create database TPO_GOTdb
use TPO_GOTdb
go


--PRUEBA
Create table Reino (
	nombreReino varchar(60) not null unique,
	idReino int primary key,
	cantidadHabitantes int not null,
	ciudades varchar(100) not null,
	continente varchar (30) not null,
	posicion varchar (5) check (posicion in ('Norte', 'Sur', 'Este', 'Oeste')),
);
/*
drop table Reino
drop table Casa
drop table Especie
drop table Castillo
drop table Guerra
drop table relacionFamiliar
drop table Personaje
drop table Profesion*/

--alter table Reino
--alter column nombreReino varchar(60)not null
Create table Casa (
	idCasa int primary key,
	nombre varchar(20) not null unique,
	lema varchar(30) not null,
	animal varchar(20) not null,
	color varchar(20) not null,
	fechaFund date not null,
	religion varchar(20),
	fkReino int foreign key (fkReino) references Reino(idReino),
	fkGuerra int foreign key (fkGuerra) references Guerra(idGuerra),
	gano bit --Gano guerra? 1 o 0
)

Create table relacionFamiliar (
	padre varchar(30),
	madre varchar(30),
	idFamilia int primary key,
)

Create table Personaje (
	idPersonaje int primary key,
	nombre varchar(30) not null,
	fechaNacimiento date not null,
	bastardo bit not null, -- 1 si es bastardo y 0 si no es bastardo
	estado varchar(8) check(estado in('vivo', 'muerto', 'inactivo')),
	CONSTRAINT uc_Personaje unique(Nombre, fechaNacimiento),
	fkCasa int foreign key (fkCasa) references Casa(idCasa), --Casa a la que pertenece == Apellido
	fkEspecie int foreign key (fkEspecie) references Especie(idEspecie), --Especie del personaje
	fkrelacionFamiliar int foreign key (fkrelacionFamiliar) references relacionFamiliar(idFamilia)
)


Create table Castillo (
	idCastillo int primary key,
	nombre varchar(30) not null unique,
	tipoFortificacion varchar(30) not null,
	sirvientes int not null,
	fkReino int foreign key(fkReino) references Reino(idReino) --Reino donde esta el castillo
)
alter table Castillo
alter column tipoFortificacion varchar(30)

Create table Guerra (
	idGuerra int primary key,
	lugar varchar(30) not null ,
	anio int not null check(anio< 325 AND anio > 0),
	cantidadMuertes int not null,
	CONSTRAINT uc_Guerra unique(Lugar, anio)
)


Create table Profesion (
	nombre varchar(30) not null,
	tipoProfesion varchar(30) not null,
	nombreMaestre varchar(100) not null,
	fkPersonaje int foreign key (fkPersonaje) references Personaje(idPersonaje),
	edadProfesion int --Edad de cuando comenzo 
)
alter table Profesion
alter column nombreMaestre varchar(30)

Create table Especie (
	idEspecie int primary key,
	nombreCientifico varchar(30) not null unique,
	habilidades varchar(100) not null,
	hostil bit not null,
	existe bit not null,
)

insert into Reino(nombreReino, idReino, cantidadHabitantes, ciudades, continente, posicion) values
	('El Reino del Norte', 501,25000, 'Winterfell', 'Westeros', 'Norte'),
	('El Reino de la roca', 502,30000, 'Roca casterly', 'Westeros', 'Oeste'),
	('El Reino de las Islas y los Ríos', 503,17000, 'Pyke', 'Westeros', 'Oeste'),
	('El Reino del Valle', 504, 10000, 'El valle', 'Westeros', 'Este'),
	('El Reino de las Tierras de la Tormenta', 505,8000 , 'Bastion de tormentas', 'Westeros', 'Sur');

insert into Casa(idCasa, nombre, lema, animal, color, fechaFund, religion, fkReino, fkGuerra, gano) values
	(1,'House Stark', 'Winter is coming', 'Lobo huargo', 'Gris','0200.01.01', 'Antiguos Dioses', 501,289, 1),
	(2,'House Lannister', 'Hear me roar', 'Leon', 'Carmesí', '0300.01.01','Fe de los Siete', 502, 289, 1),
	(3,'House Baratheon', 'Ours is the Fury', 'Ciervo', 'Amarillo', '1100.01.01', 'Señor de la Luz', 503, 289, 1),
	(4,'House Greyjoy', 'We Do Not Sow', 'Kraken', 'Negro','0400.01.01', 'Dios Ahogado', 504, 289, 0),
	(5,'House Arryn', 'As High as Honor', 'Pajaro', 'Celeste','0350.01.01', 'Fe de los Siete', 505, 289, 1);

insert into Personaje(idPersonaje,nombre, fechaNacimiento, bastardo, estado, fkCasa, fkEspecie, fkrelacionFamiliar) values
	(2001,'Eddard Stark', '1500.01.01', 0, 'muerto',1,100, 3000),
	(2002,'Jon Snow', '1550.01.01', 1, 'vivo',1,100,3001),
	(2003,'Tywin Lannister', '1490.01.01', 0, 'vivo',2,100,null),
	(2004,'Jamie Lannister', '1510.01.01', 0, 'vivo',2,100,null),
	(2005,'Theon Greyjoy', '1550.01.01', 0, 'vivo',4,100,null);

insert into relacionFamiliar(padre, madre, idFamilia) values
	('Rickard Stark', 'Lyarra Stark', 3000),
	('Eddard Stark', null, 3001)

insert into Castillo(idCastillo, nombre, tipoFortificacion, sirvientes,fkReino) values
	(12001,'Winterfell', null, 670, 501),
	(12005,'Nido de Aguilas', null, 450, 505),
	(12003,'Harrenhal', 'Fortaleza', 200,503),
	(12002,'Casterly Rock', null, 650, 502 ),
	(12004,'Bastion de las Tormentas', null, 505, 504)

insert into Guerra(idGuerra, lugar, anio, cantidadMuertes) values
	(289, 'Las islas del hierro', 289, 350),
	(282, 'La rebelion de Robert', 282, 7500)

insert into Profesion(nombre, tipoProfesion, nombreMaestre,fkPersonaje,edadProfesion) values
	('Forja', 'Herrería', null, null, null),
	('Erudición', 'Consejero', null, null, null),
	('Venta', 'Vendedor', null, null, null),
	('Cientifico', 'Ciencia', null, null, null),
	('Jefe de Guerra', 'Realeza', null, null, null),
	('Señor', 'Realeza', null, 2001, 16)

insert into Especie(idEspecie,nombreCientifico, habilidades, hostil, existe) values
	(100, 'Humano', 'Inteligencia', 1, 1)


-- Consultas

-- 1) Que casa perdio una guerra?
select * from Casa as c
where c.gano = 0

-- 2) Integrantes de las casas
select c.nombre, count(p.nombre) as cantidad_de_integrantes
from casa as c inner join personaje as p on c.idCasa = p.fkCasa
group by c.nombre
order by cantidad_de_integrantes desc;

--3) Cuantas casas participaron en una misma guerra?
select c.nombre, count() from Guerra
>>>>>>> 5997d0fd050b38b6f7a63ec1cff08a5b4609f8aa
