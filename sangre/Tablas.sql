/*
SAUL LAGOS MORENO
EDUARDO LENIN CRUZ
WILBER O'CONNELL RUIZ
*/
DROP DATABASE IF EXISTS RegistroDonantesSangre;
Create DataBase RegistroDonantesSangre;
Use RegistroDonantesSangre;


-- DROP TABLE IF EXISTS Datos_Personales;
Create Table Datos_Personales( 
	id_Datos_Personales INT NOT NULL AUTO_INCREMENT,
	cedula Varchar (16) not null UNIQUE,
	nombre_completo VARCHAR(255) not NULL,
	fecha_nacimiento Date not null,
    genero char(2) not null,
	primary key (id_Datos_Personales)
);

SELECT *
FROM Datos_Personales;

Create Table Datos_Sangre(
id_Tipo_Sangre int not null AUTO_INCREMENT,
id_Persona int not null, 
tipo_Sangre VARCHAR (3) not null, 
primary key (id_Tipo_Sangre),
foreign key(id_Persona) references Datos_Personales(id_Datos_Personales)
);
SELECT * FROM Datos_Sangre;

CREATE TABLE Departamento(
	id_Departamento INT NOT NULL auto_increment,
	id_Municipio INT NOT NULL,
	id_Centro_Donacion INT NOT NULL,
	departamento VARCHAR(255),
	PRIMARY KEY(id_Departamento),
	FOREIGN KEY(id_Municipio) REFERENCES Municipio(id_Municipio),
	FOREIGN KEY(id_Centro_Donacion) REFERENCES Centro_Donacion(id_Centro_Donacion)
);
SELECT * FROM Departamento;

CREATE TABLE Municipio(
	id_Municipio INT NOT NULL auto_increment,
	id_Centro_Donacion INT NOT NULL,
	municipio VARCHAR(255),
	PRIMARY KEY(id_Municipio),
	FOREIGN KEY(id_Centro_Donacion) REFERENCES Centro_Donacion(id_Centro_Donacion)
);
SELECT * FROM Municipio;

CREATE TABLE Centro_Donacion(
	id_Centro_Donacion INT NOT NULL auto_increment,
	centro_Donacion varchar(255),
	PRIMARY KEY(id_Centro_Donacion)
);

SELECT * FROM Centro_Donacion;

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

SELECT * From Donacion;
	-- este id_Datos_Personales de donante, nosotros en c# vamos a tener por ejemplo un datagrid con la lista de personas, 
	-- vamos a hacer una busqueda de las personas, y una vez que seleccionemos esa persona, obtenemos su id_Datos_Personales
-- manejarla cantidad en ml

-- _____________________________________________
-- arreglar y relacionar
CREATE TABLE Almacen (
	id_Bolsa int not null auto_increment,
	id_Donacion int NOT NULL,
    id_Tipo_Sangre int not null,
    cantidad_ml int,
   PRIMARY KEY(id_Bolsa),
   Foreign Key (id_Donacion) REFERENCES Donacion(id_Donacion),
   foreign key (id_Tipo_Sangre) references Datos_Sangre(id_Tipo_Sangre)
);
Drop table if EXISTS Almacen;
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