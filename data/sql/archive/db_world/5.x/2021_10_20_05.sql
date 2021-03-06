-- DB update 2021_10_20_04 -> 2021_10_20_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_20_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_20_04 2021_10_20_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634371491771697874'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634371491771697874');

-- Makes a number of Craftsman's Writ quests repeatable
UPDATE `quest_template_addon` SET `SpecialFlags`=`SpecialFlags`|1 WHERE `ID` IN (9181, 9190, 9195, 9205, 9206);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_20_05' WHERE sql_rev = '1634371491771697874';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
