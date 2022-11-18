CREATE TABLE IF NOT EXISTS Client(
	numéroclient CHAR(4) PRIMARY KEY,
	nomclient VARCHAR(20),
	prénomclient VARCHAR(20),
	adressecourrielclient VARCHAR(40),
	rueclient VARCHAR(30), 
	villeclient VARCHAR(30), 
	codepostalclient VARCHAR(10)
); 

CREATE TABLE IF NOT EXISTS Téléphone(
	numérodetéléphone CHAR(10), 
	numéroclient CHAR(4),
	PRIMARY KEY (numérodetéléphone, numéroclient),
	FOREIGN KEY (numéroclient) REFERENCES Client
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numérofournisseur CHAR(4) PRIMARY KEY, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(70)
);

CREATE DOMAIN typesDeCatégories AS CHAR
    CHECK (VALUE IN ('Végétarien', 'Pescétarien', 'Famille', 'Famille - Facile', 'Famille - Rapid'));

CREATE TABLE IF NOT EXISTS Planrepas(
	numéroplan CHAR(4) PRIMARY KEY, 
	catégorie typesDeCatégories DEFAULT 'Végétarien', 
	fréquence NUMERIC(2, 0), /*Nombre de fois par semaines, maximum 14 fois par semaines (2 fois par jour)*/
	nbrpersonnes NUMERIC(1,0), /*nombre de personnes ajouté à ce plan (de 1 à 9)*/
	nbrcalories NUMERIC(6,0), /*nombre de calories maximum 999,999 Kcl*/
	prix NUMERIC(6, 2) NULL, /*prix maximum 9,999.99 $*/
	numérofournisseur CHAR(4) NOT NULL REFERENCES Fournisseur,
	CONSTRAINT prix CHECK (prix IS NOT NULL AND prix > 0),
	CONSTRAINT fréquence CHECK (fréquence > 0 AND fréquence =< 14),
	CONSTRAINT nbrpersonnes CHECK (nbrpersonnes > 0 AND nbrpersonnes =< 9)
);

CREATE TABLE IF NOT EXISTS Abonner(
	numéroplan CHAR(4), 
	numéroclient CHAR(4), 
	durée NUMERIC(3, 0) NOT NULL, /*Nombres de semaines, jusqu'à 999 semaines*/
	PRIMARY KEY (numéroplan, numéroclient),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas,
	FOREIGN KEY (numéroclient) REFERENCES Client
);

CREATE TABLE IF NOT EXISTS Pescétarien(
	numéroplan CHAR(4) PRIMARY KEY,
	typepoisson VARCHAR(40),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
);

CREATE TABLE IF NOT EXISTS Végétarien(
	numéroplan CHAR(4) PRIMARY KEY,
	typederepas VARCHAR(60),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
);

CREATE TABLE IF NOT EXISTS Famille(
	numéroplan CHAR(4) PRIMARY KEY,
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
);

CREATE TABLE IF NOT EXISTS Rapide (
	numéroplan CHAR(4) PRIMARY KEY,
	tempsdepréparation NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	FOREIGN KEY (numéroplan) REFERENCES Famille
);

CREATE TABLE IF NOT EXISTS Facile(
	numéroplan CHAR(4) PRIMARY KEY,
	nbringrédients NUMERIC(2,0), 
	FOREIGN KEY (numéroplan) REFERENCES Famille
);

CREATE TABLE IF NOT EXISTS Kitrepas(
	numérokitrepas CHAR(4) PRIMARY KEY,
	description VARCHAR(100),
	numéroplan CHAR(4) NOT NULL REFERENCES Planrepas	
);

CREATE TABLE IF NOT EXISTS Image(
	numéroimage CHAR(4) PRIMARY KEY, 
	données VARCHAR(40), 
	numérokitrepas CHAR(4) NOT NULL REFERENCES Kitrepas
);

