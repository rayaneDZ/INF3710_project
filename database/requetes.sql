
/*4.1- Affichez les numeros (numeroclient) et les noms (nomclient) des clients qui ont commande un repas
avec un prix compris entre 20 dollars et 40 dollars. */

SELECT numeroclient, nomclient
FROM Client
WHERE numeroclient IN (
 	SELECT numeroClient
FROM Abonner
WHERE numeroplan IN (
			SELECT numeroplan
FROM Planrepas
WHERE prix BETWEEN 20 AND 40
		)
);

/*4.2- Afficher les numeros des plans repas (numeroplan) qui ne proviennent pas du fournisseur au nom de
'QC Transport'. */

SELECT numeroplan
FROM Planrepas P, Fournisseur F
WHERE P.numerofournisseur = F.numerofournisseur
	AND F.nomfournisseur <> 'QC Transport';

/*4.3- Affichez la liste des numeros des plans Famille (numeroplan) dont la categorie du plan repas
correspond à 'cetogène'.*/

SELECT F.numeroplan
FROM Famille F, Planrepas P
WHERE F.numeroplan = P.numeroplan
	AND P.categorie = 'Cétogène'
;

/*4.4- Affichez le nombre de fournisseurs n’ayant pas de nom dans leur dossier (la valeur de nomfournisseur
est NULL).*/

SELECT COUNT(numerofournisseur)
FROM Fournisseur
WHERE nomfournisseur IS NULL;

/*4.5- Affichez les noms des fournisseurs (nomfournisseur) ayant fait des livraisons de plans repas dont le
montant est superieur aux livraisons faites par le fournisseur dont le nom est 'AB Transport'.*/

SELECT DISTINCT F.nomfournisseur, SUM(P.prix) AS somme
FROM Planrepas P, Fournisseur F
WHERE F.numerofournisseur = P.numerofournisseur
GROUP BY F.nomfournisseur
HAVING SUM(P.prix) > (
	SELECT SUM(pl.prix)
FROM Planrepas pl, Fournisseur fo
WHERE fo.numerofournisseur = pl.numerofournisseur
	AND nomfournisseur = 'AB Transport'
);

/*4.6- Affichez les noms des fournisseurs (nomfournisseur), les adresses (adressefournisseur) et le montant
total des prix des livraisons de plans repas des fournisseurs ayant les deux plus larges montants de livraison
sur la plateforme.*/
SELECT F.nomfournisseur, F.adressefournisseur, SUM(P.prix)
FROM Planrepas P, Fournisseur F
WHERE F.numerofournisseur = P.numerofournisseur
GROUP BY F.nomfournisseur, F.adressefournisseur
ORDER BY SUM(P.prix) DESC
LIMIT 2;

/*4.7- Affichez le nombre de kit repas qui n’ont jamais ete reserves chez les fournisseurs.*/ 
SELECT COUNT
(K.numerokitrepas) FROM Kitrepas K, Planrepas P, Fournisseur F
WHERE P.numerofournisseur = F.numerofournisseur
AND P.numeroplan <> K.numeroplan;

/*4.8- Affichez les numeros (numeroclient), les noms (nomclient) et les prenoms (prenomclient) des clients
dont le prenom ne commence pas par une voyelle (en majuscule ou en minuscule) et qu’ils habitent
(villeclient) à la même adresse (adressefournisseur) que le fournisseur 'Benjamin'. Ordonnez ces clients
alphabetiquement selon le nom.*/

SELECT C.numeroclient, C.nomclient, C.prenomclient
FROM Client C, Fournisseur F
WHERE F.nomfournisseur = 'Benjamin'
	AND C.villeclient = F.adressefournisseur
	AND C.prenomclient NOT LIKE  'A%'
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


/*4.9- Affichez le pays des ingredients (paysingredient) et le nombre d’ingredients par pays dont le
paysingredient ne contient pas la lettre g à la troisième position de la fin; tries par ordre decroissant selon
le pays de l’ingredient (paysingredient).*/

SELECT paysingredient, COUNT(numeroingredient)
FROM Ingredient
WHERE paysingredient NOT LIKE '%g__'
GROUP BY paysingredient
ORDER BY paysingredient DESC;


/*4.10- Creez une vue 'V_fournisseur' contenant la categorie du plan repas 'V_categorie', l’adresse du
fournisseur 'V_adresse' et le total des prix de tous les plans repas desservis par ce fournisseur 'V_tot'. Cette
vue doit uniquement contenir les fournisseurs dont V_tot est superieur à 12 500$ et dont le nom de la
categorie du plan repas contient la lettre 'e' et la lettre 'o' à la troisième position de la fin; tries par ordre 
croissant selon le nom de la categorie du plan repas et par ordre decroissant selon 'V_tot'. Finalement,
afficher le resultat de cette vue.*/

CREATE OR REPLACE VIEW V_fournisseur
(V_categorie, V_adresse, V_tot) AS
SELECT P.categorie, F.adressefournisseur, SUM(P.prix) AS somme
FROM Planrepas P, Fournisseur F
WHERE  P.numerofournisseur = F.numerofournisseur
	AND P.categorie LIKE '%e%'
	AND P.categorie LIKE  '%o__'
GROUP BY P.categorie, F.numerofournisseur
HAVING SUM(prix) > 12500
ORDER BY P.categorie ASC, somme DESC;
