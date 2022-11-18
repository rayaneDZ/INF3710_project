CREATE TABLE IF NOT EXISTS Client(
	numéroclient CHAR(6) PRIMARY KEY,
	nomclient VARCHAR(20),
	prénomclient VARCHAR(20),
	adressecourrielclient VARCHAR(40),
	rueclient VARCHAR(30), 
	villeclient VARCHAR(30), 
	codepostalclient VARCHAR(10)
); 

CREATE TABLE IF NOT EXISTS Téléphone(
	numérodetéléphone CHAR(10), 
	numéroclient CHAR(6),
	PRIMARY KEY (numérodetéléphone, numéroclient),
	FOREIGN KEY (numéroclient) REFERENCES Client
);

CREATE TABLE IF NOT EXISTS Fournisseur(
	numérofournisseur CHAR(6) PRIMARY KEY, 
	nomfournisseur VARCHAR(20),
	adressefournisseur VARCHAR(70)
);

CREATE DOMAIN typesDeCatégories AS CHAR
    CHECK (VALUE IN ('Végétarien', 'Pescétarien', 'Famille - Facile', 'Famille - Rapid'));

CREATE TABLE IF NOT EXISTS Planrepas(
	numéroplan CHAR(6) PRIMARY KEY, 
	catégorie typesDeCatégories DEFAULT 'Végétarien', 
	fréquence NUMERIC(2, 0), /*Nombre de fois par semaines, maximum 14 fois par semaines (2 fois par jour)*/
	nbrpersonnes NUMERIC(1,0), /*nombre de personnes ajouté à ce plan (de 1 à 9)*/
	nbrcalories NUMERIC(6,0), /*nombre de calories maximum 999,999 Kcl*/
	prix NUMERIC(6, 0) NULL, /*prix maximum 999,999 $*/
	numérofournisseur CHAR(6) NOT NULL REFERENCES Fournisseur,
	CONSTRAINT prix CHECK (prix IS NOT NULL AND prix > 0),
	CONSTRAINT fréquence CHECK (fréquence > 0 AND fréquence =< 14),
	CONSTRAINT nbrpersonnes CHECK (nbrpersonnes > 0 AND nbrpersonnes =< 9)
);

CREATE TABLE IF NOT EXISTS Abonner(
	numéroplan CHAR(6), 
	numéroclient CHAR(6), 
	durée NUMERIC(4, 0) NOT NULL, /*Nombres de semaines*/
	PRIMARY KEY (numéroplan, numéroclient),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas,
	FOREIGN KEY (numéroclient) REFERENCES Client
);

CREATE TABLE IF NOT EXISTS Pescétarien(
	numéroplan CHAR(6) PRIMARY KEY,
	typepoisson VARCHAR(40),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
);

CREATE TABLE IF NOT EXISTS Végétarien(
	numéroplan CHAR(6) PRIMARY KEY,
	typederepas VARCHAR(60),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
);

CREATE TABLE IF NOT EXISTS Famille(
	numéroplan CHAR(6) PRIMARY KEY,
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
);

CREATE TABLE IF NOT EXISTS Rapide (
	numéroplan CHAR(6) PRIMARY KEY,
	tempsdepréparation NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	FOREIGN KEY (numéroplan) REFERENCES Famille
);

CREATE TABLE IF NOT EXISTS Facile(
	numéroplan CHAR(6) PRIMARY KEY,
	nbringrédients NUMERIC(2,0), 
	FOREIGN KEY (numéroplan) REFERENCES Famille
);

CREATE TABLE IF NOT EXISTS Kitrepas(
	numérokitrepas CHAR(6) PRIMARY KEY,
	description VARCHAR(100),
	numéroplan CHAR(6) NOT NULL REFERENCES Planrepas	
);

CREATE TABLE IF NOT EXISTS Image(
	numéroimage CHAR(6) PRIMARY KEY, 
	données VARCHAR(40), 
	numérokitrepas CHAR(6) NOT NULL REFERENCES Kitrepas
);

CREATE TABLE IF NOT EXISTS Ingrédient(
	numéroingrédient CHAR(6) PRIMARY KEY, 
	nomingrédient VARCHAR(20), 
	paysingrédient VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Contenir(
	numéroingrédient CHAR(6), 
	numérokitrepas CHAR(6),
	PRIMARY KEY (numéroingrédient, numérokitrepas),
	FOREIGN KEY(numéroingrédient) REFERENCES Ingrédient,
	FOREIGN KEY(numérokitrepas) REFERENCES Kitrepas
);

CREATE TABLE IF NOT EXISTS Étape(
	numéroétape CHAR(6),
	numérokitrepas CHAR(6) NOT NULL, 
	descriptionétape VARCHAR(150), 
	duréeétape NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	étapeêtrecomposée CHAR(12) REFERENCES Étape,
	FOREIGN KEY (numérokitrepas) REFERENCES Kitrepas,
	PRIMARY KEY (numéroétape, numérokitrepas)
);

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
