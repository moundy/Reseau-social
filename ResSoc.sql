SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Compte`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Compte` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Compte` (
  `IDcompte` INT NOT NULL AUTO_INCREMENT ,
  `Login` VARCHAR(45) NOT NULL ,
  `password` VARCHAR(45) NOT NULL ,
  `Nom` VARCHAR(45) NULL ,
  `Prénom` VARCHAR(45) NULL ,
  `Date_naissance` DATE NULL ,
  `Avatar` VARCHAR(256) NULL ,
  `Mail` VARCHAR(80) NULL ,
  `Sexe` CHAR NULL ,
  PRIMARY KEY (`IDcompte`) ,
  UNIQUE INDEX `Login_UNIQUE` (`Login` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Groupe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Groupe` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Groupe` (
  `idGroupe` INT NOT NULL AUTO_INCREMENT ,
  `NomGroupe` VARCHAR(45) NULL ,
  `Thème` VARCHAR(45) NULL ,
  PRIMARY KEY (`idGroupe`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`EstMembre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`EstMembre` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`EstMembre` (
  `Compte` INT NOT NULL ,
  `date_adhésion` DATE NULL ,
  `estAdmin` TINYINT(1) NULL ,
  `Groupe` INT NOT NULL ,
  PRIMARY KEY (`Compte`, `Groupe`) ,
  INDEX `IDCompte_idx` (`Compte` ASC) ,
  INDEX `idGroupe_idx` (`Groupe` ASC) ,
  CONSTRAINT `cptmembre`
    FOREIGN KEY (`Compte` )
    REFERENCES `mydb`.`Compte` (`IDcompte` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idGroupe`
    FOREIGN KEY (`Groupe` )
    REFERENCES `mydb`.`Groupe` (`idGroupe` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Relation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Relation` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Relation` (
  `idRelation` INT NOT NULL AUTO_INCREMENT ,
  `compte1` INT NULL ,
  `compte2` INT NULL ,
  PRIMARY KEY (`idRelation`) ,
  INDEX `IDcompte_idx` (`compte1` ASC) ,
  INDEX `cpt2_idx` (`compte2` ASC) ,
  CONSTRAINT `cpt1`
    FOREIGN KEY (`compte1` )
    REFERENCES `mydb`.`Compte` (`IDcompte` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `cpt2`
    FOREIGN KEY (`compte2` )
    REFERENCES `mydb`.`Compte` (`IDcompte` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Post` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Post` (
  `idPost` INT NOT NULL AUTO_INCREMENT ,
  `Relation` INT NULL ,
  `Contenu` VARCHAR(512) NULL ,
  `DatePost` DATETIME NULL ,
  PRIMARY KEY (`idPost`) ,
  INDEX `idRelation_idx` (`Relation` ASC) ,
  CONSTRAINT `idRelation`
    FOREIGN KEY (`Relation` )
    REFERENCES `mydb`.`Relation` (`idRelation` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commentaire`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commentaire` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Commentaire` (
  `idCommentaire` INT NOT NULL AUTO_INCREMENT ,
  `Post` INT NULL ,
  `ContenuCom` VARCHAR(256) NULL ,
  `Posteur` INT NULL ,
  `DateCom` DATETIME NULL ,
  PRIMARY KEY (`idCommentaire`) ,
  INDEX `IDcompte_idx` (`Posteur` ASC) ,
  INDEX `idPost_idx` (`Post` ASC) ,
  CONSTRAINT `cptPosteur`
    FOREIGN KEY (`Posteur` )
    REFERENCES `mydb`.`Compte` (`IDcompte` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPost`
    FOREIGN KEY (`Post` )
    REFERENCES `mydb`.`Post` (`idPost` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Album` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Album` (
  `idAlbum` INT NOT NULL AUTO_INCREMENT ,
  `NomAlbum` VARCHAR(45) NULL ,
  `Compte` INT NULL ,
  `Albumcol` VARCHAR(45) NULL ,
  PRIMARY KEY (`idAlbum`) ,
  INDEX `IDcompte_idx` (`Compte` ASC) ,
  CONSTRAINT `cptAlb`
    FOREIGN KEY (`Compte` )
    REFERENCES `mydb`.`Compte` (`IDcompte` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Media` ;

CREATE  TABLE IF NOT EXISTS `mydb`.`Media` (
  `idMedia` INT NOT NULL AUTO_INCREMENT ,
  `NomMedia` VARCHAR(45) NULL ,
  `Type` TINYINT(1) NULL ,
  `Album` INT NULL ,
  `dateMedia` DATETIME NULL ,
  PRIMARY KEY (`idMedia`) ,
  INDEX `idAlbum_idx` (`Album` ASC) ,
  CONSTRAINT `idAlbum`
    FOREIGN KEY (`Album` )
    REFERENCES `mydb`.`Album` (`idAlbum` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
