-- Este archivo fue generado automáticamente por phpMyAdmin

-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-09-2020 a las 18:39:20
-- Versión del servidor: 10.4.13-MariaDB
-- Versión de PHP: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_viajes`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capitanes`
--

CREATE TABLE `capitanes` (
  `idcapitanes` int(11) NOT NULL,
  `nombre_capitan` varchar(45) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `capitanes_de_navio`
--

CREATE TABLE `capitanes_de_navio` (
  `idcapitanes_de_navio` int(11) NOT NULL,
  `capitanes_idcapitanes` int(11) NOT NULL,
  `navio_idnavio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fuente`
--

CREATE TABLE `fuente` (
  `idfuente` int(11) NOT NULL,
  `nombre_archivo` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `nombre_serie` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `signatura` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `tipo_doc` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `titulo_doc` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `fecha_doc` date DEFAULT NULL,
  `folio_pagina` varchar(45) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `navio`
--

CREATE TABLE `navio` (
  `idnavio` int(11) NOT NULL,
  `nombre_navio` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `tipo_navio` varchar(45) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puertos_georreferencia`
--

CREATE TABLE `puertos_georreferencia` (
  `idpuertos_georreferencia` int(11) NOT NULL,
  `nombre_puerto` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `punto_puerto` geometry DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viajes`
--

CREATE TABLE `viajes` (
  `idviajes` int(11) NOT NULL,
  `id_puerto_salida` int(11) NOT NULL,
  `fecha_salida` date DEFAULT NULL,
  `id_puerto_arribo` int(11) NOT NULL,
  `fecha_arribo` date DEFAULT NULL,
  `direccion_viaje` varchar(45) CHARACTER SET utf8 DEFAULT NULL,
  `navioid` int(11) NOT NULL,
  `capitanesid` int(11) NOT NULL,
  `fuenteid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `capitanes`
--
ALTER TABLE `capitanes`
  ADD PRIMARY KEY (`idcapitanes`);

--
-- Indices de la tabla `capitanes_de_navio`
--
ALTER TABLE `capitanes_de_navio`
  ADD PRIMARY KEY (`idcapitanes_de_navio`) USING BTREE,
  ADD KEY `fk_capitanes_has_navio_navio1_idx` (`navio_idnavio`),
  ADD KEY `fk_capitanes_has_navio_capitanes1_idx` (`capitanes_idcapitanes`);

--
-- Indices de la tabla `fuente`
--
ALTER TABLE `fuente`
  ADD PRIMARY KEY (`idfuente`);

--
-- Indices de la tabla `navio`
--
ALTER TABLE `navio`
  ADD PRIMARY KEY (`idnavio`);

--
-- Indices de la tabla `puertos_georreferencia`
--
ALTER TABLE `puertos_georreferencia`
  ADD PRIMARY KEY (`idpuertos_georreferencia`);

--
-- Indices de la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD PRIMARY KEY (`idviajes`) USING BTREE,
  ADD KEY `idnavio_idx` (`navioid`),
  ADD KEY `idcapitanes_idx` (`capitanesid`),
  ADD KEY `idfuente_idx` (`fuenteid`),
  ADD KEY `idsalida_idx` (`id_puerto_salida`),
  ADD KEY `idllegada_idx` (`id_puerto_arribo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `capitanes`
--
ALTER TABLE `capitanes`
  MODIFY `idcapitanes` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `capitanes_de_navio`
--
ALTER TABLE `capitanes_de_navio`
  MODIFY `idcapitanes_de_navio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `fuente`
--
ALTER TABLE `fuente`
  MODIFY `idfuente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `navio`
--
ALTER TABLE `navio`
  MODIFY `idnavio` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `puertos_georreferencia`
--
ALTER TABLE `puertos_georreferencia`
  MODIFY `idpuertos_georreferencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `viajes`
--
ALTER TABLE `viajes`
  MODIFY `idviajes` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `capitanes_de_navio`
--
ALTER TABLE `capitanes_de_navio`
  ADD CONSTRAINT `fk_capitanes_has_navio_capitanes1` FOREIGN KEY (`capitanes_idcapitanes`) REFERENCES `capitanes` (`idcapitanes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_capitanes_has_navio_navio1` FOREIGN KEY (`navio_idnavio`) REFERENCES `navio` (`idnavio`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `viajes`
--
ALTER TABLE `viajes`
  ADD CONSTRAINT `idcapitanes` FOREIGN KEY (`capitanesid`) REFERENCES `capitanes` (`idcapitanes`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idfuente` FOREIGN KEY (`fuenteid`) REFERENCES `fuente` (`idfuente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idllegada` FOREIGN KEY (`id_puerto_arribo`) REFERENCES `puertos_georreferencia` (`idpuertos_georreferencia`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `idnavio` FOREIGN KEY (`navioid`) REFERENCES `navio` (`idnavio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `idsalida` FOREIGN KEY (`id_puerto_salida`) REFERENCES `puertos_georreferencia` (`idpuertos_georreferencia`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