CREATE TABLE IF NOT EXISTS Ingrédient(
	numéroingrédient CHAR(4) PRIMARY KEY, 
	nomingrédient VARCHAR(20), 
	paysingrédient VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Contenir(
	numéroingrédient CHAR(4), 
	numérokitrepas CHAR(4),
	PRIMARY KEY (numéroingrédient, numérokitrepas),
	FOREIGN KEY(numéroingrédient) REFERENCES Ingrédient,
	FOREIGN KEY(numérokitrepas) REFERENCES Kitrepas
);

CREATE TABLE IF NOT EXISTS Étape(
	numéroétape CHAR(4),
	numérokitrepas CHAR(4) NOT NULL, 
	descriptionétape VARCHAR(150), 
	duréeétape NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	étapeêtrecomposée CHAR(12) REFERENCES Étape,
	FOREIGN KEY (numérokitrepas) REFERENCES Kitrepas,
	PRIMARY KEY (numéroétape, numérokitrepas)
);

INSERT INTO Client VALUES ("C001", "Bouthiba", "Rayane", "rayane@gmail.com", "Edouard-Montpetit", "Montreal", "H3T1J4");
INSERT INTO Client VALUES ("C002", "Apostu", "Robert", "robert@gmail.com", "Edouard-Montpetit", "Montreal", "H3T1J4");

INSERT INTO Téléphone VALUES ("1234567891", "C001");
INSERT INTO Téléphone VALUES ("1987654321", "C002");

INSERT INTO Fournisseur VALUES ("F001", "Fournisseur 1", "123 rue Cote-des-nêiges, Montréal");
INSERT INTO Fournisseur VALUES ("F002", "Fournisseur 2", "321 rue Cote-des-nêiges, Montréal");

INSERT INTO Planrepas VALUES ("P001", "Famille", 1, 3, 500, 20, "F001");
INSERT INTO Planrepas VALUES ("P002", "Famille", 2, 3, 500, 25, "F002");
INSERT INTO Planrepas VALUES ("P003", "Famille - Rapide", 1, 4, 500, 32, "F001");
INSERT INTO Planrepas VALUES ("P004", "Famille - Rapide", 3, 3, 500, 33, "F002");
INSERT INTO Planrepas VALUES ("P005", "Famille - Facile", 3, 5, 500, 30, "F001");
INSERT INTO Planrepas VALUES ("P006", "Famille - Facile", 5, 4, 500, 31, "F002");
INSERT INTO Planrepas VALUES ("P007", "Végétarien", 1, 3, 500, 24, "F001");
INSERT INTO Planrepas VALUES ("P008", "Végétarien", 3, 4, 500, 23, "F002");
INSERT INTO Planrepas VALUES ("P009", "Pescétarien", 2, 5, 500, 23, "F001");
INSERT INTO Planrepas VALUES ("P010", "Pescétarien", 3, 2, 500, 22, "F002");

INSERT INTO Abonner VALUES ("P001", "C001", 4);
INSERT INTO Abonner VALUES ("P002", "C002", 2);

INSERT INTO Pescétarien VALUES ("P009", "Saumon");
INSERT INTO Pescétarien VALUES ("P010", "Sardine");

INSERT INTO Végétarien VALUES ("P007", "mexicain");
INSERT INTO Végétarien VALUES ("P008", "méditerranéen");

/*
-- https://www.w3schools.com/sql/sql_datatypes.asp
*/

/*
DROP TABLE Client CASCADE;
DROP TABLE Fournisseur CASCADE;
DROP TABLE Planrepas CASCADE;
DROP TABLE Kitrepas CASCADE;
DROP TABLE Ingrédient CASCADE;
DROP TABLE Image CASCADE;
DROP TABLE Famille CASCADE;
DROP TABLE Rapide CASCADE;
DROP TABLE Facile CASCADE;
DROP TABLE Végétarien CASCADE;
DROP TABLE Pescétarien CASCADE;
DROP TABLE Téléphone CASCADE;
DROP TABLE Étape CASCADE;
DROP TABLE Contenir CASCADE;
DROP TABLE Abonner CASCADE;
*/
