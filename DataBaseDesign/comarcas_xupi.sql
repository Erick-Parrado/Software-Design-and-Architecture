DROP DATABASE IF EXISTS comarcas_xupi;

CREATE DATABASE comarcas_xupi;
USE comarcas_xupi;

-- DELETE TABLE IF EXIST ----------------------------------------------------------------------------------------

DROP TABLE IF EXISTS Rooms;
DROP TABLE IF EXISTS Kids_HoAc;
DROP TABLE IF EXISTS Hous_Acti;
DROP TABLE IF EXISTS Kids;
DROP TABLE IF EXISTS Tutors;
DROP TABLE IF EXISTS Houses;
DROP TABLE IF EXISTS Activities;
DROP TABLE IF EXISTS Regions;

-- TABLES CREATION ----------------------------------------------------------------------------------------------

CREATE TABLE Houses(
	hous_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	hous_name VARCHAR(50) NOT NULL,
	hous_postalAddress VARCHAR(50),
	hous_postalCode INT NOT NULL,
	hous_nameStreet VARCHAR(50) NOT NULL,
	hous_capacity INT NOT NULL,
	regi_id INT NOT NULL
);

CREATE TABLE Regions(
	regi_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	regi_name VARCHAR(50) NOT NULL,
	regi_population INT NOT NULL DEFAULT 0
);

CREATE TABLE Rooms(
	room_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	room_code VARCHAR(50),
    hous_id INT NOT NULL
);

CREATE TABLE Tutors(
	tuto_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	tuto_name VARCHAR(50) NOT NULL,
	tuto_phone VARCHAR(50) NOT NULL,
	tuto_isDirector BOOLEAN NOT NULL,
    hous_id INT NOT NULL
);

CREATE TABLE Activities(
	acti_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    acti_name VARCHAR(50) NOT NULL
);
CREATE TABLE Kids (
	kid_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    kid_name VARCHAR(50) NOT NULL,
    kid_parentsPhone VARCHAR(50) NOT NULL,
    hous_id INT NOT NULL,
    regi_id INT NOT NULL
);

CREATE TABLE Hous_Acti(
	hoac_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    hous_id INT NOT NULL,
    acti_id INT NOT NULL
);

CREATE TABLE Kids_HoAc(
	kiha_id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    kiha_evaluation FLOAT NOT NULL,
    kid_id INT NOT NULL,
    hoac_id INT NOT NULL
);

-- FOREIGNS KEYS ------------------------------------------------------------------------------------------------------
-- TABLE HOUSES
ALTER TABLE Houses ADD CONSTRAINT FOREIGN KEY (regi_id) REFERENCES Regions(regi_id);
-- TABLE ROOMS
ALTER TABLE Rooms ADD CONSTRAINT FOREIGN KEY (hous_id) REFERENCES Houses(hous_id);

ALTER TABLE Tutors ADD CONSTRAINT FOREIGN KEY (hous_id) REFERENCES Houses(hous_id);

-- TABLE HOUS_ACTI 
ALTER TABLE Hous_Acti ADD CONSTRAINT FOREIGN KEY (hous_id) REFERENCES Houses(hous_id);
ALTER TABLE Hous_Acti ADD CONSTRAINT FOREIGN KEY (acti_id) REFERENCES Activities(acti_id);

-- TABLE KIDS
ALTER TABLE Kids ADD CONSTRAINT FOREIGN KEY (regi_id) REFERENCES Regions(regi_id);
ALTER TABLE Kids ADD CONSTRAINT FOREIGN KEY (hous_id) REFERENCES Houses(hous_id);

-- TABLE Kids_HoAc
ALTER TABLE Kids_HoAc ADD CONSTRAINT FOREIGN KEY (hoac_id) REFERENCES Hous_Acti(hoac_id);
ALTER TABLE Kids_HoAc ADD CONSTRAINT FOREIGN KEY (kid_id) REFERENCES Kids(kid_id);

-- TRIGGER TO INCREASE REGION PUPULATION -----------------------------------------------------------------------
delimiter $$
CREATE TRIGGER  add_Habitant BEFORE INSERT ON Kids
FOR EACH ROW
BEGIN
	UPDATE Regions AS r SET regi_population = r.regi_population + 1
	WHERE r.regi_id = NEW.regi_id;
END;$$
delimiter; 


-- -- TRIGGER TO sET HOUSE POSTAL ADDRESS -----------------------------------------------------------------------
-- delimiter $$
-- CREATE TRIGGER  set_HousePostalAddress AFTER INSERT ON Houses
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE houses AS h SET hous_postalAddress = CONCAT(hous_nameStreet,'-',hous_postalCode)
-- 	WHERE h.hous_id = NEW.hous_id;
-- END;$$
-- delimiter; 

DELIMITER //
CREATE PROCEDURE InsertHouse(
	IN hous_name VARCHAR(50),
	IN hous_postalCode INT,
	IN hous_nameStreet VARCHAR(50),
	IN hous_capacity INT, 
	IN regi_id INT
	)
BEGIN
	INSERT INTO Houses (hous_name, hous_postalCode, hous_nameStreet, hous_capacity, regi_id,hous_postalAddress) 
	VALUES (hous_name, hous_postalCode, hous_nameStreet, hous_capacity, regi_id, CONCAT(hous_nameStreet,hous_postalCode));
