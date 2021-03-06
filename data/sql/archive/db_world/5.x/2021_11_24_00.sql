-- DB update 2021_11_23_01 -> 2021_11_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_23_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_23_01 2021_11_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1625503957300357300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625503957300357300');

DROP TABLE IF EXISTS `skilltiers_dbc`; 
CREATE TABLE `skilltiers_dbc`
(
  `ID` INT NOT NULL DEFAULT 0,
  `Cost_1` INT NOT NULL DEFAULT 0,
  `Cost_2` INT NOT NULL DEFAULT 0,
  `Cost_3` INT NOT NULL DEFAULT 0,
  `Cost_4` INT NOT NULL DEFAULT 0,
  `Cost_5` INT NOT NULL DEFAULT 0,
  `Cost_6` INT NOT NULL DEFAULT 0,
  `Cost_7` INT NOT NULL DEFAULT 0,
  `Cost_8` INT NOT NULL DEFAULT 0,
  `Cost_9` INT NOT NULL DEFAULT 0,
  `Cost_10` INT NOT NULL DEFAULT 0,
  `Cost_11` INT NOT NULL DEFAULT 0,
  `Cost_12` INT NOT NULL DEFAULT 0,
  `Cost_13` INT NOT NULL DEFAULT 0,
  `Cost_14` INT NOT NULL DEFAULT 0,
  `Cost_15` INT NOT NULL DEFAULT 0,
  `Cost_16` INT NOT NULL DEFAULT 0,
  `Value_1` INT NOT NULL DEFAULT 0,
  `Value_2` INT NOT NULL DEFAULT 0,
  `Value_3` INT NOT NULL DEFAULT 0,
  `Value_4` INT NOT NULL DEFAULT 0,
  `Value_5` INT NOT NULL DEFAULT 0,
  `Value_6` INT NOT NULL DEFAULT 0,
  `Value_7` INT NOT NULL DEFAULT 0,
  `Value_8` INT NOT NULL DEFAULT 0,
  `Value_9` INT NOT NULL DEFAULT 0,
  `Value_10` INT NOT NULL DEFAULT 0,
  `Value_11` INT NOT NULL DEFAULT 0,
  `Value_12` INT NOT NULL DEFAULT 0,
  `Value_13` INT NOT NULL DEFAULT 0,
  `Value_14` INT NOT NULL DEFAULT 0,
  `Value_15` INT NOT NULL DEFAULT 0,
  `Value_16` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4; 

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_24_00' WHERE sql_rev = '1625503957300357300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
