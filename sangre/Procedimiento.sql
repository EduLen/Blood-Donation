Use RegistroDonantesSangre;	
-- Datos_personales
DROP PROCEDURE IF EXISTS Consultar;
DELIMITER $$
	CREATE PROCEDURE Consultar (IN idC int)
		BEGIN
			SELECT * 
			FROM Datos_Personales
			WHERE id = idC;
		END$$
DELIMITER ;
Call Consultar ('3');

Select * from Datos_Personales;
-- Insertar 
DROP PROCEDURE IF EXISTS insert_DP;
DELIMITER $$
	CREATE PROCEDURE insert_DP 
		(
		IN cedula VARCHAR (16), IN nombre VARCHAR (255), IN apellido VARCHAR(255), IN fechaDonacion DATE ,
		IN fechaNacimiento DATE , IN lugar_Origen VARCHAR (255))
			BEGIN
				INSERT INTO Datos_Personales(cedula, nombre, apellido, fechaDonacion, fecahanacimiento, lugar_Origen)
				VALUES (cedula, nombre, apellido, fechaDonacion, fechaNacimiento,  lugar_Origen);
			End$$
DELIMITER ;
CALL insert_DP('121-060104-1222G', 'Oconnel', 'Ruiz', '2022-11-21', '2004-03-12',  'Estelí');

-- Delete procedure
DROP PROCEDURE IF EXISTS eliminarRegistro;
DELIMITER $$
	CREATE PROCEDURE eliminarRegistro (IN id_er int)
		BEGIN
			delete FROM Datos_Personales where id = id_er;
		END$$
DELIMITER ;
CALL eliminarRegistro('2');

-- UPDATE PROCEDURE
DROP PROCEDURE IF EXISTS modificarRegistro;
DELIMITER $$
	CREATE PROCEDURE modificarRegistro
		(IN id_mr INT, IN cedula VARCHAR (16), IN nombre VARCHAR (255), IN apellido VARCHAR(255),
		IN fechaDonacion DATE , IN fechaNacimiento DATE , IN codigo INT , IN lugar_Origen VARCHAR (255))
	BEGIN
		UPDATE Datos_Personales d
		SET 
		d.cedula = cedula, 
		d.nombre = nombre, 
		d.apellido = apellido, 
		d.fechaDonacion = fechaDonacion, 
		d.fecahanacimiento = fechaNacimiento, 
		d.codigo = codigo, 
		d.lugar_Origen = lugar_Origen
		WHERE id = id_mr;
	END$$
DELIMITER ;
CALL modificarRegistro ('1','491-230903-100T', 'Eduardo', 'Lagos', '2022-11-19', '2003-09-23', 34, 'Esteli');

DROP PROCEDURE donaciones_dia;
DELIMITER $$
 CREATE PROCEDURE donaciones_dia(IN dia DATE)
 BEGIN
 SELECT * FROM Datos_Personales WHERE fechaDonacion = dia;
 END$$
 DELIMITER $$
 CALL donaciones_dia('2022-11-19');
 
 
-- Tipo de sangre Pocedimientos
DROP PROCEDURE IF EXISTS consultarTipoSangre;
DELIMITER $$
	CREATE PROCEDURE consultarTipoSangre (IN id int)
		BEGIN
			SELECT * FROM TipoSangre WHERE idPersona = id;
		END$$
DELIMITER ;
Call consultarTipoSangre('1');

DROP PROCEDURE IF EXISTS insertar_sangre;
DELIMITER $$
		CREATE PROCEDURE insertar_sangre(IN tipoSangre VARCHAR (3))
			BEGIN 
				INSERT INTO TipoSangre(tipoSangre)
			VALUES(tipoSangre);
			END$$
DELIMITER ;
 CALL insertar_sangre('O');

DELIMITER $$
	CREATE PROCEDURE eliminarTipoSangre(IN idSangreIns INT)
		BEGIN
			DELETE FROM TipoSangre WHERE idSangre = idSangreIns;
        END$$
DELIMITER ;
CALL eliminarTipoSangre('1');

DROP PROCEDURE IF EXISTS actualizarTipoSangre;
DELIMITER $$
	CREATE PROCEDURE actualizarTipoSangre
		(
        IN idSangreIns INT, IN idPersonaIns INT, IN tipoSangreIns VARCHAR (3)
        )
        BEGIN
			UPDATE TipoSangre
            SET idPersona =idPersonaIns, tipoSangre = tipoSangreIns
            where idSangre = idSangreIns;
        END$$
