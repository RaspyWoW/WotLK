-- DB update 2021_10_17_04 -> 2021_10_17_05
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_17_04';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_17_04 2021_10_17_05 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634470512939185700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634470512939185700');

DELETE FROM `smart_scripts` WHERE `entryorguid`=2695 AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2695, 0, 1, 0, 20, 0, 100, 0, 637, 0, 0, 0, 0, 1, 0, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sara Balloo - On Quest Rewarded - Emote'), 
(2695, 0, 2, 0, 20, 0, 100, 0, 637, 0, 0, 0, 0, 1, 1, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Sara Balloo - On Quest Rewarded - Talk');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE `entry`=2695;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_17_05' WHERE sql_rev = '1634470512939185700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
