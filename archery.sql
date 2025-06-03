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

CREATE TABLE `RangeInstance` ( 
  `range_instance_ID` INT AUTO_INCREMENT NOT NULL,
  `round_definition_association_ID` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`range_instance_ID`),
  CONSTRAINT `range_instance_round_definition_association_id_FK`
    FOREIGN KEY (`round_definition_association_ID`)
    REFERENCES `RoundDefinitionAssociation` (`round_definition_association_ID`)
    ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE `Ends` ( 
  `end_ID` INT AUTO_INCREMENT NOT NULL,
  `range_instance_ID` INT NOT NULL,
  `end_total_score` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `PRIMARY` PRIMARY KEY (`end_ID`),
  CONSTRAINT `ends_range_instance_id_FK`
    FOREIGN KEY (`range_instance_ID`)
    REFERENCES `RangeInstance` (`range_instance_ID`)
    ON DELETE NO ACTION ON UPDATE CASCADE
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


-- -------------------------------------------------------------------
-- PROCEDURE: Create new archer:
-- -------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE create_archer(
  IN arg_name VARCHAR(250),
  IN arg_age INT,
  IN arg_gender VARCHAR(250),
  IN arg_category VARCHAR(50)
)
BEGIN
  INSERT INTO Archers (name, age, gender, category)
  VALUES (arg_name, arg_age, arg_gender, arg_category);
END //
DELIMITER ;



-- -------------------------------------------------------------------
-- PROCEDURE: Initialise the round:
-- -------------------------------------------------------------------


DELIMITER //
CREATE PROCEDURE initialise_round(IN arg_round_definition_association_id INT)
BEGIN 
  DECLARE new_range_instance_id INT;

  START TRANSACTION;

    INSERT INTO RangeInstance (round_definition_association_ID)
    VALUES (arg_round_definition_association_id);

    SET new_range_instance_id = LAST_INSERT_ID();

    INSERT INTO Ends (range_instance_ID, end_total_score)
    VALUES (new_range_instance_id, 0);

  COMMIT;

END //
DELIMITER ;


-- -------------------------------------------------------------------
-- PROCEDURE: Record round scores within the same range:
-- -------------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE record_end_scores (
    IN archer_id INT,
    IN archer_division_id INT,
    IN competition_id INT,
    IN range_instance_id INT,
    IN is_competition TINYINT,
    IN create_new_end BOOLEAN,
    IN existing_end_id INT,
    IN score1 INT, IN score2 INT, IN score3 INT,
    IN score4 INT, IN score5 INT, IN score6 INT
)
BEGIN
  DECLARE end_id INT;
  DECLARE existing_scores INT;

  START TRANSACTION;

    IF create_new_end THEN
        INSERT INTO Ends (range_instance_ID, end_total_score)
        VALUES (range_instance_id, 0);
        SET end_id = LAST_INSERT_ID();
    ELSE
        SET end_id = existing_end_id;

        SELECT COUNT(*)
        INTO existing_scores
        FROM Scores
        WHERE end_ID = end_id;

        IF existing_scores + 6 > 6 THEN
          SIGNAL SQLSTATE '45000'
          SET MESSAGE_TEXT = 'Cannot insert more than 6 scores for an End.';
        END IF;
    END IF;

    INSERT INTO Scores (
        archer_ID, archer_devision_ID, competition_ID, 
        range_instance_ID, end_ID, score_value, is_competition
    )
    VALUES 
        (archer_id, archer_division_id, competition_id, range_instance_id, end_id, score1, is_competition),
        (archer_id, archer_division_id, competition_id, range_instance_id, end_id, score2, is_competition),
        (archer_id, archer_division_id, competition_id, range_instance_id, end_id, score3, is_competition),
        (archer_id, archer_division_id, competition_id, range_instance_id, end_id, score4, is_competition),
        (archer_id, archer_division_id, competition_id, range_instance_id, end_id, score5, is_competition),
        (archer_id, archer_division_id, competition_id, range_instance_id, end_id, score6, is_competition);

    UPDATE Ends
    SET end_total_score = (
        SELECT SUM(score_value)
        FROM Scores
        WHERE end_ID = end_id
    )
    WHERE end_ID = end_id;

  COMMIT;
END //

DELIMITER ;


-- -------------------------------------------------------------------
-- PROCEDURE: Advance into a new range in a round:
-- -------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE advance_round_range (
    IN arg_round_definition_association_id INT,
    IN arg_archer_id INT,
    IN arg_competition_id INT
)
BEGIN 
  DECLARE round_def_id INT;
  DECLARE total_ranges INT;
  DECLARE ranges_completed_by_archer INT;
  DECLARE new_range_instance_id INT;
  DECLARE new_end_id INT;

  START TRANSACTION;

    -- Step 1: Get round_definition_ID
    SELECT round_definition_ID INTO round_def_id
    FROM RoundDefinitionAssociation
    WHERE round_definition_association_ID = arg_round_definition_association_id;

    -- Step 2: Total number of ranges in this round
    SELECT COUNT(*) INTO total_ranges
    FROM RoundDefinitionAssociation
    WHERE round_definition_ID = round_def_id;

    -- Step 3: Count distinct range_instance_IDs this archer has scores for in this round & competition
    SELECT COUNT(DISTINCT s.range_instance_ID) INTO ranges_completed_by_archer
    FROM Scores s
    INNER JOIN RangeInstance ri ON s.range_instance_ID = ri.range_instance_ID
    WHERE s.archer_ID = arg_archer_id
      AND s.competition_ID = arg_competition_id
      AND ri.round_definition_association_ID IN (
          SELECT round_definition_association_ID
          FROM RoundDefinitionAssociation
          WHERE round_definition_ID = round_def_id
      );

    -- Step 4: Check if the archer has completed all allowed ranges
    IF ranges_completed_by_archer >= total_ranges THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'You have reached the end of the round.';
    ELSE
        -- Create new RangeInstance
        INSERT INTO RangeInstance (round_definition_association_ID)
        VALUES (arg_round_definition_association_id);
        SET new_range_instance_id = LAST_INSERT_ID();

        -- Attach a fresh End to this new range
        INSERT INTO Ends (range_instance_ID, end_total_score)
        VALUES (new_range_instance_id, 0);
    END IF;

  COMMIT;
END //

DELIMITER ;