DELIMITER ;
CALL actualizarTipoSangre ('1','1','AB');

-- procedimientos bolsa sangre
DROP PROCEDURE IF EXISTS consultarBolsaSangre;
DELIMITER $$
	CREATE PROCEDURE consultarBolsaSangre (in idBolsa INT)
    BEGIN
		SELECT * FROM Bolsa_sangre WHERE Id_Bolsa = idBolsa;
    END$$
DELIMITER ;
CALL consultarBolsaSangre ('1');

DROP PROCEDURE IF EXISTS insertarBolsaSangre;
DELIMITER $$
	CREATE PROCEDURE  insertarBolsaSangre(idPersonaIns int, Tamaño_mlIns Varchar(3), 
    temperaturaIns VARCHAR(10))
    BEGIN
		INSERT INTO Bolsa_sangre(idPersona, Tamaño_ml, temperatura) VALUES (idPersonaIns, Tamaño_mlIns, temperaturaIns);
    END$$
DELIMITER ;
CALL insertarBolsaSangre('1','500','3');

DROP PROCEDURE IF EXISTS eliminarBolsaSangre;
DELIMITER $$
	CREATE PROCEDURE eliminarBolsaSangre (in idBolsa INT)
    BEGIN
		DELETE FROM Bolsa_sangre WHERE Id_Bolsa = idBolsa;
    END$$
DELIMITER ;
CALL eliminarBolsaSangre('1'); 

DROP PROCEDURE IF EXISTS modificarBolsaSangre;
DELIMITER $$
	CREATE PROCEDURE modificarBolsaSangre ( idBolsaM int, idPersonaM int, Tamaño_mlM Varchar(3), temperaturaM VARCHAR(10))
    BEGIN
		UPDATE Bolsa_sangre SET idPersona = idPersonaM, Tamaño_ml = Tamaño_mlM, temperatura = temperaturaM 	
        WHERE Id_Bolsa = idBolsaM;
    END$$
DELIMITER ;
CALL modificarBolsaSangre('1','1','250','2');

-- procedimiento enfermedades
DELIMITER $$
CREATE PROCEDURE insertar_enfermedad(IN id INT, IN enfermedad VARCHAR(30))
BEGIN 
   INSERT INTO Enfermedades(id_Enfermedades, Enfermedades)
   VALUES(id,enfermedad);
END$$
DELIMITER $$
CALL insertar_enfermedad(2, 'Diabetes');

DROP PROCEDURE InsertarProducto;
DELIMITER $$
	CREATE PROCEDURE insertarProducto (IN nombreIns VARCHAR(255), cantidadIns INT)
		BEGIN
			INSERT INTO productos(nombre, cantidad) VALUES (nombreIns, cantidadIns);
        END$$
DELIMITER ;
CALL insertarProducto('Plaquetas', 5);


-- Procedimineto donacion
DELIMITER $$
	CREATE PROCEDURE consultarDonaciones(IN id INT)
    BEGIN
		SELECT * FROM Donacion WHERE idDonacion = id;
    END$$
DELIMITER ;
Call consultarDonaciones ('1');
-- arreglar
DROP PROCEDURE IF EXISTS codigo_fecha;
DELIMITER $$
	CREATE PROCEDURE codigo_fecha(IN idFecha INT)
	BEGIN 
		INSERT INTO Donacion(codigo, DonarDeNuevo, idProducto, cantidad, id, idSangre, idBolsa, idHospital)
		VALUES((ROUND(UNIX_TIMESTAMP(CURTIME(4)) * 0.5)), (SELECT DATE_ADD(fechaDonacion,INTERVAL 6 MONTH) FROM Datos_Personales WHERE id = idFecha),
        (SELECT idProducto from productos WHERE idProducto = idFecha), (SELECT cantidad FROM Almacen WHERE id_almacen = idFecha), (SELECT id FROM Datos_Personales WHERE id = idFecha),
        (SELECT idSangre FROM TipoSangre WHERE idSangre = idFecha), (SELECT Id_Bolsa FROM Bolsa_sangre WHERE Id_Bolsa = idFecha), (SELECT id_Hospitales FROM Hospitales WHERE id_Hospitales = idFecha));
	END$$
 DELIMITER;
 call  codigo_fecha(1);  
 
-- Procedimiento exportación
DROP PROCEDURE IF EXISTS consultarExportacion;
DELIMITER $$
	CREATE PROCEDURE consultarExportacion(IN idExp INT)
    BEGIN
		SELECT * FROM Exportacion WHERE id = idExp; 
    END$$
