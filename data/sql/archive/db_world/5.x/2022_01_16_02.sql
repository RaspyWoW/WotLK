-- DB update 2022_01_16_01 -> 2022_01_16_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_16_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_16_01 2022_01_16_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1641841935074090300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641841935074090300');

-- Adding formations to Molten core Giants to prevent separate pulling
DELETE FROM `creature_formations` WHERE (`leaderGUID` IN (56712, 56701, 56719, 56711, 56708, 56707, 56703, 56748, 56717, 56714, 56705));
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES 
(56712, 56712, 0, 0, 3),
(56712, 56713, 0, 0, 3),
(56701, 56701, 0, 0, 3),
(56701, 56700, 0, 0, 3),
(56719, 56719, 0, 0, 3),
(56719, 56718, 0, 0, 3),
(56711, 56711, 0, 0, 3),
(56711, 56710, 0, 0, 3),
(56708, 56708, 0, 0, 3),
(56708, 56709, 0, 0, 3),
(56707, 56707, 0, 0, 3),
(56707, 56706, 0, 0, 3),
(56703, 56703, 0, 0, 3),
(56703, 56702, 0, 0, 3),
(56748, 56748, 0, 0, 3),
(56748, 56747, 0, 0, 3),
(56717, 56717, 0, 0, 3),
(56717, 56716, 0, 0, 3),
(56714, 56714, 0, 0, 3),
(56714, 56715, 0, 0, 3),
(56705, 56705, 0, 0, 3),
(56705, 56704, 0, 0, 3);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_16_02' WHERE sql_rev = '1641841935074090300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
