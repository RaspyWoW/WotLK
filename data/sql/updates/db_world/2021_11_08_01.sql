-- DB update 2021_11_08_00 -> 2021_11_08_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_08_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_08_00 2021_11_08_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635972558195755100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635972558195755100');

DELETE FROM `creature_loot_template` WHERE `item`=3819 AND `entry` IN (1813,2044,2250,2251,2252,2253,2254,2256,2287,2655,2656,4504,5881,6557,7086,7104,7138,7149,9601,10981,10982,11458,11459,11461,11464,11465,11678,12051,13021,13196,13197,13285,13419,14303,14448);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_08_01' WHERE sql_rev = '1635972558195755100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;