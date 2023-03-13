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

DROP PROCEDURE if exists insertar_Datos_Personales;