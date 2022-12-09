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
	nbrpersonnes NUMERIC(1,0), /*nombre de personnes ajouté à ce plan (de 1 à 9)*/
	nbrcalories NUMERIC(6,0), /*nombre de calories maximum 999,999 Kcl*/
	prix NUMERIC(6, 2) NULL, /*prix maximum 9,999.99 $*/
	numerofournisseur SERIAL NOT NULL REFERENCES Fournisseur ON DELETE CASCADE,
	CONSTRAINT prix CHECK (prix IS NOT NULL AND prix > 0),
	CONSTRAINT frequence CHECK (frequence > 0 AND frequence <= 14),
	CONSTRAINT nbrpersonnes CHECK (nbrpersonnes > 0 AND nbrpersonnes <= 9),
	CONSTRAINT categorie CHECK (categorie IN ('Végétarien', 'Pescétarien', 'Famille', 'Famille - Facile', 'Famille - Rapide', 'Cétogène'))
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
	numeroIngredient SERIAL PRIMARY KEY, 
	nomIngredient VARCHAR(20), 
	paysIngredient VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Contenir(
	numeroIngredient SERIAL, 
	numerokitrepas SERIAL,
	PRIMARY KEY (numeroIngredient, numerokitrepas),
	FOREIGN KEY(numeroIngredient) REFERENCES Ingredient ON DELETE CASCADE,
	FOREIGN KEY(numerokitrepas) REFERENCES Kitrepas ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Etape(
	numeroetape SERIAL,
	numerokitrepas SERIAL, 
	descriptionetape VARCHAR(150), 
	dureeetape NUMERIC(3,0), /*En minutes, de 0 à 999 minutes*/ 
	PRIMARY KEY (numeroetape, numerokitrepas),
	etapeêtrecomposée INTEGER,
	FOREIGN KEY (numerokitrepas) REFERENCES Kitrepas ON DELETE CASCADE
);

--Client: numeroclient, nomclient, prenomclient, adressecourriel, rue, ville, codepostal
INSERT INTO Client VALUES (DEFAULT, 'Bouthiba', 'Rayane', 'rayane@gmail.com', 'Edouard-Montpetit', 'Montreal', 'H3T1J4');
INSERT INTO Client VALUES (DEFAULT, 'Apostu', 'Robert', 'robert@gmail.com', 'Edouard-Montpetit', 'Montreal', 'H3T1J4');
INSERT INTO Client VALUES (DEFAULT, 'Martel', 'Allo', 'sylvain@gmail.com', '123 rue Sherbrooke', 'Montreal', 'H3T1J4');
INSERT INTO Client VALUES (DEFAULT, 'Rousseau', 'elise', 'rousseau@gmail.com', '123 rue Sherbrooke', 'Montreal', 'H3T1J4');
INSERT INTO Client VALUES (DEFAULT, 'Thor', 'ulir', 'rousseau@gmail.com', '123 rue Sherbrooke', 'Montreal', 'H3T1J4');


INSERT INTO Telephone VALUES ('1234567891', 1); -- numerotelephone, numeroclient
INSERT INTO Telephone VALUES ('1987654321', 2);

--Fournisseur: numerofournisseur, nomfournisseur, adressefournisseur
INSERT INTO Fournisseur VALUES (DEFAULT, 'Fournisseur 1', '123 rue Cote-des-nêiges, Montréal');
INSERT INTO Fournisseur VALUES (DEFAULT, 'AB Transport', '321 rue Cote-des-nêiges, Montréal');
INSERT INTO Fournisseur VALUES (DEFAULT, 'QC Transport', '234 rue Sherbrooke, Montréal');
INSERT INTO Fournisseur VALUES (DEFAULT, 'Benjamin', 'Montreal');
INSERT INTO Fournisseur VALUES (DEFAULT, NULL, '12 rue Sherbrooke E, Montréal');
INSERT INTO Fournisseur VALUES (DEFAULT, NULL, '34 rue Sherbrooke E, Montréal');

--Planrepas: numeroplan, categorie, frequence, nbrpersonnes, nbrcalories, prix, numerofournisseur
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille', 1, 3, 500, 15, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Cétogène', 2, 3, 500, 25, 2);
INSERT INTO Planrepas VALUES (DEFAULT, 'Cétogène', 3, 3, 500, 38, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Rapide', 1, 4, 500, 32, 3);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Rapide', 3, 3, 500, 33, 3);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Facile', 3, 5, 500, 30, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Facile', 5, 4, 500, 31, 2);
INSERT INTO Planrepas VALUES (DEFAULT, 'Végétarien', 1, 3, 500, 24, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Végétarien', 3, 4, 500, 23, 3);
INSERT INTO Planrepas VALUES (DEFAULT, 'Pescétarien', 2, 5, 500, 23, 1);
INSERT INTO Planrepas VALUES (DEFAULT, 'Pescétarien', 3, 2, 500, 22, 3);
INSERT INTO Planrepas VALUES (DEFAULT, 'Végétarien', 3, 4, 500, 15, 4);
INSERT INTO Planrepas VALUES (DEFAULT, 'Famille - Rapide', 2, 5, 500, 50, 4);
INSERT INTO Planrepas VALUES (DEFAULT, 'Pescétarien', 3, 2, 500, 100, 4);

INSERT INTO Abonner VALUES (1, 1, 4);  -- numeroplan, numeroclient, duree
INSERT INTO Abonner VALUES (2, 2, 2);
INSERT INTO Abonner VALUES (3, 3, 5);

INSERT INTO Pescetarien VALUES (9, 'Saumon'); -- numeroplan, typepoisson
INSERT INTO Pescetarien VALUES (10, 'Sardine');

INSERT INTO Vegetarien VALUES (7, 'mexicain'); -- numeroplan, typederepas
INSERT INTO Vegetarien VALUES (8, 'méditerranéen');

INSERT INTO Famille VALUES (DEFAULT); -- numeroplan
INSERT INTO Famille VALUES (DEFAULT);
INSERT INTO Famille VALUES (DEFAULT);
INSERT INTO Famille VALUES (DEFAULT);
INSERT INTO Famille VALUES (DEFAULT);
INSERT INTO Famille VALUES (DEFAULT);

INSERT INTO Rapide VALUES (3); -- numeroplan, temps de prép
INSERT INTO Rapide VALUES (4);

INSERT INTO Facile VALUES (5); --numeroplan, nbringredients
INSERT INTO Facile VALUES (6);

INSERT INTO Kitrepas VALUES (DEFAULT, 'Kit repas pour le plan 1', 1); -- numerokitrepas, description, numeroplan
INSERT INTO Kitrepas VALUES (DEFAULT, 'Kit repas pour le plan 2', 2);
INSERT INTO Kitrepas VALUES (DEFAULT, 'Kit repas pour le plan 2', 3);

INSERT INTO Image VALUES (DEFAULT, 'Image pour le kit 1', 1); --numeroimage, donnees, numerokitrepas
INSERT INTO Image VALUES (DEFAULT, 'Image pour le kit 2', 2);

INSERT INTO Ingredient VALUES (DEFAULT, 'Poisson', 'Italie'); -- #Ingredient, nomingérdient, paysIngredient
INSERT INTO Ingredient VALUES (DEFAULT, 'Pate', 'Italie');
INSERT INTO Ingredient VALUES (DEFAULT, 'Boeuf', 'Holland');
INSERT INTO Ingredient VALUES (DEFAULT, 'Poulet', 'Holland');
INSERT INTO Ingredient VALUES (DEFAULT, 'Oeuf', 'Holland');
INSERT INTO Ingredient VALUES (DEFAULT, 'Parmesan', 'Espagne');

INSERT INTO Contenir VALUES (1, 1); -- #Ingredient, numerokitrepas
INSERT INTO Contenir VALUES (2, 2);

INSERT INTO Etape VALUES (DEFAULT, 1, 'Cuire le poisson', 15, NULL); --numeroEtape, numérikitrepas, descriptionrepas, dureeEtape, etrecomposéde
INSERT INTO Etape VALUES (default, 2, 'Cuire la viande', 20, NULL);

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

