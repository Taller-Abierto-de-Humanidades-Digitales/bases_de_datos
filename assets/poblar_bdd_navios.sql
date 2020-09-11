-- Inicio del proceso
BEGIN;

SET @capitanom = "Manuel Antonio de la Villa" ;
SET @navionom = "El Colón" ;
SET @puertosalida = "Cádiz" ;
SET @puertoarribo = "La Habana" ;

-- Insertar información en tabla capitanes

INSERT INTO `capitanes` (`idcapitanes`, `nombre_capitan`)
VALUES(NULL, @capitanom) ;

-- Insertar información fuente

INSERT INTO `fuente` (`idfuente`, `nombre_archivo`, `nombre_serie`, `signatura`, `tipo_doc`, `titulo_doc`, `fecha_doc`, `folio_pagina`)
VALUES(NULL, "Archivo General de Indias", "Correos", "CORREOS,275A,R.10", "Diario de navegación", "Diario de navegación del paquebot \"El Colón\"", "1770-09-28", NULL) ;

-- Insertar información navío

INSERT INTO `navio` (`idnavio`, `nombre_navio`, `tipo_navio`)
VALUES(NULL, @navionom, "paquebot") ;

-- Insertar puertos

INSERT INTO `puertos_georreferencia` (`idpuertos_georreferencia`, `nombre_puerto`, `punto_puerto`)
VALUES(NULL, @puertoarribo, ST_PointFromText('POINT(23.137085 -82.347309', 4326)),(NULL, @puertosalida, ST_PointFromText('POINT(36.542729 -6.282635', 4326)) ;

-- Eliminar duplicados para conservar ID única en relaciones
-- Eliminar duplicados de capitanes

DELETE t1 FROM `capitanes` t1
INNER JOIN `capitanes` t2 
WHERE 
    t1.`idcapitanes` > t2.`idcapitanes` AND 
    t1.`nombre_capitan` = t2.`nombre_capitan` ;

-- Eliminar duplicados de navíos

DELETE t3 FROM `navio` t3
INNER JOIN `navio` t4 
WHERE 
    t3.`idnavio` > t4.`idnavio` AND 
    t3.`nombre_navio` = t4.`nombre_navio` ;

-- Eliminar duplicados de puertos

DELETE t5 FROM `puertos_georreferencia` t5
INNER JOIN `puertos_georreferencia` t6
WHERE
    t5.`idpuertos_georreferencia` > t6.`idpuertos_georreferencia` AND
    t5.`nombre_puerto` = t6.`nombre_puerto` ;

-- Eliminar duplicados de fuente

DELETE t7 FROM `fuente` t7
INNER JOIN `fuente` t8
WHERE
    t7.`idfuente` > t8.`idfuente` AND
    t7.`signatura` = t8.`signatura` ;

-- Recuperar información para las tablas relacionales "capitanes_de_navio" y "viajes"

SET @getidcapitan = (SELECT `idcapitanes` FROM `capitanes` WHERE `nombre_capitan` LIKE @capitanom) ;
SET @getidnavio = (SELECT `idnavio` FROM `navio` WHERE `nombre_navio` LIKE @navionom) ;

-- Insertar información en Capitanes de navío

INSERT INTO `capitanes_de_navio` (`idcapitanes_de_navio`, `capitanes_idcapitanes`, `navio_idnavio`)
VALUES(NULL, @getidcapitan, @getidnavio) ;

-- Tabla viajes
-- Crear las variables para las relaciones en viajes

SET @getidviajesalida = (SELECT `idpuertos_georreferencia` FROM `puertos_georreferencia` WHERE `nombre_puerto` LIKE @puertosalida) ;
SET @getidviajearribo = (SELECT `idpuertos_georreferencia` FROM `puertos_georreferencia` WHERE `nombre_puerto` LIKE @puertoarribo) ;
SET @getidfuente = (SELECT `idfuente` FROM `fuente` WHERE `signatura` LIKE "CORREOS,275A,R.10") ;

-- Insertar información en tabla viajes

INSERT INTO `viajes`(`idviajes`, `id_puerto_salida`, `fecha_salida`, `id_puerto_arribo`, `fecha_arribo`, `direccion_viaje`, `navioid`, `capitanesid`, `fuenteid`)
VALUES(NULL, @getidviajesalida, "1770-09-28", @getidviajearribo, "1770-11-28", "viaje", @getidnavio, @getidcapitan, @getidfuente) ;

COMMIT;
-- Después de revisar las instrucciones, simular una consulta y no encontrar errores, se ejecuta la consulta.