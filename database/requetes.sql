/*1*/
SELECT numéroclient, nomclient FROM Client
WHERE numéroclient IN (
 SELECT numéroClient FROM  Abonner 
WHERE numéroplan IN (
SELECT numéroplan FROM Planrepas
WHERE prix BETWEEN 20 AND 40
)
);

/*2*/
SELECT numéroplan FROM Planrepas 
MINUS
SELECT numéroplan FROM Planrepas 
WHERE numérofournisseur IN (
SELECT numérofournisseur FROM Fournisseur 
WHERE nomfournisseur = 'QC Transport'
);

/*3*/
SELECT F.numéroplan  FROM Famille F, Planrepas P
WHERE F.numéroplan = P.numéroplan 
AND P.catégorie = 'cétogène' ;

/*4*/
SELECT COUNT(numérofournisseur) FROM Fournisseur
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
SELECT COUNT(K.numérokitrepas) FROM Kitrepas K, Planrepas P
WHERE K.numéroplan = P.numéroplan 
AND P.numérofournisseur NOT IN (
SELECT numérofournisseur FROM Fournisseur
);

/*8*/
SELECT C.numéroclient, C.nomclient, C.prénomclient FROM Client C, Fournisseur F
WHERE F.nomfournisseur = 'Benjamin'
AND C.villeclient = F.adressefournisseur  
AND C.prénomclient NOT LIKE 'A%' 
AND C.prénomclient NOT LIKE  'a%' 
AND C.prénomclient NOT LIKE  'E%' 
AND C.prénomclient NOT LIKE  'e%' 
AND C.prénomclient NOT LIKE  'I%' 
AND C.prénomclient NOT LIKE  'i%' 
AND C.prénomclient NOT LIKE  'O%' 
AND C.prénomclient NOT LIKE  'o%' 
AND C.prénomclient NOT LIKE  'U%' 
AND C.prénomclient NOT LIKE  'u%' 
ORDER BY C.nomclient;

/*9*/
SELECT paysingrédient, COUNT(numéroingrédient)
WHERE paysingrédient NOT LIKE '%g_ _'
GROUP BY paysingrédient
ORDER BY paysingrédient DESC;

/*10*/
CREATE OR REPLACE VIEW V_fournisseur (V_catégorie, V_adresse, V_tot) AS
SELECT P.catégorie, F.adressefournisseur, SUM(prix) AS somme FROM Planrepas P, Fournisseur F
WHERE  P.catégorie LIKE '%e%'
AND P.catégorie LIKE  '%o_ _'
ORDER BY P.catégorie, somme DESC
HAVING (SUM(prix) > 12500);
