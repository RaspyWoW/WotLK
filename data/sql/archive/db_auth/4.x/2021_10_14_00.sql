-- DB update 2021_06_17_00 -> 2021_10_14_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_auth' AND COLUMN_NAME = '2021_06_17_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_auth CHANGE COLUMN 2021_06_17_00 2021_10_14_00 bit;
SELECT sql_rev INTO OK FROM version_db_auth WHERE sql_rev = '1634163668021762900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1634163668021762900');

--
DELETE FROM `updates` WHERE `name` IN ('2016_08_25_01.sql', '2016_07_09_00.sql', '2019_04_13_00.sql', '2016_09_04_00.sql', '2017_08_19_00.sql', '2016_08_25_00.sql', '2016_07_09_01.sql', '2016_07_10_00.sql', '2016_11_18_00.sql', '2016_11_19_00.sql', '2017_08_20_01.sql', '2017_12_05_00.sql', '2018_01_21_00.sql', '2018_09_17_00.sql', '2019_01_05_00.sql', '2019_02_08_00.sql', '2019_02_17_00.sql', '2020_02_07_00.sql');
INSERT INTO `updates` (`name`, `hash`, `state`, `timestamp`, `speed`) VALUES
('2016_08_25_01.sql', 'A5A2BE04C8E8E85CD177B8684DFFEACF71C9CF69', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_07_09_00.sql', 'B692C4D5E96D26616E1E655D99DD27F6AC4FFDA6', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2019_04_13_00.sql', '183C28E079DAB46AD6F7C0617E19346CAD043141', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_09_04_00.sql', '420ACF7160BF5549BC298EB6A1319969789DA140', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2017_08_19_00.sql', 'E4457FFFFC0D3F86750F07CF88F549529E1B27E5', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_08_25_00.sql', '707016C338350676C814D7926DFB6081E57091C3', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_07_09_01.sql', 'DE551E4708FE31AAC60CEF69466BBC5DFAC46F79', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_07_10_00.sql', '0AE2F7FB1E9C1E2BC2870D0EB817F3C87E0A39B3', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_11_18_00.sql', '92D22B3A45466470239402367D94C3791A243EF7', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2016_11_19_00.sql', 'C55E73648F661F40237B03F266F7169D231B3D8D', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2017_08_20_01.sql', 'E6190311E1A12E259C6CD21ACFC8BAA1D3F597DF', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2017_12_05_00.sql', '475860B881DE6E9CAC93AD3B37E7AAA8D63FB1B9', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2018_01_21_00.sql', '570FC5FC653D81B0E498E3EAB6706C9868CE8079', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2018_09_17_00.sql', '31743E771FFA4C92D6B6CF747DE4302814BDF257', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2019_01_05_00.sql', '2449121ABB0D5004BF6941B340F5C294AD95EBE9', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2019_02_08_00.sql', '18FF48FC1B1C238D44198FA1E2D422BAB4C9C338', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2019_02_17_00.sql', '1F4C4A15313A261088E40909DCCAA068EAAAAAAE', 'ARCHIVED', '2021-10-14 04:13:44', 1),
('2020_02_07_00.sql', '9549BF7354B4FA5A661EC094A2C3AAF665678152', 'ARCHIVED', '2021-10-14 04:13:44', 1);

DELETE FROM `updates_include` WHERE `path`='$/data/sql/archive/db_auth';
INSERT INTO `updates_include` (`path`, `state`) VALUES ('$/data/sql/archive/db_auth', 'ARCHIVED');

--
-- END UPDATING QUERIES
--
UPDATE version_db_auth SET date = '2021_10_14_00' WHERE sql_rev = '1634163668021762900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
