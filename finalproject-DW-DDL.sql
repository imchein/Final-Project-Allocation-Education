/***********************************************
**                MSc ANALYTICS 
**     DATA ENGINEERING PLATFORMS (MSCA 31012)
** File:   Final Project: Allocation of Education Funds DDL
** Date:   12/11/2020
** ALL RIGHTS RESERVED | DO NOT DISTRIBUTE
************************************************/

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema finalproj
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `finalproj` DEFAULT CHARACTER SET utf8mb4 ;
USE `finalproj` ;

-- -----------------------------------------------------
-- Table `finalproj`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`countries` (
  `countrycode` SMALLINT NOT NULL,
  `countryname` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`countrycode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finalproj`.`region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`region` (
  `regioncode` SMALLINT NOT NULL,
  `regionname` VARCHAR(50) NULL DEFAULT NULL,
  `countrycode` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`regioncode`),
  INDEX `countrycode_idx` (`countrycode` ASC),
  CONSTRAINT `countrycode`
    FOREIGN KEY (`countrycode`)
    REFERENCES `finalproj`.`countries` (`countrycode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finalproj`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`project` (
  `projectid` SMALLINT NOT NULL,
  `envassesmentcategorycode` VARCHAR(10) NULL DEFAULT NULL,
  `goal` VARCHAR(500) NULL DEFAULT NULL,
  `lendinginstr` VARCHAR(100) NULL DEFAULT NULL,
  `lendinginstrtype` VARCHAR(10) NULL DEFAULT NULL,
  `prodline` VARCHAR(10) NULL DEFAULT NULL,
  `project_name` VARCHAR(500) NULL DEFAULT NULL,
  `status` VARCHAR(20) NULL DEFAULT NULL,
  `supplementprojectflg` VARCHAR(10) NULL DEFAULT NULL,
  `regioncode` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`projectid`),
  INDEX `regioncode_idx` (`regioncode` ASC),
  CONSTRAINT `regioncode`
    FOREIGN KEY (`regioncode`)
    REFERENCES `finalproj`.`region` (`regioncode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finalproj`.`borrower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`borrower` (
  `borrowers_id` SMALLINT NOT NULL,
  `borrower` VARCHAR(100) NULL DEFAULT NULL,
  `financier` VARCHAR(250) NULL DEFAULT NULL,
  `goal` VARCHAR(1000) NULL DEFAULT NULL,
  `impagency` VARCHAR(250) NULL DEFAULT NULL,
  `url` VARCHAR(250) NULL DEFAULT NULL,
  `projectid` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`borrowers_id`), 
  CONSTRAINT `project_borrower_fk`
    FOREIGN KEY (`projectid`)
    REFERENCES `finalproj`.`project` (`projectid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `project_borrower_fk` ON `finalproj`.`borrower` (`projectid` ASC);

-- -----------------------------------------------------
-- Table `finalproj`.`condition_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`condition_information` (
  `indicatorcode` TINYINT NOT NULL,
  `indicator` VARCHAR(250) NULL DEFAULT NULL,
  `sex` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`indicatorcode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;

 
-- -----------------------------------------------------
-- Table `finalproj`.`dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`dates` (
  `dates_id` SMALLINT NOT NULL,
  `board_approval_month` VARCHAR(50) NULL DEFAULT NULL,
  `boardapprovalyear` YEAR NULL DEFAULT NULL,
  `closingdatemonth` TINYINT NULL DEFAULT NULL,
  `closingdateyear` YEAR NULL DEFAULT NULL,
  `projectid` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`dates_id`),
  CONSTRAINT `project_dates_fk`
    FOREIGN KEY (`projectid`)
    REFERENCES `finalproj`.`project` (`projectid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;
 
CREATE INDEX `project_dates_fk`  ON `finalproj`.`dates` (`projectid` ASC);

#######################
-- -----------------------------------------------------
-- Table `finalproj`.`money`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`money` (
  `money_id` SMALLINT NOT NULL,
  `grantamt` INT NULL DEFAULT NULL,
  `ibrdcommamt` INT NULL DEFAULT NULL,
  `idacommamt` INT NULL DEFAULT NULL,
  `lendprojectcost` INT NULL DEFAULT NULL,
  `totalamt` INT NULL DEFAULT NULL,
  `projectid` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`money_id`), 
  CONSTRAINT `project_money_fk`
    FOREIGN KEY (`projectid`)
    REFERENCES `finalproj`.`project` (`projectid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `project_money_fk`  ON `finalproj`.`money` (`projectid` ASC);

-- -----------------------------------------------------
-- Table `finalproj`.`observation_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`observation_information` (
  `observationcode` SMALLINT NOT NULL,
  `obs_value` FLOAT NULL DEFAULT NULL,
  `observationstatus` VARCHAR(50) NULL DEFAULT NULL,
  `data_source` VARCHAR(250) NULL DEFAULT NULL,
  PRIMARY KEY (`observationcode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `finalproj`.`time_period`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`time_period` (
  `timecode` TINYINT NOT NULL,
  `start_project` YEAR NULL DEFAULT NULL,
  `end_project` YEAR NULL DEFAULT NULL,
  PRIMARY KEY (`timecode`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;

 
-- -----------------------------------------------------
-- Table `finalproj`.`observables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`observables` (
  `observablecode` SMALLINT NOT NULL,
  `countrycode` SMALLINT NULL DEFAULT NULL,
  `indicatorcode` TINYINT NULL DEFAULT NULL,
  `observationcode` SMALLINT NULL DEFAULT NULL,
  `timecode` TINYINT NULL DEFAULT NULL, 
  CONSTRAINT `countries_observables_fk`
    FOREIGN KEY (`countrycode`)
    REFERENCES `finalproj`.`countries` (`countrycode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `condition_information_observables_fk`
    FOREIGN KEY (`indicatorcode`)
    REFERENCES `finalproj`.`condition_information` (`indicatorcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `observation_information_observables_fk`
    FOREIGN KEY (`observationcode`)
    REFERENCES `finalproj`.`observation_information` (`observationcode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `time_period_observables_fk`
    FOREIGN KEY (`timecode`)
    REFERENCES `finalproj`.`time_period` (`timecode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;


CREATE INDEX `countries_observables_fk`  ON `finalproj`.`observables` (`countrycode` ASC);
CREATE INDEX `condition_information_observables_fk`  ON `finalproj`.`observables` (`indicatorcode` ASC);
CREATE INDEX `observation_information_observables_fk`  ON `finalproj`.`observables` (`observationcode` ASC);
CREATE INDEX `time_period_observables_fk`  ON `finalproj`.`observables` (`timecode` ASC);

 
-- -----------------------------------------------------
-- Table `finalproj`.`sector`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `finalproj`.`sector` (
  `sector_id` SMALLINT NOT NULL,
  `new_sector1` VARCHAR(250) NULL DEFAULT NULL,
  `new_sector2` VARCHAR(250) NULL DEFAULT NULL,
  `new_sector3` VARCHAR(250) NULL DEFAULT NULL,
  `new_sector4` VARCHAR(250) NULL DEFAULT NULL,
  `new_sector5` VARCHAR(250) NULL DEFAULT NULL,
  `projectid` SMALLINT NULL DEFAULT NULL,
  PRIMARY KEY (`sector_id`), 
  CONSTRAINT `project_sector_fk`
    FOREIGN KEY (`projectid`)
    REFERENCES `finalproj`.`project` (`projectid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
#COLLATE = utf8mb4_0900_ai_ci;

CREATE INDEX `project_sector_fk`  ON `finalproj`.`sector` (`projectid` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;