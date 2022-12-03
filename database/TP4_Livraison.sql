CREATE TABLE IF NOT EXISTS Client(
	numeroclient SERIAL PRIMARY KEY,
	nomclient VARCHAR(20),
	prenomclient VARCHAR(20),
	adressecourrielclient VARCHAR(40),
	rueclient VARCHAR(30), 
	villeclient VARCHAR(30), 
	codepostalclient VARCHAR(10)
); 

CREATE TABLE IF NOT EXISTS Telephone(
	numerodetelephone CHAR(10), 
	numeroclient SERIAL,
	PRIMARY KEY (numerodetelephone, numeroclient),
	FOREIGN KEY (numeroclient) REFERENCES Client ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numerofournisseur SERIAL PRIMARY KEY, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(70)
);

CREATE TABLE IF NOT EXISTS Planrepas(
	numeroplan SERIAL PRIMARY KEY, 
	categorie VARCHAR(16) DEFAULT 'Végétarien', 
	frequence NUMERIC(2, 0), /*Nombre de fois par semaines, maximum 14 fois par semaines (2 fois par jour)*/
	nbrpersonnes NUMERIC(1,0), /*nombre de personnes ajoute à ce plan (de 1 à 9)*/
	nbrcalories NUMERIC(6,0), /*nombre de calories maximum 999,999 Kcl*/
	prix NUMERIC(6, 2) NULL, /*prix maximum 9,999.99 $*/
	numerofournisseur SERIAL NOT NULL REFERENCES Fournisseur ON DELETE CASCADE,
	CONSTRAINT prix CHECK (prix IS NOT NULL AND prix > 0),
	CONSTRAINT frequence CHECK (frequence > 0 AND frequence <= 14),
	CONSTRAINT nbrpersonnes CHECK (nbrpersonnes > 0 AND nbrpersonnes <= 9),
	CONSTRAINT categorie CHECK (categorie IN ('Végétarien', 'Pescétarien', 'Famille', 'Famille - Facile', 'Famille - Rapide'))
);

