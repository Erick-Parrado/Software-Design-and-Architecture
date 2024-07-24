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