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
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Long Sydney');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Sydney');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Long Brisbane');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Brisbane');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Adelaide');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Short Adelaide');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Hobart');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Perth');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Canberra WA60/900');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Short Canberra');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Junior Canberra');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Mini Canberra');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Grange');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Melbourne');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Darwin');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Geelong');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Newcastle');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Holt');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Samford');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Drake');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Wollongong');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Townsville');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('Launceston');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('WA70/720');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('WA60/720');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('WA50/720');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('50/720');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('40/720');
INSERT INTO `RoundDefinitions` (`schedule_name`) VALUES ('30/720');
