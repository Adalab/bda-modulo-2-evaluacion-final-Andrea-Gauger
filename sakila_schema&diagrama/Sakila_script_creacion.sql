-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sakila
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sakila` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sakila` ;

-- -----------------------------------------------------
-- Table `sakila`.`actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`actor` (
  `actor_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actor_id`),
  INDEX `idx_actor_last_name` (`last_name` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 201
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`country` (
  `country_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `country` VARCHAR(50) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`country_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 110
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`city` (
  `city_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(50) NOT NULL,
  `country_id` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`city_id`),
  INDEX `idx_fk_country_id` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_country`
    FOREIGN KEY (`country_id`)
    REFERENCES `sakila`.`country` (`country_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 601
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`address` (
  `address_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(50) NOT NULL,
  `address2` VARCHAR(50) NULL DEFAULT NULL,
  `district` VARCHAR(20) NOT NULL,
  `city_id` SMALLINT UNSIGNED NOT NULL,
  `postal_code` VARCHAR(10) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `location` GEOMETRY NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`address_id`),
  INDEX `idx_fk_city_id` (`city_id` ASC) VISIBLE,
  SPATIAL INDEX `idx_location` (`location`) VISIBLE,
  CONSTRAINT `fk_address_city`
    FOREIGN KEY (`city_id`)
    REFERENCES `sakila`.`city` (`city_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 606
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`category` (
  `category_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 17
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`staff` (
  `staff_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  `picture` BLOB NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `store_id` TINYINT UNSIGNED NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(40) CHARACTER SET 'utf8' COLLATE 'utf8_bin' NULL DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`staff_id`),
  INDEX `idx_fk_store_id` (`store_id` ASC) VISIBLE,
  INDEX `idx_fk_address_id` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_staff_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `sakila`.`address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_staff_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `sakila`.`store` (`store_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`store` (
  `store_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `manager_staff_id` TINYINT UNSIGNED NOT NULL,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `idx_unique_manager` (`manager_staff_id` ASC) VISIBLE,
  INDEX `idx_fk_address_id` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_store_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `sakila`.`address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_store_staff`
    FOREIGN KEY (`manager_staff_id`)
    REFERENCES `sakila`.`staff` (`staff_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`customer` (
  `customer_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_id` TINYINT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `address_id` SMALLINT UNSIGNED NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `create_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  INDEX `idx_fk_store_id` (`store_id` ASC) VISIBLE,
  INDEX `idx_fk_address_id` (`address_id` ASC) VISIBLE,
  INDEX `idx_last_name` (`last_name` ASC) VISIBLE,
  CONSTRAINT `fk_customer_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `sakila`.`address` (`address_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_customer_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `sakila`.`store` (`store_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 600
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`language`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`language` (
  `language_id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` CHAR(20) NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`language_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`film` (
  `film_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `release_year` YEAR NULL DEFAULT NULL,
  `language_id` TINYINT UNSIGNED NOT NULL,
  `original_language_id` TINYINT UNSIGNED NULL DEFAULT NULL,
  `rental_duration` TINYINT UNSIGNED NOT NULL DEFAULT '3',
  `rental_rate` DECIMAL(4,2) NOT NULL DEFAULT '4.99',
  `length` SMALLINT UNSIGNED NULL DEFAULT NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL DEFAULT '19.99',
  `rating` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NULL DEFAULT 'G',
  `special_features` SET('Trailers', 'Commentaries', 'Deleted Scenes', 'Behind the Scenes') NULL DEFAULT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`film_id`),
  INDEX `idx_title` (`title` ASC) VISIBLE,
  INDEX `idx_fk_language_id` (`language_id` ASC) VISIBLE,
  INDEX `idx_fk_original_language_id` (`original_language_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_language`
    FOREIGN KEY (`language_id`)
    REFERENCES `sakila`.`language` (`language_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_film_language_original`
    FOREIGN KEY (`original_language_id`)
    REFERENCES `sakila`.`language` (`language_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 1001
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`film_actor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`film_actor` (
  `actor_id` SMALLINT UNSIGNED NOT NULL,
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`actor_id`, `film_id`),
  INDEX `idx_fk_film_id` (`film_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_actor_actor`
    FOREIGN KEY (`actor_id`)
    REFERENCES `sakila`.`actor` (`actor_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_film_actor_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `sakila`.`film` (`film_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`film_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`film_category` (
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `category_id` TINYINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`film_id`, `category_id`),
  INDEX `fk_film_category_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `fk_film_category_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `sakila`.`category` (`category_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_film_category_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `sakila`.`film` (`film_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`film_text`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`film_text` (
  `film_id` SMALLINT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  FULLTEXT INDEX `idx_title_description` (`title`, `description`) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`inventory` (
  `inventory_id` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `store_id` TINYINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`inventory_id`),
  INDEX `idx_fk_film_id` (`film_id` ASC) VISIBLE,
  INDEX `idx_store_id_film_id` (`store_id` ASC, `film_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_film`
    FOREIGN KEY (`film_id`)
    REFERENCES `sakila`.`film` (`film_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_store`
    FOREIGN KEY (`store_id`)
    REFERENCES `sakila`.`store` (`store_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4582
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`rental` (
  `rental_id` INT NOT NULL AUTO_INCREMENT,
  `rental_date` DATETIME NOT NULL,
  `inventory_id` MEDIUMINT UNSIGNED NOT NULL,
  `customer_id` SMALLINT UNSIGNED NOT NULL,
  `return_date` DATETIME NULL DEFAULT NULL,
  `staff_id` TINYINT UNSIGNED NOT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`),
  UNIQUE INDEX `rental_date` (`rental_date` ASC, `inventory_id` ASC, `customer_id` ASC) VISIBLE,
  INDEX `idx_fk_inventory_id` (`inventory_id` ASC) VISIBLE,
  INDEX `idx_fk_customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `idx_fk_staff_id` (`staff_id` ASC) VISIBLE,
  CONSTRAINT `fk_rental_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sakila`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rental_inventory`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `sakila`.`inventory` (`inventory_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rental_staff`
    FOREIGN KEY (`staff_id`)
    REFERENCES `sakila`.`staff` (`staff_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16050
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `sakila`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`payment` (
  `payment_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `customer_id` SMALLINT UNSIGNED NOT NULL,
  `staff_id` TINYINT UNSIGNED NOT NULL,
  `rental_id` INT NULL DEFAULT NULL,
  `amount` DECIMAL(5,2) NOT NULL,
  `payment_date` DATETIME NOT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  INDEX `idx_fk_staff_id` (`staff_id` ASC) VISIBLE,
  INDEX `idx_fk_customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `fk_payment_rental` (`rental_id` ASC) VISIBLE,
  CONSTRAINT `fk_payment_customer`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sakila`.`customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_rental`
    FOREIGN KEY (`rental_id`)
    REFERENCES `sakila`.`rental` (`rental_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_staff`
    FOREIGN KEY (`staff_id`)
    REFERENCES `sakila`.`staff` (`staff_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 16050
DEFAULT CHARACTER SET = utf8mb3;

USE `sakila` ;

-- -----------------------------------------------------
-- Placeholder table for view `sakila`.`actor_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`actor_info` (`actor_id` INT, `first_name` INT, `last_name` INT, `film_info` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sakila`.`customer_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`customer_list` (`ID` INT, `name` INT, `address` INT, `zip code` INT, `phone` INT, `city` INT, `country` INT, `notes` INT, `SID` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sakila`.`film_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`film_list` (`FID` INT, `title` INT, `description` INT, `category` INT, `price` INT, `length` INT, `rating` INT, `actors` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sakila`.`nicer_but_slower_film_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`nicer_but_slower_film_list` (`FID` INT, `title` INT, `description` INT, `category` INT, `price` INT, `length` INT, `rating` INT, `actors` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sakila`.`sales_by_store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`sales_by_store` (`store` INT, `manager` INT, `total_sales` INT);

-- -----------------------------------------------------
-- Placeholder table for view `sakila`.`staff_list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila`.`staff_list` (`ID` INT, `name` INT, `address` INT, `zip code` INT, `phone` INT, `city` INT, `country` INT, `SID` INT);

-- -----------------------------------------------------
-- View `sakila`.`actor_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila`.`actor_info`;
USE `sakila`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`actor_info` AS select 1 AS `actor_id`,1 AS `first_name`,1 AS `last_name`,1 AS `film_info`;

-- -----------------------------------------------------
-- View `sakila`.`customer_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila`.`customer_list`;
USE `sakila`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`customer_list` AS select 1 AS `ID`,1 AS `name`,1 AS `address`,1 AS `zip code`,1 AS `phone`,1 AS `city`,1 AS `country`,1 AS `notes`,1 AS `SID`;

-- -----------------------------------------------------
-- View `sakila`.`film_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila`.`film_list`;
USE `sakila`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`film_list` AS select 1 AS `FID`,1 AS `title`,1 AS `description`,1 AS `category`,1 AS `price`,1 AS `length`,1 AS `rating`,1 AS `actors`;

-- -----------------------------------------------------
-- View `sakila`.`nicer_but_slower_film_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila`.`nicer_but_slower_film_list`;
USE `sakila`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`nicer_but_slower_film_list` AS select 1 AS `FID`,1 AS `title`,1 AS `description`,1 AS `category`,1 AS `price`,1 AS `length`,1 AS `rating`,1 AS `actors`;

-- -----------------------------------------------------
-- View `sakila`.`sales_by_store`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila`.`sales_by_store`;
USE `sakila`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`sales_by_store` AS select 1 AS `store`,1 AS `manager`,1 AS `total_sales`;

-- -----------------------------------------------------
-- View `sakila`.`staff_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sakila`.`staff_list`;
USE `sakila`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sakila`.`staff_list` AS select 1 AS `ID`,1 AS `name`,1 AS `address`,1 AS `zip code`,1 AS `phone`,1 AS `city`,1 AS `country`,1 AS `SID`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
