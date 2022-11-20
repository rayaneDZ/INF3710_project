CREATE TABLE IF NOT EXISTS Client(
	numéroclient SERIAL PRIMARY KEY,
	nomclient VARCHAR(20),
	prénomclient VARCHAR(20),
	adressecourrielclient VARCHAR(40),
	rueclient VARCHAR(30), 
	villeclient VARCHAR(30), 
	codepostalclient VARCHAR(10)
); 

CREATE TABLE IF NOT EXISTS Téléphone(
	numérodetéléphone CHAR(10), 
	numéroclient SERIAL,
	PRIMARY KEY (numérodetéléphone, numéroclient),
	FOREIGN KEY (numéroclient) REFERENCES Client ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numérofournisseur SERIAL PRIMARY KEY, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(70)
);

CREATE TABLE IF NOT EXISTS Planrepas(
	numéroplan SERIAL PRIMARY KEY, 
	catégorie VARCHAR(16) DEFAULT 'Végétarien', 
	fréquence NUMERIC(2, 0), /*Nombre de fois par semaines, maximum 14 fois par semaines (2 fois par jour)*/
	nbrpersonnes NUMERIC(1,0), /*nombre de personnes ajouté à ce plan (de 1 à 9)*/
	nbrcalories NUMERIC(6,0), /*nombre de calories maximum 999,999 Kcl*/
	prix NUMERIC(6, 2) NULL, /*prix maximum 9,999.99 $*/
	numérofournisseur SERIAL NOT NULL REFERENCES Fournisseur ON DELETE CASCADE,
	CONSTRAINT prix CHECK (prix IS NOT NULL AND prix > 0),
	CONSTRAINT fréquence CHECK (fréquence > 0 AND fréquence <= 14),
	CONSTRAINT nbrpersonnes CHECK (nbrpersonnes > 0 AND nbrpersonnes <= 9),
	CONSTRAINT catégorie CHECK (catégorie IN ('Végétarien', 'Pescétarien', 'Famille', 'Famille - Facile', 'Famille - Rapide'))
);

CREATE TABLE IF NOT EXISTS Abonner(
	numéroplan SERIAL, 
	numéroclient SERIAL, 
	durée NUMERIC(3, 0) NOT NULL, /*Nombres de semaines, jusqu'à 999 semaines*/
	PRIMARY KEY (numéroplan, numéroclient),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas ON DELETE CASCADE,
	FOREIGN KEY (numéroclient) REFERENCES Client ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Pescétarien(
	numéroplan SERIAL PRIMARY KEY,
	typepoisson VARCHAR(40),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Végétarien(
	numéroplan SERIAL PRIMARY KEY,
	typederepas VARCHAR(60),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Famille(
	numéroplan SERIAL PRIMARY KEY,
	FOREIGN KEY (numéroplan) REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Rapide (
	numéroplan SERIAL PRIMARY KEY,
	tempsdepréparation NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	FOREIGN KEY (numéroplan) REFERENCES Famille ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Facile(
	numéroplan SERIAL PRIMARY KEY,
	nbringrédients NUMERIC(2,0), 
	FOREIGN KEY (numéroplan) REFERENCES Famille ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Kitrepas(
	numérokitrepas SERIAL PRIMARY KEY,
	description VARCHAR(100),
	numéroplan SERIAL NOT NULL REFERENCES Planrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Image(
	numéroimage SERIAL PRIMARY KEY, 
	données VARCHAR(40), 
	numérokitrepas SERIAL NOT NULL REFERENCES Kitrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Ingrédient(
	numéroingrédient SERIAL PRIMARY KEY, 
	nomingrédient VARCHAR(20), 
	paysingrédient VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Contenir(
	numéroingrédient SERIAL, 
	numérokitrepas SERIAL,
	PRIMARY KEY (numéroingrédient, numérokitrepas),
	FOREIGN KEY(numéroingrédient) REFERENCES Ingrédient ON DELETE CASCADE,
	FOREIGN KEY(numérokitrepas) REFERENCES Kitrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Étape(
	numéroétape SERIAL,
	numérokitrepas SERIAL NOT NULL, 
	descriptionétape VARCHAR(150), 
	duréeétape NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	PRIMARY KEY (numéroétape, numérokitrepas),
	étapeêtrecomposée INTEGER,
	FOREIGN KEY (numérokitrepas) REFERENCES Kitrepas ON DELETE CASCADE
);

INSERT INTO Client VALUES (DEFAULT, 'Bouthiba', 'Rayane', 'rayane@gmail.com', 'Edouard-Montpetit', 'Montreal', 'H3T1J4');
INSERT INTO Client VALUES (DEFAULT, 'Apostu', 'Robert', 'robert@gmail.com', 'Edouard-Montpetit', 'Montreal', 'H3T1J4');

INSERT INTO Téléphone VALUES ('1234567891', 1);
INSERT INTO Téléphone VALUES ('1987654321', 2);

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

INSERT INTO Pescétarien VALUES (9, 'Saumon');
INSERT INTO Pescétarien VALUES (10, 'Sardine');

INSERT INTO Végétarien VALUES (7, 'mexicain');
INSERT INTO Végétarien VALUES (8, 'méditerranéen');

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

INSERT INTO Ingrédient VALUES (DEFAULT, 'Poisson', 'Italie');
INSERT INTO Ingrédient VALUES (DEFAULT, 'Boeuf', 'Holland');

INSERT INTO Contenir VALUES (1, 1);
INSERT INTO Contenir VALUES (2, 2);

INSERT INTO Étape VALUES (DEFAULT, 1, 'Cuire le poisson', 15, NULL);
INSERT INTO Étape VALUES (default, 2, 'Cuire la viande', 20, NULL);

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
