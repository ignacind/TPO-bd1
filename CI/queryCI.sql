use master
go 

Create database TPO_CIdb
use TPO_CIdb
go


Create table Docente (
	dni int primary key not null,
	nombre varchar(30) not null,
	apellido varchar(30) not null,
	domicilio varchar(40) not null,
	fechaNacimiento date not null check(fechaNacimiento < '2004/01/01' and fechaNacimiento > '1904/01/01'), --Tiene que ser mayor de 18 años el profesor y 100 años es el maximo
	materiaClases varchar(100)  not null,
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
	duracion float not null,
	fechaRealizacion date,
	recursosNecesarios varchar(40)
) 
Create table Servidor (
	ip_ int primary key not null, 
	nombre varchar(30) not null, 
	capacidad int not null, 
	marca varchar(30) not null,
	oficina varchar(20) not null, --Hacer Ministerio una entidad?
	reemplazoInicio date check(reemplazoInicio < reemplazoFinal),
	reemplazoFinal date check(reemplazoFinal < reemplazoInicio)
)