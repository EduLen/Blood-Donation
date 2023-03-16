Use RegistroDonantesSangre;	
CREATE VIEW vista_datos_personales_tipo_sangre AS
SELECT id, cedula, nombre, apellido, fecha_nacimiento, tipo_sangre, genero
FROM Datos_Personales;



CREATE VIEW vista_donaciones_centro_donacion AS
SELECT D.id_Donacion, CD.centro_Donacion, DP.nombre, DP.apellido, DP.tipo_sangre, D.fecha_Donacion, D.cantidad_ml
FROM Donacion D
INNER JOIN Datos_Personales DP ON D.id_donante = DP.id
INNER JOIN Centro_Donacion CD ON D.id_Centro_Donacion = CD.id_Centro_Donacion;
 


CREATE VIEW vista_bolsas_almacenadas AS
SELECT A.id_Bolsa, A.tipo_sangre, A.cantidad_ml
FROM Almacen A ;

CREATE VIEW vista_exportaciones AS
SELECT E.id_Exportacion, A.tipo_sangre, E.cantidad_bolsas, E.cantidad_ml, E.descripcion
FROM Exportacion E
INNER JOIN Almacen A ON E.id_Bolsa = A.id_Bolsa;
-- FIN VISTAS 