-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 05-05-2013 a las 22:57:04
-- Versión del servidor: 5.5.24-log
-- Versión de PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `odontogramas`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE IF NOT EXISTS `administrador` (
  `idAdmin` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `clave` varchar(45) NOT NULL,
  PRIMARY KEY (`idAdmin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`idAdmin`, `nombre`, `clave`) VALUES
(654321, 'Administrador', '123456');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comparacion`
--

CREATE TABLE IF NOT EXISTS `comparacion` (
  `diente1` varchar(250) NOT NULL,
  `diente2` varchar(250) NOT NULL,
  `comentario` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `comparacion`
--

INSERT INTO `comparacion` (`diente1`, `diente2`, `comentario`) VALUES
('19-17-002', '19-17-003', 'todo bn'),
('19-17-004', '19-17-07', 'otra u no se la anteriot'),
('19-17-002', '19-17-005', 'me confundi');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `consulta`
--

CREATE TABLE IF NOT EXISTS `consulta` (
  `iddatosConsulta` int(11) NOT NULL AUTO_INCREMENT,
  `motivoConsulta` varchar(1000) DEFAULT NULL,
  `historiaActualEnfermedad` varchar(1000) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `otros` varchar(255) DEFAULT NULL,
  `ultimaVisitaOdon` date DEFAULT NULL,
  `motivo` varchar(255) DEFAULT NULL,
  `paciente_idpersona` varchar(45) NOT NULL,
  `fechaConsulta` date DEFAULT NULL,
  `pronostico` varchar(45) DEFAULT NULL,
  `medico_idmedico` int(11) NOT NULL,
  `docente_iddocente` int(11) NOT NULL,
  PRIMARY KEY (`iddatosConsulta`),
  KEY `fk_datosConsulta_paciente1` (`paciente_idpersona`),
  KEY `fk_datosConsulta_medico1` (`medico_idmedico`),
  KEY `fk_Consulta_docente1` (`docente_iddocente`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `consulta`
--

INSERT INTO `consulta` (`iddatosConsulta`, `motivoConsulta`, `historiaActualEnfermedad`, `observaciones`, `otros`, `ultimaVisitaOdon`, `motivo`, `paciente_idpersona`, `fechaConsulta`, `pronostico`, `medico_idmedico`, `docente_iddocente`) VALUES
(19, 'motivo', 'historia', 'observa', 'otrs', '2013-01-02', 'asdf', '1047565684', '2013-01-19', 'Regular', 123456, 8656445);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controltratamiento`
--

CREATE TABLE IF NOT EXISTS `controltratamiento` (
  `idcontroltratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(45) DEFAULT NULL,
  `historiaClinica_idhistoriaClinica` int(11) NOT NULL,
  PRIMARY KEY (`idcontroltratamiento`),
  KEY `fk_controltratamiento_historiaClinica1_idx` (`historiaClinica_idhistoriaClinica`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Volcado de datos para la tabla `controltratamiento`
--

INSERT INTO `controltratamiento` (`idcontroltratamiento`, `fecha`, `historiaClinica_idhistoriaClinica`) VALUES
(7, '2013-04-06', 5),
(8, 'null', 5);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `controltratamiento_has_tratamiento`
--

CREATE TABLE IF NOT EXISTS `controltratamiento_has_tratamiento` (
  `controltratamiento_idcontroltratamiento` int(11) NOT NULL,
  `tratamiento_idtratamiento` int(11) NOT NULL,
  PRIMARY KEY (`controltratamiento_idcontroltratamiento`,`tratamiento_idtratamiento`),
  KEY `fk_controltratamiento_has_tratamiento_tratamiento1_idx` (`tratamiento_idtratamiento`),
  KEY `fk_controltratamiento_has_tratamiento_controltratamiento1_idx` (`controltratamiento_idcontroltratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `controltratamiento_has_tratamiento`
--

INSERT INTO `controltratamiento_has_tratamiento` (`controltratamiento_idcontroltratamiento`, `tratamiento_idtratamiento`) VALUES
(7, 316),
(7, 402);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE IF NOT EXISTS `curso` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `anio` varchar(45) DEFAULT NULL,
  `periodo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcurso`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Volcado de datos para la tabla `curso`
--

INSERT INTO `curso` (`idcurso`, `nombre`, `codigo`, `estado`, `anio`, `periodo`) VALUES
(1, 'Endodoncia-I', '676767', 'activado', '2012', '02');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosbasicos`
--

CREATE TABLE IF NOT EXISTS `datosbasicos` (
  `iddatosBasicos` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iddatosBasicos`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `datosbasicos`
--

INSERT INTO `datosbasicos` (`iddatosBasicos`, `nombre`) VALUES
(1, 'Tratamiento Medico '),
(2, 'Ingestion Medicamentos '),
(3, 'Reacciones Alergicas '),
(4, 'Anestesia '),
(5, 'Antibioticos '),
(6, 'Hemorragias '),
(7, 'Irradiaciones '),
(8, 'Sinusitis '),
(9, 'Enfermedades Respiratorias '),
(10, 'Cardiopatias'),
(11, 'Diabetes '),
(12, 'Fiebre Reumatica '),
(13, 'Hepatitia '),
(14, 'Hipertension '),
(15, 'Embarazo '),
(16, 'Enfermedades Renales '),
(17, 'Enfermedades Gastroinstestinales '),
(18, 'Organos de los Sentidos '),
(19, 'Enfermedades Infectocontagiosas ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosconsulta_has_datosbasicos`
--

CREATE TABLE IF NOT EXISTS `datosconsulta_has_datosbasicos` (
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `datosBasicos_iddatosBasicos` int(11) NOT NULL,
  `valor` varchar(45) DEFAULT NULL,
  `idConsulta_datosBasicos` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idConsulta_datosBasicos`),
  KEY `fk_datosConsulta_has_datosBasicos_datosBasicos1` (`datosBasicos_iddatosBasicos`),
  KEY `fk_datosConsulta_has_datosBasicos_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Volcado de datos para la tabla `datosconsulta_has_datosbasicos`
--

INSERT INTO `datosconsulta_has_datosbasicos` (`datosConsulta_iddatosConsulta`, `datosBasicos_iddatosBasicos`, `valor`, `idConsulta_datosBasicos`) VALUES
(19, 1, 'si', 1),
(19, 2, 'si', 2),
(19, 3, 'no', 3),
(19, 4, 'no', 4),
(19, 5, 'no sabe', 5),
(19, 6, 'no sabe', 6),
(19, 7, 'no sabe', 7),
(19, 8, 'no sabe', 8),
(19, 9, 'no sabe', 9),
(19, 10, 'no sabe', 10),
(19, 11, 'no sabe', 11),
(19, 12, 'no sabe', 12),
(19, 13, 'no sabe', 13),
(19, 14, 'no sabe', 14),
(19, 15, 'no sabe', 15),
(19, 16, 'no sabe', 16),
(19, 17, 'no sabe', 17),
(19, 18, 'no sabe', 18),
(19, 19, 'no sabe', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosconsulta_has_diagnostico`
--

CREATE TABLE IF NOT EXISTS `datosconsulta_has_diagnostico` (
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `diagnostico_iddiagnostico` int(11) NOT NULL,
  PRIMARY KEY (`datosConsulta_iddatosConsulta`,`diagnostico_iddiagnostico`),
  KEY `fk_datosConsulta_has_diagnostico_diagnostico1` (`diagnostico_iddiagnostico`),
  KEY `fk_datosConsulta_has_diagnostico_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosconsulta_has_diente`
--

CREATE TABLE IF NOT EXISTS `datosconsulta_has_diente` (
  `Iddatosconsulta_has_diente` int(11) NOT NULL AUTO_INCREMENT,
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `diente_iddiente` int(11) NOT NULL,
  `cara` varchar(45) DEFAULT NULL,
  `enfermedad` varchar(45) DEFAULT NULL,
  `realizar` varchar(45) NOT NULL,
  PRIMARY KEY (`Iddatosconsulta_has_diente`),
  KEY `fk_datosConsulta_has_diente_diente1` (`diente_iddiente`),
  KEY `fk_datosConsulta_has_diente_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1296 ;

--
-- Volcado de datos para la tabla `datosconsulta_has_diente`
--

INSERT INTO `datosconsulta_has_diente` (`Iddatosconsulta_has_diente`, `datosConsulta_iddatosConsulta`, `diente_iddiente`, `cara`, `enfermedad`, `realizar`) VALUES
(928, 19, 38, 'Oclusal', 'Caries o recidiva', 'Si'),
(929, 19, 37, 'Oclusal', 'Obturado', 'No'),
(935, 19, 35, 'Vestibular', 'Ausente', 'No'),
(936, 19, 35, 'Mesial', 'Ausente', 'No'),
(937, 19, 35, 'Distal', 'Ausente', 'No'),
(938, 19, 35, 'Oclusal', 'Ausente', 'No'),
(939, 19, 35, 'Lingual', 'Ausente', 'No'),
(940, 19, 34, 'Vestibular', 'Sellante', 'Si'),
(941, 19, 34, 'Mesial', 'Sellante', 'Si'),
(942, 19, 34, 'Distal', 'Sellante', 'Si'),
(943, 19, 34, 'Oclusal', 'Sellante', 'Si'),
(944, 19, 34, 'Lingual', 'Sellante', 'Si'),
(945, 19, 33, 'Vestibular', 'Exodoncia indicada', 'No'),
(946, 19, 33, 'Mesial', 'Exodoncia indicada', 'No'),
(947, 19, 33, 'Distal', 'Exodoncia indicada', 'No'),
(948, 19, 33, 'Oclusal', 'Exodoncia indicada', 'No'),
(949, 19, 33, 'Lingual', 'Exodoncia indicada', 'No'),
(950, 19, 32, 'Vestibular', 'Endodoncia', 'No'),
(951, 19, 32, 'Mesial', 'Endodoncia', 'No'),
(952, 19, 32, 'Distal', 'Endodoncia', 'No'),
(953, 19, 32, 'Oclusal', 'Endodoncia', 'No'),
(954, 19, 32, 'Lingual', 'Endodoncia', 'No'),
(955, 19, 31, 'Vestibular', 'Incluido', 'No'),
(956, 19, 31, 'Mesial', 'Incluido', 'No'),
(957, 19, 31, 'Distal', 'Incluido', 'No'),
(958, 19, 31, 'Oclusal', 'Incluido', 'No'),
(959, 19, 31, 'Lingual', 'Incluido', 'No'),
(960, 19, 28, 'Oclusal', 'Caries o recidiva', 'No'),
(961, 19, 38, 'Oclusal', 'Obturado', 'Si'),
(962, 19, 16, 'Oclusal', 'Caries o recidiva', 'Si'),
(965, 19, 17, 'Vestibular', 'Ausente', 'Si'),
(966, 19, 17, 'Mesial', 'Ausente', 'Si'),
(967, 19, 17, 'Distal', 'Ausente', 'Si'),
(968, 19, 17, 'Oclusal', 'Ausente', 'Si'),
(969, 19, 17, 'Palatina', 'Ausente', 'Si'),
(971, 19, 18, 'Vestibular', 'Prótesis existente', 'Si'),
(972, 19, 18, 'Mesial', 'Prótesis existente', 'Si'),
(973, 19, 18, 'Distal', 'Prótesis existente', 'Si'),
(974, 19, 18, 'Oclusal', 'Prótesis existente', 'Si'),
(975, 19, 18, 'Palatina', 'Prótesis existente', 'Si'),
(978, 19, 85, 'Lingual', 'Caries o recidiva', 'Si'),
(979, 19, 75, 'Lingual', 'Obturado', 'Si'),
(980, 19, 74, 'Lingual', 'Obturado', 'No'),
(981, 19, 65, 'Palatina', 'Obturado', 'Si'),
(982, 19, 64, 'Vestibular', 'Prótesis existente', 'No'),
(983, 19, 64, 'Mesial', 'Prótesis existente', 'No'),
(984, 19, 64, 'Distal', 'Prótesis existente', 'No'),
(985, 19, 64, 'Oclusal', 'Prótesis existente', 'No'),
(986, 19, 64, 'Lingual', 'Prótesis existente', 'No'),
(987, 19, 54, 'Vestibular', 'Incluido', 'No'),
(988, 19, 54, 'Mesial', 'Incluido', 'No'),
(989, 19, 54, 'Distal', 'Incluido', 'No'),
(990, 19, 54, 'Oclusal', 'Incluido', 'No'),
(991, 19, 54, 'Lingual', 'Incluido', 'No'),
(997, 19, 53, 'Vestibular', 'Corona completa', 'No'),
(998, 19, 53, 'Mesial', 'Corona completa', 'No'),
(999, 19, 53, 'Distal', 'Corona completa', 'No'),
(1000, 19, 53, 'Oclusal', 'Corona completa', 'No'),
(1001, 19, 53, 'Palatina', 'Corona completa', 'No'),
(1002, 19, 26, 'Vestibular', 'Sellante', 'Si'),
(1003, 19, 26, 'Mesial', 'Sellante', 'Si'),
(1004, 19, 26, 'Distal', 'Sellante', 'Si'),
(1005, 19, 26, 'Oclusal', 'Sellante', 'Si'),
(1006, 19, 26, 'Palatina', 'Sellante', 'Si'),
(1007, 19, 23, 'Oclusal', 'Caries o recidiva', 'Si'),
(1008, 19, 23, 'Oclusal', 'Obturado', 'Si'),
(1009, 19, 23, 'Vestibular', 'Corona completa', 'Si'),
(1010, 19, 23, 'Mesial', 'Corona completa', 'Si'),
(1011, 19, 23, 'Distal', 'Corona completa', 'Si'),
(1012, 19, 23, 'Oclusal', 'Corona completa', 'Si'),
(1013, 19, 23, 'Palatina', 'Corona completa', 'Si'),
(1015, 19, 35, 'Oclusal', 'Obturado', 'Si'),
(1016, 19, 26, 'Mesial', 'Caries o recidiva', 'Si'),
(1017, 19, 26, 'Vestibular', 'Caries o recidiva', 'Si'),
(1018, 19, 26, 'Distal', 'Caries o recidiva', 'Si'),
(1019, 19, 26, 'Palatina', 'Caries o recidiva', 'Si'),
(1021, 19, 26, 'Mesial', 'Obturado', 'Si'),
(1022, 19, 26, 'Vestibular', 'Obturado', 'Si'),
(1023, 19, 26, 'Distal', 'Obturado', 'Si'),
(1024, 19, 26, 'Palatina', 'Obturado', 'Si'),
(1025, 19, 26, 'Oclusal', 'Obturado', 'Si'),
(1026, 19, 26, 'Vestibular', 'Corona completa', 'Si'),
(1027, 19, 26, 'Mesial', 'Corona completa', 'Si'),
(1028, 19, 26, 'Distal', 'Corona completa', 'Si'),
(1029, 19, 26, 'Oclusal', 'Corona completa', 'Si'),
(1030, 19, 26, 'Palatina', 'Corona completa', 'Si'),
(1031, 19, 24, 'Mesial', 'Caries o recidiva', 'Si'),
(1032, 19, 24, 'Vestibular', 'Caries o recidiva', 'Si'),
(1033, 19, 24, 'Distal', 'Caries o recidiva', 'Si'),
(1034, 19, 24, 'Palatina', 'Caries o recidiva', 'Si'),
(1035, 19, 24, 'Oclusal', 'Caries o recidiva', 'Si'),
(1036, 19, 24, 'Mesial', 'Obturado', 'Si'),
(1037, 19, 24, 'Vestibular', 'Obturado', 'Si'),
(1038, 19, 24, 'Distal', 'Obturado', 'Si'),
(1039, 19, 24, 'Palatina', 'Obturado', 'Si'),
(1040, 19, 24, 'Oclusal', 'Obturado', 'Si'),
(1041, 19, 24, 'Vestibular', 'Corona completa', 'Si'),
(1042, 19, 24, 'Mesial', 'Corona completa', 'Si'),
(1043, 19, 24, 'Distal', 'Corona completa', 'Si'),
(1044, 19, 24, 'Oclusal', 'Corona completa', 'Si'),
(1045, 19, 24, 'Palatina', 'Corona completa', 'Si'),
(1046, 19, 23, 'Mesial', 'Caries o recidiva', 'No'),
(1047, 19, 23, 'Mesial', 'Obturado', 'No'),
(1048, 19, 23, 'Vestibular', 'Corona completa', 'No'),
(1049, 19, 23, 'Mesial', 'Corona completa', 'No'),
(1050, 19, 23, 'Distal', 'Corona completa', 'No'),
(1051, 19, 23, 'Oclusal', 'Corona completa', 'No'),
(1052, 19, 23, 'Palatina', 'Corona completa', 'No'),
(1053, 19, 23, 'Vestibular', 'Sellante', 'No'),
(1054, 19, 23, 'Mesial', 'Sellante', 'No'),
(1055, 19, 23, 'Distal', 'Sellante', 'No'),
(1056, 19, 23, 'Oclusal', 'Sellante', 'No'),
(1057, 19, 23, 'Palatina', 'Sellante', 'No'),
(1058, 19, 11, 'Mesial', 'Caries o recidiva', 'Si'),
(1059, 19, 11, 'Vestibular', 'Caries o recidiva', 'Si'),
(1060, 19, 11, 'Distal', 'Caries o recidiva', 'Si'),
(1061, 19, 11, 'Palatina', 'Caries o recidiva', 'Si'),
(1062, 19, 11, 'Oclusal', 'Caries o recidiva', 'Si'),
(1063, 19, 11, 'Mesial', 'Obturado', 'Si'),
(1064, 19, 11, 'Vestibular', 'Obturado', 'Si'),
(1065, 19, 11, 'Distal', 'Obturado', 'Si'),
(1066, 19, 11, 'Palatina', 'Obturado', 'Si'),
(1067, 19, 11, 'Oclusal', 'Obturado', 'Si'),
(1068, 19, 11, 'Vestibular', 'Corona completa', 'Si'),
(1069, 19, 11, 'Mesial', 'Corona completa', 'Si'),
(1070, 19, 11, 'Distal', 'Corona completa', 'Si'),
(1071, 19, 11, 'Oclusal', 'Corona completa', 'Si'),
(1072, 19, 11, 'Palatina', 'Corona completa', 'Si'),
(1073, 19, 14, 'Mesial', 'Caries o recidiva', 'Si'),
(1074, 19, 14, 'Vestibular', 'Caries o recidiva', 'Si'),
(1075, 19, 14, 'Distal', 'Caries o recidiva', 'Si'),
(1076, 19, 14, 'Palatina', 'Caries o recidiva', 'Si'),
(1077, 19, 14, 'Oclusal', 'Caries o recidiva', 'Si'),
(1078, 19, 14, 'Mesial', 'Obturado', 'Si'),
(1079, 19, 14, 'Vestibular', 'Obturado', 'Si'),
(1080, 19, 14, 'Distal', 'Obturado', 'Si'),
(1081, 19, 14, 'Palatina', 'Obturado', 'Si'),
(1082, 19, 14, 'Oclusal', 'Obturado', 'Si'),
(1083, 19, 14, 'Vestibular', 'Corona completa', 'Si'),
(1084, 19, 14, 'Mesial', 'Corona completa', 'Si'),
(1085, 19, 14, 'Distal', 'Corona completa', 'Si'),
(1086, 19, 14, 'Oclusal', 'Corona completa', 'Si'),
(1087, 19, 14, 'Palatina', 'Corona completa', 'Si'),
(1088, 19, 16, 'Mesial', 'Caries o recidiva', 'Si'),
(1089, 19, 16, 'Vestibular', 'Caries o recidiva', 'Si'),
(1090, 19, 16, 'Distal', 'Caries o recidiva', 'Si'),
(1091, 19, 16, 'Palatina', 'Caries o recidiva', 'Si'),
(1092, 19, 16, 'Mesial', 'Obturado', 'Si'),
(1093, 19, 16, 'Vestibular', 'Obturado', 'Si'),
(1094, 19, 16, 'Distal', 'Obturado', 'Si'),
(1095, 19, 16, 'Palatina', 'Obturado', 'Si'),
(1096, 19, 16, 'Vestibular', 'Corona completa', 'Si'),
(1097, 19, 16, 'Mesial', 'Corona completa', 'Si'),
(1098, 19, 16, 'Distal', 'Corona completa', 'Si'),
(1099, 19, 16, 'Oclusal', 'Corona completa', 'Si'),
(1100, 19, 16, 'Palatina', 'Corona completa', 'Si'),
(1101, 19, 16, 'Oclusal', 'Obturado', 'Si'),
(1102, 19, 35, 'Mesial', 'Caries o recidiva', 'Si'),
(1103, 19, 35, 'Vestibular', 'Caries o recidiva', 'Si'),
(1104, 19, 35, 'Distal', 'Caries o recidiva', 'Si'),
(1105, 19, 35, 'Lingual', 'Caries o recidiva', 'Si'),
(1106, 19, 35, 'Mesial', 'Obturado', 'Si'),
(1107, 19, 35, 'Vestibular', 'Obturado', 'Si'),
(1108, 19, 35, 'Distal', 'Obturado', 'Si'),
(1109, 19, 35, 'Lingual', 'Obturado', 'Si'),
(1110, 19, 35, 'Vestibular', 'Corona completa', 'Si'),
(1111, 19, 35, 'Mesial', 'Corona completa', 'Si'),
(1112, 19, 35, 'Distal', 'Corona completa', 'Si'),
(1113, 19, 35, 'Oclusal', 'Corona completa', 'Si'),
(1114, 19, 35, 'Lingual', 'Corona completa', 'Si'),
(1115, 19, 35, 'Oclusal', 'Caries o recidiva', 'Si'),
(1116, 19, 33, 'Mesial', 'Caries o recidiva', 'Si'),
(1117, 19, 33, 'Vestibular', 'Caries o recidiva', 'Si'),
(1118, 19, 33, 'Distal', 'Caries o recidiva', 'Si'),
(1119, 19, 33, 'Lingual', 'Caries o recidiva', 'Si'),
(1120, 19, 33, 'Oclusal', 'Caries o recidiva', 'Si'),
(1121, 19, 33, 'Mesial', 'Obturado', 'Si'),
(1122, 19, 33, 'Vestibular', 'Obturado', 'Si'),
(1123, 19, 33, 'Distal', 'Obturado', 'Si'),
(1124, 19, 33, 'Lingual', 'Obturado', 'Si'),
(1125, 19, 33, 'Oclusal', 'Obturado', 'Si'),
(1126, 19, 33, 'Vestibular', 'Corona completa', 'Si'),
(1127, 19, 33, 'Mesial', 'Corona completa', 'Si'),
(1128, 19, 33, 'Distal', 'Corona completa', 'Si'),
(1129, 19, 33, 'Oclusal', 'Corona completa', 'Si'),
(1130, 19, 33, 'Lingual', 'Corona completa', 'Si'),
(1131, 19, 31, 'Mesial', 'Caries o recidiva', 'Si'),
(1132, 19, 31, 'Vestibular', 'Caries o recidiva', 'Si'),
(1133, 19, 31, 'Distal', 'Caries o recidiva', 'Si'),
(1134, 19, 31, 'Lingual', 'Caries o recidiva', 'Si'),
(1135, 19, 31, 'Oclusal', 'Caries o recidiva', 'Si'),
(1136, 19, 31, 'Mesial', 'Obturado', 'Si'),
(1137, 19, 31, 'Vestibular', 'Obturado', 'Si'),
(1138, 19, 31, 'Distal', 'Obturado', 'Si'),
(1139, 19, 31, 'Lingual', 'Obturado', 'Si'),
(1140, 19, 31, 'Oclusal', 'Obturado', 'Si'),
(1141, 19, 31, 'Vestibular', 'Corona completa', 'Si'),
(1142, 19, 31, 'Mesial', 'Corona completa', 'Si'),
(1143, 19, 31, 'Distal', 'Corona completa', 'Si'),
(1144, 19, 31, 'Oclusal', 'Corona completa', 'Si'),
(1145, 19, 31, 'Lingual', 'Corona completa', 'Si'),
(1146, 19, 42, 'Mesial', 'Caries o recidiva', 'Si'),
(1147, 19, 42, 'Vestibular', 'Caries o recidiva', 'Si'),
(1148, 19, 42, 'Distal', 'Caries o recidiva', 'Si'),
(1149, 19, 42, 'Lingual', 'Caries o recidiva', 'Si'),
(1150, 19, 42, 'Oclusal', 'Caries o recidiva', 'Si'),
(1151, 19, 42, 'Mesial', 'Obturado', 'Si'),
(1152, 19, 42, 'Vestibular', 'Obturado', 'Si'),
(1153, 19, 42, 'Distal', 'Obturado', 'Si'),
(1154, 19, 42, 'Lingual', 'Obturado', 'Si'),
(1155, 19, 42, 'Oclusal', 'Obturado', 'Si'),
(1156, 19, 42, 'Vestibular', 'Corona completa', 'Si'),
(1157, 19, 42, 'Mesial', 'Corona completa', 'Si'),
(1158, 19, 42, 'Distal', 'Corona completa', 'Si'),
(1159, 19, 42, 'Oclusal', 'Corona completa', 'Si'),
(1160, 19, 42, 'Lingual', 'Corona completa', 'Si'),
(1161, 19, 44, 'Mesial', 'Caries o recidiva', 'Si'),
(1162, 19, 44, 'Vestibular', 'Caries o recidiva', 'Si'),
(1163, 19, 44, 'Distal', 'Caries o recidiva', 'Si'),
(1164, 19, 44, 'Lingual', 'Caries o recidiva', 'Si'),
(1165, 19, 44, 'Oclusal', 'Caries o recidiva', 'Si'),
(1166, 19, 44, 'Mesial', 'Obturado', 'Si'),
(1167, 19, 44, 'Vestibular', 'Obturado', 'Si'),
(1168, 19, 44, 'Distal', 'Obturado', 'Si'),
(1169, 19, 44, 'Lingual', 'Obturado', 'Si'),
(1170, 19, 44, 'Oclusal', 'Obturado', 'Si'),
(1171, 19, 44, 'Vestibular', 'Corona completa', 'Si'),
(1172, 19, 44, 'Mesial', 'Corona completa', 'Si'),
(1173, 19, 44, 'Distal', 'Corona completa', 'Si'),
(1174, 19, 44, 'Oclusal', 'Corona completa', 'Si'),
(1175, 19, 44, 'Lingual', 'Corona completa', 'Si'),
(1176, 19, 46, 'Mesial', 'Caries o recidiva', 'Si'),
(1177, 19, 46, 'Vestibular', 'Caries o recidiva', 'Si'),
(1178, 19, 46, 'Distal', 'Caries o recidiva', 'Si'),
(1179, 19, 46, 'Lingual', 'Caries o recidiva', 'Si'),
(1180, 19, 46, 'Oclusal', 'Caries o recidiva', 'Si'),
(1181, 19, 46, 'Mesial', 'Obturado', 'Si'),
(1182, 19, 46, 'Vestibular', 'Obturado', 'Si'),
(1183, 19, 46, 'Distal', 'Obturado', 'Si'),
(1184, 19, 46, 'Lingual', 'Obturado', 'Si'),
(1185, 19, 46, 'Oclusal', 'Obturado', 'Si'),
(1186, 19, 46, 'Vestibular', 'Corona completa', 'Si'),
(1187, 19, 46, 'Mesial', 'Corona completa', 'Si'),
(1188, 19, 46, 'Distal', 'Corona completa', 'Si'),
(1189, 19, 46, 'Oclusal', 'Corona completa', 'Si'),
(1190, 19, 46, 'Lingual', 'Corona completa', 'Si'),
(1191, 19, 48, 'Mesial', 'Caries o recidiva', 'Si'),
(1192, 19, 48, 'Vestibular', 'Caries o recidiva', 'Si'),
(1193, 19, 48, 'Distal', 'Caries o recidiva', 'Si'),
(1194, 19, 48, 'Lingual', 'Caries o recidiva', 'Si'),
(1195, 19, 48, 'Oclusal', 'Caries o recidiva', 'Si'),
(1196, 19, 48, 'Mesial', 'Obturado', 'Si'),
(1197, 19, 48, 'Vestibular', 'Obturado', 'Si'),
(1198, 19, 48, 'Distal', 'Obturado', 'Si'),
(1199, 19, 48, 'Lingual', 'Obturado', 'Si'),
(1200, 19, 48, 'Oclusal', 'Obturado', 'Si'),
(1201, 19, 48, 'Vestibular', 'Corona completa', 'Si'),
(1202, 19, 48, 'Mesial', 'Corona completa', 'Si'),
(1203, 19, 48, 'Distal', 'Corona completa', 'Si'),
(1204, 19, 48, 'Oclusal', 'Corona completa', 'Si'),
(1205, 19, 48, 'Lingual', 'Corona completa', 'Si'),
(1226, 19, 81, 'Mesial', 'Caries o recidiva', 'Si'),
(1227, 19, 81, 'Vestibular', 'Caries o recidiva', 'Si'),
(1228, 19, 81, 'Distal', 'Caries o recidiva', 'Si'),
(1229, 19, 81, 'Lingual', 'Caries o recidiva', 'Si'),
(1230, 19, 81, 'Oclusal', 'Caries o recidiva', 'Si'),
(1231, 19, 81, 'Mesial', 'Obturado', 'Si'),
(1232, 19, 81, 'Vestibular', 'Obturado', 'Si'),
(1233, 19, 81, 'Distal', 'Obturado', 'Si'),
(1234, 19, 81, 'Lingual', 'Obturado', 'Si'),
(1235, 19, 81, 'Oclusal', 'Obturado', 'Si'),
(1236, 19, 81, 'Vestibular', 'Corona completa', 'Si'),
(1237, 19, 81, 'Mesial', 'Corona completa', 'Si'),
(1238, 19, 81, 'Distal', 'Corona completa', 'Si'),
(1239, 19, 81, 'Oclusal', 'Corona completa', 'Si'),
(1240, 19, 81, 'Lingual', 'Corona completa', 'Si'),
(1241, 19, 81, 'Vestibular', 'Sellante', 'Si'),
(1242, 19, 81, 'Mesial', 'Sellante', 'Si'),
(1243, 19, 81, 'Distal', 'Sellante', 'Si'),
(1244, 19, 81, 'Oclusal', 'Sellante', 'Si'),
(1245, 19, 81, 'Lingual', 'Sellante', 'Si'),
(1246, 19, 81, 'Vestibular', 'Exodoncia indicada', 'Si'),
(1247, 19, 81, 'Mesial', 'Exodoncia indicada', 'Si'),
(1248, 19, 81, 'Distal', 'Exodoncia indicada', 'Si'),
(1249, 19, 81, 'Oclusal', 'Exodoncia indicada', 'Si'),
(1250, 19, 81, 'Lingual', 'Exodoncia indicada', 'Si'),
(1251, 19, 81, 'Vestibular', 'Incluido', 'Si'),
(1252, 19, 81, 'Mesial', 'Incluido', 'Si'),
(1253, 19, 81, 'Distal', 'Incluido', 'Si'),
(1254, 19, 81, 'Oclusal', 'Incluido', 'Si'),
(1255, 19, 81, 'Lingual', 'Incluido', 'Si'),
(1256, 19, 81, 'Vestibular', 'Prótesis existente', 'Si'),
(1257, 19, 81, 'Mesial', 'Prótesis existente', 'Si'),
(1258, 19, 81, 'Distal', 'Prótesis existente', 'Si'),
(1259, 19, 81, 'Oclusal', 'Prótesis existente', 'Si'),
(1260, 19, 81, 'Lingual', 'Prótesis existente', 'Si'),
(1261, 19, 55, 'Mesial', 'Caries o recidiva', 'Si'),
(1262, 19, 55, 'Vestibular', 'Caries o recidiva', 'Si'),
(1263, 19, 55, 'Distal', 'Caries o recidiva', 'Si'),
(1264, 19, 55, 'Palatina', 'Caries o recidiva', 'Si'),
(1265, 19, 55, 'Oclusal', 'Caries o recidiva', 'Si'),
(1266, 19, 55, 'Mesial', 'Obturado', 'Si'),
(1267, 19, 55, 'Vestibular', 'Obturado', 'Si'),
(1268, 19, 55, 'Distal', 'Obturado', 'Si'),
(1269, 19, 55, 'Palatina', 'Obturado', 'Si'),
(1270, 19, 55, 'Oclusal', 'Obturado', 'Si'),
(1271, 19, 55, 'Vestibular', 'Corona completa', 'Si'),
(1272, 19, 55, 'Mesial', 'Corona completa', 'Si'),
(1273, 19, 55, 'Distal', 'Corona completa', 'Si'),
(1274, 19, 55, 'Oclusal', 'Corona completa', 'Si'),
(1275, 19, 55, 'Palatina', 'Corona completa', 'Si'),
(1276, 19, 55, 'Vestibular', 'Sellante', 'Si'),
(1277, 19, 55, 'Mesial', 'Sellante', 'Si'),
(1278, 19, 55, 'Distal', 'Sellante', 'Si'),
(1279, 19, 55, 'Oclusal', 'Sellante', 'Si'),
(1280, 19, 55, 'Palatina', 'Sellante', 'Si'),
(1281, 19, 55, 'Vestibular', 'Exodoncia indicada', 'Si'),
(1282, 19, 55, 'Mesial', 'Exodoncia indicada', 'Si'),
(1283, 19, 55, 'Distal', 'Exodoncia indicada', 'Si'),
(1284, 19, 55, 'Oclusal', 'Exodoncia indicada', 'Si'),
(1285, 19, 55, 'Palatina', 'Exodoncia indicada', 'Si'),
(1286, 19, 55, 'Vestibular', 'Incluido', 'Si'),
(1287, 19, 55, 'Mesial', 'Incluido', 'Si'),
(1288, 19, 55, 'Distal', 'Incluido', 'Si'),
(1289, 19, 55, 'Oclusal', 'Incluido', 'Si'),
(1290, 19, 55, 'Palatina', 'Incluido', 'Si'),
(1291, 19, 55, 'Vestibular', 'Prótesis existente', 'Si'),
(1292, 19, 55, 'Mesial', 'Prótesis existente', 'Si'),
(1293, 19, 55, 'Distal', 'Prótesis existente', 'Si'),
(1294, 19, 55, 'Oclusal', 'Prótesis existente', 'Si'),
(1295, 19, 55, 'Palatina', 'Prótesis existente', 'Si');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosconsulta_has_plantratamiento`
--

CREATE TABLE IF NOT EXISTS `datosconsulta_has_plantratamiento` (
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `planTratamiento_idplanTratamiento` int(11) NOT NULL,
  PRIMARY KEY (`datosConsulta_iddatosConsulta`,`planTratamiento_idplanTratamiento`),
  KEY `fk_datosConsulta_has_planTratamiento_planTratamiento1` (`planTratamiento_idplanTratamiento`),
  KEY `fk_datosConsulta_has_planTratamiento_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `datosconsulta_has_plantratamiento`
--

INSERT INTO `datosconsulta_has_plantratamiento` (`datosConsulta_iddatosConsulta`, `planTratamiento_idplanTratamiento`) VALUES
(19, 1),
(19, 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosconsulta_has_tratamiento`
--

CREATE TABLE IF NOT EXISTS `datosconsulta_has_tratamiento` (
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `tratamiento_idtratamiento` int(11) NOT NULL,
  PRIMARY KEY (`datosConsulta_iddatosConsulta`,`tratamiento_idtratamiento`),
  KEY `fk_datosConsulta_has_tratamiento_tratamiento1` (`tratamiento_idtratamiento`),
  KEY `fk_datosConsulta_has_tratamiento_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE IF NOT EXISTS `departamentos` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`codigo`, `nombre`) VALUES
(5, 'Antioquia'),
(8, 'Atlántico'),
(13, 'Bolívar'),
(15, 'Boyacá'),
(17, 'Caldas'),
(18, 'Caquetá'),
(19, 'Cauca'),
(20, 'Cesar'),
(23, 'Córdoba'),
(25, 'Cundinamarca'),
(27, 'Chocó'),
(41, 'Huila'),
(44, 'La Guajira'),
(47, 'Magdalena'),
(50, 'Meta'),
(52, 'Nariño'),
(54, 'Norte de Santander'),
(63, 'Quindío'),
(66, 'Risaralda'),
(68, 'Santander'),
(70, 'Sucre'),
(73, 'Tolima'),
(76, 'Valle del Cauca'),
(81, 'Arauca'),
(85, 'Casanare'),
(86, 'Putumayo'),
(88, 'San Andrés'),
(91, 'Amazonas'),
(94, 'Guainía'),
(95, 'Guaviare'),
(97, 'Vaupés'),
(99, 'Vichada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnostico`
--

CREATE TABLE IF NOT EXISTS `diagnostico` (
  `iddiagnostico` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) DEFAULT NULL,
  `diagnostico` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iddiagnostico`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=973401 ;

--
-- Volcado de datos para la tabla `diagnostico`
--

INSERT INTO `diagnostico` (`iddiagnostico`, `codigo`, `diagnostico`) VALUES
(227101, '227101', 'REPARACION DE FISTULA  OROANTRAL Y/U ORONASAL'),
(227200, '227200', 'ELEVACION DEL PISO DEL SENO MAXILAR  '),
(230101, '230101', 'EXODONCIA DE DIENTES PERMANENTES UNIRRADICULARES.'),
(230102, '230102', 'EXODONCIA DE DIENTES PERMANENTES MULTIRRADICULARES.'),
(230201, '230201', 'EXODONCIA DE DIENTES TEMPORALES UNIRRADICULARES.'),
(230202, '230202', 'EXODONCIA DE DIENTES TEMPORALES MULTIRRADICULARES.'),
(231100, '231100', 'EXODONCIA QUIRURGICA UNIRRADICULAR  '),
(231200, '231200', 'EXODONCIA QUIRURGICA MULTIRRADICULAR.  '),
(231301, '231301', 'EXODONCIA DE DIENTE  INCLUIDO'),
(231302, '231302', 'EXODONCIA DE INCLUIDOS EN POSICIÓN ECTÓPICA CON ABORDAJE INTRAORAL   (POR DIENTE)'),
(231303, '231303', 'EXODONCIA DE INCLUIDOS EN POSICIÓN ECTÓPICA CON ABORDAJE EXTRAORAL(POR DIENTE)'),
(231400, '231400', 'EXODONCIAS  MÚLTIPLES CON ALVEOLOPLASTIA POR CUADRANTE  '),
(231500, '231500', 'COLGAJO DESPLAZADO PARA ABORDAJE DE DIENTE RETENIDO (VENTANA QUIRURGICA)  '),
(232101, '232101', 'OBTURACIÓN DENTAL POR SUPERFICIE  CON  AMALGAMA'),
(232102, '232102', 'OBTURACIÓN DENTAL POR SUPERFICIE CON  RESINA DE FOTOCURADO'),
(232103, '232103', 'OBTURACIÓN DENTAL POR SUPERFICIE CON  IONÓMERO DE VIDRIO'),
(232200, '232200', 'OBTURACION TEMPORAL POR DIENTE  '),
(232300, '232300', 'COLOCACIÓN DE PIN MILIMÉTRICO  '),
(232401, '232401', 'RECONSTRUCCIÓN DE ÁNGULO INCISAL CON RESINA DE FOTOCURADO'),
(232402, '232402', 'RECONSTRUCCIÓN  TERCIO INCISAL CON RESINA DE FOTOCURADO'),
(233100, '233100', 'RESTAURACION DE  DIENTES MEDIANTE INCRUSTACION METALICA  '),
(233200, '233200', 'RESTAURACION DE  DIENTES MEDIANTE INCRUSTACION NO  METALICA  '),
(234101, '234101', 'COLOCACION O APLICACIÓN DE CORONA EN ACERO INOXIDABLE ( PARA DIENTES TEMPORALES)'),
(234102, '234102', 'COLOCACION O APLICACIÓN DE CORONA EN POLICARBOXILATO  (PARA DIENTES TEMPORALES)'),
(234103, '234103', 'COLOCACION O APLICACIÓN DE CORONA EN FORMA PLÁSTICA'),
(234104, '234104', 'COLOCACION O APLICACIÓN DE CORONA ACRÍLICA TERMOCURADA'),
(236300, '236300', 'IMPLANTE DENTAL ALOPLASTICO (OSEOINTEGRACION)  '),
(237101, '237101', 'PULPOTOMÍA '),
(237102, '237102', 'PULPECTOMIA'),
(237200, '237200', 'APEXIFICACIÓN O APEXOGENESIS  '),
(237301, '237301', 'TERAPIA DE CONDUCTO RADICULAR EN DIENTES UNIRRADICULARES PERMANENTES'),
(237302, '237302', 'TERAPIA DE CONDUCTO RADICULAR EN DIENTES BIRRADICULARES PERMANENTES'),
(237303, '237303', 'TERAPIA DE CONDUCTO RADICULAR EN DIENTES MULTIRRADICULARES PERMANENTES'),
(237304, '237304', 'TERAPIA DE CONDUCTO RADICULAR EN DIENTES TEMPORALES UNIRRADICULARES'),
(237305, '237305', 'TERAPIA DE CONDUCTO RADICULAR EN DIENTES TEMPORALES MULTIRRADICULARES'),
(237401, '237401', 'CURETAJE APICAL CON APICECTOMIA Y OBTURACION RETROGADA [CIRUGIA PERIRRADICULAR]'),
(237501, '237501', 'PROCEDIMIENTO CORRECTIVO EN RESORCION RADICULAR (INTERNA Y EXTERNA)'),
(237503, '237503', 'RECUBRIMIENTO PULPAR DIRECTO'),
(237504, '237504', 'RECUBRIMIENTO PULPAR INDIRECTO'),
(237505, '237505', 'PRUEBAS DE VITALIDAD PULPAR'),
(237601, '237601', 'FISTULIZACION QUIRURGICA POR TREPANACION Y DRENAJE'),
(237602, '237602', 'FISTULIZACION QUIRURGICA POR INCISION'),
(237901, '237901', 'BLANQUEAMIENTO DENTAL [INTRINSECO] POR CAUSAS ENDODONTICAS (POR DIENTE)'),
(240200, '240200', 'DETARTRAJE SUBGINGIVAL  (POR CUADRANTE)  '),
(240300, '240300', 'ALISADO RADICULAR CAMPO CERRADO ( POR SEXTANTE )  '),
(240500, '240500', 'ADAPTACION DE PLACA NEURO MIORELAJANTE  '),
(242201, '242201', 'CURETAJE A CAMPO ABIERTO POR SEXTANTE'),
(242204, '242204', 'AUMENTO DE REBORDE PARCIALMENTE EDENTULO ( SIN MATERIAL)'),
(242205, '242205', 'AUMENTO DE REBORDE PARCIALMENTE EDENTULO ( CON MATERIAL)'),
(242300, '242300', 'PLASTIAS PREPROTESICAS ( AUMENTO DE CORONA CLINICA )  '),
(242400, '242400', 'REPARACION O PLASTIA PERIODONTAL REGENERATIVA ( INJERTOS - MEMBRANAS )  '),
(243101, '243101', 'EXTIRPACIÓN DE LESIÓN BENIGNA ENCAPSULADA EN ENCÍA HASTA DE TRES CENTÍMETROS'),
(243400, '243400', 'GINGIVECTOMIA  '),
(244101, '244101', 'ENUCLEACIÓN DE QUISTE (ODONTOGÉNICO O NO ODONTOGÉNICO) HASTA DE  TRES CENTÍMETROS DE DIÁMETRO'),
(244102, '244102', 'ENUCLEACIÓN DE QUISTE (ODONTOGÉNICO O NO ODONTOGÉNICO) DE MÁS DE TRES CENTÍMETROS DE DIÁMETRO'),
(244103, '244103', 'RESECCIÓN DE TUMOR BENIGNO  O MALIGNO ODONTOGÉNICO'),
(245100, '245100', 'REGULARIZACIÓN DE REBORDES POR CUADRANTE  '),
(245200, '245200', 'ALVEOLECTOMÍA (INTERRADICULAR - INTRASEPTAL - RADICAL - SIMPLE CON INJERTO O IMPLANTE) NCOC'),
(247100, '247100', 'COLOCACIÓN DE APARATOLOGÍA  FIJA PARA ORTODONCIA (ARCADA)  '),
(247201, '247201', 'COLOCACIÓN DE APARATOLOGÍA REMOVIBLE INTRAORAL PARA  ORTODONCIA  (ARCADA)'),
(247202, '247202', 'COLOCACIÓN DE APARATOLOGÍA REMOVIBLE  EXTRAORAL PARA  ORTODONCIA  (ARCADA)'),
(247300, '247300', 'COLOCACION DE APARATOS DE RETENCION  '),
(247401, '247401', 'FERULIZACION RIGIDA ( SUPERIOR Y/O INFERIOR)'),
(247402, '247402', 'FERULIZACION SEMIRIGIDA ( SUPERIOR Y/O INFERIOR)'),
(248100, '248100', 'CIERRE DE DIASTEMA (ALVEOLAR; DENTAL)  '),
(248200, '248200', 'AJUSTAMIENTO OCLUSAL  '),
(248400, '248400', 'REPARACIÓN DE APARATOLOGIA FIJA O REMOVIBLE  '),
(248800, '248800', 'MASCARA FACIAL TERAPEUTICA NCOC'),
(249101, '249101', 'CONTROL DE HEMORRAGIA DENTAL POS QUIRURGICA  '),
(250201, '250201', 'BIOPSIA EN CUÑA O POR TRUCUT DE LENGUA'),
(251000, '251000', 'RESECCIÓN DE LESIÓN SUPERFICIAL EN LA LENGUA  '),
(255100, '255100', 'SUTURA DE LACERACIÓN DE LENGUA (GLOSORRAFIA)  '),
(261201, '261201', 'BIOPSIA ESCIONAL DE GLANDULA SALIVAR MENOR  (CON CONDUCTO SALIVAL)'),
(262901, '262901', 'RESECCIÓN DE MUCOCELE DE GLANDULA SALIVAL'),
(272301, '272301', 'BIOPSIA INCISIONAL DE LABIO'),
(272302, '272302', 'BIOPSIA ESCISIONAL DE LABIO'),
(274100, '274100', 'FRENILLECTOMIA LABIAL NCOC'),
(274301, '274301', 'RESECCIÓN DE LESIÓN BENIGNA DE LA MUCOSA ORAL HASTA DE DOS CENTIMETROS DE DIÁMETRO'),
(274302, '274302', 'RESECCIÓN DE LESIÓN BENIGNA DE LA MUCOSA ORAL MAYOR DE  DOS CENTIMETROS DE DIÁMETRO'),
(274901, '274901', 'REMOCIÓN DE CUERPO EXTRAÑO EN TEJIDOS BLANDOS DE LA BOCA'),
(274902, '274902', 'RESECCION  DE BRIDAS INTRAORALES'),
(275101, '275101', 'SUTURA O REPARACIÓN DE HERIDA HASTA DE CINCO CENTÍMETROS EN  LABIOS'),
(275102, '275102', 'SUTURA O REPARACIÓN DE HERIDA DE MÁS DE CINCO CENTÍMETROS EN  LABIOS'),
(275801, '275801', 'PROFUNDIZACION O DESCENSO DE PISO DE BOCA CON DESINSERCION DE MILOHIODEO Y/O GENIHIODEO'),
(275901, '275901', 'PROFUNDIZACION  DE SURCO VESTIBULAR CON INJERTO MUCOSO'),
(767705, '767705', 'REDUCCION Y FIJACION DE LUXACION  DENTO ALVEOLAR QUE COMPROMETE HASTA TRES DIENTES'),
(767706, '767706', 'REDUCCION Y FIJACION DE LUXACION DENTO ALVEOLAR QUE COMPROMETE MAS DE TRES DIENTES'),
(893106, '893106', 'CONTROL DE ORTODONCIA FIJA/REMOVIBLE  O TRATAMIENTO ORTOPÉDICO FUNCIONAL  Y  MECÁNICO'),
(893107, '893107', 'ELABORACIÓN Y ADAPTACIÓN DE APARATO ORTOPEDICO'),
(893108, '893108', 'SESION DE CONTROL DE CRECIMIENTO Y DESARROLLO DENTO-MAXILOFACIAL'),
(935500, '935500', 'APLICACIÓN DE ALAMBRE DENTAL  '),
(973400, '973400', 'EXTRACCION DE  APARATOLOGIA ORTODONTICA FIJA  ');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diente`
--

CREATE TABLE IF NOT EXISTS `diente` (
  `iddiente` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddiente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `diente`
--

INSERT INTO `diente` (`iddiente`, `nombre`) VALUES
(11, '11'),
(12, '12'),
(13, '13'),
(14, '14'),
(15, '15'),
(16, '16'),
(17, '17'),
(18, '18'),
(21, '21'),
(22, '22'),
(23, '23'),
(24, '24'),
(25, '25'),
(26, '26'),
(27, '27'),
(28, '28'),
(31, '31'),
(32, '32'),
(33, '33'),
(34, '34'),
(35, '35'),
(36, '36'),
(37, '37'),
(38, '38'),
(41, '41'),
(42, '42'),
(43, '43'),
(44, '44'),
(45, '45'),
(46, '46'),
(47, '47'),
(48, '48'),
(51, '51'),
(52, '52'),
(53, '53'),
(54, '54'),
(55, '55'),
(61, '61'),
(62, '62'),
(63, '63'),
(64, '64'),
(65, '65'),
(71, '71'),
(72, '72'),
(73, '73'),
(74, '74'),
(75, '75'),
(81, '81'),
(82, '82'),
(83, '83'),
(84, '84'),
(85, '85');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

CREATE TABLE IF NOT EXISTS `docente` (
  `iddocente` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddocente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `docente`
--

INSERT INTO `docente` (`iddocente`, `nombre`, `clave`, `codigo`, `estado`) VALUES
(768695, 'docenM', '123456', 'xx', 'inactivo'),
(877847, 'docenteY', '123456', 'xx', 'activo'),
(7563234, 'DocenteX', '123456', 'xx', 'activo'),
(8656445, 'docenteB', '123456', 'wre', 'inactivo'),
(73245345, 'andres', '123456', 'xx2', 'inactivo'),
(76675665, 'docenteA', '123456', '1232344', 'activo'),
(756838423, '34435', '34543543', 'xx', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente_has_curso`
--

CREATE TABLE IF NOT EXISTS `docente_has_curso` (
  `docente_iddocente` int(11) NOT NULL,
  `curso_idcurso` int(11) NOT NULL,
  PRIMARY KEY (`docente_iddocente`,`curso_idcurso`),
  KEY `fk_docente_has_curso_curso1` (`curso_idcurso`),
  KEY `fk_docente_has_curso_docente1` (`docente_iddocente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `docente_has_curso`
--

INSERT INTO `docente_has_curso` (`docente_iddocente`, `curso_idcurso`) VALUES
(76675665, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente_has_medico`
--

CREATE TABLE IF NOT EXISTS `docente_has_medico` (
  `docente_iddocente` int(11) NOT NULL,
  `medico_idmedico` int(11) NOT NULL,
  PRIMARY KEY (`docente_iddocente`,`medico_idmedico`),
  KEY `fk_docente_has_medico_medico1` (`medico_idmedico`),
  KEY `fk_docente_has_medico_docente1` (`docente_iddocente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `docente_has_medico`
--

INSERT INTO `docente_has_medico` (`docente_iddocente`, `medico_idmedico`) VALUES
(76675665, 123456),
(76675665, 6543554);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evolucion`
--

CREATE TABLE IF NOT EXISTS `evolucion` (
  `idevolucion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `reciboPago` varchar(45) DEFAULT NULL,
  `abono` int(11) DEFAULT NULL,
  `saldo` varchar(45) DEFAULT NULL,
  `tratamiento_idtratamiento` int(11) NOT NULL,
  PRIMARY KEY (`idevolucion`),
  KEY `fk_evolucion_tratamiento1` (`tratamiento_idtratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `examenfisicoestomatologico`
--

CREATE TABLE IF NOT EXISTS `examenfisicoestomatologico` (
  `idexamenFisicoEstomatologico` int(11) NOT NULL AUTO_INCREMENT,
  `temperatura` varchar(45) DEFAULT NULL,
  `pulso` varchar(45) DEFAULT NULL,
  `tensionArterial` varchar(45) DEFAULT NULL,
  `higieneOral` varchar(45) DEFAULT NULL,
  `sedaDental` varchar(45) DEFAULT NULL,
  `cepilloDentalUso` varchar(45) DEFAULT NULL,
  `vecesAlDia` varchar(45) DEFAULT NULL,
  `enjuagesBsinFluor` varchar(45) DEFAULT NULL,
  `enjuagesBconFluor` varchar(45) DEFAULT NULL,
  `habitosYvicios` varchar(45) DEFAULT NULL,
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  PRIMARY KEY (`idexamenFisicoEstomatologico`),
  KEY `fk_examenFisicoEstomatologico_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Volcado de datos para la tabla `examenfisicoestomatologico`
--

INSERT INTO `examenfisicoestomatologico` (`idexamenFisicoEstomatologico`, `temperatura`, `pulso`, `tensionArterial`, `higieneOral`, `sedaDental`, `cepilloDentalUso`, `vecesAlDia`, `enjuagesBsinFluor`, `enjuagesBconFluor`, `habitosYvicios`, `datosConsulta_iddatosConsulta`) VALUES
(4, '45', '15', '25', 'Mala', 'Si', 'Si', '4', 'Aveces', 'Aveces', 'Ninguno', 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historiaclinica`
--

CREATE TABLE IF NOT EXISTS `historiaclinica` (
  `idhistoriaClinica` int(11) NOT NULL AUTO_INCREMENT,
  `estadoActual` varchar(255) DEFAULT NULL,
  `dolor` varchar(255) DEFAULT NULL,
  `diente` varchar(255) DEFAULT NULL,
  `tejidosVecinos` varchar(255) DEFAULT NULL,
  `termicaFrio` varchar(255) DEFAULT NULL,
  `evaluaciones` varchar(255) DEFAULT NULL,
  `observaciones` varchar(255) DEFAULT NULL,
  `etiologia` varchar(255) DEFAULT NULL,
  `consulta_iddatosConsulta` int(11) NOT NULL,
  `corona` varchar(255) DEFAULT NULL,
  `raiz` varchar(255) DEFAULT NULL,
  `periapical` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idhistoriaClinica`),
  KEY `fk_historiaClinica_Consulta1_idx` (`consulta_iddatosConsulta`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Volcado de datos para la tabla `historiaclinica`
--

INSERT INTO `historiaclinica` (`idhistoriaClinica`, `estadoActual`, `dolor`, `diente`, `tejidosVecinos`, `termicaFrio`, `evaluaciones`, `observaciones`, `etiologia`, `consulta_iddatosConsulta`, `corona`, `raiz`, `periapical`) VALUES
(5, 'tengo un estado de vd', 'Palpacion Irradiado ', 'el diente mas grande', 'bn bn si hay', 'ahora si amigo', 'trataniebti', 'observa', 'observa', 19, 'corona', 'raiz', 'periapical');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historiaclinica_has_diagnostico`
--

CREATE TABLE IF NOT EXISTS `historiaclinica_has_diagnostico` (
  `historiaClinica_idhistoriaClinica` int(11) NOT NULL,
  `diagnostico_iddiagnostico` int(11) NOT NULL,
  PRIMARY KEY (`historiaClinica_idhistoriaClinica`,`diagnostico_iddiagnostico`),
  KEY `fk_historiaClinica_has_diagnostico_diagnostico1_idx` (`diagnostico_iddiagnostico`),
  KEY `fk_historiaClinica_has_diagnostico_historiaClinica1_idx` (`historiaClinica_idhistoriaClinica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `historiaclinica_has_diagnostico`
--

INSERT INTO `historiaclinica_has_diagnostico` (`historiaClinica_idhistoriaClinica`, `diagnostico_iddiagnostico`) VALUES
(5, 237200),
(5, 237602);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historiaclinica_has_tratamiento`
--

CREATE TABLE IF NOT EXISTS `historiaclinica_has_tratamiento` (
  `historiaClinica_idhistoriaClinica` int(11) NOT NULL,
  `tratamiento_idtratamiento` int(11) NOT NULL,
  PRIMARY KEY (`historiaClinica_idhistoriaClinica`,`tratamiento_idtratamiento`),
  KEY `fk_historiaClinica_has_tratamiento_tratamiento1_idx` (`tratamiento_idtratamiento`),
  KEY `fk_historiaClinica_has_tratamiento_historiaClinica1_idx` (`historiaClinica_idhistoriaClinica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `historiaclinica_has_tratamiento`
--

INSERT INTO `historiaclinica_has_tratamiento` (`historiaClinica_idhistoriaClinica`, `tratamiento_idtratamiento`) VALUES
(5, 921);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interconsulta`
--

CREATE TABLE IF NOT EXISTS `interconsulta` (
  `idinterconsulta` int(11) NOT NULL,
  `interconsulta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idinterconsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `interconsulta`
--

INSERT INTO `interconsulta` (`idinterconsulta`, `interconsulta`) VALUES
(1, 'Semiologia'),
(2, 'Promocion y Prevencion'),
(3, 'Operatoria'),
(4, 'Endodoncia'),
(5, 'Periodoncia'),
(6, 'Cirugia'),
(7, 'Odontopedriatia'),
(8, 'Rehabilitacion'),
(9, 'Ortodoncia'),
(10, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interconsulta_has_datosconsulta`
--

CREATE TABLE IF NOT EXISTS `interconsulta_has_datosconsulta` (
  `interconsulta_idinterconsulta` int(11) NOT NULL,
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  PRIMARY KEY (`interconsulta_idinterconsulta`,`datosConsulta_iddatosConsulta`),
  KEY `fk_interconsulta_has_datosConsulta_datosConsulta1` (`datosConsulta_iddatosConsulta`),
  KEY `fk_interconsulta_has_datosConsulta_interconsulta1` (`interconsulta_idinterconsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `interconsulta_has_datosconsulta`
--

INSERT INTO `interconsulta_has_datosconsulta` (`interconsulta_idinterconsulta`, `datosConsulta_iddatosConsulta`) VALUES
(2, 19),
(4, 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico`
--

CREATE TABLE IF NOT EXISTS `medico` (
  `idmedico` int(11) NOT NULL,
  `nombreUsuario` varchar(45) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idmedico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `medico`
--

INSERT INTO `medico` (`idmedico`, `nombreUsuario`, `clave`, `direccion`, `telefono`) VALUES
(123456, 'Julio Barcos', '123456', 'Blas de lezo', '686868'),
(6543554, 'Juan pereira', '6543554', 'barrio santa monica', '6565656');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico_has_curso`
--

CREATE TABLE IF NOT EXISTS `medico_has_curso` (
  `medico_idmedico` int(11) NOT NULL,
  `curso_idcurso` int(11) NOT NULL,
  PRIMARY KEY (`medico_idmedico`,`curso_idcurso`),
  KEY `fk_medico_has_curso_curso1` (`curso_idcurso`),
  KEY `fk_medico_has_curso_medico1` (`medico_idmedico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `medico_has_curso`
--

INSERT INTO `medico_has_curso` (`medico_idmedico`, `curso_idcurso`) VALUES
(123456, 1),
(6543554, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medico_has_paciente`
--

CREATE TABLE IF NOT EXISTS `medico_has_paciente` (
  `medico_idmedico` int(11) NOT NULL,
  `paciente_idpersona` varchar(45) NOT NULL,
  KEY `fk_medico_has_paciente_paciente1` (`paciente_idpersona`),
  KEY `fk_medico_has_paciente_medico1` (`medico_idmedico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `medico_has_paciente`
--

INSERT INTO `medico_has_paciente` (`medico_idmedico`, `paciente_idpersona`) VALUES
(123456, '1047565684'),
(123456, '98765432');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `municipios`
--

CREATE TABLE IF NOT EXISTS `municipios` (
  `codigo` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `departamentos_codigo1` int(11) NOT NULL,
  PRIMARY KEY (`codigo`),
  KEY `fk_municipios_departamentos1` (`departamentos_codigo1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `municipios`
--

INSERT INTO `municipios` (`codigo`, `nombre`, `departamentos_codigo1`) VALUES
(5001, 'Medellín', 5),
(5002, 'Abejorral', 5),
(5004, 'Abriaquí', 5),
(5021, 'Alejandria', 5),
(5030, 'Amagá', 5),
(5031, 'Amalfi', 5),
(5034, 'Andes', 5),
(5036, 'Angelópolis', 5),
(5038, 'Angostura', 5),
(5040, 'Anorí', 5),
(5042, 'Santa Fé de Antioquia', 5),
(5044, 'Anzá', 5),
(5045, 'Apartadó', 5),
(5051, 'Arboletes', 5),
(5055, 'Argelia', 5),
(5059, 'Armenia', 5),
(5079, 'Barbosa', 5),
(5086, 'Belmira', 5),
(5088, 'Bello', 5),
(5091, 'Betania', 5),
(5093, 'Betulia', 5),
(5101, 'Bolívar', 5),
(5107, 'Briceño', 5),
(5113, 'Burítica', 5),
(5120, 'Cáceres', 5),
(5125, 'Caicedo', 5),
(5129, 'Caldas', 5),
(5134, 'Campamento', 5),
(5138, 'Cañasgordas', 5),
(5142, 'Caracolí', 5),
(5145, 'Caramanta', 5),
(5147, 'Carepa', 5),
(5148, 'Carmen de Viboral', 5),
(5150, 'Carolina', 5),
(5154, 'Caucasia', 5),
(5172, 'Chigorodó', 5),
(5190, 'Cisneros', 5),
(5197, 'Cocorná', 5),
(5206, 'Concepción', 5),
(5209, 'Concordia', 5),
(5212, 'Copacabana', 5),
(5234, 'Dabeiba', 5),
(5237, 'Don Matías', 5),
(5240, 'Ebéjico', 5),
(5250, 'El Bagre', 5),
(5264, 'Entrerríos', 5),
(5266, 'Envigado', 5),
(5282, 'Fredonia', 5),
(5284, 'Frontino', 5),
(5306, 'Giraldo', 5),
(5308, 'Girardota', 5),
(5310, 'Gómez Plata', 5),
(5313, 'Granada', 5),
(5315, 'Guadalupe', 5),
(5318, 'Guarne', 5),
(5321, 'Guatapé', 5),
(5347, 'Heliconia', 5),
(5353, 'Hispania', 5),
(5360, 'Itagüí', 5),
(5361, 'Ituango', 5),
(5364, 'Jardín', 5),
(5368, 'Jericó', 5),
(5376, 'La Ceja', 5),
(5380, 'La Estrella', 5),
(5390, 'La Pintada', 5),
(5400, 'La Unión', 5),
(5411, 'Liborina', 5),
(5425, 'Maceo', 5),
(5440, 'Marinilla', 5),
(5467, 'Montebello', 5),
(5475, 'Murindó', 5),
(5480, 'Mutatá', 5),
(5483, 'Nariño', 5),
(5490, 'Necoclí', 5),
(5495, 'Nechí', 5),
(5501, 'Olaya', 5),
(5541, 'Peñol', 5),
(5543, 'Peque', 5),
(5576, 'Pueblorrico', 5),
(5579, 'Puerto Berrío', 5),
(5585, 'Puerto Nare', 5),
(5591, 'Puerto Triunfo', 5),
(5604, 'Remedios', 5),
(5607, 'Retiro', 5),
(5615, 'Ríonegro', 5),
(5628, 'Sabanalarga', 5),
(5631, 'Sabaneta', 5),
(5642, 'Salgar', 5),
(5647, 'San Andrés de Cuerquía', 5),
(5649, 'San Carlos', 5),
(5652, 'San Francisco', 5),
(5656, 'San Jerónimo', 5),
(5658, 'San José de Montaña', 5),
(5659, 'San Juan de Urabá', 5),
(5660, 'San Luís', 5),
(5664, 'San Pedro', 5),
(5665, 'San Pedro de Urabá', 5),
(5667, 'San Rafael', 5),
(5670, 'San Roque', 5),
(5674, 'San Vicente', 5),
(5679, 'Santa Bárbara', 5),
(5686, 'Santa Rosa de Osos', 5),
(5690, 'Santo Domingo', 5),
(5697, 'Santuario', 5),
(5736, 'Segovia', 5),
(5756, 'Sonsón', 5),
(5761, 'Sopetrán', 5),
(5789, 'Támesis', 5),
(5790, 'Tarazá', 5),
(5792, 'Tarso', 5),
(5809, 'Titiribí', 5),
(5819, 'Toledo', 5),
(5837, 'Turbo', 5),
(5842, 'Uramita', 5),
(5847, 'Urrao', 5),
(5854, 'Valdivia', 5),
(5856, 'Valparaiso', 5),
(5858, 'Vegachí', 5),
(5861, 'Venecia', 5),
(5873, 'Vigía del Fuerte', 5),
(5885, 'Yalí', 5),
(5887, 'Yarumal', 5),
(5890, 'Yolombó', 5),
(5893, 'Yondó (Casabe)', 5),
(5895, 'Zaragoza', 5),
(8001, 'Barranquilla', 8),
(8078, 'Baranoa', 8),
(8132, 'Juan de Acosta', 8),
(8137, 'Campo de la Cruz', 8),
(8141, 'Candelaria', 8),
(8296, 'Galapa', 8),
(8421, 'Luruaco', 8),
(8433, 'Malambo', 8),
(8436, 'Manatí', 8),
(8520, 'Palmar de Varela', 8),
(8549, 'Piojo', 8),
(8558, 'Polonuevo', 8),
(8560, 'Ponedera', 8),
(8573, 'Puerto Colombia', 8),
(8606, 'Repelón', 8),
(8634, 'Sabanagrande', 8),
(8638, 'Sabanalarga', 8),
(8675, 'Santa Lucía', 8),
(8685, 'Santo Tomás', 8),
(8758, 'Soledad', 8),
(8770, 'Suan', 8),
(8832, 'Tubará', 8),
(8849, 'Usiacuri', 8),
(11001, 'Bogotá D.C.', 25),
(13001, 'Cartagena', 13),
(13006, 'Achí', 13),
(13030, 'Altos del Rosario', 13),
(13042, 'Arenal', 13),
(13052, 'Arjona', 13),
(13062, 'Arroyohondo', 13),
(13074, 'Barranco de Loba', 13),
(13140, 'Calamar', 13),
(13160, 'Cantagallo', 13),
(13188, 'Cicuco', 13),
(13212, 'Córdoba', 13),
(13222, 'Clemencia', 13),
(13244, 'El Carmen de Bolívar', 13),
(13248, 'El Guamo', 13),
(13268, 'El Peñon', 13),
(13300, 'Hatillo de Loba', 13),
(13430, 'Magangué', 13),
(13433, 'Mahates', 13),
(13440, 'Margarita', 13),
(13442, 'María la Baja', 13),
(13458, 'Montecristo', 13),
(13468, 'Mompós', 13),
(13473, 'Morales', 13),
(13490, 'Norosí', 13),
(13549, 'Pinillos', 13),
(13580, 'Regidor', 13),
(13600, 'Río Viejo', 13),
(13620, 'San Cristobal', 13),
(13647, 'San Estanislao', 13),
(13650, 'San Fernando', 13),
(13654, 'San Jacinto', 13),
(13655, 'San Jacinto del Cauca', 13),
(13657, 'San Juan de Nepomuceno', 13),
(13667, 'San Martín de Loba', 13),
(13670, 'San Pablo', 13),
(13673, 'Santa Catalina', 13),
(13683, 'Santa Rosa', 13),
(13688, 'Santa Rosa del Sur', 13),
(13744, 'Simití', 13),
(13760, 'Soplaviento', 13),
(13780, 'Talaigua Nuevo', 13),
(13810, 'Tiquisio (Puerto Rico)', 13),
(13836, 'Turbaco', 13),
(13838, 'Turbaná', 13),
(13873, 'Villanueva', 13),
(13894, 'Zambrano', 13),
(15001, 'Tunja', 15),
(15022, 'Almeida', 15),
(15047, 'Aquitania', 15),
(15051, 'Arcabuco', 15),
(15087, 'Belén', 15),
(15090, 'Berbeo', 15),
(15092, 'Beteitiva', 15),
(15097, 'Boavita', 15),
(15104, 'Boyacá', 15),
(15106, 'Briceño', 15),
(15109, 'Buenavista', 15),
(15114, 'Busbanza', 15),
(15131, 'Caldas', 15),
(15135, 'Campohermoso', 15),
(15162, 'Cerinza', 15),
(15172, 'Chinavita', 15),
(15176, 'Chiquinquirá', 15),
(15180, 'Chiscas', 15),
(15183, 'Chita', 15),
(15185, 'Chitaraque', 15),
(15187, 'Chivatá', 15),
(15189, 'Ciénaga', 15),
(15204, 'Cómbita', 15),
(15212, 'Coper', 15),
(15215, 'Corrales', 15),
(15218, 'Covarachía', 15),
(15223, 'Cubará', 15),
(15224, 'Cucaita', 15),
(15226, 'Cuitiva', 15),
(15232, 'Chíquiza', 15),
(15236, 'Chívor', 15),
(15238, 'Duitama', 15),
(15244, 'El Cocuy', 15),
(15248, 'El Espino', 15),
(15272, 'Firavitoba', 15),
(15276, 'Floresta', 15),
(15293, 'Gachantivá', 15),
(15296, 'Gámeza', 15),
(15299, 'Garagoa', 15),
(15317, 'Guacamayas', 15),
(15322, 'Guateque', 15),
(15325, 'Guayatá', 15),
(15332, 'Guicán', 15),
(15362, 'Izá', 15),
(15367, 'Jenesano', 15),
(15368, 'Jericó', 15),
(15377, 'Labranzagrande', 15),
(15380, 'La Capilla', 15),
(15401, 'La Victoria', 15),
(15403, 'La Uvita', 15),
(15407, 'Villa de Leiva', 15),
(15425, 'Macanal', 15),
(15442, 'Maripí', 15),
(15455, 'Miraflores', 15),
(15464, 'Mongua', 15),
(15466, 'Monguí', 15),
(15469, 'Moniquirá', 15),
(15476, 'Motavita', 15),
(15480, 'Muzo', 15),
(15491, 'Nobsa', 15),
(15494, 'Nuevo Colón', 15),
(15500, 'Oicatá', 15),
(15507, 'Otanche', 15),
(15511, 'Pachavita', 15),
(15514, 'Páez', 15),
(15516, 'Paipa', 15),
(15518, 'Pajarito', 15),
(15522, 'Panqueba', 15),
(15531, 'Pauna', 15),
(15532, 'Paya', 15),
(15537, 'Paz de Río', 15),
(15542, 'Pesca', 15),
(15550, 'Pisva', 15),
(15572, 'Puerto Boyacá', 15),
(15580, 'Quipama', 15),
(15599, 'Ramiriquí', 15),
(15600, 'Ráquira', 15),
(15621, 'Rondón', 15),
(15632, 'Saboyá', 15),
(15638, 'Sáchica', 15),
(15646, 'Samacá', 15),
(15660, 'San Eduardo', 15),
(15664, 'San José de Pare', 15),
(15667, 'San Luís de Gaceno', 15),
(15673, 'San Mateo', 15),
(15676, 'San Miguel de Sema', 15),
(15681, 'San Pablo de Borbur', 15),
(15686, 'Santana', 15),
(15690, 'Santa María', 15),
(15693, 'Santa Rosa de Viterbo', 15),
(15696, 'Santa Sofía', 15),
(15720, 'Sativanorte', 15),
(15723, 'Sativasur', 15),
(15740, 'Siachoque', 15),
(15753, 'Soatá', 15),
(15755, 'Socotá', 15),
(15757, 'Socha', 15),
(15759, 'Sogamoso', 15),
(15761, 'Somondoco', 15),
(15762, 'Sora', 15),
(15763, 'Sotaquirá', 15),
(15764, 'Soracá', 15),
(15774, 'Susacón', 15),
(15776, 'Sutamarchán', 15),
(15778, 'Sutatenza', 15),
(15790, 'Tasco', 15),
(15798, 'Tenza', 15),
(15804, 'Tibaná', 15),
(15806, 'Tibasosa', 15),
(15808, 'Tinjacá', 15),
(15810, 'Tipacoque', 15),
(15814, 'Toca', 15),
(15816, 'Toguí', 15),
(15820, 'Topagá', 15),
(15822, 'Tota', 15),
(15832, 'Tunungua', 15),
(15835, 'Turmequé', 15),
(15837, 'Tuta', 15),
(15839, 'Tutasá', 15),
(15842, 'Úmbita', 15),
(15861, 'Ventaquemada', 15),
(15879, 'Viracachá', 15),
(15897, 'Zetaquirá', 15),
(17001, 'Manizales', 17),
(17013, 'Aguadas', 17),
(17042, 'Anserma', 17),
(17050, 'Aranzazu', 17),
(17088, 'Belalcázar', 17),
(17174, 'Chinchiná', 17),
(17272, 'Filadelfia', 17),
(17380, 'La Dorada', 17),
(17388, 'La Merced', 17),
(17433, 'Manzanares', 17),
(17442, 'Marmato', 17),
(17444, 'Marquetalia', 17),
(17446, 'Marulanda', 17),
(17486, 'Neira', 17),
(17495, 'Norcasia', 17),
(17513, 'Pácora', 17),
(17524, 'Palestina', 17),
(17541, 'Pensilvania', 17),
(17614, 'Río Sucio', 17),
(17616, 'Risaralda', 17),
(17653, 'Salamina', 17),
(17662, 'Samaná', 17),
(17665, 'San José', 17),
(17777, 'Supía', 17),
(17867, 'La Victoria', 17),
(17873, 'Villamaría', 17),
(17877, 'Viterbo', 17),
(18001, 'Florencia', 18),
(18029, 'Albania', 18),
(18094, 'Belén de los Andaquíes', 18),
(18150, 'Cartagena del Chairá', 18),
(18205, 'Curillo', 18),
(18247, 'El Doncello', 18),
(18256, 'El Paujil', 18),
(18410, 'La Montañita', 18),
(18460, 'Milán', 18),
(18479, 'Morelia', 18),
(18592, 'Puerto Rico', 18),
(18610, 'San José del Fragua', 18),
(18753, 'San Vicente del Caguán', 18),
(18765, 'Solano', 18),
(18785, 'Solita', 18),
(18860, 'Valparaiso', 18),
(19001, 'Popayán', 19),
(19022, 'Almaguer', 19),
(19050, 'Argelia', 19),
(19075, 'Balboa', 19),
(19100, 'Bolívar', 19),
(19110, 'Buenos Aires', 19),
(19130, 'Cajibío', 19),
(19137, 'Caldono', 19),
(19142, 'Caloto', 19),
(19212, 'Corinto', 19),
(19256, 'El Tambo', 19),
(19290, 'Florencia', 19),
(19300, 'Guachené', 19),
(19318, 'Guapí', 19),
(19355, 'Inzá', 19),
(19364, 'Jambaló', 19),
(19392, 'La Sierra', 19),
(19397, 'La Vega', 19),
(19418, 'López (Micay)', 19),
(19450, 'Mercaderes', 19),
(19455, 'Miranda', 19),
(19473, 'Morales', 19),
(19513, 'Padilla', 19),
(19517, 'Páez (Belalcazar)', 19),
(19532, 'Patía (El Bordo)', 19),
(19533, 'Piamonte', 19),
(19548, 'Piendamó', 19),
(19573, 'Puerto Tejada', 19),
(19585, 'Puracé (Coconuco)', 19),
(19622, 'Rosas', 19),
(19693, 'San Sebastián', 19),
(19698, 'Santander de Quilichao', 19),
(19701, 'Santa Rosa', 19),
(19743, 'Silvia', 19),
(19760, 'Sotara (Paispamba)', 19),
(19780, 'Suárez', 19),
(19785, 'Sucre', 19),
(19807, 'Timbío', 19),
(19809, 'Timbiquí', 19),
(19821, 'Toribío', 19),
(19824, 'Totoró', 19),
(19845, 'Villa Rica', 19),
(20001, 'Valledupar', 20),
(20011, 'Aguachica', 20),
(20013, 'Agustín Codazzi', 20),
(20032, 'Astrea', 20),
(20045, 'Becerríl', 20),
(20060, 'Bosconia', 20),
(20175, 'Chimichagua', 20),
(20178, 'Chiriguaná', 20),
(20228, 'Curumaní', 20),
(20238, 'El Copey', 20),
(20250, 'El Paso', 20),
(20295, 'Gamarra', 20),
(20310, 'Gonzalez', 20),
(20383, 'La Gloria', 20),
(20400, 'La Jagua de Ibirico', 20),
(20443, 'Manaure Balcón del Cesar', 20),
(20517, 'Pailitas', 20),
(20550, 'Pelaya', 20),
(20570, 'Pueblo Bello', 20),
(20614, 'Río de oro', 20),
(20621, 'La Paz (Robles)', 20),
(20710, 'San Alberto', 20),
(20750, 'San Diego', 20),
(20770, 'San Martín', 20),
(20787, 'Tamalameque', 20),
(23001, 'Monteria', 23),
(23068, 'Ayapel', 23),
(23079, 'Buenavista', 23),
(23090, 'Canalete', 23),
(23162, 'Cereté', 23),
(23168, 'Chimá', 23),
(23182, 'Chinú', 23),
(23189, 'Ciénaga de Oro', 23),
(23300, 'Cotorra', 23),
(23350, 'La Apartada y La Frontera', 23),
(23417, 'Lorica', 23),
(23419, 'Los Córdobas', 23),
(23464, 'Momil', 23),
(23466, 'Montelíbano', 23),
(23500, 'Moñitos', 23),
(23555, 'Planeta Rica', 23),
(23570, 'Pueblo Nuevo', 23),
(23574, 'Puerto Escondido', 23),
(23580, 'Puerto Libertador', 23),
(23586, 'Purísima', 23),
(23660, 'Sahagún', 23),
(23670, 'San Andrés Sotavento', 23),
(23672, 'San Antero', 23),
(23675, 'San Bernardo del Viento', 23),
(23678, 'San Carlos', 23),
(23682, 'San José de Uré', 23),
(23686, 'San Pelayo', 23),
(23807, 'Tierralta', 23),
(23815, 'Tuchín', 23),
(23855, 'Valencia', 23),
(25001, 'Agua de Dios', 25),
(25019, 'Albán', 25),
(25035, 'Anapoima', 25),
(25040, 'Anolaima', 25),
(25053, 'Arbeláez', 25),
(25086, 'Beltrán', 25),
(25095, 'Bituima', 25),
(25099, 'Bojacá', 25),
(25120, 'Cabrera', 25),
(25123, 'Cachipay', 25),
(25126, 'Cajicá', 25),
(25148, 'Caparrapí', 25),
(25151, 'Cáqueza', 25),
(25154, 'Carmen de Carupa', 25),
(25168, 'Chaguaní', 25),
(25175, 'Chía', 25),
(25178, 'Chipaque', 25),
(25181, 'Choachí', 25),
(25183, 'Chocontá', 25),
(25200, 'Cogua', 25),
(25214, 'Cota', 25),
(25224, 'Cucunubá', 25),
(25245, 'El Colegio', 25),
(25258, 'El Peñón', 25),
(25260, 'El Rosal', 25),
(25269, 'Facatativá', 25),
(25279, 'Fómeque', 25),
(25281, 'Fosca', 25),
(25286, 'Funza', 25),
(25288, 'Fúquene', 25),
(25290, 'Fusagasugá', 25),
(25293, 'Gachalá', 25),
(25295, 'Gachancipá', 25),
(25297, 'Gachetá', 25),
(25299, 'Gama', 25),
(25307, 'Girardot', 25),
(25312, 'Granada', 25),
(25317, 'Guachetá', 25),
(25320, 'Guaduas', 25),
(25322, 'Guasca', 25),
(25324, 'Guataquí', 25),
(25326, 'Guatavita', 25),
(25328, 'Guayabal de Siquima', 25),
(25335, 'Guayabetal', 25),
(25339, 'Gutiérrez', 25),
(25368, 'Jerusalén', 25),
(25372, 'Junín', 25),
(25377, 'La Calera', 25),
(25386, 'La Mesa', 25),
(25394, 'La Palma', 25),
(25398, 'La Peña', 25),
(25402, 'La Vega', 25),
(25407, 'Lenguazaque', 25),
(25426, 'Machetá', 25),
(25430, 'Madrid', 25),
(25436, 'Manta', 25),
(25438, 'Medina', 25),
(25473, 'Mosquera', 25),
(25483, 'Nariño', 25),
(25486, 'Nemocón', 25),
(25488, 'Nilo', 25),
(25489, 'Nimaima', 25),
(25491, 'Nocaima', 25),
(25506, 'Venecia (Ospina Pérez)', 25),
(25513, 'Pacho', 25),
(25518, 'Paime', 25),
(25524, 'Pandi', 25),
(25530, 'Paratebueno', 25),
(25535, 'Pasca', 25),
(25572, 'Puerto Salgar', 25),
(25580, 'Pulí', 25),
(25592, 'Quebradanegra', 25),
(25594, 'Quetame', 25),
(25596, 'Quipile', 25),
(25599, 'Apulo', 25),
(25612, 'Ricaurte', 25),
(25645, 'San Antonio de Tequendama', 25),
(25649, 'San Bernardo', 25),
(25653, 'San Cayetano', 25),
(25658, 'San Francisco', 25),
(25662, 'San Juan de Río Seco', 25),
(25718, 'Sasaima', 25),
(25736, 'Sesquilé', 25),
(25740, 'Sibaté', 25),
(25743, 'Silvania', 25),
(25745, 'Simijaca', 25),
(25754, 'Soacha', 25),
(25758, 'Sopó', 25),
(25769, 'Subachoque', 25),
(25772, 'Suesca', 25),
(25777, 'Supatá', 25),
(25779, 'Susa', 25),
(25781, 'Sutatausa', 25),
(25785, 'Tabio', 25),
(25793, 'Tausa', 25),
(25797, 'Tena', 25),
(25799, 'Tenjo', 25),
(25805, 'Tibacuy', 25),
(25807, 'Tibirita', 25),
(25815, 'Tocaima', 25),
(25817, 'Tocancipá', 25),
(25823, 'Topaipí', 25),
(25839, 'Ubalá', 25),
(25841, 'Ubaque', 25),
(25843, 'Ubaté', 25),
(25845, 'Une', 25),
(25851, 'Útica', 25),
(25862, 'Vergara', 25),
(25867, 'Viani', 25),
(25871, 'Villagómez', 25),
(25873, 'Villapinzón', 25),
(25875, 'Villeta', 25),
(25878, 'Viotá', 25),
(25885, 'Yacopí', 25),
(25888, 'Zipacón', 25),
(25899, 'Zipaquirá', 25),
(27001, 'Quibdó', 27),
(27006, 'Acandí', 27),
(27025, 'Alto Baudó (Pie de Pato)', 27),
(27050, 'Atrato (Yuto)', 27),
(27073, 'Bagadó', 27),
(27075, 'Bahía Solano (Mútis)', 27),
(27077, 'Bajo Baudó (Pizarro)', 27),
(27086, 'Belén de Bajirá', 27),
(27099, 'Bojayá (Bellavista)', 27),
(27135, 'Cantón de San Pablo', 27),
(27150, 'Carmen del Darién (CURBARADÓ)', 27),
(27160, 'Cértegui', 27),
(27205, 'Condoto', 27),
(27245, 'El Carmen de Atrato', 27),
(27250, 'Santa Genoveva de Docorodó', 27),
(27361, 'Istmina', 27),
(27372, 'Juradó', 27),
(27413, 'Lloró', 27),
(27425, 'Medio Atrato', 27),
(27430, 'Medio Baudó', 27),
(27450, 'Medio San Juan (ANDAGOYA)', 27),
(27491, 'Novita', 27),
(27495, 'Nuquí', 27),
(27580, 'Río Iró', 27),
(27600, 'Río Quito', 27),
(27615, 'Ríosucio', 27),
(27660, 'San José del Palmar', 27),
(27745, 'Sipí', 27),
(27787, 'Tadó', 27),
(27800, 'Unguía', 27),
(27810, 'Unión Panamericana (ÁNIMAS)', 27),
(41001, 'Neiva', 41),
(41006, 'Acevedo', 41),
(41013, 'Agrado', 41),
(41016, 'Aipe', 41),
(41020, 'Algeciras', 41),
(41026, 'Altamira', 41),
(41078, 'Baraya', 41),
(41132, 'Campoalegre', 41),
(41206, 'Colombia', 41),
(41244, 'Elías', 41),
(41298, 'Garzón', 41),
(41306, 'Gigante', 41),
(41319, 'Guadalupe', 41),
(41349, 'Hobo', 41),
(41357, 'Íquira', 41),
(41359, 'Isnos', 41),
(41378, 'La Argentina', 41),
(41396, 'La Plata', 41),
(41483, 'Nátaga', 41),
(41503, 'Oporapa', 41),
(41518, 'Paicol', 41),
(41524, 'Palermo', 41),
(41530, 'Palestina', 41),
(41548, 'Pital', 41),
(41551, 'Pitalito', 41),
(41615, 'Rivera', 41),
(41660, 'Saladoblanco', 41),
(41668, 'San Agustín', 41),
(41676, 'Santa María', 41),
(41770, 'Suaza', 41),
(41791, 'Tarqui', 41),
(41797, 'Tesalia', 41),
(41799, 'Tello', 41),
(41801, 'Teruel', 41),
(41807, 'Timaná', 41),
(41872, 'Villavieja', 41),
(41885, 'Yaguará', 41),
(44001, 'Riohacha', 44),
(44035, 'Albania', 44),
(44078, 'Barrancas', 44),
(44090, 'Dibulla', 44),
(44098, 'Distracción', 44),
(44110, 'El Molino', 44),
(44279, 'Fonseca', 44),
(44378, 'Hatonuevo', 44),
(44420, 'La Jagua del Pilar', 44),
(44430, 'Maicao', 44),
(44560, 'Manaure', 44),
(44650, 'San Juan del Cesar', 44),
(44847, 'Uribia', 44),
(44855, 'Urumita', 44),
(44874, 'Villanueva', 44),
(47001, 'Santa Marta', 47),
(47030, 'Algarrobo', 47),
(47053, 'Aracataca', 47),
(47058, 'Ariguaní (El Difícil)', 47),
(47161, 'Cerro San Antonio', 47),
(47170, 'Chivolo', 47),
(47189, 'Ciénaga', 47),
(47205, 'Concordia', 47),
(47245, 'El Banco', 47),
(47258, 'El Piñon', 47),
(47268, 'El Retén', 47),
(47288, 'Fundación', 47),
(47318, 'Guamal', 47),
(47441, 'Pedraza', 47),
(47460, 'Nueva Granada', 47),
(47545, 'Pijiño', 47),
(47551, 'Pivijay', 47),
(47555, 'Plato', 47),
(47570, 'Puebloviejo', 47),
(47605, 'Remolino', 47),
(47660, 'Sabanas de San Angel (SAN ANGEL)', 47),
(47675, 'Salamina', 47),
(47692, 'San Sebastián de Buenavista', 47),
(47703, 'San Zenón', 47),
(47707, 'Santa Ana', 47),
(47720, 'Santa Bárbara de Pinto', 47),
(47745, 'Sitionuevo', 47),
(47798, 'Tenerife', 47),
(47960, 'Zapayán (PUNTA DE PIEDRAS)', 47),
(47980, 'Zona Bananera (PRADO - SEVILLA)', 47),
(50001, 'Villavicencio', 50),
(50006, 'Acacías', 50),
(50110, 'Barranca de Upía', 50),
(50124, 'Cabuyaro', 50),
(50150, 'Castilla la Nueva', 50),
(50223, 'Cubarral', 50),
(50226, 'Cumaral', 50),
(50245, 'El Calvario', 50),
(50251, 'El Castillo', 50),
(50270, 'El Dorado', 50),
(50287, 'Fuente de Oro', 50),
(50313, 'Granada', 50),
(50318, 'Guamal', 50),
(50325, 'Mapiripan', 50),
(50330, 'Mesetas', 50),
(50350, 'La Macarena', 50),
(50370, 'Uribe', 50),
(50400, 'Lejanías', 50),
(50450, 'Puerto Concordia', 50),
(50568, 'Puerto Gaitán', 50),
(50573, 'Puerto López', 50),
(50577, 'Puerto Lleras', 50),
(50590, 'Puerto Rico', 50),
(50606, 'Restrepo', 50),
(50680, 'San Carlos de Guaroa', 50),
(50683, 'San Juan de Arama', 50),
(50686, 'San Juanito', 50),
(50689, 'San Martín', 50),
(50711, 'Vista Hermosa', 50),
(52001, 'San Juan de Pasto', 52),
(52019, 'Albán (San José)', 52),
(52022, 'Aldana', 52),
(52036, 'Ancuya', 52),
(52051, 'Arboleda (Berruecos)', 52),
(52079, 'Barbacoas', 52),
(52083, 'Belén', 52),
(52110, 'Buesaco', 52),
(52203, 'Colón (Génova)', 52),
(52207, 'Consaca', 52),
(52210, 'Contadero', 52),
(52215, 'Córdoba', 52),
(52224, 'Cuaspud (Carlosama)', 52),
(52227, 'Cumbal', 52),
(52233, 'Cumbitara', 52),
(52240, 'Chachaguí', 52),
(52250, 'El Charco', 52),
(52254, 'El Peñol', 52),
(52256, 'El Rosario', 52),
(52258, 'El Tablón de Gómez', 52),
(52260, 'El Tambo', 52),
(52287, 'Funes', 52),
(52317, 'Guachucal', 52),
(52320, 'Guaitarilla', 52),
(52323, 'Gualmatán', 52),
(52352, 'Iles', 52),
(52354, 'Imúes', 52),
(52356, 'Ipiales', 52),
(52378, 'La Cruz', 52),
(52381, 'La Florida', 52),
(52385, 'La Llanada', 52),
(52390, 'La Tola', 52),
(52399, 'La Unión', 52),
(52405, 'Leiva', 52),
(52411, 'Linares', 52),
(52418, 'Sotomayor (Los Andes)', 52),
(52427, 'Magüi (Payán)', 52),
(52435, 'Mallama (Piedrancha)', 52),
(52473, 'Mosquera', 52),
(52480, 'Nariño', 52),
(52490, 'Olaya Herrera', 52),
(52506, 'Ospina', 52),
(52520, 'Francisco Pizarro', 52),
(52540, 'Policarpa', 52),
(52560, 'Potosí', 52),
(52565, 'Providencia', 52),
(52573, 'Puerres', 52),
(52585, 'Pupiales', 52),
(52612, 'Ricaurte', 52),
(52621, 'Roberto Payán (San José)', 52),
(52678, 'Samaniego', 52),
(52683, 'Sandoná', 52),
(52685, 'San Bernardo', 52),
(52687, 'San Lorenzo', 52),
(52693, 'San Pablo', 52),
(52694, 'San Pedro de Cartago', 52),
(52695, 'Santa Bárbara (Iscuandé)', 52),
(52699, 'Guachavés', 52),
(52720, 'Sapuyes', 52),
(52786, 'Taminango', 52),
(52788, 'Tangua', 52),
(52835, 'Tumaco', 52),
(52838, 'Túquerres', 52),
(52885, 'Yacuanquer', 52),
(54001, 'Cúcuta', 54),
(54003, 'Ábrego', 54),
(54051, 'Arboledas', 54),
(54099, 'Bochalema', 54),
(54109, 'Bucarasica', 54),
(54125, 'Cácota', 54),
(54128, 'Cáchira', 54),
(54172, 'Chinácota', 54),
(54174, 'Chitagá', 54),
(54206, 'Convención', 54),
(54223, 'Cucutilla', 54),
(54239, 'Durania', 54),
(54245, 'El Carmen', 54),
(54250, 'El Tarra', 54),
(54261, 'El Zulia', 54),
(54313, 'Gramalote', 54),
(54344, 'Hacarí', 54),
(54347, 'Herrán', 54),
(54377, 'Labateca', 54),
(54385, 'La Esperanza', 54),
(54398, 'La Playa', 54),
(54405, 'Los Patios', 54),
(54418, 'Lourdes', 54),
(54480, 'Mutiscua', 54),
(54498, 'Ocaña', 54),
(54518, 'Pamplona', 54),
(54520, 'Pamplonita', 54),
(54553, 'Puerto Santander', 54),
(54599, 'Ragonvalia', 54),
(54660, 'Salazar', 54),
(54670, 'San Calixto', 54),
(54673, 'San Cayetano', 54),
(54680, 'Santiago', 54),
(54720, 'Sardinata', 54),
(54743, 'Silos', 54),
(54800, 'Teorama', 54),
(54810, 'Tibú', 54),
(54820, 'Toledo', 54),
(54871, 'Villa Caro', 54),
(54874, 'Villa del Rosario', 54),
(63001, 'Armenia', 63),
(63111, 'Buenavista', 63),
(63130, 'Calarcá', 63),
(63190, 'Circasia', 63),
(63212, 'Cordobá', 63),
(63272, 'Filandia', 63),
(63302, 'Génova', 63),
(63401, 'La Tebaida', 63),
(63470, 'Montenegro', 63),
(63548, 'Pijao', 63),
(63594, 'Quimbaya', 63),
(63690, 'Salento', 63),
(66001, 'Pereira', 66),
(66045, 'Apía', 66),
(66075, 'Balboa', 66),
(66088, 'Belén de Umbría', 66),
(66170, 'Dos Quebradas', 66),
(66318, 'Guática', 66),
(66383, 'La Celia', 66),
(66400, 'La Virginia', 66),
(66440, 'Marsella', 66),
(66456, 'Mistrató', 66),
(66572, 'Pueblo Rico', 66),
(66594, 'Quinchía', 66),
(66682, 'Santa Rosa de Cabal', 66),
(66687, 'Santuario', 66),
(68001, 'Bucaramanga', 68),
(68013, 'Aguada', 68),
(68020, 'Albania', 68),
(68051, 'Aratoca', 68),
(68077, 'Barbosa', 68),
(68079, 'Barichara', 68),
(68081, 'Barrancabermeja', 68),
(68092, 'Betulia', 68),
(68101, 'Bolívar', 68),
(68121, 'Cabrera', 68),
(68132, 'California', 68),
(68147, 'Capitanejo', 68),
(68152, 'Carcasí', 68),
(68160, 'Cepita', 68),
(68162, 'Cerrito', 68),
(68167, 'Charalá', 68),
(68169, 'Charta', 68),
(68176, 'Chima', 68),
(68179, 'Chipatá', 68),
(68190, 'Cimitarra', 68),
(68207, 'Concepción', 68),
(68209, 'Confines', 68),
(68211, 'Contratación', 68),
(68217, 'Coromoro', 68),
(68229, 'Curití', 68),
(68235, 'El Carmen', 68),
(68245, 'El Guacamayo', 68),
(68250, 'El Peñon', 68),
(68255, 'El Playón', 68),
(68264, 'Encino', 68),
(68266, 'Enciso', 68),
(68271, 'Florián', 68),
(68276, 'Floridablanca', 68),
(68296, 'Galán', 68),
(68298, 'Gámbita', 68),
(68306, 'Girón', 68),
(68318, 'Guaca', 68),
(68320, 'Guadalupe', 68),
(68322, 'Guapota', 68),
(68324, 'Guavatá', 68),
(68327, 'Guepsa', 68),
(68344, 'Hato', 68),
(68368, 'Jesús María', 68),
(68370, 'Jordán', 68),
(68377, 'La Belleza', 68),
(68385, 'Landázuri', 68),
(68397, 'La Paz', 68),
(68406, 'Lebrija', 68),
(68418, 'Los Santos', 68),
(68425, 'Macaravita', 68),
(68432, 'Málaga', 68),
(68444, 'Matanza', 68),
(68464, 'Mogotes', 68),
(68468, 'Molagavita', 68),
(68498, 'Ocamonte', 68),
(68500, 'Oiba', 68),
(68502, 'Onzaga', 68),
(68522, 'Palmar', 68),
(68524, 'Palmas del Socorro', 68),
(68533, 'Páramo', 68),
(68547, 'Pie de Cuesta', 68),
(68549, 'Pinchote', 68),
(68572, 'Puente Nacional', 68),
(68573, 'Puerto Parra', 68),
(68575, 'Puerto Wilches', 68),
(68615, 'Rio Negro', 68),
(68655, 'Sabana de Torres', 68),
(68669, 'San Andrés', 68),
(68673, 'San Benito', 68),
(68679, 'San Gíl', 68),
(68682, 'San Joaquín', 68),
(68684, 'San Miguel', 68),
(68686, 'San José de Miranda', 68),
(68689, 'San Vicente del Chucurí', 68),
(68705, 'Santa Bárbara', 68),
(68720, 'Santa Helena del Opón', 68),
(68745, 'Simacota', 68),
(68755, 'Socorro', 68),
(68770, 'Suaita', 68),
(68773, 'Sucre', 68),
(68780, 'Suratá', 68),
(68820, 'Tona', 68),
(68855, 'Valle de San José', 68),
(68861, 'Vélez', 68),
(68867, 'Vetas', 68),
(68872, 'Villanueva', 68),
(68895, 'Zapatoca', 68),
(70001, 'Sincelejo', 70),
(70110, 'Buenavista', 70),
(70124, 'Caimito', 70),
(70204, 'Colosó (Ricaurte)', 70),
(70215, 'Corozal', 70),
(70221, 'Coveñas', 70),
(70230, 'Chalán', 70),
(70233, 'El Roble', 70),
(70235, 'Galeras (Nueva Granada)', 70),
(70265, 'Guaranda', 70),
(70400, 'La Unión', 70),
(70418, 'Los Palmitos', 70),
(70429, 'Majagual', 70),
(70473, 'Morroa', 70),
(70508, 'Ovejas', 70),
(70523, 'Palmito', 70),
(70670, 'Sampués', 70),
(70678, 'San Benito Abad', 70),
(70702, 'San Juan de Betulia', 70),
(70708, 'San Marcos', 70),
(70713, 'San Onofre', 70),
(70717, 'San Pedro', 70),
(70742, 'Sincé', 70),
(70771, 'Sucre', 70),
(70820, 'Tolú', 70),
(70823, 'Tolú Viejo', 70),
(73001, 'Ibagué', 73),
(73024, 'Alpujarra', 73),
(73026, 'Alvarado', 73),
(73030, 'Ambalema', 73),
(73043, 'Anzoátegui', 73),
(73055, 'Armero (Guayabal)', 73),
(73067, 'Ataco', 73),
(73124, 'Cajamarca', 73),
(73148, 'Carmen de Apicalá', 73),
(73152, 'Casabianca', 73),
(73168, 'Chaparral', 73),
(73200, 'Coello', 73),
(73217, 'Coyaima', 73),
(73226, 'Cunday', 73),
(73236, 'Dolores', 73),
(73268, 'Espinal', 73),
(73270, 'Falan', 73),
(73275, 'Flandes', 73),
(73283, 'Fresno', 73),
(73319, 'Guamo', 73),
(73347, 'Herveo', 73),
(73349, 'Honda', 73),
(73352, 'Icononzo', 73),
(73408, 'Lérida', 73),
(73411, 'Líbano', 73),
(73443, 'Mariquita', 73),
(73449, 'Melgar', 73),
(73461, 'Murillo', 73),
(73483, 'Natagaima', 73),
(73504, 'Ortega', 73),
(73520, 'Palocabildo', 73),
(73547, 'Piedras', 73),
(73555, 'Planadas', 73),
(73563, 'Prado', 73),
(73585, 'Purificación', 73),
(73616, 'Rioblanco', 73),
(73622, 'Roncesvalles', 73),
(73624, 'Rovira', 73),
(73671, 'Saldaña', 73),
(73675, 'San Antonio', 73),
(73678, 'San Luis', 73),
(73686, 'Santa Isabel', 73),
(73770, 'Suárez', 73),
(73854, 'Valle de San Juan', 73),
(73861, 'Venadillo', 73),
(73870, 'Villahermosa', 73),
(73873, 'Villarrica', 73),
(76001, 'Calí', 76),
(76020, 'Alcalá', 76),
(76036, 'Andalucía', 76),
(76041, 'Ansermanuevo', 76),
(76054, 'Argelia', 76),
(76100, 'Bolívar', 76),
(76109, 'Buenaventura', 76),
(76111, 'Buga', 76),
(76113, 'Bugalagrande', 76),
(76122, 'Caicedonia', 76),
(76126, 'Calima (Darién)', 76),
(76130, 'Candelaria', 76),
(76147, 'Cartago', 76),
(76233, 'Dagua', 76),
(76243, 'El Águila', 76),
(76246, 'El Cairo', 76),
(76248, 'El Cerrito', 76),
(76250, 'El Dovio', 76),
(76275, 'Florida', 76),
(76306, 'Ginebra', 76),
(76318, 'Guacarí', 76),
(76364, 'Jamundí', 76),
(76400, 'La Unión', 76),
(76403, 'La Victoria', 76),
(76497, 'Obando', 76),
(76520, 'Palmira', 76),
(76563, 'Pradera', 76),
(76606, 'Restrepo', 76),
(76616, 'Riofrío', 76),
(76622, 'Roldanillo', 76),
(76670, 'San Pedro', 76),
(76677, 'La Cumbre', 76),
(76736, 'Sevilla', 76),
(76823, 'Toro', 76),
(76828, 'Trujillo', 76),
(76834, 'Tulúa', 76),
(76845, 'Ulloa', 76),
(76863, 'Versalles', 76),
(76869, 'Vijes', 76),
(76890, 'Yotoco', 76),
(76892, 'Yumbo', 76),
(76895, 'Zarzal', 76),
(81001, 'Arauca', 81),
(81065, 'Arauquita', 81),
(81220, 'Cravo Norte', 81),
(81300, 'Fortúl', 81),
(81591, 'Puerto Rondón', 81),
(81736, 'Saravena', 81),
(81794, 'Tame', 81),
(85001, 'Yopal', 85),
(85010, 'Aguazul', 85),
(85015, 'Chámeza', 85),
(85125, 'Hato Corozal', 85),
(85136, 'La Salina', 85),
(85139, 'Maní', 85),
(85162, 'Monterrey', 85),
(85225, 'Nunchía', 85),
(85230, 'Orocué', 85),
(85250, 'Paz de Ariporo', 85),
(85263, 'Pore', 85),
(85279, 'Recetor', 85),
(85300, 'Sabanalarga', 85),
(85315, 'Sácama', 85),
(85325, 'San Luís de Palenque', 85),
(85400, 'Támara', 85),
(85410, 'Tauramena', 85),
(85430, 'Trinidad', 85),
(85440, 'Villanueva', 85),
(86001, 'Mocoa', 86),
(86219, 'Colón', 86),
(86320, 'Orito', 86),
(86568, 'Puerto Asís', 86),
(86569, 'Puerto Caicedo', 86),
(86571, 'Puerto Guzmán', 86),
(86573, 'Puerto Leguízamo', 86),
(86749, 'Sibundoy', 86),
(86755, 'San Francisco', 86),
(86757, 'San Miguel', 86),
(86760, 'Santiago', 86),
(86865, 'Valle del Guamuez', 86),
(86885, 'Villagarzón', 86),
(88564, 'Providencia', 88),
(91001, 'Leticia', 91),
(91540, 'Puerto Nariño', 91),
(94001, 'Inírida', 94),
(95001, 'San José del Guaviare', 95),
(95015, 'Calamar', 95),
(95025, 'El Retorno', 95),
(95200, 'Miraflores', 95),
(97001, 'Mitú', 97),
(97161, 'Carurú', 97),
(97666, 'Taraira', 97),
(99001, 'Puerto Carreño', 99),
(99524, 'La Primavera', 99),
(99624, 'Santa Rosalía', 99),
(99773, 'Cumaribo', 99);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paciente`
--

CREATE TABLE IF NOT EXISTS `paciente` (
  `idpersona` varchar(45) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `num_afiliacion` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `sexo` varchar(45) DEFAULT NULL,
  `estadoCivil` varchar(45) DEFAULT NULL,
  `fechaNacimiento` date DEFAULT NULL,
  `municipios_codigo` int(11) NOT NULL,
  `profesiones_codigo` int(11) NOT NULL,
  PRIMARY KEY (`idpersona`),
  KEY `fk_paciente_municipios1` (`municipios_codigo`),
  KEY `fk_paciente_profesiones1` (`profesiones_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `paciente`
--

INSERT INTO `paciente` (`idpersona`, `nombre`, `direccion`, `num_afiliacion`, `telefono`, `sexo`, `estadoCivil`, `fechaNacimiento`, `municipios_codigo`, `profesiones_codigo`) VALUES
('1047565684', 'Pedro Jose Payares Mendez', 'Bocagrande Avenida san martin Nº 15 29', '104759568466', '6812555', 'masculino', 'soltero', '1986-02-24', 13001, 2135),
('98765432', 'Juan gabriel', 'centro', '98765432', '6776767', 'masculino', 'casado', '2013-03-21', 13001, 311);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantratamiento`
--

CREATE TABLE IF NOT EXISTS `plantratamiento` (
  `idplanTratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idplanTratamiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `plantratamiento`
--

INSERT INTO `plantratamiento` (`idplanTratamiento`, `nombre`) VALUES
(1, 'Semiologia'),
(2, 'Promocion y Prevencion'),
(3, 'Operatoria'),
(4, 'Endodoncia'),
(5, 'Periodoncia'),
(6, 'Cirugia'),
(7, 'Odontopedriatia'),
(8, 'Rehabilitacion'),
(9, 'Ortodoncia'),
(10, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preparacionbiomedica`
--

CREATE TABLE IF NOT EXISTS `preparacionbiomedica` (
  `idpreparacionBiomedica` int(11) NOT NULL AUTO_INCREMENT,
  `canal` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `referencia` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `la` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `lri` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `lrt` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `instInicial` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `limaRetroceso` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `preApical` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `historiaClinica_idhistoriaClinica` int(11) NOT NULL,
  PRIMARY KEY (`idpreparacionBiomedica`),
  KEY `fk_preparacionBiomedica_historiaClinica1` (`historiaClinica_idhistoriaClinica`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesiones`
--

CREATE TABLE IF NOT EXISTS `profesiones` (
  `profesion` varchar(255) DEFAULT NULL,
  `codigo` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `profesiones`
--

INSERT INTO `profesiones` (`profesion`, `codigo`) VALUES
('Personal Directivo de la Administración Pública', 12),
('Directores y Gerentes Generales de Servicios Financieros, de Telecomunicaciones y Otros Servicios', 13),
('Directores y Gerentes Generales de Salud, Educación, Servicios Social y Comunitario y Organizaciones', 14),
('Directores y Gerentes Generales de Comercio, Medios de Comunicación y Otros Servicios', 15),
('Directores y Gerentes Generales de Producción de Bienes, Servicios Públicos, Transporte y Construcción', 16),
('Gerentes Financieros', 111),
('Gerentes de Recursos Humanos', 112),
('Gerentes de Compras y Adquisiciones', 113),
('Gerentes de Otros Servicios Administrativos', 114),
('Gerentes de Seguros, Bienes Raíces y Corretaje Financiero', 121),
('Gerentes de Banca, Crédito e Inversiones', 122),
('Gerentes de Otros Servicios a las Empresas', 123),
('Gerentes de Empresas de Telecomunicaciones', 131),
('Gerentes de Servicios de Correo y Mensajería', 132),
('Gerentes de Ingeniería', 211),
('Gerentes de Investigación y Desarrollo en Ciencias Naturales y Aplicadas', 212),
('Gerentes de Sistemas de Información y Procesamiento de Datos', 213),
('Gerentes de Servicios a la Salud', 311),
('Gerentes de Programas de Política Social y de Salud', 411),
('Gerentes de Programas de Política de Desarrollo Económico', 412),
('Gerentes de Programas de Política Educativa', 413),
('Otros Gerentes de Administración Pública', 414),
('Administradores de Educación Superior y Formación para el Trabajo', 421),
('Directores y Administradores de Educación Básica y Media', 422),
('Gerentes de Servicios Social, Comunitario y Correccional', 423),
('Gerentes de Biblioteca, Archivo, Museo y Galería de Arte', 511),
('Gerentes de Medios de Comunicación y Artes Escénicas', 512),
('Directores de Programas de Esparcimiento y Deportes', 513),
('Gerentes de Ventas, Mercadeo y Publicidad', 611),
('Gerentes de Servicios de Comercio Exterior', 612),
('Gerentes de Comercio al Por Menor', 621),
('Gerentes de Restaurantes y Servicios de Alimentos', 631),
('Gerentes de Servicios de Alojamiento', 632),
('Gerentes de Otros Servicios', 651),
('Gerentes de Producción Primaria ', 711),
('Gerentes de Construcción', 811),
('Gerentes de Transporte y Distribución', 812),
('Gerentes de Operación de Instalaciones Físicas', 821),
('Gerentes de Mantenimiento', 822),
('Gerentes de Producción Industrial', 911),
('Gerentes de Empresas de Servicios Públicos', 912),
('Contadores y Auditores', 1111),
('Analistas y Agentes de Inversiones y Finanzas', 1112),
('Profesionales en Recursos Humanos', 1121),
('Profesionales en Organización y Administración de las Empresas', 1122),
('Supervisores, Empleados de Apoyo Administrativo', 1211),
('Supervisores, Empleados de Seguros y Finanzas', 1212),
('Supervisores, Empleados de Información y Servicio al Cliente', 1213),
('Supervisores, Empleados de Correo y Mensajería', 1214),
('Supervisores, Empleados de Registro, Distribución y Programación', 1215),
('Asistentes Administrativos', 1221),
('Administradores de Inmuebles', 1222),
('Asistentes de Personal y Selección', 1223),
('Asistentes de Compras y Adquisiciones', 1224),
('Asistentes de Juzgados Tribunales y Afines', 1225),
('Funcionarios de Aduanas, Impuestos, Inmigración y Seguridad Social', 1226),
('Asistentes de Comercio Exterior', 1227),
('Organizadores de Eventos', 1228),
('Analistas de Crédito y Cobranzas', 1231),
('Avaluadores y Liquidadores de Seguros', 1233),
('Agentes de Aduana', 1234),
('Secretarias', 1311),
('Auxiliares de Oficina', 1312),
('Recepcionistas y Operadores de Conmutador', 1313),
('Digitadores', 1321),
('Transcriptores y Relatores', 1322),
('Auxiliares Contables', 1331),
('Cajeros de Servicios Financieros', 1332),
('Auxiliares de Banca, Seguros y Otros Servicios Financieros', 1333),
('Auxiliares de Cartera y Cobranzas', 1334),
('Auxiliares Administrativos', 1341),
('Auxiliares de Personal', 1342),
('Auxiliares de Tribunales', 1343),
('Auxiliares de Archivo y Registro', 1344),
('Auxiliares de Biblioteca', 1345),
('Auxiliares de Publicación y Afines', 1346),
('Auxiliares de Información y Servicio al Cliente', 1353),
('Auxiliares de Estadísticas y Encuestadores', 1354),
('Auxiliares de Correo y Servicio Postal', 1361),
('Auxiliares de Almacén y Bodega', 1371),
('Auxiliares de Compras e Inventarios', 1372),
('Operadores de Radio y Despachadores', 1373),
('Programadores de Rutas y Tripulaciones', 1374),
('Operadores Telefónicos', 1375),
('Físicos y Astrónomos', 2111),
('Químicos', 2112),
('Geólogos, Geoquímicas y Geofísicos', 2113),
('Meteorólogos', 2114),
('Biólogos, Botánicos, Zoólogos y Relacionados', 2121),
('Expertos Forestales ', 2122),
('Expertos Agrícolas y Pecuarios', 2123),
('Ingenieros en Construcción y Obras Civiles', 2131),
('Ingenieros Mecánicos', 2132),
('Ingenieros Electricistas', 2133),
('Ingenieros Electrónicos y de Telecomunicaciones', 2134),
('Ingenieros Químicos', 2135),
('Ingenieros Industriales y de Fabricación', 2141),
('Ingenieros de Materiales y Metalurgia', 2142),
('Ingenieros de Minas', 2143),
('Ingenieros de Petróleos', 2144),
('Ingenieros de Sistemas, Informática y Computación', 2145),
('Otros Ingenieros ', 2146),
('Arquitectos', 2151),
('Urbanistas y Planificadores del Uso del Suelo', 2152),
('Profesionales Topográficos ', 2153),
('Matemáticos, Estadísticos y Actuarios ', 2161),
('Analistas de Sistemas Informáticos', 2171),
('Administradores de Sistemas Informáticos', 2172),
('Programadores de Aplicaciones Informáticas', 2173),
('Técnicos en Química Aplicada', 2211),
('Técnicos en Geología y Minería', 2212),
('Técnicos en Meteorología', 2213),
('Técnicos en Ciencias Biológicas ', 2221),
('Técnicos Forestales y de Recursos Naturales', 2222),
('Técnicos en Construcción y Arquitectura', 2231),
('Técnicos en Mecánica y Construcción Mecánica', 2232),
('Técnicos en Fabricación Industrial', 2233),
('Técnicos en Electricidad', 2241),
('Técnicos en Electrónica y Telecomunicaciones', 2242),
('Técnicos en Instrumentos Industriales', 2243),
('Técnicos en Instrumentos de Aeronavegación', 2244),
('Diseñadores Industriales', 2251),
('Dibujantes Técnicos', 2252),
('Topógrafos ', 2253),
('Técnicos en Cartografía', 2254),
('Inspectores de Pruebas No destructivas', 2261),
('Inspectores de Sanidad, Seguridad y Salud Ocupacional', 2262),
('Inspectores de Construcción', 2263),
('Inspectores de Equipos de Transporte e Instrumentos de Medición ', 2264),
('Inspectores de Productos Agrícolas, Pecuarios y de Pesca', 2265),
('Pilotos, Ingenieros e Instructores de Vuelo', 2271),
('Controladores de Tráfico Aéreo', 2272),
('Capitanes y Oficiales de Cubierta', 2273),
('Oficiales de Máquinas', 2274),
('Controladores de Tráfico Ferroviario y Marítimo', 2275),
('Técnicos de Sistemas', 2281),
('Médicos Especialistas', 3111),
('Médicos Generales', 3112),
('Odontólogos', 3113),
('Veterinarios', 3114),
('Optómetras', 3121),
('Otras Ocupaciones Profesionales en Diagnóstico y Tratamiento de la Salud n.c.a.', 3122),
('Farmacéuticos', 3131),
('Dietistas y Nutricionistas', 3132),
('Audiólogos y Terapeutas del Lenguaje', 3141),
('Fisioterapeutas', 3142),
('Terapeutas Ocupacionales', 3143),
('Enfermeros', 3151),
('Técnicos de Laboratorio Médico y Patología', 3211),
('Técnicos en Terapia Respiratoria y Cardiovascular', 3212),
('Técnicos en Imágenes Diagnósticas', 3213),
('Técnicos en Radioterapia y Medicina Nuclear', 3214),
('Instrumentador Quirúrgico', 3215),
('Técnicos Dentales', 3221),
('Higienistas Dentales', 3222),
('Técnicos Ópticos', 3231),
('Practicantes de Medicina Alternativa', 3232),
('Asistentes de Ambulancia y Otras Ocupaciones Paramédicas', 3233),
('Otras Ocupaciones Técnicas en Terapia y Valoración', 3234),
('Auxiliares de Enfermería', 3311),
('Auxiliares de Odontología', 3312),
('Promotores de Salud', 3313),
('Auxiliares de Laboratorio Clínico', 3314),
('Auxiliares de Droguería y Farmacia', 3315),
('Jueces', 4111),
('Abogados', 4112),
('Profesores de Educación Superior', 4121),
('Especialistas en Métodos Pedagógicos y Material Didáctico', 4122),
('Instructores de Formación para el Trabajo', 4131),
('Profesores de Educación Básica Secundaria y Media', 4141),
('Profesores de Educación Básica Primaria', 4142),
('Profesores de Preescolar', 4143),
('Orientadores Educativos', 4144),
('Psicólogos', 4151),
('Trabajadores Sociales y Consultores de Familia', 4152),
('Sociólogos, Antropólogos y Afines', 4161),
('Filósofos, Filólogos y Afines', 4162),
('Consultores, Investigadores y Analistas de Política Económica', 4171),
('Consultores y Funcionarios de Desarrollo Económico y Comercial', 4172),
('Investigadores, Consultores y Funcionarios de Políticas Sociales, de  Salud y de Educación ', 4173),
('Funcionarios de Programas Exclusivos de la Administración Pública', 4174),
('Investigadores, Consultores y Funcionarios de Políticas de Ciencias Naturales y Aplicadas', 4175),
('Asistentes en Servicios Social y Comunitario', 4211),
('Consejeros de Servicios de Empleo', 4212),
('Instructores y Profesores de Personas Discapacitadas', 4213),
('Otros Instructores', 4214),
('Asistentes Legales y Afines', 4216),
('Bibliotecarios', 5111),
('Restauradores y Curadores', 5112),
('Archivistas', 5113),
('Escritores', 5121),
('Editores', 5122),
('Periodistas', 5123),
('Traductores e Interpretes', 5124),
('Ocupaciones Profesionales en Relaciones Públicas y Comunicaciones', 5125),
('Productores, Directores Artísticos, Coreógrafos y Ocupaciones Relacionadas', 5131),
('Directores Musicales, Compositores y Arreglistas', 5132),
('Músicos y Cantantes', 5133),
('Bailarines', 5134),
('Actores', 5135),
('Pintores, Escultores y Otros Artistas Visuales', 5136),
('Ocupaciones Técnicas Relacionadas con Museos y Galerías', 5211),
('Técnicos en Biblioteca y Archivo', 5212),
('Fotógrafos', 5221),
('Operadores de Cámara de Cine y Televisión', 5222),
('Técnicos de Arte Gráfico', 5223),
('Técnicos en Transmisión de Radio y Televisión', 5224),
('Técnicos en Grabación de Audio y Video', 5225),
('Otras Ocupaciones Técnicas en Cine, TV y Artes Escénicas', 5226),
('Ocupaciones de Asistencia en Cine, TV y Artes Escénicas  ', 5227),
('Anunciadores y Locutores', 5231),
('Diseñadores Gráficos y Dibujantes Artísticos', 5241),
('Diseñadores de Interiores', 5242),
('Diseñadores de Teatro, Moda, Exhibición, y Otros Diseñadores Creativos', 5243),
('Artesanos', 5244),
('Patronistas –Productos de Tela, Cuero y Piel', 5245),
('Entrenadores y Preparadores Físicos', 5252),
('Supervisores de Ventas', 6211),
('Supervisores de Servicios de Alimentos', 6213),
('Supervisores de Personal ', 6214),
('Técnicos Criminalisticos y Judiciales', 6224),
('Agentes y Corredores de Seguros', 6231),
('Agentes de Bienes Raíces', 6232),
('Vendedores –Ventas Técnicas', 6233),
('Agentes de Compras e Intermediarios', 6234),
('Chef', 6241),
('Vendedores –Ventas no Técnicas', 6311),
('Vendedores de Mostrador', 6321),
('Mercaderistas e Impulsadores', 6322),
('Cajeros de Comercio', 6323),
('Modelos', 6324),
('Agentes de Viajes', 6331),
('Empleados de Ventas y Servicios de Líneas Aéreas, Marítimas y Terrestres', 6332),
('Auxiliares de Vuelo y Sobrecargos', 6333),
('Empleados de Recepción Hotelera', 6334),
('Guías de Viaje y Turismo', 6341),
('Recreacionistas', 6342),
('Operadores de Juegos Mecánicos y de Salón', 6343),
('Cortadores de Carne –Comercio Mayorista y al Detal', 6351),
('Panaderos y Pasteleros', 6352),
('Meseros y Capitán de Meseros', 6353),
('Barman', 6354),
('Cocineros', 6355),
('Funcionarios de Regulación', 6362),
('Bomberos', 6364),
('Guardianes de Prisión', 6365),
('Auxiliares del Cuidado de Niños', 6372),
('Estilistas, Esteticistas y Afines', 6373),
('Trabajadores del Cuidado de Animales', 6374),
('Empleados de Pompas Fúnebres', 6375),
('Trabajadores de Estación de Servicio', 6611),
('Otras Ocupaciones Elementales de las Ventas', 6612),
('Ayudantes de Cocina y Cafetería', 6621),
('Aseadores  ', 6631),
('Aseadores Especializados y Fumigadores', 6632),
('Auxiliares de Servicios a Viajeros', 6641),
('Auxiliares de Servicios de Recreación y Deporte', 6642),
('Empleados de Lavandería', 6643),
('Otras Ocupaciones Elementales de los Servicios ', 6644),
('Supervisores, Minería y Canteras', 7211),
('Supervisores, Perforación y Servicios –Pozos de Petróleo y Gas', 7212),
('Supervisores, Producción Agrícola', 7221),
('Supervisores, Producción Pecuaria', 7222),
('Supervisores, Explotación Forestal y Silvicultura', 7223),
('Agricultores y Administradores Agropecuarios', 7231),
('Contratistas de Servicios Agrícolas y Relacionados', 7232),
('Contratistas y Supervisores de Servicios de Jardinería y Viverismo', 7233),
('Administradores de Explotación Acuícola', 7234),
('Capitanes y Patrones de Pesca', 7241),
('Operarios de Apoyo y Servicios en Minería Bajo Tierra', 7311),
('Operarios de Apoyo y Servicios en Perforación de Petróleo y Gas', 7312),
('Mineros –Producción Bajo Tierra', 7313),
('Perforadores de Pozos de Gas y Petróleo y Trabajadores Relacionados', 7314),
('Trabajadores de Explotación Forestal', 7321),
('Trabajadores de Silvicultura y Forestación', 7322),
('Trabajadores Agrícolas', 7331),
('Trabajadores Pecuarios', 7332),
('Trabajadores de Plantas de Incubación Artificial ', 7335),
('Pescadores', 7341),
('Obreros y Ayudantes de Minería', 7611),
('Obreros y Ayudantes de Producción en Pozos de Petróleo y Gas', 7612),
('Obreros Agropecuarios ', 7613),
('Jardineros', 7614),
('Contratistas y Supervisores, Ajustadores de Maquinas-Herramientas y Ocupaciones Relacionadas', 8211),
('Contratistas y Supervisores, Electricidad y Telecomunicaciones', 8212),
('Contratistas y Supervisores, Instalación de Tuberías ', 8213),
('Contratistas y Supervisores, Moldeo, Forja y Montaje de Estructuras Metálicas', 8214),
('Contratistas y Supervisores, Carpintería', 8215),
('Contratistas y Supervisores, Mecánica', 8216),
('Contratistas y Supervisores, Operación de Equipo Pesado', 8217),
('Contratistas y Supervisores, Construcción y Otras Ocupaciones de Instalación y Reparación', 8218),
('Supervisores de Operación de Transporte Ferroviario', 8221),
('Supervisores de Operación de Transporte Terrestre (no ferroviario)', 8222),
('Ajustadores de Maquinas-Herramientas', 8311),
('Modelistas y Matriceros', 8312),
('Electricistas Industriales', 8321),
('Electricistas Residenciales', 8322),
('Instaladores de Redes de Energía Eléctrica', 8323),
('Instaladores y Reparadores de Redes y Líneas de Telecomunicaciones', 8324),
('Trabajadores de Instalación y Reparación de Equipos de Telecomunicaciones', 8325),
('Técnicos de Mantenimiento y Servicio de Televisión por Cable', 8326),
('Plomeros', 8331),
('Instaladores de Tuberías y Sistemas de Aspersión', 8332),
('Instaladores de Redes  y Equipos a Gas', 8333),
('Chapistas y Caldereros', 8341),
('Soldadores', 8342),
('Montadores de Estructuras Metálicas', 8343),
('Ornamentistas y Forjadores', 8344),
('Carpinteros', 8351),
('Ebanistas', 8352),
('Oficiales de Construcción', 8361),
('Trabajadores en Hormigón y Enfoscado', 8362),
('Enchapadores ', 8363),
('Techadores', 8364),
('Instaladores de Material Aislante', 8365),
('Pintores y Empapeladores', 8366),
('Instaladores de Pisos', 8367),
('Revocadores', 8368),
('Mecánicos Industriales', 8371),
('Mecánicos de Maquinaria Textil', 8372),
('Mecánicos de Equipo Pesado', 8373),
('Mecánicos de Aviación', 8374),
('Mecánicos de Aire Acondicionado y Refrigeración', 8375),
('Mecánicos de Vehículos Automotores', 8381),
('Electricistas de Vehículos Automotores', 8382),
('Mecánicos de Motos', 8383),
('Latoneros', 8384),
('Reparadores de Aparatos Electrodomésticos', 8391),
('Mecánicos Electricistas', 8392),
('Ajustadores y Reparadores de Equipos Electrónicos', 8393),
('Mecánicos de Otros Pequeñas Máquinas y Motores', 8394),
('Instaladores Residenciales y Comerciales', 8411),
('Operarios de Mantenimiento -Instalaciones de Abastecimiento de Agua y Gas', 8412),
('Vidrieros', 8413),
('Otros Reparadores', 8414),
('Tapiceros', 8421),
('Sastres, Modistos, Plateros y Sombrereros', 8422),
('Zapateros y Afines', 8423),
('Joyeros y Relojeros', 8424),
('Tipógrafos', 8425),
('Cerrajeros y Otros Oficios', 8426),
('Buzos', 8427),
('Operadores de Maquinas Estacionarias y Equipo Auxiliar', 8431),
('Operadores de Plantas de Generación y Distribución de Energía', 8432),
('Operadores de Grúa', 8441),
('Perforadores y Operarios de Voladura –Minería de Superficie, Canteras y Construcción', 8442),
('Perforadores de Pozos de Agua', 8443),
('Operadores de Equipo Pesado (excepto grúa)', 8451),
('Operadores de Equipo para Limpieza de Vías y Alcantarillado', 8452),
('Operadores de Maquinaria Agrícola', 8453),
('Maquinistas de Transporte Ferroviario', 8461),
('Guardafrenos y Otros Operadores Ferroviarios', 8462),
('Marineros de Cubierta', 8481),
('Marineros de Sala de Máquinas', 8482),
('Operadores de Pequeñas Embarcaciones', 8483),
('Operarios de Rampa –Transporte Aéreo', 8484),
('Operarios Portuarios', 8491),
('Operarios de Cargue y Descargue de Materiales', 8492),
('Ayudantes y Obreros de Construcción', 8611),
('Ayudantes de Otros Oficios ', 8612),
('Obreros de Mantenimiento de Obras Públicas', 8621),
('Ayudantes de Transporte Automotor ', 8622),
('Supervisores Tratamiento de Metales y Minerales', 9211),
('Supervisores, Procesamiento de Químicos, Petróleo, Gas y Tratamiento de Agua y Generación de Energía', 9212),
('Supervisores, Procesamiento de Alimentos, Bebidas y Tabaco', 9213),
('Supervisores, Fabricación de Productos de Plástico y Caucho', 9214),
('Supervisores, Procesamiento de la Madera y Producción de Pulpa y Papel', 9215),
('Supervisores, Procesamiento Textil', 9216),
('Supervisores, Ensamble de Vehículos de Motor', 9221),
('Supervisores, Fabricación de Productos Electrónicos', 9222),
('Supervisores, Fabricación de Productos Eléctricos', 9223),
('Supervisores, Fabricación de Muebles y Accesorios', 9224),
('Supervisores, Fabricación de Productos de Tela, Cuero y Piel', 9225),
('Supervisores, Impresión y Ocupaciones Relacionadas', 9226),
('Supervisores, Fabricación de Otros Productos Mecánicos y Metálicos', 9227),
('Supervisores, Fabricación  Ensamble de Otros Productos n.c.a', 9228),
('Operadores de Control Central de Procesos, Tratamiento de Metales y Minerales', 9231),
('Operadores de Procesos, Químicos, Gas y Petróleo', 9232),
('Operadores de Control de Procesos, Producción de Pulpa', 9233),
('Operadores de Control de Procesos, Fabricación de Papel', 9234),
('Operadores de Maquinas, Tratamiento de Metales y Minerales', 9311),
('Trabajadores de Fundición', 9312),
('Operadores de Fabricación, Moldeo y Acabado del Vidrio', 9313),
('Operadores de Moldeo de Arcilla, Piedra y Concreto', 9314),
('Inspectores de Control de Calidad, Tratamiento de Metales y Minerales', 9315),
('Operadores de Máquinas de Planta Química', 9321),
('Operadores de Máquinas para Procesamiento de Plásticos', 9322),
('Operadores de Máquinas y Trabajadores Relacionados con el Procesamiento del Caucho', 9323),
('Operadores de Plantas de Tratamiento de Aguas y Desechos', 9324),
('Operadores de Máquinas para Procesamiento de la Madera', 9331),
('Operadores de Máquinas para la Producción de Pulpa', 9332),
('Operadores de Máquinas para la Fabricación de Papel', 9333),
('Operadores de Máquinas para la Fabricación de Productos de Papel', 9334),
('Inspectores de Control de Calidad, Procesamiento de la Madera', 9335),
('Operadores de Máquinas para la Preparación de Fibras Textiles', 9341),
('Operadores de Telares y Otras Máquinas Tejedoras', 9342),
('Operadores de Máquinas de Tintura y Acabado Textil', 9343),
('Analistas de  Calidad Textiles', 9344),
('Operadores de Máquinas para Coser', 9351),
('Cortadores de Tela, Cuero y Piel', 9352),
('Operadores de Máquinas y Trabajadores Relacionados con la Fabricación de Calzado y Marroquinería ', 9353),
('Operarios del Tratamiento de Pieles y Cueros', 9354),
('Inspectores de Control de Calidad, Fabricación de Productos de Tela, Piel y Cuero', 9355),
('Operadores de Control de Procesos y Máquinas para la Elaboración de Alimentos y Bebidas', 9361),
('Operarios de Planta de Beneficio Animal', 9362),
('Operarios de Planta de Procesamiento y Empaque de Pescado', 9363),
('Operadores de Máquinas para la Elaboración de Productos de Tabaco', 9364),
('Inspectores de Control de Calidad, Procesamiento de Alimentos y Bebidas', 9365),
('Operadores de Máquinas de Impresión', 9371),
('Grabadores y Otras Ocupaciones de Pre-impresión', 9372),
('Operadores de Máquinas de Encuadernación y Acabado', 9373),
('Procesadores Fotográficos y de Películas', 9374),
('Ensambladores e Inspectores de Vehículos a Automotor', 9381),
('Ensambladores, Fabricantes e Inspectores de Equipos y Componentes Electrónicos', 9382),
('Ensambladores e Inspectores de Aparatos y Equipo Eléctrico', 9383),
('Ensambladores, Fabricantes e Inspectores de Transformadores y Motores Eléctricos Industriales', 9384),
('Ensambladores e Inspectores de Productos Mecánicos', 9385),
('Ensambladores e Inspectores de Ensamble de Aeronaves', 9386),
('Operadores de Máquinas e Inspectores de la Fabricación de Productos y Componentes Eléctricos', 9387),
('Ensambladores e Inspectores de Embarcaciones', 9391),
('Ensambladores e Inspectores de Muebles y Accesorios', 9392),
('Operarios de Acabado de Muebles', 9393),
('Ensambladores de Productos Plásticos e Inspectores', 9394),
('Operarios de Recubrimientos Metálicos', 9395),
('Pintores en Procesos de Manufactura', 9396),
('Operadores de Máquinas Herramientas', 9411),
('Operadores de Máquinas para el Trabajo de la Madera', 9412),
('Operadores de Máquinas para el Trabajo del Metal', 9413),
('Operadores de Máquinas para Forja', 9414),
('Operadores de Máquinas de Soldadura', 9415),
('Operadores de Máquinas para la Fabricación de Otros Productos Metálicos', 9416),
('Obreros y Ayudantes en el Tratamiento de Metales y Minerales', 9611),
('Ayudantes en la Fabricación Metálica', 9612),
('Obreros y Ayudantes de Planta Química', 9613),
('Obreros y Ayudantes en el Procesamiento de la Madera y Producción de Pulpa y Papel', 9614),
('Obreros y Ayudantes en la Elaboración de Alimentos y Bebidas', 9615);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `radiografia`
--

CREATE TABLE IF NOT EXISTS `radiografia` (
  `idradiografia` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `ruta` varchar(255) DEFAULT NULL,
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  PRIMARY KEY (`idradiografia`),
  KEY `fk_radiografia_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `remision`
--

CREATE TABLE IF NOT EXISTS `remision` (
  `idremision` int(11) NOT NULL,
  `remision` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idremision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `remision`
--

INSERT INTO `remision` (`idremision`, `remision`) VALUES
(1, 'Semiologia'),
(2, 'Promocion y Prevencion'),
(3, 'Operatoria'),
(4, 'Endodoncia'),
(5, 'Periodoncia'),
(6, 'Cirugia'),
(7, 'Odontopedriatia'),
(8, 'Rehabilitacion'),
(9, 'Ortodoncia'),
(10, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `remision_has_datosconsulta`
--

CREATE TABLE IF NOT EXISTS `remision_has_datosconsulta` (
  `remision_idremision` int(11) NOT NULL,
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  PRIMARY KEY (`remision_idremision`,`datosConsulta_iddatosConsulta`),
  KEY `fk_remision_has_datosConsulta_datosConsulta1` (`datosConsulta_iddatosConsulta`),
  KEY `fk_remision_has_datosConsulta_remision1` (`remision_idremision`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `remision_has_datosconsulta`
--

INSERT INTO `remision_has_datosconsulta` (`remision_idremision`, `datosConsulta_iddatosConsulta`) VALUES
(2, 19),
(5, 19),
(9, 19);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE IF NOT EXISTS `tratamiento` (
  `idtratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `tratamiento` varchar(255) DEFAULT NULL,
  `presupuesto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtratamiento`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2104 ;

--
-- Volcado de datos para la tabla `tratamiento`
--

INSERT INTO `tratamiento` (`idtratamiento`, `tratamiento`, `presupuesto`) VALUES
(101, 'Historia Clinica, impresión para modelo, Rx panoramica digital', '32000'),
(102, 'Historia Clinica, impresión para modelo, sin Rx panoramica digital', '12000'),
(103, 'Historia Clinica Reevaluacion', '10000'),
(104, 'Historia Clinica de niño (incluye face higienica, control de placa, primera impresión, modelo inicial) incluye 1 Rx periapical niño', '13000'),
(105, 'Historia Clinica de niños - Reevaluacion paquete: Fase Higienica, Control de placa y Cubeta de fluorogel, alginato, modelo inicial', '6500'),
(106, 'Terapeutica con Fluor de Estaño', '8000'),
(107, 'Terapeutica con Fluor Neutro', '5000'),
(108, 'Historia Clinica de Flap sin aparatologia', '20000'),
(109, 'Urgencias C/Rx periapical', '10000'),
(110, 'Rx Periapical adulto institucional', '1000'),
(111, 'Rx Periapical adulto ambulatoria', '6000'),
(112, 'Rx Pediatrica institucional', '1000'),
(113, 'Rx Pediatrica (Ambulatoria)', '4000'),
(114, 'Rx Oclusal Institucional', '9000'),
(115, 'Rx Oclusal (Ambulatoria)', '13000'),
(116, 'Rx Panoramica digital Institucional', '20000'),
(117, 'Rx Panoramica digital (Ambulatoria)', '22000'),
(118, 'Reimpresion Rx Panoramica digital', '10000'),
(119, 'Rx Panoramica digital mas Rx lateral institucional', '40000'),
(120, 'Rx Panoramica digital mas Rx lateral Ambulatoria', '44000'),
(201, 'Procedimiento obturacion en amalgama (una superficie)', '5000'),
(202, 'Procedimiento Obturacion en amalgama (dos o mas superficies)', '8000'),
(203, 'Procedimiento Obturacion en  resinas (una superficie)', '12000'),
(204, 'Procedimiento obturacion en resinas (dos o mas superficies)', '15000'),
(205, 'Procedimiento lonómero de vidrio Vitremer adulto (base cavitaria Muñón, Obturacion definitiva, etc.)', '10000'),
(206, 'lonomero Cementante (porcion)', '3500'),
(207, 'Lonomero Reconstructor', '15000'),
(208, 'Sellantes porcion (incluido eyector, tela de caucho, etc)', '4300'),
(209, 'Resina Fluida', '7300'),
(210, 'Cementacion Duall', '12000'),
(301, 'Godiva para sellado periferico', '1700'),
(302, 'Pasta Zinquenólica C/impresión', '10000'),
(303, 'Pasta Zinquenólica C/Pro porcion apra  rebasar', '3700'),
(304, 'Silicona pesada y liviana por porcion', '17200'),
(305, 'Silicona masilla porcion', '11600'),
(306, 'Silicona liviana porcion', '8000'),
(307, 'Vitrebond', '7200'),
(308, 'Duralay y Muñon molar, premolar, central, etc. Porcion', '1300'),
(309, 'Temblond cemento provisional, porcion', '700'),
(310, 'Hidróxido de Ca. Pasta cementante provisional (porcion)', '700'),
(311, 'Ionomero de Auto Vitremer, cementante definitivo (porcion adicional)', '1300'),
(312, 'Fosfato de Zinc, Cemento Smith Polvo liquido (porcion)', '700'),
(313, 'Lamina de Cera', '300'),
(314, 'Alambre de Ortodoncia No. 6, 7, 8 cada pie', '750'),
(315, 'Porcion de conos', '1900'),
(316, 'Tela de Caucho', '750'),
(317, 'Acrilico Jet Provisionales, colores N° Porcion polvo, liquido', '1200'),
(318, 'Cemento Dual porcion', '4800'),
(401, 'Exodincia sin incluir Rx periapical', '7000'),
(402, 'Exodincia incluida Rx periapical', '8000'),
(403, 'Cirugia oral programada pregrado', '27000'),
(404, 'Cirugia oral programada postgrado sin historia clinica', '60000'),
(405, 'Exodoncia en niños', '8500'),
(501, 'Pulpectomía C/R', '8500'),
(502, 'Pulpotomía C/R', '6000'),
(503, 'Recubrimiento Pulpar (pediatría)', '6100'),
(504, 'Endodoncia Monorradicular C/Rx', '17000'),
(505, 'Endodoncia Birradicular C/Rx', '19000'),
(506, 'Endodoncia Multirradicular C/Rx', '30000'),
(507, 'Retratamiento Desobturacion y tratamiento de conducto', '20000'),
(508, 'Retratamiento Desobturacion y tratamiento de conducto en diente birradicular', '20000'),
(509, 'Endodoncia Monorradicular C/Rx Especializada', '40000'),
(510, 'Endodoncia Birradicular C/Rx Especializada', '45000'),
(511, 'Endodoncia Multirradicular C/Rx Especializada', '65000'),
(512, 'Anestesico adicional', '500'),
(513, 'Aguja adicional', '200'),
(601, 'Periodoncia, fase higienica y motivacion', '6000'),
(602, 'uso de ultrasonido', '5500'),
(701, 'Mantenedores de espacio (fijo, removible, boton de Nance)', '14000'),
(702, 'Materiales para Placa de Hawley', '14000'),
(703, 'Materiales para Placa con tornillo de expansion, superior e inferior cada uno', '24000'),
(704, 'Mentonera', '20000'),
(705, 'Bandas metalicas cada una', '6000'),
(706, 'Tubos juego (2 unidades)', '7000'),
(707, 'Materiales para placa con tornillo triple', '35000'),
(708, 'Materiales para placa con tornillo Hyrax', '47000'),
(709, 'Materiales para placa Obturatriz incluye material de impresión', '14000'),
(710, 'Materiales para Aparato Ortopedico y funcionales', '23200'),
(711, 'Con tornillo Disyuntor', '41700'),
(712, 'Alginato Superior e Inferior, Modelo para Aparatologia de Ortodoncia', '1200'),
(801, 'Primera fase quirúrgica (1 Implante)', '150000'),
(802, 'Primera fase quirúrgica (2 - 3 Implantes)', '200000'),
(803, 'Primera fase quirúrgica (4 o mas Implantes)', '250000'),
(804, 'Segunda fase quirúrgica (1 Pilar)', '100000'),
(805, 'Segunda fase quirúrgica (2 - 3 Pilares)', '130000'),
(806, 'Segunda fase quirúrgica (4 o mas  Pilares)', '180000'),
(807, 'Cirugia de Regeneracion ósea (sin material)', '100000'),
(901, 'Historia Clinica', '35000'),
(902, 'Estudios de modelos superior e inferior', '15000'),
(903, 'Control de Placa', '9000'),
(904, 'Topicacion Fluor', '12000'),
(905, 'Sellantes por cuadrante', '16000'),
(906, 'Sellante por diente', '4500'),
(907, 'Pulpectomia (temp)', '22000'),
(908, 'Resina ', '15000'),
(909, 'Resina Adicional', '6000'),
(910, 'Ionomero', '12000'),
(911, 'Urgencia', '18000'),
(912, 'Terapia fluor con fluor de estaño', '15000'),
(913, 'Exodoncia temporal', '10000'),
(914, 'Corona acero', '42000'),
(915, 'Formas platicas', '26000'),
(916, 'Mantenedor de espacio fijo por 2', '100000'),
(917, 'Placas activas superior e inferior', '180000'),
(918, 'Protesis total', '80000'),
(919, 'Cirugia', '65000'),
(920, 'Topicacion con fluoruro acidulado', '12000'),
(921, 'Tratamiento barniz fluor', '20000'),
(1001, 'Yeso comun, superior e inferior cada uno', '1000'),
(1002, 'Yeso extraduro c/imp', '2300'),
(1003, 'Yeso tipo III C/u impresión - porcion', '1200'),
(1004, 'Yeso tipo IV C/u impresión - porcion', '2300'),
(1005, 'Porcion de Acrilico autopolimerizante polvo', '1200'),
(1006, 'Porcion de Acrilico autopolimerizante liquido', '1200'),
(1007, 'Porcion de Acrilico termocurado liquido', '3500'),
(1008, 'Porcion de Acrilico termocurado polvo', '3500'),
(1009, 'Lamina de Cera rosada', '300'),
(1101, 'Historia clinica + Rx periapical', '20000'),
(1102, 'Endodoncia molares', '65000'),
(1103, 'Endodoncia premolares', '45000'),
(1104, 'Endodoncia incisivos', '40000'),
(1105, 'Urgencia', '25000'),
(1106, 'Cirugia apical', '60000'),
(1107, 'Ferulizacion en trauma dentoalveolar', '35000'),
(1108, 'Apicoformacion por cita', '25000'),
(1109, 'Blanqueamiento interno por cita', '20000'),
(1110, 'Capsula de Amalgama', '1000'),
(1111, 'Porcion de Conos gutapercha', '1400'),
(1112, 'Cemento de grosman', '600'),
(1113, 'Rx periapical', '1000'),
(1201, 'Tratamiento Ortodoncia', '995000'),
(1202, 'Tratamiento Ortodoncia (sin incluir aparatologia)', '440000'),
(1203, 'Tratamiento Ortodoncia (Brackets autoligado)', '1500000'),
(1204, 'Tratamiento Fisurado ', '50000'),
(1301, 'Historia Clinica C/Rx', '35000'),
(1302, 'Historia Clinica S/Rx', '15000'),
(2001, 'NEUROLOGIA TRIGEMINAL POR SESION', '40000'),
(2002, 'TRASTORNOS DE ATM POR SESION', '40000'),
(2003, 'PARALISIS FACIAL POR SESION', '40000'),
(2004, 'DOLORES DE CUELLO, CABEZA, ESPALDA POR SESION', '40000'),
(2005, 'HERPES ZOSTER O STOMATITIS AFTOSA POR AFTAS MAYORES POR SESION', '40000'),
(2101, 'TRATAMIENTO COMPLETO HIPERSENSIBILIDAD DENTINARIA (HASTA 3 ORGANOS DENTARIOS) POR 3 SESIONES', '40000'),
(2102, 'TRATAMIENTO COMPLETO DE HERPES SIMPLE POR 4 SESIONES', '60000'),
(2103, 'TRATAMIENTO COMPLETO POR AFTAS POR 4 SESIONES', '60000');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `controltratamiento`
--
ALTER TABLE `controltratamiento`
  ADD CONSTRAINT `fk_controltratamiento_historiaClinica1` FOREIGN KEY (`historiaClinica_idhistoriaClinica`) REFERENCES `historiaclinica` (`idhistoriaClinica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `controltratamiento_has_tratamiento`
--
ALTER TABLE `controltratamiento_has_tratamiento`
  ADD CONSTRAINT `fk_controltratamiento_has_tratamiento_controltratamiento1` FOREIGN KEY (`controltratamiento_idcontroltratamiento`) REFERENCES `controltratamiento` (`idcontroltratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_controltratamiento_has_tratamiento_tratamiento1` FOREIGN KEY (`tratamiento_idtratamiento`) REFERENCES `tratamiento` (`idtratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historiaclinica`
--
ALTER TABLE `historiaclinica`
  ADD CONSTRAINT `fk_historiaClinica_Consulta1` FOREIGN KEY (`consulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historiaclinica_has_diagnostico`
--
ALTER TABLE `historiaclinica_has_diagnostico`
  ADD CONSTRAINT `fk_historiaClinica_has_diagnostico_diagnostico1` FOREIGN KEY (`diagnostico_iddiagnostico`) REFERENCES `diagnostico` (`iddiagnostico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_historiaClinica_has_diagnostico_historiaClinica1` FOREIGN KEY (`historiaClinica_idhistoriaClinica`) REFERENCES `historiaclinica` (`idhistoriaClinica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `historiaclinica_has_tratamiento`
--
ALTER TABLE `historiaclinica_has_tratamiento`
  ADD CONSTRAINT `fk_historiaClinica_has_tratamiento_historiaClinica1` FOREIGN KEY (`historiaClinica_idhistoriaClinica`) REFERENCES `historiaclinica` (`idhistoriaClinica`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_historiaClinica_has_tratamiento_tratamiento1` FOREIGN KEY (`tratamiento_idtratamiento`) REFERENCES `tratamiento` (`idtratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `preparacionbiomedica`
--
ALTER TABLE `preparacionbiomedica`
  ADD CONSTRAINT `fk_preparacionBiomedica_historiaClinica1` FOREIGN KEY (`historiaClinica_idhistoriaClinica`) REFERENCES `historiaclinica` (`idhistoriaClinica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
