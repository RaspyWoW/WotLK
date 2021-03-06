-- DB update 2021_12_17_08 -> 2021_12_17_09
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_17_08';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_17_08 2021_12_17_09 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639429050892480400'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639429050892480400');

DELETE FROM `gameobject_template_addon` WHERE `entry`=195089;
INSERT INTO `gameobject_template_addon` VALUES
(195089,35,0,0,0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_17_09' WHERE sql_rev = '1639429050892480400';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
