USE archery;

CREATE TABLE `Archers` ( 
  `archer_ID` INT AUTO_INCREMENT NOT NULL,
  `name` VARCHAR(250) NOT NULL,
  `age` INT NOT NULL,
  `gender` VARCHAR(250) NOT NULL,
  `category` VARCHAR(50) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`archer_ID`)
);

CREATE TABLE `Devisions` ( 
  `devision_ID` INT AUTO_INCREMENT NOT NULL,
  `style` VARCHAR(250) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`devision_ID`)
);

CREATE TABLE `ArcherDevision` ( 
  `archer_ID` INT NOT NULL,
  `devision_ID` INT NOT NULL,
  `archer_devision_ID` INT AUTO_INCREMENT NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`archer_devision_ID`),
  CONSTRAINT `archer_id_FK` FOREIGN KEY (`archer_ID`) REFERENCES `Archers` (`archer_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `devision_id_FK` FOREIGN KEY (`devision_ID`) REFERENCES `Devisions` (`devision_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Clubs` ( 
  `club_ID` INT AUTO_INCREMENT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `name` TEXT NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`club_ID`)
);

CREATE TABLE `Competitions` ( 
  `competition_ID` INT AUTO_INCREMENT NOT NULL,
  `name` TEXT NOT NULL,
  `club_ID` INT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`competition_ID`),
  CONSTRAINT `fk_club_id` FOREIGN KEY (`club_ID`) REFERENCES `Clubs` (`club_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `RangeDefinitions` ( 
  `range_definition_ID` INT AUTO_INCREMENT NOT NULL,
  `distance` INT NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`range_definition_ID`)
);

CREATE TABLE `RoundDefinitions` ( 
  `round_definition_ID` INT AUTO_INCREMENT NOT NULL,
  `schedule_name` TEXT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`round_definition_ID`)
);

