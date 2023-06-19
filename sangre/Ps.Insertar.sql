DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `actualizar_Datos_Personales`(
		IN pid_Datos_Personales INT,
        IN pid_Sangre INT,
		IN pcedula varchar(16),
        IN pnombre_completo VARCHAR(255),   
        IN pnumero varchar(12),
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
			id_Sangre = pid_Sangre,
			cedula = pcedula,
            nombre_completo = pnombre_completo,
            numero = pnumero,
            fecha_nacimiento = pfecha_nacimiento,
            genero = pgenero
            WHERE id_Datos_Personales  = pid_Datos_Personales  ;
		set pmensaje = "Se ha actualizado correctamente";
		COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `ActualizarDonacion`(
    IN donacion_id INT,
    IN nuevo_analisis VARCHAR(100),
    IN motivo_rechazo TEXT,
    IN pmensaje VARCHAR(200)
)
BEGIN
	DECLARE EXIT  HANDLER  FOR  SQLEXCEPTION
                BEGIN
					SET pmensaje= "ERROR: No se pudieron realizar los cambios";
                END;
                START TRANSACTION;
    -- Insertar la donación en la tabla "Donaciones_Desechadas" si es "Rechazado"
    IF nuevo_analisis = 'Rechazado' THEN
        INSERT INTO Donaciones_Desechadas (id_Datos_Personales, idDonacion, motivo)
        SELECT dp.id_Datos_Personales, d.id_Donacion, motivo_rechazo
        FROM Donacion d
        INNER JOIN Datos_Personales dp ON d.id_Datos_Personales = dp.id_Datos_Personales
        WHERE d.id_Donacion = donacion_id;
    END IF;
					SET pmensaje = "Se han realizado los cambios correctamente ";
				COMMIT;
    -- Actualizar la columna "analisis" en la tabla "Donacion"
    UPDATE Donacion SET analisis = "Examinado" WHERE id_Donacion = donacion_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `consultar_Datos_Personales`(IN pcedula varchar(16))
BEGIN 
		IF pcedula IS NULL THEN
			SELECT * FROM Datos_Personales;
		ELSE
			SELECT * FROM Datos_Personales WHERE cedula = pcedula;
		END IF;
    END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `donaciones_Sin_Analizar`(
	
)
BEGIN
					SELECT * FROM vista_donaciones WHERE analisis = "Sin Analizar";  
    END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `eliminar_Datos_Personales`(
	IN pcedula varchar(16),
    IN pestado varchar(10),
    OUT pmensaje VARCHAR(200))
BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
			BEGIN
				ROLLBACK;
					SELECT 'Error: no se pudo eliminar los datos de la persona';
			END;
		START TRANSACTION;
			UPDATE Datos_Personales SET
			estado = pestado
            WHERE cedula = pcedula; 
            set pmensaje = "Se han eliminado los datos correctamente";
        COMMIT;
        END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `insertar_Centro_Donacion`(
    IN pid_Departamento int,
    IN Pid_Municipio INT,
    IN pcentro_Donacion varchar(255),
    OUT pmensaje varchar(200))
BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        SELECT 'Error: no se pudo insertar el centro de salud';
                    END;
                START TRANSACTION;
                INSERT INTO Centro_Donacion(id_Departamento, id_Municipio, centro_Donacion) VALUES (pid_Departamento, pid_Municipio, pcentro_Donacion);
                set pmensaje = "Se ha insertado correctamente";
            COMMIT;
    END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `insertar_Datos_Personales`(
        IN pcedula varchar(16), 
        IN pnombre_completo VARCHAR(255),
        IN pfecha_nacimiento Date,
        IN pgenero char(2),
        IN pid_sangre INT,
        IN pnumero VARCHAR(15),
        OUT pmensaje varchar(200))
BEGIN
                DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                         ROLLBACK;
                        set pmensaje = 'Error: no se pudo insertar los datos de la persona';
                    END;
                START TRANSACTION;

                    INSERT INTO Datos_Personales(cedula, nombre_completo, fecha_nacimiento, genero, id_Sangre, numero) 
                    VALUES ( pcedula, pnombre_completo, pfecha_nacimiento, pgenero, pid_sangre, pnumero);
                    set pmensaje = "Se ha insertado el registro de manera exitosa";
                COMMIT;
            END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `insertar_Donacion`(
    IN pid_Datos_Personales int,
    IN pid_Centro_Donacion int,
    IN pfecha_Donacion DATE, 
    IN pcantidad_ml int,
    OUT pmensaje varchar(200))
BEGIN           
             DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN
                       
                        set pmensaje = 'Error: no se pudo insertar la donacion';
                          ROLLBACK;
                    END;
                START TRANSACTION;
                BEGIN
                DECLARE getDate varchar(15);
                             SELECT MAX(donar_de_nuevo) FROM Donacion WHERE id_Datos_Personales = (SELECT id_Datos_Personales FROM Datos_Personales WHERE                             id_Datos_Personales = pid_Datos_Personales) into getDate;
         -- aqui va todo
         
                IF getDate IS NULL THEN
                		        INSERT INTO Donacion( id_Datos_Personales, id_Centro_Donacion, fecha_Donacion, donar_de_nuevo, cantidad_ml) VALUES
							    ( pid_Datos_Personales, pid_Centro_Donacion, pfecha_Donacion, calcularFecha(pfecha_Donacion), pcantidad_ml);
                                 set pmensaje =  'Se inserto la donacion correctamente';
                else
				
			
                 
                   IF  pfecha_Donacion < getDate THEN
						        SET pmensaje = "Esta persona no puede donar porque no se ha cumplido el tiempo de recuperación";
				   ELSE IF pfecha_Donacion > getDate THEN
								INSERT INTO Donacion( id_Datos_Personales, id_Centro_Donacion, fecha_Donacion, donar_de_nuevo, cantidad_ml) VALUES
							    ( pid_Datos_Personales, pid_Centro_Donacion, pfecha_Donacion, calcularFecha(pfecha_Donacion), pcantidad_ml);
                                 set pmensaje =  'Se inserto la donacion correctamente';
					END IF;
END IF;         
         
				-- SET pmensaje = getDate;
 
               END IF;
                    COMMIT ;
                END ;
            END$$
DELIMITER ;

DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `vista_Donacion_p`(
	IN pcedula Varchar (16),
    IN pmensaje varchar(200)
)
BEGIN
		DECLARE EXIT  HANDLER  FOR  SQLEXCEPTION
                BEGIN
					set pmensaje= "Error: Esta persona aun no ha donado.";
                    ROLLBACK;
                END;
		START TRANSACTION;
			    
                select * From vista_donaciones WHERE cedula = pcedula;
                set pmensaje = "Se encontro a la persona correctamente";
        COMMIT;
    END$$
DELIMITER ;


DELIMITER $$
CREATE DEFINER=`educruz`@`%` PROCEDURE `vista_persona_c`(
	IN pcedula Varchar (16),
    IN pmensaje varchar(200)
)
BEGIN
		DECLARE EXIT  HANDLER  FOR  SQLEXCEPTION
                BEGIN
					set pmensaje= "Error: Esta persona no se encuntra a esta persona.";
                    ROLLBACK;
                END;
		START TRANSACTION;
			    
                select * From vista_personas_cedula WHERE cedula = pcedula;
                set pmensaje = "Se encontro a la persona correctamente";
        COMMIT;
    END$$
DELIMITER ;
--Arreglar esto

DELIMITER $$
CREATE DEFINER=`educruz`@`%` FUNCTION `calcularFecha`(fecha DATE) RETURNS date
    DETERMINISTIC
BEGIN 
		RETURN DATE_ADD(fecha, Interval 6 MONTH);
	END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE new_usser(
	IN p_usser VARCHAR(255),
    IN P_password VARCHAR(15),
    in pbusiness_position varchar(30),
    OUT pmessage VARCHAR(200)
)
	BEGIN
			DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN  
                    ROLLBACK;
                        set pmessage = 'Error: no se puede registrar el nuevo usuario';
                    END;
                START TRANSACTION;
                    INSERT INTO Login(usser, usser_password, business_position ) 
                    VALUES ( p_usser, p_password, pbusiness_position );
                    set pmessage = "Se ha agregado un nuevo usuario";
                COMMIT;
    END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE update_usser(
	IN p_id_Login INT,
	IN p_usser VARCHAR(255),
    IN P_password VARCHAR(15),
    in pbusiness_position varchar(30),
    OUT pmessage VARCHAR(200)
)
	BEGIN
		DECLARE EXIT HANDLER FOR SQLEXCEPTION
                    BEGIN  
                    ROLLBACK;
                        set pmessage = 'Error: no se puede actualizar usuario';
                    END;
		START TRANSACTION ;
			UPDATE Login SET 
            usser = p_usser,
            usser_password = p_password,
            business_position = pbusiness_position
            WHERE id_Login = p_id_Login;
            
            set pmessage = 'Se ha actualizado este usuario';
        COMMIT;
    END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE vista_Almacen()
	BEGIN
		SELECT * FROM vista_almacen;
    	END$$
DELIMITER ;

