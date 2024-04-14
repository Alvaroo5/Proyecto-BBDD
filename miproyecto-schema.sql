-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `arbitro`
--

DROP TABLE IF EXISTS `arbitro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `arbitro` (
  `id_arbitro` int(11) NOT NULL,
  `nombre` varchar(25) DEFAULT NULL,
  `apellidos` varchar(30) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `nacionalidad` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id_arbitro`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `nombre_equipo` varchar(25) NOT NULL,
  `entrenador` varchar(45) DEFAULT NULL,
  `año_fundacion` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`nombre_equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadio`
--

DROP TABLE IF EXISTS `estadio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadio` (
  `nombre_estadio` varchar(20) NOT NULL,
  `ciudad` varchar(20) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`nombre_estadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger before_estadio_insert

before insert on estadio

for each row

begin

    insert into insertados (nombre_estadio, ciudad, telefono) values (new.nombre_estadio, new.ciudad, new.telefono);

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `fichajes`
--

DROP TABLE IF EXISTS `fichajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fichajes` (
  `EQUIPO_nombre_equipo` varchar(25) NOT NULL,
  `JUGADOR_dni` varchar(10) NOT NULL,
  `fecha_inicio` varchar(15) DEFAULT NULL,
  `fecha_fin` varchar(15) NOT NULL,
  `tarifa_transferencia` int(10) unsigned DEFAULT NULL,
  `contrato` varchar(20) DEFAULT NULL,
  `clausula` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`EQUIPO_nombre_equipo`,`JUGADOR_dni`),
  KEY `fk_EQUIPO_has_JUGADOR_JUGADOR1` (`JUGADOR_dni`),
  CONSTRAINT `fk_EQUIPO_has_JUGADOR_EQUIPO1` FOREIGN KEY (`EQUIPO_nombre_equipo`) REFERENCES `equipo` (`nombre_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EQUIPO_has_JUGADOR_JUGADOR1` FOREIGN KEY (`JUGADOR_dni`) REFERENCES `jugador` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gol`
--

DROP TABLE IF EXISTS `gol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gol` (
  `minuto` varchar(10) NOT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  `jugador_marca` varchar(10) NOT NULL,
  `jugador_asiste` varchar(10) NOT NULL,
  `PARTIDO_id_partido` int(11) NOT NULL,
  KEY `fk_GOL_JUGADOR1` (`jugador_marca`),
  KEY `fk_GOL_JUGADOR2` (`jugador_asiste`),
  KEY `fk_GOL_PARTIDO1` (`PARTIDO_id_partido`),
  CONSTRAINT `fk_GOL_JUGADOR1` FOREIGN KEY (`jugador_marca`) REFERENCES `jugador` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GOL_JUGADOR2` FOREIGN KEY (`jugador_asiste`) REFERENCES `jugador` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GOL_PARTIDO1` FOREIGN KEY (`PARTIDO_id_partido`) REFERENCES `partido` (`id_partido`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `insertados`
--

DROP TABLE IF EXISTS `insertados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `insertados` (
  `nombre_estadio` varchar(20) NOT NULL,
  `ciudad` varchar(20) DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`nombre_estadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `juegan`
--

DROP TABLE IF EXISTS `juegan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `juegan` (
  `EQUIPO_nombre_equipo` varchar(25) NOT NULL,
  `ESTADIO_nombre_estadio` varchar(20) NOT NULL,
  PRIMARY KEY (`EQUIPO_nombre_equipo`,`ESTADIO_nombre_estadio`),
  KEY `fk_EQUIPO_has_ESTADIO_ESTADIO1` (`ESTADIO_nombre_estadio`),
  CONSTRAINT `fk_EQUIPO_has_ESTADIO_EQUIPO1` FOREIGN KEY (`EQUIPO_nombre_equipo`) REFERENCES `equipo` (`nombre_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_EQUIPO_has_ESTADIO_ESTADIO1` FOREIGN KEY (`ESTADIO_nombre_estadio`) REFERENCES `estadio` (`nombre_estadio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jugador`
--

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `dni` varchar(10) NOT NULL,
  `nombre` varchar(15) DEFAULT NULL,
  `apellidos` varchar(20) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger registro_insert

after insert on jugador

for each row

begin

    insert into registro (forma)

    values ('insertado correctamente');

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `partido`
--

DROP TABLE IF EXISTS `partido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partido` (
  `id_partido` int(11) NOT NULL,
  `num_jornada` varchar(15) DEFAULT NULL,
  `fecha_y_hora` date DEFAULT NULL,
  `resultado` varchar(20) DEFAULT NULL,
  `TEMPORADA_nombre_temporada` varchar(15) NOT NULL,
  `ARBITRO_id_arbitro` int(11) NOT NULL,
  `EQUIPO_nombre_local` varchar(25) NOT NULL,
  `EQUIPO_nombre_visitante` varchar(25) NOT NULL,
  PRIMARY KEY (`id_partido`),
  KEY `fk_PARTIDO_TEMPORADA` (`TEMPORADA_nombre_temporada`),
  KEY `fk_PARTIDO_ARBITRO1` (`ARBITRO_id_arbitro`),
  KEY `fk_PARTIDO_EQUIPO1` (`EQUIPO_nombre_local`),
  KEY `fk_PARTIDO_EQUIPO2` (`EQUIPO_nombre_visitante`),
  CONSTRAINT `fk_PARTIDO_ARBITRO1` FOREIGN KEY (`ARBITRO_id_arbitro`) REFERENCES `arbitro` (`id_arbitro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PARTIDO_EQUIPO1` FOREIGN KEY (`EQUIPO_nombre_local`) REFERENCES `equipo` (`nombre_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PARTIDO_EQUIPO2` FOREIGN KEY (`EQUIPO_nombre_visitante`) REFERENCES `equipo` (`nombre_equipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PARTIDO_TEMPORADA` FOREIGN KEY (`TEMPORADA_nombre_temporada`) REFERENCES `temporada` (`nombre_temporada`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `registro`
--

DROP TABLE IF EXISTS `registro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registro` (
  `forma` varchar(25) NOT NULL,
  PRIMARY KEY (`forma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `temporada`
--

DROP TABLE IF EXISTS `temporada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temporada` (
  `nombre_temporada` varchar(15) NOT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  PRIMARY KEY (`nombre_temporada`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'mydb'
--
/*!50003 DROP FUNCTION IF EXISTS `edadMediaEquipo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `edadMediaEquipo`(nombre_equipo varchar(25)) RETURNS decimal(10,2)
begin

    declare edad_total decimal(10, 2);

    declare cantidad_jugadores int;

    

    select sum(year(curdate()) - year(fecha_nacimiento)) into edad_total

    from jugador

    where dni in (select jugador_dni from fichajes where equipo_nombre_equipo = nombre_equipo);

    

    select count(*) into cantidad_jugadores

    from fichajes

    where equipo_nombre_equipo = nombre_equipo;

    

    return edad_total / cantidad_jugadores;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `numeroPartidosArbitrados` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `numeroPartidosArbitrados`(arbitro_id int) RETURNS int(11)
begin

    declare num_partidos int;

    

    select count(*) into num_partidos

    from arbitro

    where id_arbitro = arbitro_id;

    

    if num_partidos > 0 then

        select count(*)

        into num_partidos

        from partido

        where arbitro_id_arbitro = arbitro_id;

        return num_partidos;

    else

        return null; 

    end if;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `calcularEdadMediaEquipoEnEstadio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcularEdadMediaEquipoEnEstadio`(in nombre_estadio varchar(20))
begin

    declare nombre_equipo_en_estadio varchar(25);

    declare edad_media decimal(10, 2);

    

    select equipo_nombre_equipo into nombre_equipo_en_estadio

    from juegan

    where estadio_nombre_estadio = nombre_estadio;

    

    set edad_media = edadmediaequipo(nombre_equipo_en_estadio);



    select concat('La edad media de los jugadores del equipo que juega en el estadio ', nombre_estadio,' es: ', edad_media, ' años') as resultado;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `consultarEquipos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarEquipos`()
begin

    select 

        equipo.nombre_equipo,

        equipo.entrenador,

        count(jugador.dni) as cantidad_jugadores

    from 

        equipo

    left join 

        fichajes on equipo.nombre_equipo = fichajes.equipo_nombre_equipo

    left join 

        jugador on fichajes.jugador_dni = jugador.dni

    group by 

        equipo.nombre_equipo, equipo.entrenador;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `mostrarEstadios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrarEstadios`()
begin

    declare done int default false;

    declare estadio_nombre varchar(55);



    declare estadios_cursor cursor for 

        select nombre_estadio from estadio limit 5;



    declare continue handler for not found set done = true;



    open estadios_cursor;



    mostrar_loop: loop

        fetch estadios_cursor into estadio_nombre;



        if done then

            leave mostrar_loop;

        end if;



        select concat('Estadio: ', estadio_nombre) as mensaje;

    end loop;



    close estadios_cursor;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-14 13:26:08
