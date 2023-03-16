DELIMITER $$
    CREATE PROCEDURE insertar_Datos_Personales(
        IN pcedula varchar(16), 
        IN pnombre varchar(255),
        IN papellido varchar(255),
        IN pfecha_nacimiento Date,
        IN ptipo_sangre varchar(5),
        IN pgenero char(2),
        OUT pmensaje varchar(200))
            BEGIN
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar los datos de la persona';
                    END;
                START TRANSACTION;
                
                    INSERT INTO Datos_Personales(cedula, nombre, apellido, fecha_nacimiento, tipo_sangre, genero) 
                    VALUES ( pcedula, pnombre, papellido, pfecha_nacimiento, ptipo_sangre, pgenero);
                    set pmensaje = "Se ha insertado el registro de manera exitosa";
                COMMIT;
            END
DELIMITER ;

-- Consultar en Datos Personales
DELIMITER $$
CREATE PROCEDURE consultar_datos_personales(IN idPersona INT)
BEGIN 
IF(idPersona = 0) THEN
   SELECT * FROM Datos_Personales;
   ELSE
      SELECT * FROM Datos_Personales WHERE id = idPersona;
      END IF;
   END$$
     call consultar_datos_personales(1);


   -- Eliminar datos personales
   DELIMITER $$ 
CREATE PROCEDURE eliminar_datos_personales(IN idPersona INT, OUT messageDelete VARCHAR(200))
BEGIN
DELETE FROM Datos_Personales WHERE id = idPersona;
SET messageDelete = "Se ha eliminado la persona exitosamente";
END$$ 
call eliminar_datos_personales(1, @messageDelete);
CALL insertar_Datos_Personales('121-060404-1004G', 'Eduardo', 'Cruz', '2004-04-06', '+O', 'M', @mensaje);

-- Insertar en datos de sangre

DELIMITER $$
CREATE PROCEDURE insertar_Datos_Sangre(
    IN pidPersona INT,
    IN ptipoSangre varchar(3),
    OUT pmensaje varchar(200))
        BEGIN
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar los datos de la sangre';
                    END;
            START TRANSACTION;
                INSERT INTO Datos_Sangre(idPersona, tipoSangre) VALUES (pidPersona, ptipoSangre);
                set pmensaje = "Se ha insertado los datos de la sangre de manera exitosa";
            COMMIT;
        END
DELIMITER ;

CALL insertar_Datos_Sangre('1', '+O', @mensaje);
SELECT*FROM datos_sangre;
-- Consultar datos sangre
DELIMITER $$
CREATE PROCEDURE consultar_datos_sangre(IN idPersona INT)
BEGIN 
DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo consultar los datos";
				END;

      SELECT * FROM Datos_Sangre WHERE id = idPersona;
   END$$
   call consultar_datos_sangre(1);


   --Eliminar datos en sangre
      DELIMITER $$ 
CREATE PROCEDURE eliminar_datos_sangre(IN idPersona INT, OUT messageDelete VARCHAR(200))
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo eliminar los datos";
				END;

DELETE FROM TipoSangre WHERE id = idPersona;
SET messageDelete = "Se han eliminado los datos exitosamente";
END$$ 
call eliminar_datos_sangre(1, @messageDelete);


-- INSERTAR EN DEPARTAMENTO
DELIMITER $$
CREATE PROCEDURE insertar_departamento(
pdepartamento VARCHAR(255)
)
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo insertar los datos";
				END;
	  START TRANSACTION;
      INSERT INTO departamento(departamento) VALUES(pdepartamento);
END$$
call insertar_departamento('Chontales');


-- Insertar municipio
DELIMITER $$
CREATE PROCEDURE insertar_municipio(
pmunicipio VARCHAR(255)
)
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo insertar los datos";
				END;
	  START TRANSACTION;
      INSERT INTO Municipio(municipio) VALUES(pmunicipio);
END$$
call insertar_departamento('Muy Muy');


-- Centro Donacion

DELIMITER $$
CREATE PROCEDURE insertar_Centro_Donacion(
    IN pcentro_Donacion varchar(255),
    OUT pmensaje varchar(200))
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar los datos del centro de salud';
                    END;
                START TRANSACTION;
                INSERT INTO Centro_Donacion(centro_Donacion) VALUES (pcentro_Donacion);
                set pmensaje = "Se ha insertado los datos de la centro de salud de manera exitosa";
            COMMIT;
    END
DELIMITER ;

CALL insertar_Centro_Donacion("Hospital San Juan De Dios", @mensaje);

-- Insertar en tabla donacion
DELIMITER $$
CREATE PROCEDURE insertar_Donacion( pid_Selector int, IN pid_donante int, IN pfecha_Donacion DATE, IN pcantidad_ml int,OUT pmensaje varchar(200))
        BEGIN
                    DECLARE EXIT HANDLER FOR SQLEXCEPTION
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar los datos de la donacion';
                    END;
                START TRANSACTION;
                INSERT INTO Donacion(id_Selector, id_donante, id_Centro_Donacion, fecha_Donacion, codigo, cantidad_ml ) VALUES (
                                                         |pid_Selector,
                                                         (SELECT id From Datos_Personales WHERE id = pid_Selector),
                                                         (SELECT id_Centro_Donacion FROM Centro_Donacion Where id_Centro_Donacion = pid_Selector),
                                                          pfecha_Donacion,
                                                         (ROUND(UNIX_TIMESTAMP(CURTIME(4)) * 0.5)),
                                                         pcantidad_ml
                                                         );
                set pmensaje = "Se ha insertado los datos de la donacion de manera exitosa";
            COMMIT;   
    END
DELIMITER ;

Call insertar_Donacion('1', '2023-03-12', '500', @mensaje);
DROP Procedure if EXISTS insertar_Donacion;

--Arreglar esto