SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema `${ info.artifactId.camel.lowercase }`
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `${ info.artifactId.camel.lowercase }`;
CREATE SCHEMA IF NOT EXISTS `${ info.artifactId.camel.lowercase }` DEFAULT CHARACTER SET utf8 COLLATE utf8_turkish_ci;
USE `${ info.artifactId.camel.lowercase }`;

<#-- ********** Tables ********** -->
-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`users` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`users` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `birthdate` Date NULL,
  `title` VARCHAR(45) NULL,
  `mobile` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `username` VARCHAR(30) NULL,
  `password` VARCHAR(100) NULL,
  `password_expiration` TIMESTAMP NULL,
  `password_attempts` INT DEFAULT NULL,
  `account_expiration` TIMESTAMP NULL DEFAULT NULL,
  `last_login` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB;
-- UNIQUE KEY `idx_username` (`username`)

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`constants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`constants` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`constants` (
  `code` CHAR(4) NOT NULL,
  `name` VARCHAR(100) NULL,
  `category` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`code`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`emails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`emails` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`emails` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email_type` CHAR(4) NULL,
  `subject` VARCHAR(200) NULL,
  `content` TEXT NULL,
  `created` TIMESTAMP NULL,
  `sent` TIMESTAMP NULL,
  `retry` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_emails_1_idx` (`email_type` ASC) VISIBLE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`email_recipients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`email_recipients` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`email_recipients` (
  `fk_users` INT UNSIGNED NOT NULL,
  `fk_emails` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`fk_users`, `fk_emails`),
  INDEX `fk_emails_to_1_idx` (`fk_emails` ASC) VISIBLE,
  CONSTRAINT `fk_emails_to_1`
    FOREIGN KEY (`fk_users`)
    REFERENCES `${ info.artifactId.camel.lowercase }`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_emails_to_2`
    FOREIGN KEY (`fk_emails`)
    REFERENCES `${ info.artifactId.camel.lowercase }`.`emails` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`logs` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`logs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `log_type` CHAR(4) NOT NULL,
  `fk_users` INT UNSIGNED NULL,
  `when` TIMESTAMP NULL,
  `description` VARCHAR(250) NULL,
  INDEX `fk_logs_1_idx` (`fk_users` ASC) VISIBLE,
  INDEX `fk_logs_2_idx` (`log_type` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_logs_1`
    FOREIGN KEY (`fk_users`)
    REFERENCES `${ info.artifactId.camel.lowercase }`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`users_online`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`users_online` ;

CREATE TABLE `users_online` (
  `fk_users` int UNSIGNED NOT NULL,
  `last_ping` timestamp NOT NULL,
  PRIMARY KEY (`fk_users`),
  CONSTRAINT `fk_users_online_1`
    FOREIGN KEY (`fk_users`)
    REFERENCES `${ info.artifactId.camel.lowercase }`.`users` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`roles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`roles` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`roles` (
  `fk_users` INT UNSIGNED NOT NULL,
  `role` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`fk_users`, `role`),
  INDEX `fk_roles_1_idx` (`role` ASC) VISIBLE,
  CONSTRAINT `fk_roles_1`
    FOREIGN KEY (`fk_users`)
    REFERENCES `${ info.artifactId.camel.lowercase }`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`settings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`settings` ;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`settings` (
  `key` VARCHAR(30) NOT NULL,
  `setting` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE = InnoDB;

<#list entities as entity>
-- -----------------------------------------------------
-- Table `${ info.artifactId.camel.lowercase }`.`${ entity.name.plural.snake }`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `${ info.artifactId.camel.lowercase }`.`${ entity.name.plural.snake }`;

CREATE TABLE IF NOT EXISTS `${ info.artifactId.camel.lowercase }`.`${ entity.name.plural.snake }` (
    `id` INT UNSIGNED AUTO_INCREMENT NOT NULL,
<#list entity.fields as field>
    `${ field.name }` ${ field.mysql }<#if field.required> NOT NULL</#if>,
</#list>
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;
</#list>

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;