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

INSERT INTO Departamento (departamento)
VALUES
  ( 'Boaco'),
  ( 'Carazo'),
  ( 'Chinandega'),
  ( 'Chontales'),
  ( 'Estelí'),
  ( 'Granada'),
  ( 'Jinotega'),
  ( 'León'),
  ( 'Madriz'),
  ( 'Managua'),
  ( 'Masaya'),
  ( 'Matagalpa'),
  ( 'Nueva Segovia'),
  ( 'Río San Juan'),
  ( 'Rivas'),
  (16, 'Región Autónoma del Atlántico Norte'),
  (17, 'Región Autónoma del Atlántico Sur');


CREATE TABLE Municipio(
	id_Municipio INT NOT NULL auto_increment,
	municipio VARCHAR(255),
    id_Departamento int not NULL,
	PRIMARY KEY(id_Municipio),
	FOREIGN KEY(id_Departamento) REFERENCES Departamento(id_Departamento)
);


INSERT INTO Municipio ( municipio, id_Departamento)
VALUES
  ('Boaco', 1),
  ( 'San José de los Remates', 1),
  ( 'San Lorenzo', 1),
  ( 'Santa Lucía', 1),
  ( 'Teustepe', 1),
  ( 'Jinotepe', 2),
  ( 'Diriamba', 2),
  ( 'San Marcos', 2),
  ( 'La Conquista', 2),
  ( 'Dolores', 2),
  ( 'El Rosario', 2),
  ('La Paz de Carazo', 2),
  ( 'Chinandega', 3),
  ( 'El Realejo', 3),
  ( 'Chichigalpa', 3),
  ( 'Posoltega', 3),
  ( 'Corinto', 3),
  ( 'El Viejo', 3),
  ( 'Puerto Morazán', 3),
  ( 'Santo Tomás del Norte', 3),
  ( 'Somotillo', 3),
  ( 'Villanueva', 3),
  ( 'Juigalpa', 4),
  ( 'Acoyapa', 4),
  ( 'Comalapa', 4),
  ( 'Cuapa', 4),
  ( 'El Coral', 4),
  ( 'La Libertad', 4),
  ( 'San Francisco de Cuapa', 4),
  ( 'San Pedro de Lóvago', 4),
  ( 'Santo Domingo', 4),
  ( 'Santo Tomás', 4),
  ( 'Villa Sandino', 4),
  ( 'Estelí', 5),
  ( 'Condega', 5),
  ( 'La Trinidad', 5),
  ( 'Pueblo Nuevo', 5),
  ( 'San Juan de Limay', 5),
  ( 'San Nicolás', 5),
  ( 'Granada', 6),
  ( 'Diriá', 6),
  ( 'Diriomo', 6),
  ( 'Guadalupe', 6),
  ( 'Jinotepe', 6),
  ( 'Nandaime', 6),
  ( 'Jinotega', 7),
  ( 'El Cuá', 7),
  ( 'La Concordia', 7),
  ( 'San José de Bocay', 7),
  ( 'San Rafael del Norte', 7),
  ( 'San Sebastián de Yalí', 7),
  ( 'Santa María de Pantasma', 7),
  ( 'Wiwilí', 7),
  ( 'León', 8),
  ( 'Achuapa', 8),
  ( 'El Jicaral', 8),
  ( 'El Sauce', 8),
  ( 'La Paz Centro', 8),
  ( 'Larreynaga', 8),
  ( 'Nagarote', 8),
  ( 'Quezalguaque', 8),
  ( 'Santa Rosa del Peñón', 8),
  ( 'Telica', 8),
  ( 'Somoto', 9),
  ( 'San Lucas', 9),
  ( 'Telpaneca', 9),
  ( 'Palacagüina', 9),
  ( 'Las Sabanas', 9),
  ( 'Yalagüina', 9),
  ( 'Managua', 10),
  ( 'Ciudad Sandino', 10),
  ( 'El Crucero', 10),
  ( 'Mateare', 10),
  ( 'San Francisco Libre', 10),
  ( 'San Rafael del Sur', 10),
  ( 'Ticuantepe', 10),
  ( 'Tipitapa', 10),
  ( 'Masaya', 11),
  ( 'Catarina', 11),
  ( 'La Concepción', 11),
  ( 'Masatepe', 11),
  ( 'Nandasmo', 11),
  ( 'Nindirí', 11),
  ( 'Niquinohomo', 11),
  ( 'San Juan de Oriente', 11),
  ( 'Tisma', 11),
  ( 'Matagalpa', 12),
  ( 'Ciudad Darío', 12),
  ( 'Esquipulas', 12),
  ( 'Matiguás', 12),
  ( 'Muy Muy', 12),
  ( 'Rancho Grande', 12),
  ( 'Río Blanco', 12),
  ( 'San Dionisio', 12),
  ( 'San Isidro', 12),
  ( 'San Ramón', 12),
  ( 'Sébaco', 12),
  ( 'Terrabona', 12),
  ( 'Ocotal', 13),
  ( 'Ciudad Antigua', 13),
  ( 'Dipilto', 13),
  ( 'El Jícaro', 13),
  ( 'Jalapa', 13),
  ( 'Macuelizo', 13),
  ( 'Mozonte', 13),
  ( 'Murra', 13),
  ( 'Quilalí', 13),
  ( 'San Fernando', 13),
  ( 'Santa María', 13),
  ( 'Wiwilí de Nueva Segovia', 13),
  ( 'El Castillo', 14),
  ( 'El Castillo' , 14),
  ( 'San Miguelito', 14),
  ( 'El Almendro', 14),
  ( 'Morrito', 14),
  ( 'San Juan De Nicaragua', 14),
  ( 'Rivas', 15),
  ( 'Altagracia', 15),
  ( 'Belén', 15),
  ( 'Buenos Aires', 15),
  ( 'Cárdenas', 15),
  ( 'Moyogalpa', 15),
  ( 'Potosí', 15),
  ( 'San Jorge', 15),
  ( 'San Juan del Sur', 15),
  ( 'Tola', 15),
  ( 'Región Autónoma del Atlántico Norte', 16),
  ( 'Región Autónoma del Atlántico Sur', 17);
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
