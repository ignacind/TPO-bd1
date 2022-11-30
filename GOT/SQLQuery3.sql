use master
go 

Create database GameOfThrones
use GameOfThrones
go


--PRUEBA
Create table Reino (
	nombreReino varchar(20) not null unique,
	idReino int primary key,
	cantidadHabitantes int not null,
	ciudades varchar(100) not null,
	continente varchar (30) not null,
	posicion varchar (5) check (posicion in ('Norte', 'Sur', 'Este', 'Oeste')),
);


Create table Guerra (
	idGuerra int primary key,
	lugar varchar(30) not null ,
	anio int not null check(anio< 325 AND anio > 0),
	cantidadMuertes int not null,
	CONSTRAINT uc_Guerra unique(Lugar, anio)
)

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
	gano varchar(2) check(gano in('SI', 'NO')),
)

Create table relacionFamiliar (
	padre varchar(30),
	madre varchar(30),
	idFamilia int primary key,
)


Create table Especie (
	idEspecie int primary key,
	nombreCientifico varchar(30) not null unique,
	habilidades varchar(100) not null,
	hostil bit not null,
	existe bit not null,
)

Create table Personaje (
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

Create table Profesion (
	nombre varchar(30) not null,
	tipoProfesion varchar(30) not null,
	nombreMaestre varchar(100) not null,
	fkPersonaje int foreign key (fkPersonaje) references Personaje(idPersonaje),
	edadProfesion int --Edad de cuando comenzo 
)



