DELIMITER $$
    CREATE PROCEDURE insertar_Datos_Personales(
        IN pcedula varchar(16), 
        IN pnombre_completo VARCHAR(255),   
        IN pfecha_nacimiento Date,       
        IN pgenero char(2),
        OUT pmensaje varchar(200))
            BEGIN
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar los datos de la persona';
                    END;
                START TRANSACTION;
                
                    INSERT INTO Datos_Personales(cedula, nombre_completo, fecha_nacimiento, genero) 
                    VALUES ( pcedula, pnombre_completo, pfecha_nacimiento, pgenero);
                    set pmensaje = "Se ha insertado el registro de manera exitosa";
                COMMIT;
            END
DELIMITER ;
CALL insertar_Datos_Personales('121-060404-1004G', 'Eduardo Lenin Cruz López', '2004-04-06', '+O', @mensaje);

-- Consultar en Datos Personales
DELIMITER $$
CREATE PROCEDURE consultar_datos_personales(IN idPersona = 0)
BEGIN 
IF(idPersona = 0) THEN
   SELECT * FROM Datos_Personales;
   ELSE
      SELECT * FROM Datos_Personales WHERE id_Datos_Personales = idPersona;
      END IF;
   END
DELIMITER ;
     call consultar_datos_personales(1);


   -- Eliminar datos personales
   DELIMITER $$ 
CREATE PROCEDURE eliminar_datos_personales(IN idPersona INT, OUT messageDelete VARCHAR(200))
BEGIN
DELETE FROM Datos_Personales WHERE id_Datos_Personales = idPersona;
SET messageDelete = "Se ha eliminado la persona exitosamente";
END$$ 
call eliminar_datos_personales(1, @messageDelete);



-- Consultar en Datos Personales
DELIMITER $$
CREATE PROCEDURE consultar_datos_personales(IN idPersona INT)
BEGIN 
IF IS NULL THEN
   SELECT * FROM Datos_Personales;
   ELSE
      SELECT * FROM Datos_Personales WHERE id_Datos_Personales = idPersona;
      END IF;
   END$$
     call consultar_datos_personales(1);
          call consultar_datos_personales(null);
   
   -- Eliminar datos personales
   DELIMITER $$ 
CREATE PROCEDURE eliminar_datos_personales(IN idPersona INT, OUT messageDelete VARCHAR(200))
BEGIN
DELETE FROM Datos_Personales WHERE id_Datos_Personales = idPersona;
SET messageDelete = "Se ha eliminado la persona exitosamente";
END$$ 
call eliminar_datos_personales(1, @messageDelete);



-- Insertar en datos de sangre

DELIMITER $$
CREATE PROCEDURE insertar_Datos_Sangre(
    IN pid_Persona INT,
    IN ptipo_Sangre varchar(3),
    OUT pmensaje varchar(200))
        BEGIN
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar los datos de la sangre';
                    END;
            START TRANSACTION;
                INSERT INTO Datos_Sangre(id_Persona, tipo_Sangre) VALUES (pid_Persona, ptipo_Sangre);
                set pmensaje = "Se ha insertado los datos de la sangre de manera exitosa";
            COMMIT;
        END
DELIMITER ;
CALL insertar_Datos_Sangre('1', '+O', @mensaje);

-- Consultar datos sangre
DELIMITER $$
CREATE PROCEDURE consultar_datos_sangre(IN idPersona INT)
BEGIN 
DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo consultar los datos";
				END;

      SELECT * FROM Datos_Sangre WHERE id_Datos_Personales = idPersona;
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

DELETE FROM TipoSangre WHERE id_Datos_Personales = idPersona;
SET messageDelete = "Se han eliminado los datos exitosamente";
END$$ 
call eliminar_datos_sangre(1, @messageDelete);


-- INSERTAR EN DEPARTAMENTO
DELIMITER $$





-- INSERTAR EN DEPARTAMENTO
DELIMITER $$
CREATE PROCEDURE insertar_departamento(
    IN pid_Municipio int,
    IN Pid_Centro_Donacion INT,
    pdepartamento VARCHAR(255)
    )
BEGIN
 DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo insertar los datos";
				END;
	  START TRANSACTION;
      INSERT INTO departamento(id_Municipio, id_Centro_Donacion, departamento) VALUES(pid_Municipio, Pid_Centro_Donacion, pdepartamento);
    END
DELIMITER ;
call insertar_departamento('1','1','Esteli');


-- Insertar municipio
DELIMITER $$
CREATE PROCEDURE insertar_municipio(
    IN pid_Centro_Donacion int,
    IN pmunicipio VARCHAR(255)
    )
        BEGIN
            DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
					ROLLBACK;
				SELECT "Error: no se pudo insertar los datos";
				END;
	  START TRANSACTION;
      INSERT INTO Municipio(id_Centro_Donacion, municipio) VALUES(pid_Centro_Donacion, pmunicipio);
    END
DELIMITER ;
call insertar_municipio('1','Esteli');




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
CREATE PROCEDURE insertar_Donacion(
    IN pid_Datos_Personales int,
    IN pid_Tipo_Sangre int,
    IN pid_Centro_Donacion int,
    IN pfecha_Donacion DATE, 
    IN pcantidad_ml int,
    OUT pmensaje varchar(200))
            BEGIN
                  
                
                INSERT INTO Donacion( id_Datos_Personales, id_Tipo_Sangre, id_Centro_Donacion, fecha_Donacion, cantidad_ml ) VALUES
                                    ( pid_Datos_Personales, pid_Tipo_Sangre, pid_Centro_Donacion, pfecha_Donacion, pcantidad_ml);
                set pmensaje = "Se ha insertado los datos de la donacion de manera exitosa";
           
            END
DELIMITER ;

Call insertar_Donacion('1','1','1', '2023-03-12', '500', @mensaje);
DROP Procedure if EXISTS insertar_Donacion;

--Arreglar esto