DELIMITER ;
CALL consultarExportacion('1');

DROP PROCEDURE IF EXISTS insertarExportacion;
DELIMITER $$
	CREATE PROCEDURE insertarExportacion (cantidadIns int, idproductoIns INT, descripcionIns VARCHAR(255))
    BEGIN
		INSERT INTO Exportacion(cantidadBolsas, idproducto, descripcion) VALUES (cantidadBolsasIns, idproductoIns, descripcionIns);
    END$$
DELIMITER ;
CALL insertarExportacion('2', '1', 'Transfución de sangre');

-- Procedimiento deparamentos
DROP PROCEDURE IF EXISTS consultarDepartamento;
DELIMITER $$
	CREATE PROCEDURE consultarDepartamento(IN id INT)
    BEGIN
		SELECT * FROM Departamento WHERE id_departamento = id;
    END$$
DELIMITER ;
CALL consultarDepartamento(1);

DROP PROCEDURE IF EXISTS insertarDepartamento;
DELIMITER $$
	CREATE PROCEDURE insertarDepartamento (IN departamentoIns VARCHAR(255))
    BEGIN
		INSERT INTO Departamento(departamento) VALUES (departamentoIns);
    END$$
DELIMITER ;
CALL insertarDepartamento('Esteli');

-- procedimiento municipios
DROP PROCEDURE IF EXISTS consultarMunicipio;
DELIMITER $$
	CREATE PROCEDURE consultarMunicipio(in id INT)
    BEGIN
		SELECT * FROM municipios WHERE idMunicipios = id;
    END$$
DELIMITER ;
CALL consultarMunicipio('1');

DROP PROCEDURE IF EXISTS insertarMunicipio;
DELIMITER $$
	CREATE PROCEDURE insertarMunicipio ( IN municipioIns VARCHAR(255), IN idDepartamentoIns INT)
    BEGIN
		INSERT INTO municipios(municipio, id_departamento) VALUES (municipioIns, idDepartamentoIns);
    END$$
DELIMITER ;
CALL insertarMunicipio ('Esteli','1');

-- Procedimiento hospitales
DROP PROCEDURE consultarHospitales;
DELIMITER $$
	CREATE PROCEDURE consultarHospitales (IN id INT)
    BEGIN
		SELECT * FROM Hospitales WHERE id_hospitales = id;
    END$$
DELIMITER ;
CALL consultarHospitales('1');

DROP PROCEDURE IF EXISTS insertarHospital;
DELIMITER $$
	CREATE PROCEDURE insertarHospital (in hospitalIns VARCHAR(255), IN idMunicipiosIns INT, IN id_departamentoIns INT)
    BEGIN
		INSERT INTO Hospitales(hospital, idMunicipios, id_departamento) VALUES (hospitalIns, idMunicipiosIns, id_departamentoIns);
    END$$
DELIMITER ;
CALL insertarHospital('Hospital Adventista De Nicaragua','1','1'); 


DROP PROCEDURE insertar_donacion ;
DELIMITER $$
	CREATE PROCEDURE insertar_donacion ()
    BEGIN
		INSERT INTO Donacion(idProducto, cantidad, id, idSangre, idBolsa, idHospital)
        VALUES((SELECT idProducto from productos), (SELECT cantidad FROM Almacen), (SELECT id FROM Datos_Personales),
        (SELECT idSangre FROM TipoSangre), (SELECT Id_Bolsa FROM Bolsa_sangre), (SELECT id_Hospitales FROM Hospitales));
    END$$
DELIMITER ;
CALL insertar_donacion ();

SELECT * FROM Hospitales;
SELECT * FROM productos;
-- hacer un procedimiento almacenado pedir codigo, hospital, idproducto, cantidad
DROP PROCEDURE IF EXISTS insertarDonacion;
DELIMITER $$
	CREATE PROCEDURE insertarDonacion( id INT, idHospital INT)
		BEGIN
         INSERT INTO Donacion (codigo, hospital, idproducto, cantidad)
         VALUES((ROUND(UNIX_TIMESTAMP(CURTIME(4)) * 0.5)),(SELECT hospital FROM Hospitales WHERE id_hospitales = idHospital),
         (SELECT idProducto FROM  productos where idproducto = id), (SELECT cantidad FROM  productos WHERE idproducto = id));
        END$$
DELIMITER ;
CALL insertarDonacion(2, 7);
SELECT* FROM Donacion;