CREATE TABLE IF NOT EXISTS Client(
	numéroclient CHAR(6) PRIMARY KEY,
	nomclient VARCHAR(20),
	prénomclient VARCHAR(20),
	adressecourrielclient VARCHAR(40), 
	rueclient VARCHAR(30), 
	villeclient VARCHAR(30), 
	codepostalclient VARCHAR(10)
); 

CREATE TABLE IF NOT EXISTS Fournisseur(
	numérofournisseur CHAR(6) PRIMARY KEY, 
	nomfournisseur VARCHAR(20), 
	adressefournisseur VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Planrepas(
	numéroplan CHAR(6) PRIMARY KEY, 
	catégorie VARCHAR(20), 
	fréquence VARCHAR(100), 
	nbrpersonnes NUMERIC(3,0), 
	nbrcalories NUMERIC(6,0),
	prix NUMERIC(6, 0) NULL,
	CONSTRAINT prix CHECK (prix IS NOT NULL AND prix > 0),
	numérofournisseur CHAR(6) NOT NULL REFERENCES Fournisseur
);

CREATE TABLE IF NOT EXISTS Kitrepas(
	numérokitrepas CHAR(6) PRIMARY KEY,
	description VARCHAR(50),
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

CREATE TABLE IF NOT EXISTS Famille(
	numéroplan CHAR(6) PRIMARY KEY,
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
	/*
	Famille(numéroplan)
PK : numéroplan
FK : numéroplan ref Planrepas
	*/
);

CREATE TABLE IF NOT EXISTS Rapide (
	numéroplan CHAR(6) PRIMARY KEY,
	tempsdepréparation NUMERIC(3,2),  --> On suppose que le temps de prép. est en minutes. Donc on peut avoir ex: 150,30 min c-à-d 150 min et 30 secondes
	FOREIGN KEY (numéroplan) REFERENCES Famille
	/*
	Rapide(numéroplan, tempsdepréparation)
		PK : numéroplan
		FK : numéroplan ref Famille */
);

CREATE TABLE IF NOT EXISTS Facile(
	numéroplan CHAR(6) PRIMARY KEY,
	nbringrédients NUMERIC(2,0), 
	FOREIGN KEY (numéroplan) REFERENCES Famille
	/* Facile(numéroplan, nbringrédients)
		PK : numéroplan
		FK : numéroplan ref Famille*/
);

CREATE TABLE IF NOT EXISTS Végétarien(
	numéroplan CHAR(6) PRIMARY KEY,
	typederepas VARCHAR(60),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas
/*
Végétarien(numéroplan, typederepas)
PK : numéroplan
FK : numéroplan ref Planrepas
*/
);

CREATE TABLE IF NOT EXISTS Pescétarien(
	numéroplan CHAR(6) PRIMARY KEY,
	typepoisson VARCHAR(40),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas	
	/* 
	Pescétarien(numéroplan, typepoisson)
	PK : numéroplan
	FK : numéroplan ref Planrepas*/
);

CREATE TABLE IF NOT EXISTS Téléphone(
	numérodetéléphone NUMERIC(10,0), 
	numéroclient CHAR(6),
	PRIMARY KEY (numérodetéléphone, numéroclient),
	FOREIGN KEY (numéroclient) REFERENCES Client
/*
Téléphone(numérodetéléphone, numéroclient)
PK : (numérodetéléphone, numéroclient)
FK : numéroclient ref Client	
*/
);

CREATE TABLE IF NOT EXISTS Étape(
	numérokitrepas CHAR(6), 
	descriptionétape VARCHAR(150), 
	duréeétape NUMERIC(3,0), --> On suppose que le temps de prép. est en minutes. Donc on peut avoir ex: 150 min
	numérokitrepasêtrecomposée CHAR(6) REFERENCES Étape,
	PRIMARY KEY (numérokitrepas),
	FOREIGN KEY (numérokitrepas) REFERENCES Kitrepas
/*
Étape(numérokitrepas, descriptionétape, duréeétape, numérokitrepasêtrecomposée)
PK : numérokitrepas
FK : numérokitrepas ref Kitrepas
*/
);

CREATE TABLE IF NOT EXISTS Contenir(
	numéroingrédient CHAR(6), 
	numérokitrepas CHAR(6),
	PRIMARY KEY (numéroingrédient, numérokitrepas),
	FOREIGN KEY(numéroingrédient) REFERENCES Ingrédient,
	FOREIGN KEY(numérokitrepas) REFERENCES Kitrepas

/*
Contenir(numéroingrédient, numérokitrepas)
PK : (numéroingrédient, numérokitrepas)
FK : numérokitrepas ref Kitrepas
FK : numéroingrédient ref Ingrédient	
*/
);

CREATE TABLE IF NOT EXISTS Abonner(
	numéroplan CHAR(6), 
	numéroclient CHAR(6), 
	durée NUMERIC(3,2) NOT NULL, 
	PRIMARY KEY (numéroplan, numéroclient),
	FOREIGN KEY (numéroplan) REFERENCES Planrepas,
	FOREIGN KEY (numéroclient) REFERENCES Client
	
/*
Abonner(numéroplan, numéroclient, durée)
PK : (numéroplan, numéroclient)
FK : numéroplan ref Planrepas
FK : numéroclient ref Client
NN durée
*/
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
