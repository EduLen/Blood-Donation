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