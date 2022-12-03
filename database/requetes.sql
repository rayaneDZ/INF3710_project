/*1*/
SELECT numeroclient, nomclient FROM Client
WHERE numeroclient IN (
 SELECT numeroClient FROM  Abonner 
WHERE numeroplan IN (
SELECT numeroplan FROM Planrepas
WHERE prix BETWEEN 20 AND 40
)
);

/*2*/
SELECT numeroplan FROM Planrepas 
MINUS
SELECT numeroplan FROM Planrepas 
WHERE numerofournisseur IN (
SELECT numerofournisseur FROM Fournisseur 
WHERE nomfournisseur = 'QC Transport'
);

/*3*/
SELECT F.numeroplan  FROM Famille F, Planrepas P
WHERE F.numeroplan = P.numeroplan 
AND P.categorie = 'cétogène' ;

/*4*/
SELECT COUNT(numerofournisseur) FROM Fournisseur
WHERE nomfournisseur = NULL;

/*5*/
SELECT DISTINCT nomfournisseur, SUM(prix) AS somme FROM Planrepas 
WHERE somme >ALL (
	SELECT SUM(prix) FROM Planrepas
	WHERE nomfournisseur = 'AB Transport'
);

/*6*/
SELECT nomfournisseur, adressefournisseur, SUM(prix) FROM Planrepas
WHERE prix 

/*7*/
SELECT COUNT(K.numerokitrepas) FROM Kitrepas K, Planrepas P
WHERE K.numeroplan = P.numeroplan 
AND P.numerofournisseur NOT IN (
SELECT numerofournisseur FROM Fournisseur
);

/*8*/
SELECT C.numeroclient, C.nomclient, C.prenomclient FROM Client C, Fournisseur F
WHERE F.nomfournisseur = 'Benjamin'
AND C.villeclient = F.adressefournisseur  
AND C.prenomclient NOT LIKE 'A%' 
AND C.prenomclient NOT LIKE  'a%' 
AND C.prenomclient NOT LIKE  'E%' 
AND C.prenomclient NOT LIKE  'e%' 
AND C.prenomclient NOT LIKE  'I%' 
AND C.prenomclient NOT LIKE  'i%' 
AND C.prenomclient NOT LIKE  'O%' 
AND C.prenomclient NOT LIKE  'o%' 
AND C.prenomclient NOT LIKE  'U%' 
AND C.prenomclient NOT LIKE  'u%' 
ORDER BY C.nomclient;

/*9*/
SELECT paysingredient, COUNT(numeroingredient)
WHERE paysingredient NOT LIKE '%g_ _'
GROUP BY paysingredient
ORDER BY paysingredient DESC;

/*10*/
CREATE OR REPLACE VIEW V_fournisseur (V_categorie, V_adresse, V_tot) AS
SELECT P.categorie, F.adressefournisseur, SUM(prix) AS somme FROM Planrepas P, Fournisseur F
WHERE  P.categorie LIKE '%e%'
AND P.categorie LIKE  '%o_ _'
ORDER BY P.categorie, somme DESC
HAVING (SUM(prix) > 12500);
