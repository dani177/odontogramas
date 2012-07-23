-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 23-07-2012 a las 22:28:44
-- Versión del servidor: 5.5.16
-- Versión de PHP: 5.3.8

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE IF NOT EXISTS `curso` (
  `idcurso` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `anio` varchar(45) DEFAULT NULL,
  `periodo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcurso`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosbasicos`
--

CREATE TABLE IF NOT EXISTS `datosbasicos` (
  `iddatosBasicos` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iddatosBasicos`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datosconsulta_has_datosbasicos`
--

CREATE TABLE IF NOT EXISTS `datosconsulta_has_datosbasicos` (
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `datosBasicos_iddatosBasicos` int(11) NOT NULL,
  `valor` varchar(45) DEFAULT NULL,
  KEY `fk_datosConsulta_has_datosBasicos_datosBasicos1` (`datosBasicos_iddatosBasicos`),
  KEY `fk_datosConsulta_has_datosBasicos_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
  `datosConsulta_iddatosConsulta` int(11) NOT NULL,
  `diente_iddiente` int(11) NOT NULL,
  `cara` varchar(45) DEFAULT NULL,
  `enfermedad` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`datosConsulta_iddatosConsulta`,`diente_iddiente`),
  KEY `fk_datosConsulta_has_diente_diente1` (`diente_iddiente`),
  KEY `fk_datosConsulta_has_diente_datosConsulta1` (`datosConsulta_iddatosConsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diagnostico`
--

CREATE TABLE IF NOT EXISTS `diagnostico` (
  `iddiagnostico` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) DEFAULT NULL,
  `diagnostico` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`iddiagnostico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `diente`
--

CREATE TABLE IF NOT EXISTS `diente` (
  `iddiente` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddiente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `docente`
--

CREATE TABLE IF NOT EXISTS `docente` (
  `iddocente` int(11) NOT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `clave` varchar(45) DEFAULT NULL,
  `codigo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddocente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `interconsulta`
--

CREATE TABLE IF NOT EXISTS `interconsulta` (
  `idinterconsulta` int(11) NOT NULL,
  `interconsulta` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idinterconsulta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `plantratamiento`
--

CREATE TABLE IF NOT EXISTS `plantratamiento` (
  `idplanTratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idplanTratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profesiones`
--

CREATE TABLE IF NOT EXISTS `profesiones` (
  `profesion` varchar(255) DEFAULT NULL,
  `codigo` int(11) NOT NULL,
  PRIMARY KEY (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tratamiento`
--

CREATE TABLE IF NOT EXISTS `tratamiento` (
  `idtratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `tratamiento` varchar(255) DEFAULT NULL,
  `presupuesto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idtratamiento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `consulta`
--
ALTER TABLE `consulta`
  ADD CONSTRAINT `fk_datosConsulta_paciente1` FOREIGN KEY (`paciente_idpersona`) REFERENCES `paciente` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_datosConsulta_medico1` FOREIGN KEY (`medico_idmedico`) REFERENCES `medico` (`idmedico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Consulta_docente1` FOREIGN KEY (`docente_iddocente`) REFERENCES `docente` (`iddocente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `datosconsulta_has_datosbasicos`
--
ALTER TABLE `datosconsulta_has_datosbasicos`
  ADD CONSTRAINT `fk_datosConsulta_has_datosBasicos_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_datosConsulta_has_datosBasicos_datosBasicos1` FOREIGN KEY (`datosBasicos_iddatosBasicos`) REFERENCES `datosbasicos` (`iddatosBasicos`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `datosconsulta_has_diagnostico`
--
ALTER TABLE `datosconsulta_has_diagnostico`
  ADD CONSTRAINT `fk_datosConsulta_has_diagnostico_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_datosConsulta_has_diagnostico_diagnostico1` FOREIGN KEY (`diagnostico_iddiagnostico`) REFERENCES `diagnostico` (`iddiagnostico`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `datosconsulta_has_diente`
--
ALTER TABLE `datosconsulta_has_diente`
  ADD CONSTRAINT `fk_datosConsulta_has_diente_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_datosConsulta_has_diente_diente1` FOREIGN KEY (`diente_iddiente`) REFERENCES `diente` (`iddiente`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `datosconsulta_has_plantratamiento`
--
ALTER TABLE `datosconsulta_has_plantratamiento`
  ADD CONSTRAINT `fk_datosConsulta_has_planTratamiento_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_datosConsulta_has_planTratamiento_planTratamiento1` FOREIGN KEY (`planTratamiento_idplanTratamiento`) REFERENCES `plantratamiento` (`idplanTratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `datosconsulta_has_tratamiento`
--
ALTER TABLE `datosconsulta_has_tratamiento`
  ADD CONSTRAINT `fk_datosConsulta_has_tratamiento_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_datosConsulta_has_tratamiento_tratamiento1` FOREIGN KEY (`tratamiento_idtratamiento`) REFERENCES `tratamiento` (`idtratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `docente_has_curso`
--
ALTER TABLE `docente_has_curso`
  ADD CONSTRAINT `fk_docente_has_curso_docente1` FOREIGN KEY (`docente_iddocente`) REFERENCES `docente` (`iddocente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_docente_has_curso_curso1` FOREIGN KEY (`curso_idcurso`) REFERENCES `curso` (`idcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `docente_has_medico`
--
ALTER TABLE `docente_has_medico`
  ADD CONSTRAINT `fk_docente_has_medico_docente1` FOREIGN KEY (`docente_iddocente`) REFERENCES `docente` (`iddocente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_docente_has_medico_medico1` FOREIGN KEY (`medico_idmedico`) REFERENCES `medico` (`idmedico`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `evolucion`
--
ALTER TABLE `evolucion`
  ADD CONSTRAINT `fk_evolucion_tratamiento1` FOREIGN KEY (`tratamiento_idtratamiento`) REFERENCES `tratamiento` (`idtratamiento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `examenfisicoestomatologico`
--
ALTER TABLE `examenfisicoestomatologico`
  ADD CONSTRAINT `fk_examenFisicoEstomatologico_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `interconsulta_has_datosconsulta`
--
ALTER TABLE `interconsulta_has_datosconsulta`
  ADD CONSTRAINT `fk_interconsulta_has_datosConsulta_interconsulta1` FOREIGN KEY (`interconsulta_idinterconsulta`) REFERENCES `interconsulta` (`idinterconsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_interconsulta_has_datosConsulta_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `medico_has_curso`
--
ALTER TABLE `medico_has_curso`
  ADD CONSTRAINT `fk_medico_has_curso_medico1` FOREIGN KEY (`medico_idmedico`) REFERENCES `medico` (`idmedico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_medico_has_curso_curso1` FOREIGN KEY (`curso_idcurso`) REFERENCES `curso` (`idcurso`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `medico_has_paciente`
--
ALTER TABLE `medico_has_paciente`
  ADD CONSTRAINT `fk_medico_has_paciente_medico1` FOREIGN KEY (`medico_idmedico`) REFERENCES `medico` (`idmedico`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_medico_has_paciente_paciente1` FOREIGN KEY (`paciente_idpersona`) REFERENCES `paciente` (`idpersona`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `municipios`
--
ALTER TABLE `municipios`
  ADD CONSTRAINT `fk_municipios_departamentos1` FOREIGN KEY (`departamentos_codigo1`) REFERENCES `departamentos` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `paciente`
--
ALTER TABLE `paciente`
  ADD CONSTRAINT `fk_paciente_municipios1` FOREIGN KEY (`municipios_codigo`) REFERENCES `municipios` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_paciente_profesiones1` FOREIGN KEY (`profesiones_codigo`) REFERENCES `profesiones` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `radiografia`
--
ALTER TABLE `radiografia`
  ADD CONSTRAINT `fk_radiografia_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `remision_has_datosconsulta`
--
ALTER TABLE `remision_has_datosconsulta`
  ADD CONSTRAINT `fk_remision_has_datosConsulta_remision1` FOREIGN KEY (`remision_idremision`) REFERENCES `remision` (`idremision`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_remision_has_datosConsulta_datosConsulta1` FOREIGN KEY (`datosConsulta_iddatosConsulta`) REFERENCES `consulta` (`iddatosConsulta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
