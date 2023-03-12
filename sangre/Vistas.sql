Use RegistroDonantesSangre;	
-- VISTAS 
CREATE VIEW ver_donaciones_hoy as
SELECT * FROM Datos_Personales WHERE fechaDonacion = current_date();

CREATE VIEW ver_enfermedades as
SELECT Datos_Personales.nombre, Enfermedades.Enfermedades
 FROM Datos_Personales INNER JOIN Enfermedades ON
 Datos_Personales.id = Enfermedades.id_Enfermedades;

CREATE VIEW ver_tipo_sangre as
SELECT Datos_Personales.nombre, TipoSangre.tipoSangre
 FROM Datos_Personales INNER JOIN TipoSangre ON
 Datos_Personales.id = TipoSangre.idSangre;

CREATE VIEW ver_sangre_especifica as
SELECT Datos_Personales.nombre, TipoSangre.tipoSangre
 FROM Datos_Personales INNER JOIN TipoSangre ON
 Datos_Personales.id = TipoSangre.idSangre WHERE TipoSangre.tipoSangre = 'O+';

CREATE VIEW ver_sangre_especifica_Onegativa as
SELECT Datos_Personales.nombre, TipoSangre.tipoSangre
 FROM Datos_Personales INNER JOIN TipoSangre ON
 Datos_Personales.id = TipoSangre.idSangre WHERE TipoSangre.tipoSangre = 'O-';
 
-- FIN VISTAS 