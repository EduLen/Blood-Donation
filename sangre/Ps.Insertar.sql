-- Insertar Datos personales
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

CALL insertar_Datos_Personales('121-060404-1004G', 'Lenin Eduardo López Cruz', '2004-08-24', 'M', @mensaje);

-- Actualizar Datos personales 
DELIMITER $$
CREATE PROCEDURE actualizar_Datos_Personales(
		IN pcedula varchar(16), 
        IN pnombre_completo VARCHAR(255),   
        IN pfecha_nacimiento Date,       
        IN pgenero char(2),
        OUT pmensaje varchar(200)      
)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				ROLLBACK;
					SELECT 'Error: no se pudo actualizar los datos de la persona';
			END;
		START TRANSACTION;
		UPDATE Datos_Personales SET
			cedula = pcedula,
            nombre_completo = pnombre_completo,
            fecha_nacimiento = pfecha_nacimiento,
            genero = pgenero
            WHERE cedula = pcedula ;
		set pmensaje = "Se ha insertado el registro de manera exitosa";
		COMMIT;
    END
CALL actualizar_Datos_Personales('121-060404-1005G', 'Eduardo Lenin Cruz López', '2004-08-24', 'M', @mensaje);

-- Consultar en Datos Personales
DELIMITER $$
CREATE PROCEDURE consultar_Datos_Personales(IN pcedula varchar(16))
	BEGIN 
		IF pcedula IS NULL THEN
			SELECT * FROM Datos_Personales;
		ELSE
			SELECT * FROM Datos_Personales WHERE cedula = pcedula;
		END IF;
    END


CALL consultar_Datos_Personales(null);
CALL consultar_Datos_Personales('121-060404-1004G');

   -- Eliminar datos personales
DELIMITER $$ 
CREATE PROCEDURE eliminar_Datos_Personales(
	IN pcedula varchar(16),
    OUT pmensaje VARCHAR(200))
		BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				ROLLBACK;
					SELECT 'Error: no se pudo eliminar los datos de la persona';
			END;
		START TRANSACTION;
			DELETE FROM Datos_Personales WHERE cedula = pcedula; 
            set pmensaje = "Se han eliminado los datos de manera exitosa";
        COMMIT;
        END

CALL eliminar_Datos_Personales('121-060404-1004G', @mensaje);


-- --------------------------
-- Procediminetos Tipo Sangre
-- --------------------------
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

CALL insertar_Datos_Sangre('1', '-O', @mensaje);

-- Actualizar Datos Sangre
DELIMITER $$
CREATE PROCEDURE actualizar_Datos_Sangre(
	IN pid_Tipo_Sangre int,
	IN pid_Persona int, 
	IN ptipo_Sangre VARCHAR (3),
	OUT pmensaje varchar(200)      
)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				ROLLBACK;
					SELECT 'Error: no se pudo actualizar los datos de la sangre';
			END;
		START TRANSACTION;
		UPDATE Datos_Sangre SET
			id_Persona  = pid_Persona ,
            tipo_Sangre = ptipo_Sangre
            WHERE id_Tipo_Sangre = pid_Tipo_Sangre  ;
		set pmensaje = "Se han actualizado los datos de manera exitosa";
		COMMIT;
    END
    
CALL  actualizar_Datos_Sangre('2', '1', '+AB', @mensaje)

-- Consultar datos sangre
DELIMITER $$
CREATE PROCEDURE consultar_Datos_Sangre(IN pid_Tipo_Sangre int)
	BEGIN 
		IF pid_Tipo_Sangre IS NULL THEN
			SELECT * FROM Datos_Sangre;
		ELSE
			SELECT * FROM Datos_Sangre WHERE id_Tipo_Sangre = pid_Tipo_Sangre;
		END IF;
    END
call consultar_Datos_Sangre(null);
call consultar_Datos_Sangre(1);


-- Eliminar datos en sangre

DELIMITER $$ 
CREATE PROCEDURE eliminar_Datos_Sangre(
	IN pid_Tipo_Sangre int,
    OUT pmensaje VARCHAR(200))
		BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				ROLLBACK;
				SELECT 'Error: no se pudo eliminar los datos de la sangre';
			END;
		START TRANSACTION;
			DELETE FROM Datos_Sangre WHERE id_Tipo_Sangre = pid_Tipo_Sangre; 
            set pmensaje = "Se han eliminado los datos de manera exitosa";
        COMMIT;
        END
call eliminar_datos_sangre(1, @mensaje);



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
