DROP DATABASE IF EXISTS RegistroDonantesSangre;
Create DataBase RegistroDonantesSangre;
Use RegistroDonantesSangre;


-- DROP TABLE IF EXISTS Datos_Personales;
Create Table Datos_Personales( -- donantes
	id INT NOT NULL AUTO_INCREMENT,
	cedula Varchar (16) not null UNIQUE ,
	nombre Varchar(255) Not null,
	apellido Varchar(255) Not null,
	-- fechaDonacion date NOT NULL, meter en donacion
	fecahanacimiento Date not null,
	tipo_sangre VARCHAR(5) NOT NULL,
    genero varchar(255) not null,
	-- lugar_origen varchar(255) not null,
	-- EnfermeroExamenFisico VARCHAR(255),
	-- EnfermeroExtraccionSangre VARCHAR(255),
	-- presionArterial VARCHAR(10), meter en donación
	-- peso VARCHAR(10), meter en donacion 
	-- nivelDeGlucosa VARCHAR(10), meter en donación
	-- idSangre INT,
	primary key (id)
);
Select * from Datos_Personales;

Create Table TipoSangre(
idSangre int not null AUTO_INCREMENT,
idPersona int , 
tipoSangre VARCHAR (3) not null,
primary key (idSangre),
foreign key(idPersona) references Datos_Personales(id)
);



Create Table Bolsa_sangre(
	Id_Bolsa int not null auto_increment,
    idPersona int not null,
	Tamaño_ml Varchar(3) not null default "250",
	temperatura VARCHAR(10) not null default "2",
	primary key (Id_Bolsa),
	foreign key (idPersona) references Datos_Personales(id)
);

CREATE TABLE Enfermedades(
	id_Enfermedades INT NOT NULL AUTO_INCREMENT,
	idPersona INT,
	Enfermedades VARCHAR(255),
	PRIMARY KEY(id_Enfermedades),
	FOREIGN KEY(idPersona) REFERENCES Datos_Personales(id)
);



CREATE TABLE productos(
idproducto INT NOT NULL AUTO_INCREMENT ,
nombre VARCHAR(255) NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (idproducto)
);
-- INSERT INTO `registrodonantessangre`.`productos` (`nombre`, `cantidad`) VALUES ('Sangre', '10'); -- agregar en un procedimiento de almacenado
select * from productos;




CREATE TABLE Almacen (
	id_almacen int not null auto_increment,
    nombre varchar(255), 
    cantidad int,
    idproducto INT ,
	PRIMARY KEY(id_almacen),
    foreign key (idproducto) references productos(idproducto)
);
SELECT * FROM Almacen;


CREATE TABLE Exportacion(
	id INT NOT NULL auto_increment,
	cantidad int,
    idproducto int,
	descripcion VARCHAR(255),
	PRIMARY KEY(id),
	foreign key(idproducto) references productos(idproducto)
);

create table Departamento(
	id_departamento int not null auto_increment,
	departamento Varchar(255)not null,
	PRIMARY KEY(id_departamento)
);
insert into Departamento(departamento) values('Esteli'),('Madriz'),('Nueva Segovia'),('Managua'),('Matagalpa'),('Granada'),('Rivas'),('Rio San Juan'),
('Chinandega'),('Jinotega'),('Chontales'),('Leon'), ('Masaya'), ('Boaco'),('Carazo');

