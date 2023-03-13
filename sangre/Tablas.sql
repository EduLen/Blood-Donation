/*
SAUL LAGOS MORENO
EDUARDO LENIN CRUZ
WILBER O'CONNELL RUIZ
*/
DROP DATABASE IF EXISTS RegistroDonantesSangre;
Create DataBase RegistroDonantesSangre;
Use RegistroDonantesSangre;


-- DROP TABLE IF EXISTS Datos_Personales;
Create Table Datos_Personales( -- donantes
	id INT NOT NULL AUTO_INCREMENT,
	cedula Varchar (16) not null UNIQUE,
	nombre Varchar(255) Not null,
	apellido Varchar(255) Not null,
	fecha_nacimiento Date not null,
	tipo_sangre VARCHAR(5) NOT NULL,
    genero char(2) not null,
	primary key (id)
);


Create Table Datos_Sangre(
idSangre int not null AUTO_INCREMENT,
idPersona int not null, 
tipoSangre VARCHAR (3) not null, 
primary key (idSangre),
foreign key(idPersona) references Datos_Personales(id)
);
--tipo sangre mandar a tabla donacion o almacen?

CREATE TABLE Departamento(
	id_Departamento INT NOT NULL auto_increment,
	departamento VARCHAR(255),
	PRIMARY KEY(id_Departamento)
);

CREATE TABLE Municipio(
	id_Municipio INT NOT NULL auto_increment,
	municipio VARCHAR(255),
	PRIMARY KEY(id_Municipio)
);

CREATE TABLE Centro_Donacion(
	id_Centro_Donacion INT NOT NULL auto_increment,
	centro_Donacion varchar(255),
	PRIMARY KEY(id_Centro_Donacion)
);
-- Buscar como relacionarlas 

CREATE TABLE Donacion(
	id_Donacion INT AUTO_INCREMENT NOT NULL,
    id_donante int not null,
    id_Centro_Donacion int not null,
    fecha_Donacion Date not null,
	codigo int not null, 
    cantidad_ml int not null, 
	PRIMARY KEY(id_Donacion) ,
    foreign key (id_donante) references Datos_Personales(id),
    foreign key (id_Centro_Donacion) references Centro_Donacion (id_Centro_Donacion )
);
-- ver que ahcer con el codigo
-- manejarla cantidad en ml

DROP TABLE if EXISTS Donacion;
-- _____________________________________________
-- arreglar y relacionar
CREATE TABLE Almacen (
	id_Bolsa int not null auto_increment,
	id_Donacion int NOT NULL,
    tipo_sangre VARCHAR(3) not NULL, 
    cantidad_ml int,
   PRIMARY KEY(id_Bolsa),
   Foreign Key (id_Donacion) REFERENCES Donacion(id_Donacion)
);

CREATE TABLE Exportacion(
	id_Exportacion INT NOT NULL auto_increment,
	id_Bolsa int NOT NULL,
	cantidad_bolsas int not null,
	cantidad_ml int not null,
	tipo_sangre VARCHAR(3) not null,
	descripcion VARCHAR(255) not null,
	PRIMARY KEY(id_Exportacion),
	Foreign Key (id_Bolsa) REFERENCES Almacen(id_Bolsa)
);
-- arreglar y relacionar
-- _____________________________________________
 show tables;