CREATE TABLE `RoundDefinitionAssociation` ( 
  `round_definition_association_ID` INT AUTO_INCREMENT NOT NULL,
  `range_definition_ID` INT NOT NULL,
  `round_definition_ID` INT NOT NULL,
  `total_ends` INT NOT NULL,
  `face_size` VARCHAR(10) NOT NULL,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`round_definition_association_ID`),
  CONSTRAINT `round_definition_association_range_definition_id_FK` FOREIGN KEY (`range_definition_ID`) REFERENCES `RangeDefinitions` (`range_definition_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `round_definition_association_round_definition_id_FK` FOREIGN KEY (`round_definition_ID`) REFERENCES `RoundDefinitions` (`round_definition_ID`) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE `Ends` ( 
  `end_ID` INT AUTO_INCREMENT NOT NULL,
  `end_total_score` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`end_ID`)
);

CREATE TABLE `RangeInstance` ( 
  `range_instance_ID` INT AUTO_INCREMENT NOT NULL,
  `end_ID` INT NOT NULL,
  `round_definition_association_ID` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`range_instance_ID`),
  CONSTRAINT `range_instance_round_definition_association_id_FK` FOREIGN KEY (`round_definition_association_ID`) REFERENCES `RoundDefinitionAssociation` (`round_definition_association_ID`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `range_instance_end_id_FK` FOREIGN KEY (`end_ID`) REFERENCES `Ends` (`end_ID`) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `Scores` ( 
  `score_ID` INT AUTO_INCREMENT NOT NULL,
  `archer_ID` INT NOT NULL,
  `archer_devision_ID` INT NOT NULL,
  `competition_ID` INT NULL,
  `range_instance_ID` INT NOT NULL,
  `end_ID` INT NOT NULL,
  `score_value` INT NOT NULL,
  `is_competition` TINYINT NOT NULL DEFAULT 1 ,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`score_ID`),
  CONSTRAINT `scores_archer_id_FK` FOREIGN KEY (`archer_ID`) REFERENCES `Archers` (`archer_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scores_archer_devision_id_FK` FOREIGN KEY (`archer_devision_ID`) REFERENCES `ArcherDevision` (`archer_devision_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scores_competition_id_FK` FOREIGN KEY (`competition_ID`) REFERENCES `Competitions` (`competition_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scores_range_instance_id_FK` FOREIGN KEY (`range_instance_ID`) REFERENCES `RangeInstance` (`range_instance_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `scores_end_id_FK` FOREIGN KEY (`end_ID`) REFERENCES `Ends` (`end_ID`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- seed:
INSERT INTO `Archers` (`name`, `age`, `gender`, `category`) VALUES ('Jane Doe', 40, 'female', 'Open Female');
INSERT INTO `Archers` (`name`, `age`, `gender`, `category`) VALUES ('Jessica Bina', 19, 'female', 'Under 21 Female');
INSERT INTO `Archers` (`name`, `age`, `gender`, `category`) VALUES ('Samuel Curt', 50, 'male', '50+ Male');
INSERT INTO `Archers` (`name`, `age`, `gender`, `category`) VALUES ('George Papa', 17, 'male', 'Under 18 Male');

INSERT INTO Devisions (style) VALUES ('Recurve');
INSERT INTO Devisions (style) VALUES ('Compound');
INSERT INTO Devisions (style) VALUES ('Recurve Barebow');
INSERT INTO Devisions (style) VALUES ('Compound Longbow');
INSERT INTO Devisions (style) VALUES ('Longbow');

INSERT INTO `ArcherDevision` (`archer_ID`, `devision_ID`) VALUES ('1','1');
INSERT INTO `ArcherDevision` (`archer_ID`, `devision_ID`) VALUES ('2','3');
INSERT INTO `ArcherDevision` (`archer_ID`, `devision_ID`) VALUES ('3','4');
INSERT INTO `ArcherDevision` (`archer_ID`, `devision_ID`) VALUES ('4','4');

INSERT INTO `Clubs` (`name`) VALUES ('Hoppers Crossings Archary');
INSERT INTO `Clubs` (`name`) VALUES ('Sunshine Archary Club');
INSERT INTO `Clubs` (`name`) VALUES ('Taylors Hill Club');

-- for now, competitons soley belong to clubs
INSERT INTO `Competitions` (`name`, `club_ID`) VALUES ('The Royal Bow Invitational', 1);
INSERT INTO `Competitions` (`name`, `club_ID`) VALUES ('Sovereign Arrow Challenge', 1);
INSERT INTO `Competitions` (`name`, `club_ID`) VALUES ('Precision Archery Open', 2);
INSERT INTO `Competitions` (`name`, `club_ID`) VALUES ('Bullseye Cup', 3);
INSERT INTO `Competitions` (`name`, `club_ID`) VALUES ('Sunset Valley Archery Meet', 3);
INSERT INTO `Competitions` (`name`, `club_ID`) VALUES ('Oceania Archery Trials', 3);

INSERT INTO `RangeDefinitions` (`distance`) VALUES ('90');
INSERT INTO `RangeDefinitions` (`distance`) VALUES ('70');
INSERT INTO `RangeDefinitions` (`distance`) VALUES ('60');
INSERT INTO `RangeDefinitions` (`distance`) VALUES ('50');
INSERT INTO `RangeDefinitions` (`distance`) VALUES ('40');
INSERT INTO `RangeDefinitions` (`distance`) VALUES ('30');
INSERT INTO `RangeDefinitions` (`distance`) VALUES ('20');

INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('WA90/1440');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('WA70/1440');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('WA60/1440');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('AA50/1440');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('AA40/1440');

-- WA90/1440
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('1','1','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('2','1','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('4','1','6','80');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('6','1','6','80');

-- WA70/1440
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('2','2','6','80');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('3','2','6','80');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('4','2','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('6','2','6','122');

-- WA60/1440
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('3','3','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('4','3','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('5','3','6','80');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('6','3','6','80');

-- AA50/1440
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('4','4','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('5','4','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('6','4','6','80');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('7','4','6','80');

-- AA40/1440
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('5','5','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('6','5','6','122');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('6','5','6','80');
INSERT INTO `RoundDefinitionAssociation` (`range_definition_ID`, `round_definition_ID`, `total_ends`, `face_size`) VALUES ('7','5','6','80');


-- PART 1: initialise the first range with manually provided RoundDefinitionAssociation ID
-- Variables to configure the round
SET @archer_id = 1; -- Jane Doe
SET @archer_division_id = 1; -- Jane's Recurve division
SET @competition_id = 1; -- The Royal Bow Invitational
SET @round_definition_association_id = 1; -- WA90/1440, 90m, 122cm, 6 ends

START TRANSACTION;

-- initialise first end with zero score (before any arrows are shot)
INSERT INTO Ends (end_total_score) 
VALUES (0);

SET @current_end_id = LAST_INSERT_ID();

-- Initialise first range instance with the manually specified RoundDefinitionAssociation ID
INSERT INTO RangeInstance (end_ID, round_definition_association_ID)
VALUES (@current_end_id, @round_definition_association_id);

SET @current_range_instance_id = LAST_INSERT_ID();

COMMIT;

-- ==============================================================================================
-- PART 2: Record scores for the current end
-- Jane shoots her first end (6 arrows) at 90m
START TRANSACTION;

-- Arrow 1: Score 9
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 9, 1);

-- Arrow 2: Score 10
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 10, 1);

-- Arrow 3: Score 9
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 9, 1);

-- Arrow 4: Score 8
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 8, 1);

-- Arrow 5: Score 10
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 10, 1);

-- Arrow 6: Score 9
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 9, 1);

-- Update end total score (55 points)
UPDATE Ends 
SET end_total_score = (
    SELECT SUM(score_value) 
    FROM Scores 
    WHERE end_ID = @current_end_id
)
WHERE end_ID = @current_end_id;

COMMIT;

-- ==============================================================================================
-- PART 3: Create new end within the same range - 90m
START TRANSACTION;

-- Create a new end for the next set of arrows (same range/distance)
INSERT INTO Ends (end_total_score) 
VALUES (0);

SET @current_end_id = LAST_INSERT_ID();

-- Arrow 1: Score 7
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 9, 1);