CREATE TABLE IF NOT EXISTS Abonner(
	numeroplan SERIAL, 
	numeroclient SERIAL, 
	duree NUMERIC(3, 0) NOT NULL, /*Nombres de semaines, jusqu'à 999 semaines*/
	PRIMARY KEY (numeroplan, numeroclient),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas ON DELETE CASCADE,
	FOREIGN KEY (numeroclient) REFERENCES Client ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Pescetarien(
	numeroplan SERIAL PRIMARY KEY,
	typepoisson VARCHAR(40),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Vegetarien(
	numeroplan SERIAL PRIMARY KEY,
	typederepas VARCHAR(60),
	FOREIGN KEY (numeroplan) REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Famille(
	numeroplan SERIAL PRIMARY KEY,
	FOREIGN KEY (numeroplan) REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Rapide (
	numeroplan SERIAL PRIMARY KEY,
	tempsdepreparation NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	FOREIGN KEY (numeroplan) REFERENCES Famille ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Facile(
	numeroplan SERIAL PRIMARY KEY,
	nbringredients NUMERIC(2,0), 
	FOREIGN KEY (numeroplan) REFERENCES Famille ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Kitrepas(
	numerokitrepas SERIAL PRIMARY KEY,
	description VARCHAR(100),
	numeroplan SERIAL NOT NULL REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Image(
	numeroimage SERIAL PRIMARY KEY, 
	donnees VARCHAR(40), 
	numerokitrepas SERIAL NOT NULL REFERENCES Kitrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Ingredient(
	numeroingredient SERIAL PRIMARY KEY, 
	nomingredient VARCHAR(20), 
	paysingredient VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Contenir(
	numeroingredient SERIAL, 
	numerokitrepas SERIAL,
	PRIMARY KEY (numeroingredient, numerokitrepas),
	FOREIGN KEY(numeroingredient) REFERENCES Ingredient ON DELETE CASCADE,
	FOREIGN KEY(numerokitrepas) REFERENCES Kitrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Etape(
	numeroetape SERIAL,
	numerokitrepas SERIAL, 
	descriptionetape VARCHAR(150), 
	dureeetape NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	PRIMARY KEY (numeroetape, numerokitrepas),
	etapeêtrecomposee INTEGER,
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas ON DELETE CASCADE
);

INSERT INTO Client VALUES (DEFAULT, 'Bouthiba', 'Rayane', 'rayane@gmail.com', 'Edouard-Montpetit', 'Montreal', 'H3T1J4');
INSERT INTO Client VALUES (DEFAULT, 'Apostu', 'Robert', 'robert@gmail.com', 'Edouard-Montpetit', 'Montreal', 'H3T1J4');

INSERT INTO Telephone VALUES ('1234567891', 1);
INSERT INTO Telephone VALUES ('1987654321', 2);

INSERT INTO Fournisseur VALUES (DEFAULT, 'Fournisseur 1', '123 rue Cote-des-nêiges, Montréal');
INSERT INTO Fournisseur VALUES (DEFAULT, 'Fournisseur 2', '321 rue Cote-des-nêiges, Montréal');

INSERT INTO Planrepas VALUES (DEFAULT, 'Famille', 1, 3, 500, 20, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille', 2, 3, 500, 25, 2);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Rapide', 1, 4, 500, 32, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Rapide', 3, 3, 500, 33, 2);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Facile', 3, 5, 500, 30, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Facile', 5, 4, 500, 31, 2);
INSERT INTO Planrepas VALUES (DEFAULT, 'Végétarien', 1, 3, 500, 24, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Végétarien', 3, 4, 500, 23, 2);
INSERT INTO Planrepas VALUES (DEFAULT, 'Pescétarien', 2, 5, 500, 23, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Pescétarien', 3, 2, 500, 22, 2);

INSERT INTO Abonner VALUES (1, 1, 4);
INSERT INTO Abonner VALUES (2, 2, 2);

INSERT INTO Pescetarien VALUES (9, 'Saumon');
INSERT INTO Pescetarien VALUES (10, 'Sardine');

INSERT INTO Vegetarien VALUES (7, 'mexicain');
INSERT INTO Vegetarien VALUES (8, 'méditerranéen');

INSERT INTO Famille VALUES (1);
INSERT INTO Famille VALUES (2);
INSERT INTO Famille VALUES (3);
INSERT INTO Famille VALUES (4);
INSERT INTO Famille VALUES (5);
INSERT INTO Famille VALUES (6);

INSERT INTO Rapide VALUES (3);
INSERT INTO Rapide VALUES (4);

INSERT INTO Facile VALUES (5);
INSERT INTO Facile VALUES (6);

INSERT INTO Kitrepas VALUES (DEFAULT, 'Kit repas pour le plan 1', 1);
INSERT INTO Kitrepas VALUES (DEFAULT, 'Kit repas pour le plan 2', 2);

INSERT INTO Image VALUES (DEFAULT, 'Image pour le kit 1', 1);
INSERT INTO Image VALUES (DEFAULT, 'Image pour le kit 2', 2);

INSERT INTO Ingredient VALUES (DEFAULT, 'Poisson', 'Italie');
INSERT INTO Ingredient VALUES (DEFAULT, 'Boeuf', 'Holland');

INSERT INTO Contenir VALUES (1, 1);
INSERT INTO Contenir VALUES (2, 2);

INSERT INTO Etape VALUES (DEFAULT, 1, 'Cuire le poisson', 15, NULL);
INSERT INTO Etape VALUES (default, 2, 'Cuire la viande', 20, NULL);

/*
-- https://www.w3schools.com/sql/sql_datatypes.asp
*/

/*
DROP TABLE Client CASCADE;
DROP TABLE Fournisseur CASCADE;
DROP TABLE Planrepas CASCADE;
DROP TABLE Kitrepas CASCADE;
DROP TABLE Ingredient CASCADE;
DROP TABLE Image CASCADE;
DROP TABLE Famille CASCADE;
DROP TABLE Rapide CASCADE;
DROP TABLE Facile CASCADE;
DROP TABLE Vegetarien CASCADE;
DROP TABLE Pescetarien CASCADE;
DROP TABLE Telephone CASCADE;
DROP TABLE Etape CASCADE;
DROP TABLE Contenir CASCADE;
DROP TABLE Abonner CASCADE;
*/
