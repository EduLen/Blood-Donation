/*
SAUL LAGOS MORENO
EDUARDO LENIN CRUZ
WILBER O'CONNELL RUIZ
*/
DROP DATABASE IF EXISTS RegistroDonantesSangre;
Create DataBase RegistroDonantesSangre;
Use RegistroDonantesSangre;
CREATE TABLE `Centro_Donacion` (
  `id_Centro_Donacion` int NOT NULL AUTO_INCREMENT,
  `id_Departamento` int NOT NULL,
  `id_Municipio` int NOT NULL,
  `centro_Donacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Centro_Donacion`),
  KEY `id_Departamento` (`id_Departamento`),
  KEY `id_Municipio` (`id_Municipio`),
  CONSTRAINT `Centro_Donacion_ibfk_1` FOREIGN KEY (`id_Departamento`) REFERENCES `Departamento` (`id_Departamento`),
  CONSTRAINT `Centro_Donacion_ibfk_2` FOREIGN KEY (`id_Municipio`) REFERENCES `Municipio` (`id_Municipio`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Datos_Personales` (
  `id_Datos_Personales` int NOT NULL AUTO_INCREMENT,
  `id_Sangre` int NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `cedula` varchar(16) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` char(2) NOT NULL,
  `estado` varchar(10) NOT NULL DEFAULT 'Activo',
  PRIMARY KEY (`id_Datos_Personales`),
  UNIQUE KEY `cedula` (`cedula`),
  KEY `id_Sangre` (`id_Sangre`),
  CONSTRAINT `Datos_Personales_ibfk_1` FOREIGN KEY (`id_Sangre`) REFERENCES `Datos_Sangre` (`id_Tipo_Sangre`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Datos_Sangre` (
  `id_Tipo_Sangre` int NOT NULL AUTO_INCREMENT,
  `tipo_Sangre` varchar(3) NOT NULL,
  PRIMARY KEY (`id_Tipo_Sangre`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Departamento` (
  `id_Departamento` int NOT NULL AUTO_INCREMENT,
  `departamento` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_Departamento`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Donacion` (
  `id_Donacion` int NOT NULL AUTO_INCREMENT,
  `id_Datos_Personales` int NOT NULL,
  `id_Centro_Donacion` int NOT NULL,
  `fecha_Donacion` date NOT NULL,
  `donar_de_nuevo` date DEFAULT NULL,
  `cantidad_ml` int NOT NULL,
  `analisis` varchar(100) DEFAULT (_utf8mb4'Sin Analizar'),
  PRIMARY KEY (`id_Donacion`),
  KEY `id_Datos_Personales` (`id_Datos_Personales`),
  KEY `id_Centro_Donacion` (`id_Centro_Donacion`),
  CONSTRAINT `Donacion_ibfk_1` FOREIGN KEY (`id_Datos_Personales`) REFERENCES `Datos_Personales` (`id_Datos_Personales`),
  CONSTRAINT `Donacion_ibfk_2` FOREIGN KEY (`id_Centro_Donacion`) REFERENCES `Centro_Donacion` (`id_Centro_Donacion`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Donaciones_Desechadas` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_Datos_Personales` int NOT NULL,
  `idDonacion` int NOT NULL,
  `motivo` text,
  PRIMARY KEY (`id`),
  KEY `id_Datos_Personales` (`id_Datos_Personales`),
  KEY `idDonacion` (`idDonacion`),
  CONSTRAINT `Donaciones_Desechadas_ibfk_1` FOREIGN KEY (`id_Datos_Personales`) REFERENCES `Datos_Personales` (`id_Datos_Personales`),
  CONSTRAINT `Donaciones_Desechadas_ibfk_2` FOREIGN KEY (`idDonacion`) REFERENCES `Donacion` (`id_Donacion`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `Municipio` (
  `id_Municipio` int NOT NULL AUTO_INCREMENT,
  `municipio` varchar(255) DEFAULT NULL,
  `id_Departamento` int NOT NULL,
  PRIMARY KEY (`id_Municipio`),
  KEY `id_Departamento` (`id_Departamento`),
  CONSTRAINT `Municipio_ibfk_1` FOREIGN KEY (`id_Departamento`) REFERENCES `Departamento` (`id_Departamento`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