-- Arrow 2: Score 10
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 10, 1);

-- Arrow 3: Score 8
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 9, 1);

-- Arrow 4: Score 8
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 8, 1);

-- Arrow 5: Score 9
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 10, 1);

-- Arrow 6: Score 10
INSERT INTO Scores (archer_ID, archer_devision_ID, competition_ID, range_instance_ID, end_ID, score_value, is_competition)
VALUES (@archer_id, @archer_division_id, @competition_id, @current_range_instance_id, @current_end_id, 9, 1);

-- Update end total score (55 points)
UPDATE Ends 
SET end_total_score = (
    SELECT SUM(score_value) 
    FROM Scores 
    WHERE end_ID = @current_end_id
)
WHERE end_ID = @current_end_id;

COMMIT;

-- ==============================================================================================
-- PART 4: Progress to a new range (manually specified)
-- Jane moves to 70m
SET @round_definition_association_id = 2; -- 70m distance for WA90/1440

-- Prepare for Jane's first end at 70m
START TRANSACTION;

-- Create a new end record for the first 70m end
INSERT INTO Ends (end_total_score, created_at) 
VALUES (0, CURRENT_TIMESTAMP);

SET @current_end_id = LAST_INSERT_ID();

-- Create a new range instance for 70m
INSERT INTO RangeInstance (end_ID, round_definition_association_ID, created_at)
VALUES (@current_end_id, @round_definition_association_id, CURRENT_TIMESTAMP);

SET @current_range_instance_id = LAST_INSERT_ID();

COMMIT;




---------------------------------------------------------------------
-- CREATING PROCEDURES FOR EACH OF THE ABOVE ROUND INSERTION QUERIES;
---------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE initialise_round(IN round_definition_id)
BEGIN 

START TRANSACTION;

-- initialise first end with zero score (before any arrows are shot)
INSERT INTO Ends (end_total_score) 
VALUES (0);

SET @current_end_id = LAST_INSERT_ID();

-- Initialise first range passed in manually via procedure args.
INSERT INTO RangeInstance (end_ID, round_definition_association_ID)
VALUES (@current_end_id, round_definition_id);

COMMIT;

END
DELIMITER;
