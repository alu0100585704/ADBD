-- MySQL Script generated by MySQL Workbench
-- Thu Nov 12 19:18:40 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`ZONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ZONA` (
  `NOMBRE` VARCHAR(45) NOT NULL,
  `AREA` VARCHAR(45) NULL,
  `CONCEJAL` VARCHAR(45) NULL,
  PRIMARY KEY (`NOMBRE`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CALLE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CALLE` (
  `NOMBRE` VARCHAR(45) NOT NULL,
  `LONGITUD` DECIMAL(10,0) NULL,
  `CARRILES` VARCHAR(45) NULL,
  `ZONA` VARCHAR(45) NULL,
  INDEX `zona_idx` (`ZONA` ASC),
  PRIMARY KEY (`NOMBRE`),
  CONSTRAINT `fk_zona_ZONA_zona`
    FOREIGN KEY (`ZONA`)
    REFERENCES `mydb`.`ZONA` (`NOMBRE`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CONSTRUCCION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CONSTRUCCION` (
  `NUMERO` INT NOT NULL,
  `CALLE` VARCHAR(45) NOT NULL,
  `FECHA_CONSTRUCCION` DATE NULL,
  `CONSERVACION` VARCHAR(45) NULL,
  `tipo_bloque_0_unifamiliar_1_o_null` TINYINT(1) NULL,
  PRIMARY KEY (`NUMERO`, `CALLE`),
  INDEX `calle_idx` (`CALLE` ASC),
  CONSTRAINT `fk_CONSTRUCCION_CALLE`
    FOREIGN KEY (`CALLE`)
    REFERENCES `mydb`.`CALLE` (`NOMBRE`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UNIFAMILIAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`UNIFAMILIAR` (
  `NUMERO` INT NOT NULL,
  `CALLE` VARCHAR(45) NOT NULL,
  `NUMERO_HABITANTES` VARCHAR(45) NULL,
  `DNI_PROPIETARIO` DECIMAL(10,0) NULL,
  PRIMARY KEY (`NUMERO`, `CALLE`),
  INDEX `DIRECCION_idx` (`CALLE` ASC),
  INDEX `DNI_PROPIETARIO_idx` (`DNI_PROPIETARIO` ASC),
  CONSTRAINT `UNIFAMILIAR_NUMERO_CONSTRUCCION_NUMERO`
    FOREIGN KEY (`NUMERO`)
    REFERENCES `mydb`.`CONSTRUCCION` (`NUMERO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `UNIFAMILIAR_CALLE_CONSTRUCCION_CALLE`
    FOREIGN KEY (`CALLE`)
    REFERENCES `mydb`.`CONSTRUCCION` (`CALLE`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `UNIFAMILIAR_DNI_PROPIETARIO_PERSONA_DNI_PROPIETARIO`
    FOREIGN KEY (`DNI_PROPIETARIO`)
    REFERENCES `mydb`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`BLOQUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`BLOQUE` (
  `NUMERO` INT NOT NULL,
  `CALLE` VARCHAR(45) NOT NULL,
  `NUMERO_PISOS` INT NULL,
  PRIMARY KEY (`NUMERO`, `CALLE`),
  INDEX `DIRECCION_idx` (`CALLE` ASC),
  CONSTRAINT `fk_BLOQUE_NUMERO_CONSTRUCCION_NUMERO`
    FOREIGN KEY (`NUMERO`)
    REFERENCES `mydb`.`CONSTRUCCION` (`NUMERO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_BLOQUE_CALLE_CONSTRUCCION_CALLE`
    FOREIGN KEY (`CALLE`)
    REFERENCES `mydb`.`CONSTRUCCION` (`CALLE`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PISO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PISO` (
  `LETRA` VARCHAR(2) NOT NULL,
  `PLANTA` INT NOT NULL,
  `NUMERO` INT NOT NULL,
  `CALLE` VARCHAR(45) NOT NULL,
  `DNI_PROPIETARIO` DECIMAL(10,0) NULL,
  PRIMARY KEY (`LETRA`, `PLANTA`, `NUMERO`, `CALLE`),
  INDEX `NUMERO_idx` (`NUMERO` ASC),
  INDEX `DIRECCION_idx` (`CALLE` ASC),
  INDEX `fk_PISO_DNI_idx` (`DNI_PROPIETARIO` ASC),
  CONSTRAINT `fk_PISO_NUMERO_BLOQUE_NUMERO`
    FOREIGN KEY (`NUMERO`)
    REFERENCES `mydb`.`BLOQUE` (`NUMERO`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PISO_CALLE_BLOQUE_CALLE`
    FOREIGN KEY (`CALLE`)
    REFERENCES `mydb`.`BLOQUE` (`CALLE`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PISO_DNI`
    FOREIGN KEY (`DNI_PROPIETARIO`)
    REFERENCES `mydb`.`PERSONA` (`DNI`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PERSONA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`PERSONA` (
  `DNI` DECIMAL(10,0) NOT NULL,
  `FECHA_INICIO` DATE NOT NULL,
  `NOMBRE` VARCHAR(45) NULL,
  `ESTUDIOS` VARCHAR(45) NULL,
  `CABEZAFAMILIA` DECIMAL(10,0) NULL,
  `APELLIDO1` VARCHAR(45) NULL,
  `APELLIDO2` VARCHAR(45) NULL,
  `NUMERO_PISO` INT NULL,
  `CALLE_PISO` VARCHAR(45) NULL,
  `LETRA` VARCHAR(2) NULL,
  `PLANTA` INT NULL,
  `NUMERO_UNIFAMILIAR` INT NULL,
  `CALLE_UNIFAMILIAR` VARCHAR(45) NULL,
  `FECHA_FIN` DATE NULL,
  PRIMARY KEY (`DNI`, `FECHA_INICIO`),
  INDEX `fk_PERSONA_CABEZAFAMILIA_idx` (`CABEZAFAMILIA` ASC),
  INDEX `fk_PERSONA_UNIFAMILIAR_idx` (`NUMERO_UNIFAMILIAR` ASC, `CALLE_UNIFAMILIAR` ASC),
  INDEX `fk_PERSONA_PISO_idx` (`LETRA` ASC, `PLANTA` ASC, `NUMERO_PISO` ASC, `CALLE_PISO` ASC),
  CONSTRAINT `fk_PERSONA_CABEZAFAMILIA`
    FOREIGN KEY (`CABEZAFAMILIA`)
    REFERENCES `mydb`.`PERSONA` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERSONA_UNIFAMILIAR`
    FOREIGN KEY (`NUMERO_UNIFAMILIAR` , `CALLE_UNIFAMILIAR`)
    REFERENCES `mydb`.`UNIFAMILIAR` (`NUMERO` , `CALLE`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_PERSONA_PISO`
    FOREIGN KEY (`LETRA` , `PLANTA` , `NUMERO_PISO` , `CALLE_PISO`)
    REFERENCES `mydb`.`PISO` (`LETRA` , `PLANTA` , `NUMERO` , `CALLE`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`ZONA`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`ZONA` (`NOMBRE`, `AREA`, `CONCEJAL`) VALUES ('Geneto', 'La Laguna', 'Pepito');
INSERT INTO `mydb`.`ZONA` (`NOMBRE`, `AREA`, `CONCEJAL`) VALUES ('La Cuesta', 'La Laguna', 'María Pepita');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CALLE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CALLE` (`NOMBRE`, `LONGITUD`, `CARRILES`, `ZONA`) VALUES ('Los Trujillos', NULL, NULL, NULL);
INSERT INTO `mydb`.`CALLE` (`NOMBRE`, `LONGITUD`, `CARRILES`, `ZONA`) VALUES ('Franco de Medina', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`CONSTRUCCION`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`CONSTRUCCION` (`NUMERO`, `CALLE`, `FECHA_CONSTRUCCION`, `CONSERVACION`, `tipo_bloque_0_unifamiliar_1_o_null`) VALUES (9, 'Los Trujillos', NULL, NULL, NULL);
INSERT INTO `mydb`.`CONSTRUCCION` (`NUMERO`, `CALLE`, `FECHA_CONSTRUCCION`, `CONSERVACION`, `tipo_bloque_0_unifamiliar_1_o_null`) VALUES (60, 'Franco de Medina', NULL, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`BLOQUE`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`BLOQUE` (`NUMERO`, `CALLE`, `NUMERO_PISOS`) VALUES (9, 'Los trujillos', 2);
INSERT INTO `mydb`.`BLOQUE` (`NUMERO`, `CALLE`, `NUMERO_PISOS`) VALUES (60, 'Franco de Medina', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`PISO`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PISO` (`LETRA`, `PLANTA`, `NUMERO`, `CALLE`, `DNI_PROPIETARIO`) VALUES ('A', 3, 60, 'Franco de Medina', NULL);
INSERT INTO `mydb`.`PISO` (`LETRA`, `PLANTA`, `NUMERO`, `CALLE`, `DNI_PROPIETARIO`) VALUES ('A', 2, 9, 'Los Trujillos', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`PERSONA`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`PERSONA` (`DNI`, `FECHA_INICIO`, `NOMBRE`, `ESTUDIOS`, `CABEZAFAMILIA`, `APELLIDO1`, `APELLIDO2`, `NUMERO_PISO`, `CALLE_PISO`, `LETRA`, `PLANTA`, `NUMERO_UNIFAMILIAR`, `CALLE_UNIFAMILIAR`, `FECHA_FIN`) VALUES (78556096, '2010-10-25', 'Juan', 'Bachillerato', NULL, 'Siverio', 'Rojas', 9, 'Los Trujillos', 'A', 2, NULL, NULL, NULL);
INSERT INTO `mydb`.`PERSONA` (`DNI`, `FECHA_INICIO`, `NOMBRE`, `ESTUDIOS`, `CABEZAFAMILIA`, `APELLIDO1`, `APELLIDO2`, `NUMERO_PISO`, `CALLE_PISO`, `LETRA`, `PLANTA`, `NUMERO_UNIFAMILIAR`, `CALLE_UNIFAMILIAR`, `FECHA_FIN`) VALUES (12345678, '2014-10-12', 'Saray', 'Diplomada', NULL, 'Antón', 'Marrero', 9, 'Los Trujillos', 'A', 2, NULL, NULL, NULL);
INSERT INTO `mydb`.`PERSONA` (`DNI`, `FECHA_INICIO`, `NOMBRE`, `ESTUDIOS`, `CABEZAFAMILIA`, `APELLIDO1`, `APELLIDO2`, `NUMERO_PISO`, `CALLE_PISO`, `LETRA`, `PLANTA`, `NUMERO_UNIFAMILIAR`, `CALLE_UNIFAMILIAR`, `FECHA_FIN`) VALUES (51234588, '2020-1-1', 'Bernardo', 'EGB', 51234588, 'Siverio', 'Rojas', 60, 'Franco de Medina', 'A', 3, NULL, NULL, NULL);

COMMIT;

