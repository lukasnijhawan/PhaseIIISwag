DROP DATABASE IF EXISTS ta4400spring2020;
CREATE DATABASE ta4400spring2020;
USE ta4400spring2020;

-- The following command turns off the Safe Update checks so that your
-- UPDATE and DELETE queries will work without restrictions.  You don't
-- have to replicate this command anywhere else in your code.
SET SQL_SAFE_UPDATES = 0;

CREATE TABLE ta4400spring2020.`User`(
	username VARCHAR(55) PRIMARY KEY,
    `password` VARCHAR(255) NOT NULL,
    firstName VARCHAR(55) NOT NULL,
    lastName VARCHAR(55) NOT NULL
);

CREATE TABLE ta4400spring2020.Building (
	buildingName VARCHAR(55) PRIMARY KEY,
    description TEXT NOT NULL
);

CREATE TABLE ta4400spring2020.Station (
	stationName VARCHAR(55) PRIMARY KEY,
    buildingName VARCHAR(55) NOT NULL UNIQUE,
    capacity INT NOT NULL,
    FOREIGN KEY (buildingName) REFERENCES Building (buildingName)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.Food (
	foodName VARCHAR(55) PRIMARY KEY
);

CREATE TABLE ta4400spring2020.Customer (
	username VARCHAR(55) PRIMARY KEY,
    balance DECIMAL(6, 2) NOT NULL,
    stationName VARCHAR(55),
    FOREIGN KEY (stationName) REFERENCES Station (stationName)
		ON DELETE SET NULL ON UPDATE RESTRICT,
	FOREIGN KEY (username) REFERENCES `User` (username)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ta4400spring2020.Employee (
	username VARCHAR(55) PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    FOREIGN KEY (username) REFERENCES `User` (username)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.Manager (
	username VARCHAR(55) PRIMARY KEY,
    FOREIGN KEY (username) REFERENCES Employee (username)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.FoodTruck (
	foodTruckName VARCHAR(55) PRIMARY KEY,
    stationName VARCHAR(55) NOT NULL,
    managerUsername VARCHAR(55) NOT NULL,
    FOREIGN KEY (stationName) REFERENCES Station (stationName)
		ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (managerUsername) REFERENCES Manager (username)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.Staff (
	username VARCHAR(55) PRIMARY KEY,
    foodTruckName VARCHAR(55),
    FOREIGN KEY (username) REFERENCES Employee (username)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (foodTruckName) REFERENCES FoodTruck (foodTruckName)
		ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE ta4400spring2020.`Admin` (
	username VARCHAR(55) PRIMARY KEY,
    FOREIGN KEY (username) REFERENCES Employee (username)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.Orders (
	orderID INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    customerUsername VARCHAR(55) NOT NULL,
    FOREIGN KEY (customerUsername) REFERENCES Customer (username)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.MenuItem (
	price DECIMAL(6,2) NOT NULL,
    foodTruckName VARCHAR(55) NOT NULL,
    foodName VARCHAR(55) NOT NULL,
    PRIMARY KEY (foodTruckName, foodName),
    FOREIGN KEY (foodName) REFERENCES Food (foodName)
		ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY (foodTruckName) REFERENCES FoodTruck (foodTruckName)
		ON UPDATE RESTRICT ON DELETE RESTRICT
);

CREATE TABLE ta4400spring2020.BuildingTag (
	buildingName VARCHAR(55) NOT NULL,
    tag VARCHAR(55) NOT NULL,
    PRIMARY KEY (buildingName, tag),
    FOREIGN KEY (buildingName) REFERENCES Building (buildingName)
		ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE ta4400spring2020.OrderDetail (
	orderID INT NOT NULL,
    foodTruckName VARCHAR(55) NOT NULL,
    foodName VARCHAR(55) NOT NULL,
    purchaseQuantity INT NOT NULL,
    PRIMARY KEY (orderID, foodTruckName, foodName),
    FOREIGN KEY (orderID) REFERENCES Orders (orderID)
		ON UPDATE RESTRICT ON DELETE RESTRICT,
	FOREIGN KEY (foodTruckName, foodName) REFERENCES MenuItem (foodTruckName, foodName)
		ON UPDATE RESTRICT ON DELETE RESTRICT
);

INSERT INTO ta4400spring2020.Building(buildingName,description) VALUES ("Clough","Has starbucks; located near to transit hub"),("College of Computing","Famously called as CoC"),("CrossLand Tower","Library"),("KLAUS Adv Computing","Connected to CoC through binary bridge"),("Molecular Engineering","Hosts classes for molecular engineering"),("Skiles","Host classes for media and literature students"),("Students_Center","Host for student activities"),("TechTower","Most Iconic building"),("Weber Building","Classes mostly related to space technology");

INSERT INTO ta4400spring2020.Station(stationName,buildingName,capacity) VALUES ("Clough Commons","Clough",20.0),("CoC Court Yard","College of Computing",15.0),("Bio Quad","Molecular Engineering",20.0),("Skiles Walkway","Skiles",11.0),("Campanile","Students_Center",5.0);

INSERT INTO ta4400spring2020.Food(foodName) VALUES ("CeasarSalad"),("Waffles"),("TrailMix"),("ChickenSandwich"),("Nachos"),("ChickenWings"),("HamBurger"),("VegetarianGumbo"),("CheeseBurger"),("Shawarma"),("Noodles"),("ChocolateShake"),("MargheritaPizza"),("Bagels"),("ElkBurger"),("SalmonTacos"),("ChickenTacos"),("SouthWestChickenSalad"),("VegetarianTacos"),("VegSpringRolls"),("VegPizza"),("HotDog"),("Pie"),("ShrimpGumbo");

INSERT INTO ta4400spring2020.BuildingTag(buildingName,tag) VALUES ("College of Computing","Computing"),("Clough","LEED"),("KLAUS Adv Computing","Computing"),("CrossLand Tower","LEED"),("TechTower","ADA"),("Students_Center","LEED"),("TechTower","Registrar"),("Weber Building","ADA"),("Clough","ADA"),("Clough","Labs"),("Weber Building","Sciences"),("Molecular Engineering","Engineering"),("CrossLand Tower","Library"),("Skiles","Liberal Arts");

INSERT INTO ta4400spring2020.`User`(username,`password`,firstname,lastname) VALUES ("2Cool_not_todoschool","4242424242","Smarty","Pants"),("4400_thebestclass","4400440044","Seriously","Itis"),("Aturning_Machine12","3333333333","Alan","Turing"),("beBatman!","5555555555","Bruce","Wayne"),("bestfriends4ever1","44444444433","C3P0","Droid"),("bestfriends4ever2","44444444443","R2D2","Droid"),("BuzzyAsAYellowJacket","1010101010","Buzz","Buzz"),("coxRaycox","4242424242","Ray","Cox"),("customer1","1111111111","One","One"),("customer2","1011111111","Two","Two"),("deer.john","22222022222","John","Deer"),("doe.jane","22222222200","Jane","Doe"),("doe.john","20000000002","John","Doe"),("EmmsBest","1000000011","Emma","Williams"),("employee1","1000111111","Employee","Won"),("Employeeofthemonth","1000011111","Beast","Boy"),("FatherofInfoTheory","2222222222","Claude","Shannon"),("ILikeFlowers","1000000001","Lily","Rose"),("JHallPride","2222222222","James","Hall"),("JNash28TheoryofGaming","1111111111","John","Nash"),("LadyVader1977","54545454545","Leia","Organa"),("LifeIsLikeABoxOfChoco.","4444444444","Forrest","Gump"),("LifeUniverseEverything","4242424242","Forty","Two"),("Manager1","1000001111","First","Manager"),("Manager2","1000000111","Second","Manager"),("Manager3","1000000011","Third","Manager"),("Manager4","1000000001","Fourth","Manager"),("mKJerrY","22222022222","Mike","Jerry"),("Nekonsh","8888888888","Nelsh","Kong"),("RPosince","2222222222","Prince","Ross"),("RRanskans","44444444433","Ruby","Rans"),("scoRa","7000000000","Dhey","Scott"),("sffrgerge","1000000000","Blah","BlahBlah"),("SShen","4444444444","Soms","Shen"),("Staff1","3333333333","One","Staff"),("Staff2","2222222222","Two","Staff"),("notmybusiness","7000000000","Kermit","TheFrog"),("theCustomersAlwaysRight","1001111111","Always","Everytime"),("thereal_GPBurdell","9999999999","George","Burdell"),("TingTong","1000000000","Eva","Bell"),("tkingTom","2222222222","Tom","King"),("TooCuteNottoMention","8888888888","Baby","Yoda"),("toongNonyLongy","20000000002","Tony","Long"),("Violax","4400440044","Violet","Lax"),("WomanWhoSmashedCode","4444444444","Elizabeth","Friedman"),("YayVish","6666666666","Vishy","Yay"),("YouBetterBeNiceToMe","6666666666","Talking","Tina");

-- The following command hashes all of the plaintext passwords that we entered above into a more secure form using MySQL's built-in md5() function
-- Ideally, you would hash the plaintext passwords immediately as they are entered to avoid potential exposure
UPDATE ta4400spring2020.`User` SET `password` = md5(`password`);

INSERT INTO ta4400spring2020.Customer(username,balance,stationName) VALUES ("4400_thebestclass",44.0,"Clough Commons"),("beBatman!",89.99,"Skiles Walkway"),("BuzzyAsAYellowJacket",0.5,"Skiles Walkway"),("coxRaycox",4.5,"CoC Court Yard"),("customer1",46.99,"Clough Commons"),("customer2",47.0,"CoC Court Yard"),("JHallPride",30.9,"Clough Commons"),("LifeUniverseEverything",42.42,"Campanile"),("mKJerrY",44.2,"Bio Quad"),("RPosince",67.89,"Campanile"),("RRanskans",7.78,"Bio Quad"),("sffrgerge",4.09,"Clough Commons"),("notmybusiness",19.55,"Bio Quad"),("theCustomersAlwaysRight",2.99,"CoC Court Yard"),("TingTong",50.25,"Bio Quad"),("tkingTom",70.14,"Skiles Walkway"),("toongNonyLongy",17.9,"Clough Commons"),("Violax",15.2,"Skiles Walkway"),("YouBetterBeNiceToMe",52.63,"Bio Quad");

INSERT INTO ta4400spring2020.Employee(username,email) VALUES ("2Cool_not_todoschool","school@gmail.com"),("4400_thebestclass","4400_thebestclass@gatech.edu"),("Aturning_Machine12","machine12@outlook.com"),("beBatman!","beBatman!@gatech.edu"),("bestfriends4ever1","bff@hotmail.com"),("bestfriends4ever2","bff2@gmail.com"),("BuzzyAsAYellowJacket","BuzzyAsAYellowJacket@gatech.edu"),("deer.john","dj3@outlook.com"),("doe.jane","dj1@outlook.com"),("doe.john","dj2@outlook.com"),("EmmsBest","emmsbest@gatech.edu"),("employee1","employee1@gatech.edu"),("Employeeofthemonth","Employeeofthemonth@gatech.edu"),("FatherofInfoTheory","fot@gmail.com"),("ILikeFlowers","flora@gatech.edu"),("JNash28TheoryofGaming","jg@hotmail.com"),("LadyVader1977","lv1977@gatech.edu"),("LifeIsLikeABoxOfChoco.","chocolate@gmail.com"),("Manager1","manager1@gatech.edu"),("Manager2","manager2@gatech.edu"),("Manager3","manager3@gatech.edu"),("Manager4","manager4@gatech.edu"),("Nekonsh","nekonsh@gatech.edu"),("RRanskans","rranskans@gatech.edu"),("scoRa","scoRa@gatech.edu"),("sffrgerge","sff@outlook.com"),("SShen","sshen@gatech.edu"),("Staff1","staff1@gatech.edu"),("Staff2","staff2@gatech.edu"),("thereal_GPBurdell","gpb@gatech.edu"),("TingTong","tingtong@gatech.edu"),("TooCuteNottoMention","mention@gmail.com"),("Violax","violax@gatech.edu"),("WomanWhoSmashedCode","smashedcode@gmail.com"),("YayVish","yayvish@gatech.edu");

INSERT INTO ta4400spring2020.`Admin`(username) VALUES ("4400_thebestclass"),("Nekonsh"),("scoRa");

INSERT INTO ta4400spring2020.Manager(username) VALUES ("doe.jane"),("FatherofInfoTheory"),("LadyVader1977"),("LifeIsLikeABoxOfChoco."),("Manager1"),("Manager2"),("Manager3"),("Manager4"),("SShen"),("thereal_GPBurdell"),("YayVish");

INSERT INTO ta4400spring2020.FoodTruck(foodTruckName,managerUsername,stationName) VALUES ("JohnJaneAndVenison","doe.jane","Campanile"),("FourAnalystInATacoTruck","FatherofInfoTheory","Clough Commons"),("GoodFoodTruck","FatherofInfoTheory","CoC Court Yard"),("BurgerBird","LadyVader1977","Clough Commons"),("FoodTrolley","LadyVader1977","Skiles Walkway"),("FoodTruckYoureLookingFor","LadyVader1977","Campanile"),("BubbaGumps","LifeIsLikeABoxOfChoco.","Campanile"),("CrazyPies","Manager1","Campanile"),("NachoBizness","Manager2","Campanile"),("TruckOfFood","Manager2","Campanile"),("ShawarmaExpress","Manager3","Bio Quad"),("WaffleTruffle","SShen","CoC Court Yard"),("GoodOnAStudentBudget","thereal_GPBurdell","Bio Quad"),("FusionFoodTruck","YayVish","Campanile");

INSERT INTO ta4400spring2020.Staff(username,foodTruckName) VALUES ("2Cool_not_todoschool","WaffleTruffle"),("Aturning_Machine12","FourAnalystInATacoTruck"),("beBatman!","WaffleTruffle"),("bestfriends4ever1","FoodTruckYoureLookingFor"),("bestfriends4ever2","BurgerBird"),("BuzzyAsAYellowJacket","ShawarmaExpress"),("deer.john","JohnJaneAndVenison"),("doe.john","TruckOfFood"),("EmmsBest","CrazyPies"),("employee1","BurgerBird"),("Employeeofthemonth","ShawarmaExpress"),("ILikeFlowers","CrazyPies"),("JNash28TheoryofGaming","GoodFoodTruck"),("RRanskans","FoodTrolley"),("sffrgerge","GoodOnAStudentBudget"),("Staff1","BubbaGumps"),("Staff2","BubbaGumps"),("TingTong","FusionFoodTruck"),("TooCuteNottoMention","NachoBizness"),("Violax","FoodTrolley"),("WomanWhoSmashedCode","FourAnalystInATacoTruck");

INSERT INTO ta4400spring2020.MenuItem(price,foodTruckName,foodName) VALUES (3.21,"FoodTruckYoureLookingFor","Nachos"),(9.06,"GoodFoodTruck","SouthWestChickenSalad"),(4.51,"FoodTrolley","Pie"),(4.28,"CrazyPies","MargheritaPizza"),(4.51,"GoodOnAStudentBudget","CheeseBurger"),(4.36,"JohnJaneAndVenison","TrailMix"),(6.22,"BubbaGumps","ShrimpGumbo"),(4.4,"GoodFoodTruck","Noodles"),(5.48,"GoodOnAStudentBudget","ChocolateShake"),(2.23,"GoodOnAStudentBudget","HotDog"),(6.65,"WaffleTruffle","Waffles"),(6.58,"NachoBizness","ChickenTacos"),(8.03,"FourAnalystInATacoTruck","SalmonTacos"),(4.7,"NachoBizness","VegetarianTacos"),(7.88,"FoodTruckYoureLookingFor","VegPizza"),(6.3,"ShawarmaExpress","Shawarma"),(3.82,"GoodOnAStudentBudget","HamBurger"),(5.95,"FusionFoodTruck","VegetarianTacos"),(3.53,"TruckOfFood","VegSpringRolls"),(5.21,"BubbaGumps","ChickenTacos"),(5.28,"FourAnalystInATacoTruck","ChickenWings"),(9.57,"FoodTruckYoureLookingFor","SouthWestChickenSalad"),(3.48,"CrazyPies","VegPizza"),(7.59,"NachoBizness","SalmonTacos"),(3.46,"GoodOnAStudentBudget","CeasarSalad"),(7.16,"FusionFoodTruck","SalmonTacos"),(5.82,"FoodTrolley","Waffles"),(6.22,"FourAnalystInATacoTruck","ChickenTacos"),(6.01,"FoodTrolley","ChickenWings"),(4.85,"ShawarmaExpress","ChocolateShake"),(3.11,"GoodFoodTruck","VegSpringRolls"),(6.68,"BurgerBird","ElkBurger"),(4.53,"BurgerBird","Pie"),(3.82,"BubbaGumps","VegetarianGumbo"),(4.19,"CrazyPies","Pie"),(7.54,"FoodTrolley","ChocolateShake"),(5.13,"NachoBizness","Nachos"),(7.05,"BurgerBird","HamBurger"),(4.77,"TruckOfFood","Noodles"),(3.44,"GoodOnAStudentBudget","Waffles"),(5.84,"FourAnalystInATacoTruck","VegetarianTacos"),(4.76,"BurgerBird","CheeseBurger"),(7.58,"FoodTruckYoureLookingFor","MargheritaPizza"),(10.17,"JohnJaneAndVenison","ElkBurger");

INSERT INTO ta4400spring2020.Orders(customerUsername,date) VALUES ("customer1","2020-01-01"),("customer1","2020-01-01"),("customer2","2020-01-01"),("customer2","2020-02-01"),("customer1","2020-02-02"),("customer2","2020-02-03"),("theCustomersAlwaysRight","2020-02-04"),("theCustomersAlwaysRight","2020-02-04"),("notmybusiness","2020-02-04"),("customer1","2020-02-04"),("customer2","2020-02-05"),("theCustomersAlwaysRight","2020-02-05"),("notmybusiness","2020-02-05"),("notmybusiness","2020-02-05"),("notmybusiness","2020-02-06"),("theCustomersAlwaysRight","2020-02-06"),("notmybusiness","2020-02-06"),("customer1","2020-02-10"),("customer2","2020-02-10"),("customer2","2020-02-10"),("customer2","2020-02-10"),("BuzzyAsAYellowJacket","2020-02-10"),("BuzzyAsAYellowJacket","2020-02-10"),("customer1","2020-02-10"),("customer2","2020-02-10"),("BuzzyAsAYellowJacket","2020-02-11"),("customer2","2020-02-11"),("customer2","2020-02-22"),("customer2","2020-02-29"),("customer1","2020-02-29"),("customer1","2020-03-01"),("customer2","2020-03-01"),("customer2","2020-03-01"),("sffrgerge","2020-03-01"),("sffrgerge","2020-03-01"),("customer1","2020-03-01"),("LifeUniverseEverything","2020-03-01"),("beBatman!","2020-03-01"),("beBatman!","2020-03-01"),("YouBetterBeNiceToMe","2020-03-01"),("YouBetterBeNiceToMe","2020-03-01");

INSERT INTO ta4400spring2020.OrderDetail(orderID,foodTruckName,foodName,purchaseQuantity) VALUES (35,"GoodOnAStudentBudget","Waffles",1),(31,"FourAnalystInATacoTruck","ChickenTacos",3),(26,"FoodTrolley","Pie",1),(26,"FoodTrolley","ChickenWings",6),(7,"BurgerBird","HamBurger",2),(24,"TruckOfFood","VegSpringRolls",5),(6,"FourAnalystInATacoTruck","SalmonTacos",1),(7,"BurgerBird","ElkBurger",2),(36,"GoodOnAStudentBudget","HamBurger",1),(36,"GoodOnAStudentBudget","ChocolateShake",1),(40,"CrazyPies","VegPizza",1),(31,"FourAnalystInATacoTruck","ChickenWings",5),(17,"ShawarmaExpress","Shawarma",6),(27,"FoodTruckYoureLookingFor","VegPizza",1),(11,"NachoBizness","ChickenTacos",1),(15,"FoodTrolley","ChickenWings",1),(22,"GoodOnAStudentBudget","Waffles",3),(6,"FourAnalystInATacoTruck","ChickenTacos",3),(11,"NachoBizness","SalmonTacos",3),(8,"ShawarmaExpress","Shawarma",2),(3,"GoodOnAStudentBudget","Waffles",2),(16,"FoodTrolley","ChickenWings",2),(1,"CrazyPies","Pie",2),(32,"BurgerBird","Pie",1),(22,"GoodOnAStudentBudget","CheeseBurger",1),(31,"FourAnalystInATacoTruck","SalmonTacos",3),(23,"GoodOnAStudentBudget","ChocolateShake",2),(10,"TruckOfFood","VegSpringRolls",3),(34,"FourAnalystInATacoTruck","ChickenWings",5),(38,"BubbaGumps","ChickenTacos",7),(32,"BurgerBird","CheeseBurger",3),(41,"BubbaGumps","VegetarianGumbo",1),(37,"BurgerBird","CheeseBurger",1),(19,"FourAnalystInATacoTruck","VegetarianTacos",3),(22,"GoodOnAStudentBudget","CeasarSalad",5),(13,"FoodTrolley","ChocolateShake",1),(20,"FourAnalystInATacoTruck","VegetarianTacos",2),(28,"BurgerBird","CheeseBurger",1),(14,"GoodOnAStudentBudget","HamBurger",4),(2,"GoodOnAStudentBudget","HotDog",1),(29,"FourAnalystInATacoTruck","ChickenWings",6),(33,"FoodTrolley","Pie",1),(41,"BubbaGumps","ShrimpGumbo",1),(24,"TruckOfFood","Noodles",1),(33,"FoodTrolley","Waffles",2),(40,"CrazyPies","MargheritaPizza",1),(35,"GoodOnAStudentBudget","CeasarSalad",2),(23,"GoodOnAStudentBudget","HamBurger",1),(25,"BurgerBird","Pie",1),(31,"FourAnalystInATacoTruck","VegetarianTacos",1),(21,"GoodOnAStudentBudget","ChocolateShake",1),(6,"FourAnalystInATacoTruck","ChickenWings",4),(33,"FoodTrolley","ChickenWings",5),(5,"NachoBizness","SalmonTacos",3),(18,"WaffleTruffle","Waffles",4),(12,"FoodTruckYoureLookingFor","MargheritaPizza",2),(34,"FourAnalystInATacoTruck","SalmonTacos",3),(21,"GoodOnAStudentBudget","CheeseBurger",1),(4,"FoodTrolley","ChickenWings",4),(3,"GoodOnAStudentBudget","CheeseBurger",1),(9,"JohnJaneAndVenison","TrailMix",2),(41,"BubbaGumps","ChickenTacos",1),(22,"GoodOnAStudentBudget","HotDog",1),(26,"FoodTrolley","Waffles",2),(39,"NachoBizness","Nachos",2),(11,"NachoBizness","Nachos",4),(30,"BubbaGumps","VegetarianGumbo",1),(1,"CrazyPies","VegPizza",1),(1,"CrazyPies","MargheritaPizza",1),(3,"GoodOnAStudentBudget","HamBurger",1),(11,"NachoBizness","VegetarianTacos",3),(10,"TruckOfFood","Noodles",1),(20,"FourAnalystInATacoTruck","ChickenWings",1),(12,"FoodTruckYoureLookingFor","VegPizza",2),(21,"GoodOnAStudentBudget","HamBurger",3),(26,"FoodTrolley","ChocolateShake",2),(2,"GoodOnAStudentBudget","CeasarSalad",1),(34,"FourAnalystInATacoTruck","ChickenTacos",3);

DROP VIEW IF EXISTS login_classifier;
CREATE VIEW login_classifier AS
SELECT username, 'Admin' AS userType FROM `Admin`
WHERE username NOT IN (SELECT username FROM Customer)
UNION
SELECT username, 'Manager' AS userType FROM Manager
WHERE username NOT IN (SELECT username FROM Customer)
UNION
SELECT username, 'Staff' AS userType FROM Staff
WHERE username NOT IN (SELECT username FROM Customer)
UNION
SELECT username, 'Admin-Customer' AS userType FROM `Admin`
WHERE username in (SELECT username FROM Customer)
UNION
SELECT username, 'Manager-Customer' AS userType FROM Manager
WHERE username in (SELECT username FROM Customer)
UNION
SELECT username, 'Staff-Customer' AS userType FROM Staff
WHERE username in (SELECT username FROM Customer)
UNION
SELECT username, 'Customer' AS userType FROM Customer
WHERE username NOT IN (SELECT username FROM Employee);

-- Query #1: login [Screen #1 Login]
DROP PROCEDURE IF EXISTS login;
DELIMITER //
CREATE PROCEDURE login(
				IN i_username VARCHAR(50),
				IN i_password VARCHAR(50))
sp_main: BEGIN
	DROP TABLE IF EXISTS login_result;
    CREATE TABLE login_result (
		username VARCHAR(50),
		userType ENUM('Customer', 'Admin', 'Staff', 'Manager', 'Admin-Customer', 'Staff-Customer', 'Manager-Customer')
    );

	IF NOT EXISTS (SELECT username, `password` FROM `User`
		WHERE username = i_username AND `password` = md5(i_password)) THEN LEAVE sp_main; END IF;

    INSERT INTO login_result
    SELECT username, userType FROM login_classifier WHERE username = i_username;

END //
DELIMITER ;

-- Query #2: register  [Screen #2 Register]
DROP PROCEDURE IF EXISTS register;
DELIMITER //
CREATE PROCEDURE register(
				IN i_username VARCHAR(50),
				IN i_email VARCHAR(50),
                IN i_firstname VARCHAR(50),
                IN i_lastname VARCHAR(50),
                IN i_password VARCHAR(50),
                IN i_confirmPassword VARCHAR(50),
                IN i_balance DECIMAL,
                IN i_type ENUM('Admin', 'Manager', 'Staff'))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #3: ad_filter_building_station [Screen #4 Admin Manage Building & Station]
DROP PROCEDURE IF EXISTS ad_filter_building_station;
DELIMITER //
CREATE PROCEDURE ad_filter_building_station(
				IN i_buildingName VARCHAR(50),
				IN i_buildingTag VARCHAR(50),
                IN i_stationName VARCHAR(50),
                IN i_minCapacity INT,
                IN i_maxCapacity INT)
BEGIN
	DROP TABLE IF EXISTS ad_filter_building_station_result;
	CREATE TABLE ad_filter_building_station_result(
		buildingName varchar(100), tags text,
        stationName varchar(100), capacity int, foodTruckNames text
	);

	INSERT INTO ad_filter_building_station_result
    SELECT * FROM
		(SELECT buildingInfo.buildingName, tags, stationInfo.stationName, stationInfo.capacity, foodTruckNames FROM
			(SELECT B.buildingName, GROUP_CONCAT(BT.tag) as "tags" FROM Building as B LEFT JOIN BuildingTag as BT on B.buildingName = BT.buildingName GROUP BY B.buildingName) as buildingInfo LEFT JOIN
			(SELECT S.stationName, S.capacity, S.buildingName, GROUP_CONCAT(F.foodTruckName) as "foodTruckNames" FROM Station as S LEFT JOIN FoodTruck as F on S.stationName = F.stationName GROUP BY S.stationName) as stationInfo
		ON buildingInfo.buildingName = stationInfo.buildingName
		GROUP BY buildingInfo.buildingName) as innerTable
	WHERE (i_buildingName is NULL OR i_buildingName = "" OR buildingName = i_buildingName)
    AND (i_buildingTag is NULL OR i_buildingTag = "" OR tags LIKE CONCAT('%', i_buildingTag, '%'))
    AND (i_stationName is NULL OR i_stationName = "" OR stationName = i_stationName)
    AND (i_minCapacity is NULL OR capacity >= i_minCapacity)
    AND (i_maxCapacity is NULL OR capacity <= i_maxCapacity);

END //
DELIMITER ;

-- Query #4: ad_delete_building [Screen #4 Admin Manage Building & Station]
DROP PROCEDURE IF EXISTS ad_delete_building;
DELIMITER //
CREATE PROCEDURE ad_delete_building(
				IN i_buildingName VARCHAR(50))
BEGIN

	DELETE FROM Building WHERE buildingName = i_buildingName;

END //
DELIMITER ;

-- Query #5: ad_delete_station [Screen #4 Admin Manage Building & Station]
DROP PROCEDURE IF EXISTS ad_delete_station;
DELIMITER //
CREATE PROCEDURE ad_delete_station(
                IN i_stationName VARCHAR(50))
BEGIN

	DELETE FROM Station WHERE stationName = i_stationName;

END //
DELIMITER ;

-- Query #6: ad_add_building_tag [Screen #5 Admin Add Building Tag]
DROP PROCEDURE IF EXISTS ad_add_building_tag;
DELIMITER //
CREATE PROCEDURE ad_add_building_tag(IN i_buildingName VARCHAR(55), IN i_tag VARCHAR(55))
BEGIN

	INSERT INTO Building VALUES (i_buildingName, i_tag);

END //
DELIMITER ;

-- Query #7: ad_create_building [Screen #5 Admin Create Building]
DROP PROCEDURE IF EXISTS ad_create_building;
DELIMITER //
CREATE PROCEDURE ad_create_building(IN i_buildingName VARCHAR(55), IN i_description TEXT)
BEGIN

	INSERT INTO Building VALUES (i_buildingName, i_description);

END //
DELIMITER ;

-- Query #8: ad_view_building [Screen #6 Admin Update Building]
DROP PROCEDURE IF EXISTS ad_view_building;
DELIMITER //
CREATE PROCEDURE ad_view_building(IN i_buildingName VARCHAR(55))
BEGIN
	DROP TABLE IF EXISTS ad_view_building_result;
	CREATE TABLE ad_view_building_result(buildingName varchar(100), `description` text, tags text);

	INSERT INTO ad_view_building_result
    SELECT buildingName, description, tags
    FROM Building NATURAL JOIN (SELECT GROUP_CONCAT(tag SEPARATOR ',') AS tags FROM BuildingTag GROUP BY buildingName) AS tagTable
    WHERE buildingName = i_buildingName;

END //
DELIMITER ;

-- Query #9: ad_update_building [Screen #6 Admin Update Building]
DROP PROCEDURE IF EXISTS ad_update_building;
DELIMITER //
CREATE PROCEDURE ad_update_building(IN i_buildingName VARCHAR(55), IN i_oldBuildingName VARCHAR(55), IN i_description TEXT)
BEGIN

	DELETE FROM BuildingTag WHERE buildingName = i_buildingName;
	UPDATE Building SET buildingName = i_buildingName AND `description` = i_description WHERE buildingName = i_oldBuildingName;

END //
DELIMITER ;

-- Query #10: ad_get_available_building [Screen #7 Admin Create Station]
DROP PROCEDURE IF EXISTS ad_get_available_building;
DELIMITER //
CREATE PROCEDURE ad_get_available_building()
BEGIN
    DROP TABLE IF EXISTS ad_get_available_building_result;
    CREATE TABLE ad_get_available_building_result(buildingName varchar(100));

    INSERT INTO ad_get_available_building_result
    SELECT buildingName
    FROM Building
    WHERE buildingName NOT IN (SELECT buildingName FROM Station);

END //
DELIMITER ;

-- Query #11: ad_create_station [Screen #7 Admin Create Station]
DROP PROCEDURE IF EXISTS ad_create_station;
DELIMITER //
CREATE PROCEDURE ad_create_station(IN i_stationName VARCHAR(100), IN  i_buildingName VARCHAR(100), IN i_capacity INT)
BEGIN

    IF i_buildingName in (
        SELECT buildingName
        FROM ad_get_available_building_result) THEN
        INSERT INTO Station (stationName, buildingName, capacity)
        VALUES (i_stationName,  i_buildingName, i_capacity);
    END IF;

END //
DELIMITER ;

-- Query #12: ad_view_station [Screen #8 Admin Update Station]
DROP PROCEDURE IF EXISTS ad_view_station;
DELIMITER //
CREATE PROCEDURE ad_view_station(IN i_stationName VARCHAR(100))
BEGIN
    DROP TABLE IF EXISTS ad_view_station_result;
    CREATE TABLE ad_view_station_result(stationName varchar(100), capacity int, buildingName varchar(100));

	INSERT INTO ad_view_station_result
    SELECT stationName, capacity, buildingName
    FROM Station
    WHERE stationName = i_stationName;

END //
DELIMITER ;

-- Query #13: ad_update_station [Screen #8 Admin Update Station]
DROP PROCEDURE IF EXISTS ad_update_station;
DELIMITER //
CREATE PROCEDURE ad_update_station(IN i_stationName VARCHAR(100), IN i_capacity INT, IN i_buildingName VARCHAR(100))
BEGIN

    UPDATE Station
    SET capacity = i_capacity, buildingName = i_buildingName
    WHERE stationName = i_stationName;

END //
DELIMITER ;

-- Query #14: ad_filter_food [Screen #9 Admin Manage Food]
DROP PROCEDURE IF EXISTS ad_filter_food;
DELIMITER //
CREATE PROCEDURE ad_filter_food(IN i_foodName VARCHAR(100), IN i_sortedBy ENUM('name', 'menuCount', 'purchaseCount'), IN i_sortDirection ENUM('ASC', 'DESC'))
BEGIN
    DROP TABLE IF EXISTS ad_filter_food_result;
    CREATE TABLE ad_filter_food_result(foodName varchar(100), menuCount int, purchaseCount int);

	INSERT INTO ad_filter_food_result
    SELECT foodName, count(foodName) as menuCount, sum(purchaseQuantity) as purchaseCount
    FROM orderdetail
    WHERE i_foodName = NULL OR foodName = i_foodName
    GROUP BY foodName
    ORDER BY
        CASE WHEN (i_sortedBy = "name" AND (i_sortDirection = "ASC" OR i_sortDirection = NULL)) THEN foodName END ASC,
        CASE WHEN i_sortedBy = "name" AND i_sortDirection = "DESC" THEN foodName END DESC,
		CASE WHEN i_sortedBy = "menuCount" AND (i_sortDirection = "ASC" OR i_sortDirection = NULL) THEN menuCount END ASC,
		CASE WHEN i_sortedBy = "menuCount" AND i_sortDirection = "DESC" THEN menuCount END DESC,
		CASE WHEN i_sortedBy = "purchaseCount" AND (i_sortDirection = "ASC" OR i_sortDirection = NULL) THEN purchaseCount END ASC,
		CASE WHEN i_sortedBy = "purchaseCount" AND i_sortDirection = "DESC" THEN purchaseCount END DESC;

END //
DELIMITER ;

-- Query #15: ad_delete_food [Screen #9 Admin Manage Food]
DROP PROCEDURE IF EXISTS ad_delete_food;
DELIMITER //
CREATE PROCEDURE ad_delete_food(IN i_foodName VARCHAR(100))
BEGIN

    DELETE FROM Food
    WHERE foodName = i_foodName;

END //
DELIMITER ;

-- Query #16: ad_create_food [Screen #10 Admin Create Food]
DROP PROCEDURE IF EXISTS ad_create_food;
DELIMITER //
CREATE PROCEDURE ad_create_food(IN i_foodName VARCHAR(100))
BEGIN

    INSERT INTO Food(foodName)
    VALUES (i_foodName);

END //
DELIMITER ;

-- Query #17: mn_filter_foodTruck [Screen #11 Manager Manage Food Truck]
DROP PROCEDURE IF EXISTS mn_filter_foodTruck;
DELIMITER //
CREATE PROCEDURE mn_filter_foodTruck(IN i_foodTruckName VARCHAR(50), IN i_stationName VARCHAR(50), IN i_minStaffCount INT, IN i_maxStaffCount INT, IN i_hasRemainingCapacity BOOLEAN)
BEGIN
	DROP TABLE IF EXISTS mn_filter_foodTruck_result;
    CREATE TABLE mn_filter_foodTruck_result(foodTruckName varchar(100), stationName varchar(100),
		remainingCapacity int, staffCount int, menuItemCount int);

    -- place your code/solution here

END //
DELIMITER ;

-- Query #18: mn_delete_foodTruck [Screen #11 Manager Manage Food Truck]
DROP PROCEDURE IF EXISTS mn_delete_foodTruck;
DELIMITER //
CREATE PROCEDURE mn_delete_foodTruck(IN i_foodTruckName VARCHAR(50))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #19a: mn_create_foodTruck_add_station [Screen #12 Manager Create Food Truck]
DROP PROCEDURE IF EXISTS mn_create_foodTruck_add_station;
DELIMITER //
CREATE PROCEDURE mn_create_foodTruck_add_station(IN i_foodTruckName VARCHAR(50), IN i_stationName VARCHAR(50), IN i_managerUsername VARCHAR(50))
BEGIN

    -- place your code/solution here
    IF i_stationName in (
        SELECT stationName
        FROM station
        WHERE capacity > 0
        ) THEN
        INSERT INTO FoodTruck (foodTruckName, stationName, managerUsername)
        VALUES (i_foodTruckName, i_stationName, i_managerUsername);
    END IF;

END //
DELIMITER ;

-- Query #19b: mn_create_foodTruck_add_staff [Screen #12 Manager Create Food Truck]
DROP PROCEDURE IF EXISTS mn_create_foodTruck_add_staff;
DELIMITER //
CREATE PROCEDURE mn_create_foodTruck_add_staff(IN i_foodTruckName VARCHAR(50), IN i_staffName VARCHAR(50))
BEGIN

    -- place your code/solution here
    IF i_staffName in (
        SELECT username
        FROM Staff
        WHERE foodTruckName IS NULL
        ) THEN
        UPDATE Staff
        SET foodTruckName = i_foodTruckName
        WHERE Staff.username = i_staffName
    END IF;

END //
DELIMITER ;

-- Query #19c: mn_create_foodTruck_add_menu_item [Screen #12 Manager Create Food Truck]
DROP PROCEDURE IF EXISTS mn_create_foodTruck_add_menu_item;
DELIMITER //
CREATE PROCEDURE mn_create_foodTruck_add_menu_item(IN i_foodTruckName VARCHAR(50), IN i_price INT, IN i_foodName VARCHAR(50))
BEGIN

    -- place your code/solution here
    IF i_foodName NOT IN (
        SELECT foodName
        FROM MenuItem
        WHERE foodTruckName = i_foodTruckName
    ) AND
    i_foodName IN (
        SELECT *
        FROM Food
    )
        THEN
        INSERT INTO MenuItem(price, foodTruckName, foodName)
        VALUES (i_price,i_foodTruckName,i_foodName)
    END IF;

END //
DELIMITER ;

-- Query #20: mn_view_foodTruck_staff [Screen #13 Manager Update Food Truck]
DROP PROCEDURE IF EXISTS mn_view_foodTruck_staff;
DELIMITER //
CREATE PROCEDURE mn_view_foodTruck_staff(IN i_managerUsername VARCHAR(50), i_foodTruckName VARCHAR(50))
BEGIN
	DROP TABLE IF EXISTS mn_view_foodTruck_staff_result;
    CREATE TABLE mn_view_foodTruck_staff_result(foodTruckName varchar(100), stationName varchar(100), assignedStaff varchar(100));

    -- place your code/solution here
    INSERT INTO mn_view_foodTruck_staff_result
    SELECT FoodTruck.FoodTruckName, FoodTruck.stationName, Staff.username
    FROM Staff JOIN FoodTruck on Staff.foodtruckname = FoodTruck.foodtruckname
    WHERE foodtruck.managerUsername = i_managerUsername and foodtruck.foodTruckName = i_foodTruckName;


END //
DELIMITER ;

-- Query #21: mn_view_foodTruck_menu [Screen #13 Manager Update Food Truck]
DROP PROCEDURE IF EXISTS mn_view_foodTruck_menu;
DELIMITER //
CREATE PROCEDURE mn_view_foodTruck_menu(IN i_managerUsername VARCHAR(50), i_foodTruckName VARCHAR(50))
BEGIN
	DROP TABLE IF EXISTS mn_view_foodTruck_menu_result;
    CREATE TABLE mn_view_foodTruck_menu_result(foodTruckName varchar(100), stationName varchar(100),
		foodName varchar(100), price decimal(6,2));

    -- place your code/solution here
    INSERT INTO mn_view_foodTruck_menu_result
    SELECT foodTruck.foodTruckName, stationName, foodName, price
    FROM MenuItem join FoodTruck on MenuItem.foodTruckName = FoodTruck.foodTruckName
    WHERE foodTruck.foodTruckName = i_foodTruckName,foodTruck.managerUsername = i_managerUsername
    ;






END //
DELIMITER ;

-- Query #22a: mn_view_foodTruck_menu [Screen #13 Manager Update Food Truck]
DROP PROCEDURE IF EXISTS mn_update_foodTruck_station;
DELIMITER //
CREATE PROCEDURE mn_update_foodTruck_station(IN i_foodTruckName VARCHAR(50), IN i_stationName VARCHAR(50))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #22b: mn_update_foodTruck_staff [Screen #13 Manager Update Food Truck]
DROP PROCEDURE IF EXISTS mn_update_foodTruck_staff;
DELIMITER //
CREATE PROCEDURE mn_update_foodTruck_staff(IN i_foodTruckName VARCHAR(50), IN i_staffName VARCHAR(50))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #22c: mn_update_foodTruck_menu_item [Screen #13 Manager Update Food Truck]
DROP PROCEDURE IF EXISTS mn_update_foodTruck_menu_item;
DELIMITER //
CREATE PROCEDURE mn_update_foodTruck_menu_item(IN i_foodTruckName VARCHAR(50), IN i_price INT, IN i_foodName VARCHAR(50))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #23: mn_get_station [Screen #14 Manager Food Truck Summary]
DROP PROCEDURE IF EXISTS mn_get_station;
DELIMITER //
CREATE PROCEDURE mn_get_station(IN i_managerUsername VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS mn_get_station_result;
    CREATE TABLE mn_get_station_result(stationName varchar(100));

    -- place your code/solution here

END //
DELIMITER ;

-- Query #24: mn_filter_summary [Screen #14 Manager Food Truck Summary]
DROP PROCEDURE IF EXISTS mn_filter_summary;
DELIMITER //
CREATE PROCEDURE mn_filter_summary(IN i_foodTruckName VARCHAR(50), IN i_stationName VARCHAR(50), IN i_minDate DATE, IN i_maxDate DATE, IN i_sortedBy ENUM('foodTruckName', 'totalOrder', 'totalRevenue', 'totalCustomer'), IN i_sortedDirection ENUM('ASC', 'DESC'))
BEGIN
    DROP TABLE IF EXISTS mn_filter_summary_result;
    CREATE TABLE mn_filter_summary_result(foodTruckName varchar(100), totalOrder int, totalRevenue decimal, totalCustomer int);

    -- place your code/solution here

END //
DELIMITER ;

-- Query #25: mn_summary_detail [Screen #15 Manager Summary Detail]
DROP PROCEDURE IF EXISTS mn_summary_detail;
DELIMITER //
CREATE PROCEDURE mn_summary_detail(IN i_managerUsername VARCHAR(50), IN i_foodTruckName VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS mn_summary_detail_result;
	CREATE TABLE mn_summary_detail_result(`date` date, customerName varchar(100), totalPurchase decimal,
		orderCount int, foodNames text);

    -- place your code/solution here

END //
DELIMITER ;

-- Query #26: cus_filter_explore [Screen #16 Customer Explore]
DROP PROCEDURE IF EXISTS cus_filter_explore;
DELIMITER //
CREATE PROCEDURE cus_filter_explore(IN i_buildingName VARCHAR(50), IN i_stationName VARCHAR(50), IN i_buildingTag VARCHAR(50), IN i_foodTruckName VARCHAR(50), IN i_foodName VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS cus_filter_explore_result;
    CREATE TABLE cus_filter_explore_result(stationName varchar(100), buildingName varchar(100),
		foodTruckNames text, foodNames text);

    -- place your code/solution here

END //
DELIMITER ;

-- Query #27: cus_select_location [Screen #16 Customer Explore]
DROP PROCEDURE IF EXISTS cus_select_location;
DELIMITER //
CREATE PROCEDURE cus_select_location( IN i_customerUsername VARCHAR(50), IN i_stationName VARCHAR(50))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #28: cus_current_information_basic [Screen #17 Customer Current Information]
DROP PROCEDURE IF EXISTS cus_current_information_basic;
DELIMITER //
CREATE PROCEDURE cus_current_information_basic(IN i_customerUsername VARCHAR(55))
BEGIN
    DROP TABLE IF EXISTS cus_current_information_basic_result;
    CREATE TABLE cus_current_information_basic_result(stationName varchar(100), buildingName varchar(100), tags text, `description` text,
		balance decimal);

    -- place your code/solution here

END //
DELIMITER ;

-- Query #29: cus_current_information_foodTruck [Screen #17 Customer Current Information]
DROP PROCEDURE IF EXISTS cus_current_information_foodTruck;
DELIMITER //
CREATE PROCEDURE cus_current_information_foodTruck(IN i_customerUsername VARCHAR(55))
BEGIN
    DROP TABLE IF EXISTS cus_current_information_foodTruck_result;
    CREATE TABLE cus_current_information_foodTruck_result(foodTruckName varchar(100), managerName varchar(100), foodNames text);

    -- place your code/solution here

END //
DELIMITER ;

-- Query #30: cus_current_information_foodTruck [Screen #18 Customer Order]
DROP PROCEDURE IF EXISTS cus_order;
DELIMITER //
CREATE PROCEDURE cus_order(IN i_date DATE, i_customerUsername VARCHAR(55))
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #31: cus_add_item_to_order [Screen #18 Customer Order]
DROP PROCEDURE IF EXISTS cus_add_item_to_order;
DELIMITER //
CREATE PROCEDURE cus_add_item_to_order(IN i_foodTruckName VARCHAR(55), i_foodName VARCHAR(55), i_purchaseQuantity INT)
BEGIN

    -- place your code/solution here

END //
DELIMITER ;

-- Query #32: cus_order_history [Screen #19 Customer Order History]
DROP PROCEDURE IF EXISTS cus_order_history;
DELIMITER //
CREATE PROCEDURE cus_order_history(IN i_customerUsername VARCHAR(55))
BEGIN
	DROP TABLE IF EXISTS cus_order_history_result;
    CREATE TABLE cus_order_history_result(`date` date, orderID char(10), orderTotal decimal(6,2),
		foodNames varchar(100), foodQuantity int);

    -- place your code/solution here
    INSERT INTO cus_order_history

    SELECT date,
    orderID,
    sum(purchaseQuantity*price),
    GROUP_CONCAT(orderdetail.foodName),
    sum(purchaseQuantity)

    FROM (orderdetail NATURAL JOIN orders) INNER JOIN menuitem ON
    orderdetail.foodTruckName = menuitem.foodTruckName
    AND
    orderdetail.foodName = menuitem.foodName
    WHERE customerUsername = i_customerUsername
    GROUP BY orderID
    ;
END //
DELIMITER ;