END;//
DELIMITER ;



-- -- -- TRIGGER TO SET HOUSE POSTAL ADDRESS -----------------------------------------------------------------------

-- delimiter $$
-- CREATE TRIGGER  set_RoomCode AFTER INSERT ON Rooms
-- FOR EACH ROW
-- BEGIN
-- 	UPDATE Rooms AS r SET room_code = CONCAT('RM-',(SELECT COUNT(*) FROM Rooms WHERE hous_id = NEW.hous_id)+1)
-- 	WHERE r.room_id = NEW.room_id;
-- END;$$
-- delimiter; 


DELIMITER //
CREATE PROCEDURE InsertRoom(
	IN hous_id INT
	)
BEGIN
	INSERT INTO Rooms(room_code,hous_id) 
	VALUES (CONCAT('RM-',(SELECT COUNT(*) FROM Rooms AS r  WHERE r.hous_id = hous_id)+1),hous_id);
END;//
DELIMITER ;
-- PROCEDURE TO RELATE THE ACTIVITIES WITH THE HOUSES ----------------------------------------------------

DELIMITER //
CREATE PROCEDURE RelateActivitiesWithHouses()
BEGIN
    DECLARE i INT DEFAULT 1;
	IF (SELECT COUNT(*) FROM Houses) > 0 THEN
		WHILE i <= 10 DO
			INSERT INTO hous_acti (hous_id, acti_id) VALUES (FLOOR(RAND()*5)+1, FLOOR(RAND()*7)+1);
			SET i = i + 1;
		END WHILE;
	END IF;
END;//
DELIMITER ;


----------------------------------------------------------------------------------------------------------

-- PROCEDURE ACTIVITIES EVALUATIONS  ----------------------------------------------------

DELIMITER //
CREATE PROCEDURE EvaluateActivities()
BEGIN
    DECLARE i INT DEFAULT 1;
	IF (SELECT COUNT(*) FROM Houses) > 0 THEN
    WHILE i <= 50 DO
        INSERT INTO Kids_HoAc (kid_id,hoac_id,kiha_evaluation) VALUES (FLOOR(RAND()*20)+1,FLOOR(RAND() * 10) + 1,RAND()*5+1);
        SET i = i + 1;
    END WHILE;
	END IF;
END;//
DELIMITER ;
/*---------------------------------------------------------------------*/
-- INSER DATA ------------------------------------------------------------------------------------------------------
INSERT INTO Regions (regi_name) VALUES
('Emberá'),
('Tenza'),
('Hiza'),
('Ricaute'),
('Marquez'),
('Turmeque');

CALL InsertHouse ('Los monchos',  579, 'Milagros', 60, 5);
CALL InsertHouse ('Angeles de saber', 874, 'Rojas', 45 , 1);
CALL InsertHouse ('Mi pequeño paraiso', 988, 'Quito', 33, 2);
CALL InsertHouse ('Burbujas magicas', 4230, 'Bolivar', 70, 2);
CALL InsertHouse ('Nogales de esperanza', 5075, 'Santander', 54, 3);


INSERT INTO Tutors (tuto_name, tuto_phone, tuto_isDirector, hous_id) VALUES 
('Sandra Cabezas', '3228796655', 1, 1),
('Marta Barriga', '3123458900', 0, 2),
('Eliecer Cucunuva', '3458798787', 0, 3),
('Alex Tunja', '3214576121', 0, 4),
('Sonia Bogota', '34589612', 1, 3),
('Tomas Turmeque', '3123578900', 1, 3),
('Marisol Ropefuego', '3134578614', 0, 5),
('Luz Rayo', '35048998777', 0, 1),
('Sofia Valiente', '3145876878', 0, 4);

INSERT INTO Kids (kid_name, kid_parentsPhone, hous_id, regi_id) VALUES 
('Esteban', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Oscar', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Jenifer', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Sofia', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Valeria', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Yanira', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Blanca', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Victoria', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Eliana', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Dana', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Sergio', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Danilo', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Matias', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Tomas', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Amari', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Ricardo', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Sandra', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Nubia', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Elias', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Geronimo', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1),
('Santiago', FLOOR(RAND() * 8000000000) + 1000000000, FLOOR(RAND() * 5) + 1, FLOOR(RAND() * 5) + 1);

INSERT INTO Activities (acti_name) VALUES 
('Natacion'),
('Fotografia'),
('Fubol'),
('Voleibol'),
('Canto'),
('Musica'),
('Pintura');

CALL InsertRoom (FLOOR(RAND()*5)+1);
-- CREATE ROOMS ----------------------------------------------------
	-- DELIMITER //
	-- CREATE PROCEDURE createRooms()
	-- BEGIN
	-- 	DECLARE i INT DEFAULT 1;
	-- 	WHILE i <= 2 DO
	-- 		SET @house = (FLOOR(RAND()*5)+1);
	-- 		INSERT INTO Rooms (room_code,hous_id) VALUES (CONCAT('RM-',(SELECT COUNT(*) FROM Rooms WHERE hous_id = @house)+1),@house);
	-- 		SET i = i + 1;
	-- 	END WHILE;
	-- END //
	-- DELIMITER ;
-- CALL createRooms();
CALL RelateActivitiesWithHouses();
CALL EvaluateActivities();

/*Authors: Erick Parrado - Karen Soler*/