CREATE TABLE municipios(
	idMunicipios INT auto_increment NOT NULL,
	municipio VARCHAR(255) NOT NULL,
	id_departamento int,
	PRIMARY KEY(idMunicipios),
	foreign key(id_departamento) references Departamento(id_departamento)
);
insert into municipios(municipio, id_departamento) values ('Esteli','1'),('La Trinidad','1'),('Pueblo Nuevo','1'),('San Nicolas','1'),('San Juan de Limay','1'), ('Condega','1');
insert into municipios(municipio, id_departamento) values ('Somoto','2'),('San Lucas','2'),('San José de Cusmapa','2'),('Las Sabanas','2'),('Totogalpa','2'),('Telpaneca','2'),('Yalagüina','2'),('Palacagüina','2'),('San Juan del Río Coco','2');
insert into municipios(municipio, id_departamento) values ('Ocotal','3'),('Quilalí','3'),('Santa María','3'),('El Jícaro','3'),('Wiwilí','3'),('Ciudad Antigua','3'),('Dipilto','3'),('Jalapa','3'),('Murra','3'),('Macuelizo','3'),('Mozonte','3');
insert into municipios(municipio, id_departamento) values ('Managua','4'),('Mateare','4'),('Tipitapa','4'),('Ciudad Sandino','4'),('El Crucero','4'),('San Rafael del Sur','4'),('Villa el Carmen','4'),('San francisco libre','4'),('Ticuantepe','4');
insert into municipios(municipio, id_departamento) values ('Rancho Grande','5'),('Río Blanco','5'),('San Isidro','5'),('El Tuma-La Dalia','5'),('Sébaco','5'),('Matagalpa','5'),('San Ramón','5'),('Muy Muy','5'),('Esquipulas','5'),('San Dionisio','5'),('Terrabona','5'), ('Ciudad Dario','5');
insert into municipios(municipio, id_departamento) values ('Granada','6'),('Nandaime','6'),('Diriá','6'),('Diriomo','6');
insert into municipios(municipio, id_departamento) values ('Rivas','7'),('Cárdenas','7'),('Tola','7'),('Buenos Aires','7'),('San Juan del Sur','7'),('Belén','7'),('San Jorge','7'),('Moyogalpa','7'),('Potolsí','7'),('Altagracia','7'),('El Ostional','7');
insert into municipios(municipio, id_departamento) values ('San Carlos','8'),('El Castillo','8'),('El Almendro','8'),('San Juan del Norte','8'),('San Miguelito','8'),('Morrito','8');
insert into municipios(municipio, id_departamento) values ('Chinandega','9'),('Chichigalpa','9'),('Tonala','9'),('San Francisco del Norte','9'),('El Viejo','9'),('San Pedro del Norte','9'),('Somotillo','9'),('Posoltega','9'),('El Realejo','9'),('Villa Nueva','9'),('Santo Tomas del Norte','9'),('Cinco Pinos','9'),('Corinto','9' );
insert into municipios(municipio, id_departamento) values ('Jinotega','10'),('El Cuá','10'),('Santa María de pantasma','10'),('San Rafael del Norte','10'),('San José de Bocay','10'),('Wiwilí','10'),('La Concordia','10'),('San Sebastián de Yalí','10'),('La Dalia','10');
insert into municipios(municipio, id_departamento) values ('El Coral','11'),('Santo Tomás','11'),('Comalapa','11'),('El Almendro','11'),('Juigalpa','11'),('San Pedro de Lóvago','11'),('Cuapa','11'),('Acoyapa','11'),('Santo Domingo','11'),('El Ayote','11'),('La Libertad','11'),('Villa Sandino','11'),('La Gateada','11');
insert into municipios(municipio, id_departamento) values ('León','12'),('Telica','12'),('El Sauce','12'),('Larreynaga','12'),('El Jicaral','12'),('Achuapa','12'),('La Paz Centro','12'),('Quezalguaque','12'),('Santa Rosa del Peñón','12'),('Nagarote','12');
insert into municipios(municipio, id_departamento) values ('Masaya','13'),('Masatepe','13'),('Nindirí','13'),('La Concepción','13'),('Niquinohomo','13'),('Nandasmo','13'),('Tisma','13'),('Catarina','13'),('San Juan de Oriente','13');
insert into municipios(municipio, id_departamento) values ('Boaco','14'),('Camoapa','14'),('San Lorenzo','14'),('Teustepe','14'),('San José de los Remantes','14'),('Santa Lucía','14');
insert into municipios(municipio, id_departamento) values ('Jinotepe','15'),('El Rosario','15'),('La Paz','15'),('La Conquista','15'),('Diriamba','15'),('Dolores','15'),('San Marcos','15'),('Santa Teresa','15');

