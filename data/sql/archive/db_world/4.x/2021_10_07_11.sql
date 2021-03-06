-- DB update 2021_10_07_10 -> 2021_10_07_11
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_07_10';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_07_10 2021_10_07_11 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633176430290869200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633176430290869200');

DELETE FROM `gameobject` WHERE `guid`=12487;
DELETE FROM `gameobject` WHERE `guid`=2135425;
INSERT INTO `gameobject` VALUES (2135425, 1731, 1, 0, 0, 1, 1, -402.363, -4745.78, 38.7069, 0.0534247, -0, -0, -0.0267091, -0.999643, 300, 0, 1, '', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_07_11' WHERE sql_rev = '1633176430290869200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
