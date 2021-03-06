-- DB update 2021_10_08_05 -> 2021_10_08_06
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_08_05';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_08_05 2021_10_08_06 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633190607873695800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633190607873695800');

UPDATE `spell_proc_event` SET `procEx`=0x0240003 WHERE `entry`=-11213;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_08_06' WHERE sql_rev = '1633190607873695800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