CREATE TABLE Hospitales(
	id_hospitales INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	hospital VARCHAR (255) NOT NULL,
	idMunicipios INT NOT NULL,
	id_departamento INT NOT NULL,
	foreign key(idMunicipios) references municipios(idMunicipios),
	foreign key(id_departamento) references Departamento(id_departamento)
);
select * from Hospitales;
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Adventista De Nicaragua','1','1'),('Hospital San Juan de Dios','1','1'),('Clínica Abventista Estelí','1','1'),('Sialis Estelí Delegación Departamental','1','1'),('Cruz Roja Filial Estelí','1','1'),
('Clínica previsional de salud','1','1'),('Clinica medica previsional Estelí','1','1'),('Centro Médico Nazareth','1','1'),('Centro médClinica Sermessa','1','1'),('Medical clinic','1','1'),('Centro de Salud Oscar Gámez','1','1'),('Centro De Salud Leonel Rugama','1','1'),('SILAIS','1','1');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Pedro Altamirano','2','1'), ('Antiguo Hospital Adventista La Trinidad','2','1');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Centro De Salud Julio Cesar Videa','3','1'), ('Hospital Monseñor Videa','3','1'  );
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Germán Pomares','4','1'), ('Iglesia De San Nicolas Esteli','4','1'), ('Centro de Salud de San Nicolas','4','1') ;
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Municipal','5','1'), ('Centro de salud san juan de Limay','5','1'), ('Clínica san ángel','5','1'), ('pidra. Marmolina','5','1');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Ada Maria Lopez','6','1');
-- Madriz
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Juan Antonio Brenes Palacio','7','2'),('Centro De Salud','7','2'),('Cruz Roja','7','2'),('SILAIS','7','2'); 
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Relacion Madriz','8','2');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Centro De Salud Héroes Y Mártires','9','2'),(' Puesto de Salud Augusto C. Sandino','9','2');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Centro De Salud','10','2'),(' Villa El Carmen','10','2'); 
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('CENTRO DE SALUD TOTOGALPA','11','2'),('Nido de las aves','11','2');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Cruz Roja','12','2'),('Centro de Salud','12','2');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Mini-Hospital Coronel Santos López','13','2');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Centro de Salud Haydee Meneses','14','2') ;
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Relacion Madriz','15','2');
-- Nueva Segovia
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Departamental de Nueva Segovia','16','3'),('Hospital Ocotal','16','3'), ('Hospital Dr. Alfonzo Moncada','16','3');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Hospital Bello Amanecer','17','3'),('Centro de Salud Germán Pomares','17','3');
INSERT INTO Hospitales(hospital,idMunicipios,id_departamento) values ('Relación con Nueva Segovia','18','3');
-- hacer un procedimiento almacenado pedir codigo, hospital, idproducto, cantidad
-- Trabajamos con los hospitales insertados manejandolos con el id
CREATE TABLE Donacion(
	idDonacion INT AUTO_INCREMENT NOT NULL,
    donante_id int not null,
    codigo int,
    idproducto INT,
    centro_donacion_id int not null,
    fecha_donacion Date not null,
    cantidad int, -- manejarlas en ml
	-- id int, -- redundante
	-- idSangre int, -- pueda que no sea necesario 
    -- idBolsa int, -- esto no es necesario 
	PRIMARY KEY(idDonacion) ,
    foreign key (donante_id) references Datos_Personales(id),
    foreign key (centro_donacion_id) references Hospitales (id_hospitales),
     foreign key(idproducto) references productos(idproducto)
	-- foreign key(id) references Datos_Personales(id),
	-- foreign key(idSangre) references TipoSangre(idSangre),
    -- foreign key(idBolsa) references Bolsa_sangre(Id_Bolsa),
    -- foreign key(idHospital) references Hospitales(id_hospitales)
);
SELECT * FROM  Donacion; 
Drop Table if exists Donacion;

Drop table IF EXISTS producto;

/*
SAUL LAGOS MORENO
EDUARDO LENIN CRUZ
WILBER O'CONNELL RUIZ
*/

