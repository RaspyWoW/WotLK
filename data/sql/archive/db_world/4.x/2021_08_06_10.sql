-- DB update 2021_08_06_09 -> 2021_08_06_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_08_06_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_08_06_09 2021_08_06_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1627818799536182900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1627818799536182900');

-- Added movement to Mok'rash (1493)
UPDATE `creature` SET  `MovementType` = 1, `wander_distance`= 5 WHERE (`id` = 1493) AND (`guid` IN (1672));


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_08_06_10' WHERE sql_rev = '1627818799536182900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
