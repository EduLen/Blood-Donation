/*
SAUL LAGOS MORENO
EDUARDO LENIN CRUZ
WILBER O'CONNELL RUIZ
*/
DROP DATABASE IF EXISTS RegistroDonantesSangre;
Create DataBase RegistroDonantesSangre;
Use RegistroDonantesSangre;

Create Table Datos_Personales( 
	id_Datos_Personales INT NOT NULL AUTO_INCREMENT,
	cedula Varchar (16) not null UNIQUE,
	nombre_completo VARCHAR(255) not NULL,
	fecha_nacimiento Date not null,
    	estado varchar(10) default 'Activo',
	genero char(2) not null,
	primary key (id_Datos_Personales)
);

Select * from Datos_Personales;

Create Table Datos_Sangre(
id_Tipo_Sangre int not null AUTO_INCREMENT,
id_Persona int not null, 
tipo_Sangre VARCHAR (3) not null, 
primary key (id_Tipo_Sangre),
foreign key(id_Persona) references Datos_Personales(id_Datos_Personales)
);

CREATE TABLE Departamento(
	id_Departamento INT NOT NULL auto_increment,	
	departamento VARCHAR(255),
	PRIMARY KEY(id_Departamento)
);


CREATE TABLE Municipio(
	id_Municipio INT NOT NULL auto_increment,
	id_Departamento int not NULL,
	municipio VARCHAR(255),
	PRIMARY KEY(id_Municipio),
	FOREIGN KEY(id_Departamento) REFERENCES Departamento(id_Departamento)
);

CREATE TABLE Centro_Donacion(
	id_Centro_Donacion INT NOT NULL auto_increment,
	id_Departamento int NOT NULL,
	id_Municipio INT NOT NULL,
	centro_Donacion varchar(255),
	PRIMARY KEY(id_Centro_Donacion),
	FOREIGN KEY(id_Departamento) REFERENCES Departamento(id_Departamento),
	FOREIGN KEY(id_Municipio) REFERENCES Municipio(id_Municipio)
);


CREATE TABLE Donacion(
	id_Donacion INT AUTO_INCREMENT NOT NULL, 
    id_Datos_Personales int not null,
	id_Tipo_Sangre int not null,
    id_Centro_Donacion int not null,
    fecha_Donacion Date not null,
    cantidad_ml int not null, 
	PRIMARY KEY(id_Donacion) ,
    foreign key (id_Datos_Personales) references Datos_Personales(id_Datos_Personales),
	foreign key (id_Tipo_Sangre) references Datos_Sangre(id_Tipo_Sangre),
    foreign key (id_Centro_Donacion) references Centro_Donacion (id_Centro_Donacion)
);

CREATE TABLE Almacen (
	id_Bolsa int not null auto_increment,
	id_Donacion int NOT NULL,
    id_Tipo_Sangre int not null,
    cantidad_ml int,
   PRIMARY KEY(id_Bolsa),
   Foreign Key (id_Donacion) REFERENCES Donacion(id_Donacion),
   foreign key (id_Tipo_Sangre) references Datos_Sangre(id_Tipo_Sangre)
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
