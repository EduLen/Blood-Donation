Use RegistroDonantesSangre;	
CREATE VIEW vista_datos_personales_tipo_sangre AS
SELECT id_Datos_Personales, cedula, nombre, apellido, fecha_nacimiento, tipo_sangre, genero
FROM Datos_Personales;

CREATE ALGORITHM=UNDEFINED DEFINER=`educruz`@`%` SQL SECURITY DEFINER VIEW `vista_donaciones` AS 
select `d`.`id_Donacion` AS `id_Donacion`,`dp`.`cedula` AS `cedula`,`dp`.`nombre_completo` AS `nombre_completo`,`cd`.`centro_Donacion` 
AS `centro_Donacion`,`mun`.`municipio` AS `municipio`,`dep`.`departamento` AS `departamento`,`ds`.`tipo_Sangre` 
AS `tipo_Sangre`,`d`.`cantidad_ml` AS `cantidad_ml`,`d`.`fecha_Donacion` AS `fecha_Donacion`,`d`.`donar_de_nuevo` 
AS `donar_de_nuevo`,`d`.`analisis` AS `analisis` 
from (((((`Donacion` `d` join `Datos_Personales` `dp` on((`d`.`id_Datos_Personales` = `dp`.`id_Datos_Personales`))) 
join `Centro_Donacion` `cd` on((`d`.`id_Centro_Donacion` = `cd`.`id_Centro_Donacion`))) join `Municipio` `mun` 
on((`cd`.`id_Municipio` = `mun`.`id_Municipio`))) join `Departamento` `dep` on((`cd`.`id_Departamento` = `dep`.`id_Departamento`))) 
join `Datos_Sangre` `ds` on((`dp`.`id_Sangre` = `ds`.`id_Tipo_Sangre`)));

CREATE ALGORITHM=UNDEFINED DEFINER=`educruz`@`%` SQL SECURITY DEFINER VIEW `vista_donaciones_rechazadas` AS select `d`.`fecha_Donacion` 
AS `fecha_Donacion`,`dp`.`nombre_completo` AS `nombre_completo`,`dd`.`motivo` AS `motivo`
from ((`Donaciones_Desechadas` `dd` join `Donacion` `d` on((`dd`.`id` = `d`.`id_Donacion`))) join `Datos_Personales` `dp` on
((`dd`.`id_Datos_Personales` = `dp`.`id_Datos_Personales`)));

CREATE ALGORITHM=UNDEFINED DEFINER=`educruz`@`%` SQL SECURITY DEFINER VIEW `vista_personas_cedula` AS select `dp`.`id_Datos_Personales` 
AS `id_Datos_Personales`,`dp`.`cedula` AS `cedula`,`dp`.`nombre_completo` AS `nombre_completo`,`ds`.`tipo_Sangre` 
AS `tipo_Sangre`,`dp`.`genero` AS `genero` from (`Datos_Personales` `dp` join `Datos_Sangre` `ds` 
on((`dp`.`id_Sangre` = `ds`.`id_Tipo_Sangre`)));

CREATE ALGORITHM=UNDEFINED DEFINER=`educruz`@`%` SQL SECURITY DEFINER VIEW `vista_personas_sangre` AS select `dp`.`id_Datos_Personales` 
AS `id_Datos_Personales`,`dp`.`cedula` AS `cedula`,`dp`.`nombre_completo` AS `nombre_completo`,`dp`.`fecha_nacimiento` 
AS `fecha_nacimiento`,`dp`.`numero` AS `numero`,`dp`.`genero` AS `genero`,`dp`.`estado` AS `estado`,`ds`.`tipo_Sangre` 
AS `Tipo_Sangre` from (`Datos_Personales` `dp` join `Datos_Sangre` `ds` on((`dp`.`id_Sangre` = `ds`.`id_Tipo_Sangre`)));


CREATE VIEW vista_almacen AS
SELECT a.id_Donacion, dp.nombre_completo, ds.tipo_Sangre, a.cantidad_ml
FROM Almacen a
JOIN Donacion d ON a.id_Donacion = d.id_Donacion
JOIN Datos_Personales dp ON d.id_Datos_Personales = dp.id_Datos_Personales
JOIN Datos_Sangre ds ON dp.id_Sangre = ds.id_Tipo_Sangre;
