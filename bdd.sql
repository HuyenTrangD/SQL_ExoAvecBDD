# lien pour exe : https://aymeric-auberton.fr/academie/mysql/exercices

# Avant de commencer :
# Etape 1 : Pour créer le schéma pour la table : Create Schema -> Nommer la table
# Etape 2 : Pour insérer date : Double cliquer sur la table -> Ouvrir le fichier data -> Exécuter
# Etape 3 : Pour voir le schéma : Database -> Reverse Engineer

## I- PREMIÈRE PARTIE / table lpecom_livres

# 1 - Quelle requête utiliser pour afficher l'ensemble des enregistrements de la table lpecom_livres ?

select *
from lpecom_livres ;

# 2 - Quelle requête utiliser pour sélectionner uniquement les livres 
# qui ont un prix strictement supérieur à 20 de la table lpecom_livres ?

select id_livre, titre, prix
from lpecom_livres
where prix > 20 ;

# 3 - Quelle requête utiliser pour trier les enregistrements de la table lpecom_livres 
# du prix le plus élevé aux prix le plus bas

select *
from lpecom_livres
order by prix desc ;

# 4 - Quelle requête utiliser pour récupérer le prix du livre le plus élevé de la table lpecom_livres ?

SELECT MAX(prix)
FROM lpecom_livres ;

# 5 - Quelle requête utiliser pour récupérer les livres de la table lpecom_livres 
# qui ont un prix compris entre 20 et 22 ?

SELECT id_livre, titre, prix
FROM lpecom_livres
WHERE prix BETWEEN 20 AND 22 ;

# 6 - Quelle requête utiliser pour récupérer tous les livres de la table lpecom_livres 
# à l'exception de celui portant la valeur pour la colonne isbn_10 : 2092589547 ?

SELECT id_livre, titre, isbn_10
FROM lpecom_livres
WHERE isbn_10 != 2092589547 ;

# 7 - Quelle requête utiliser pour récupérer le prix du livre le moins élevé de la table lpecom_livres 
# en renommant la colonne dans les résultats par minus ?

SELECT MIN(Prix) AS minus
FROM lpecom_livres ;

# 8 - Quelle requête utiliser pour sélectionner uniquement les 3 premiers résultats 
# sans le tout premier de la table lpecom_livres ?

SELECT *
FROM lpecom_livres
ORDER BY id_livre
LIMIT 3 OFFSET 1 ;

## II - DEUXIÈME PARTIE / Table lpecom_examens

SELECT *
FROM lpecom_examens 
ORDER BY id_examen ;

# 1 - Quelle requête utiliser pour afficher l'id des étudiants qui ont participés à au moins un examen ?

SELECT DISTINCT id_etudiant
FROM lpecom_examens ;

SELECT DISTINCT id_etudiant
FROM lpecom_examens
WHERE id_examen IS NOT NULL ;

# 2 - Quelle requête utiliser pour compter le nombre d'étudiants qui ont participés à au moins un examen ?

SELECT DISTINCT COUNT(id_etudiant)
FROM lpecom_examens ;

SELECT COUNT(DISTINCT id_etudiant)
FROM lpecom_examens ;

# 3 - Quelle requête utiliser pour calculer la moyenne de l'examen portant l'id : 45 ?

SELECT avg(note)
FROM lpecom_examens
WHERE id_examen = 45 ;

# 4 - Quelle requête utiliser pour récupérer la meilleure note de l'examen portant l'id : 87 ?

SELECT max(note)
FROM lpecom_examens
WHERE id_examen = 87 ;

# 5 - Quelle requête utiliser pour afficher l'id des étudiants qui ont eu plus de 11 à l'examen 45 
# ou plus de 12 à l'examen 87 ?

SELECT DISTINCT id_etudiant, id_examen, note
FROM lpecom_examens
WHERE (id_examen = 45 AND note > 11)
OR (id_examen = 87 AND note > 12) 
ORDER BY id_examen, note ;

# 6 - Quelle requête utiliser pour afficher tous les enregistrement de la table lpecom_examens 
# avec en plus, si c'est possible, le prenom et le nom de l'étudiant ?

SELECT ex.*, et.prenom, et.nom
FROM lpecom_examens AS ex
LEFT JOIN lpecom_etudiants AS et 
	ON ex.id_etudiant = et.id_etudiant ;

SELECT ex.*, et.prenom, et.nom
FROM lpecom_examens AS ex
LEFT JOIN lpecom_etudiants AS et
	USING (id_etudiant) ;

# 7 - Quelle requête utiliser pour afficher les enregistrement de la table lpecom_examens 
# avec le prenom et le nom de l'étudiant, uniquement quand les étudiants sont présents dans la table lpecom_etudiants

SELECT *
FROM lpecom_etudiants ;

SELECT ex.*, et.prenom, et.nom
FROM lpecom_examens AS ex
INNER JOIN lpecom_etudiants AS et 
	ON ex.id_etudiant = et.id_etudiant ;
    
# 8 - Quelle requête utiliser pour afficher uniquement le nom et le prenom de l'étudiant avec l'id : 30 
# avec la moyenne de ses deux examens dans une colonne moyenne ?

SELECT  nom, prenom,
		avg(note) AS moyenne
FROM lpecom_etudiants
JOIN lpecom_examens USING(id_etudiant)
WHERE id_etudiant = 30 ;

SELECT et.prenom, et.nom, AVG(ex.note) as moyenne
FROM lpecom_examens ex
INNER JOIN lpecom_etudiants et ON ex.id_etudiant = et.id_etudiant
WHERE et.id_etudiant = 30 ;

# 9 - Quelle requête utiliser pour afficher les 3 meilleures examens, du meilleur au moins bon
# avec le prenom et le nom de l'étudiant associé ?

SELECT prenom, nom, note
FROM lpecom_etudiants
JOIN lpecom_examens USING (id_etudiant)
ORDER BY note DESC
LIMIT 3 ;

SELECT *
FROM lpecom_examens ex
INNER JOIN lpecom_etudiants et ON ex.id_etudiant = et.id_etudiant
ORDER BY ex.note DESC
LIMIT 3 ;

## III - TROISIÈME PARTIE /table lpecom_realisateurs/ table lpecom_films/ table lpecom_films_notes

SELECT *
FROM lpecom_realisateurs ;

SELECT *
FROM lpecom_films ;

SELECT *
FROM lpecom_films_notes ;

# 1 - Afficher id, prenom, nom de la table lpecom_realisateurs qui vient de us et sexe 1 = Jenkins Patty

SELECT *
FROM lpecom_realisateurs
WHERE nation = "us"
AND sexe = 1 ;

# 2 - Afficher tous les éléments de la première ligne de la table lpecom_realisateurs 
# dont le sexe = 0 et ordonner nom par ordre décroissant => Scott

SELECT *
FROM lpecom_realisateurs
WHERE sexe = "0"
ORDER BY nom DESC
LIMIT 1 ;

# 3 - Afficher id, nom (lpecom_films) avec prenom, nom (lpecom_realisateurs)
# et ordonner id (lpecom_films) par ordre croissant => 121

SELECT 	f.id, f.nom AS film,
		r.prenom, r.nom
FROM lpecom_films AS f
JOIN lpecom_realisateurs AS r 
	ON f.id_realisateur = r.id
ORDER BY f.id ASC ;

# 4 - Afficher id, nom (lpecom_films) avec prenom, nom (lpecom_realisateurs)
# et ordonner id (lpecom_films) par ordre croissant => 121

SELECT 	f.id, f.nom AS film, 
		r.prenom, r.nom
FROM lpecom_films AS f
LEFT JOIN lpecom_realisateurs AS r 
	ON f.id_realisateur = r.id
ORDER BY f.id ASC ;

# 5 - Afficher id, nom (lpecom_films) avec note lpecom_films_notes) et ordonner id par ordre croissant

SELECT 	f.id, f.nom, 
		fn.note
FROM lpecom_films AS f
LEFT JOIN lpecom_films_notes AS fn 
	ON f.id = fn.id_film
ORDER BY f.id ASC ;

# 6 - Afficher nom (lpecom_films) avec nom, prenom (lpecom_realisateurs) de id = 546

SELECT 	f.id, f.nom, 
		r.prenom AS realisateur_prenom, 
		r.nom AS realisateur_nom, 
        AVG(fn.note) AS moyenne_note
FROM lpecom_films AS f
INNER JOIN lpecom_realisateurs AS r 
	ON f.id_realisateur = r.id
INNER JOIN lpecom_films_notes AS fn 
	ON f.id = fn.id_film
WHERE f.id = 546 ;

# 7 - Afficher la note moyenne de films de la nation us

SELECT 	r.nation, 
		ROUND(AVG(fn.note), 2) AS moyenne_note
FROM lpecom_films AS f
INNER JOIN lpecom_realisateurs AS r 
	ON f.id_realisateur = r.id
INNER JOIN lpecom_films_notes AS fn 
	ON f.id = fn.id_film
WHERE r.nation = "us" ;

# 8 - Afficher la meilleure note de films de la nation uk

SELECT 	r.nation, 
		MAX(fn.note) AS max_note
FROM lpecom_films f
INNER JOIN lpecom_realisateurs AS r
	ON f.id_realisateur = r.id
INNER JOIN lpecom_films_notes AS fn 
	ON f.id = fn.id_film
WHERE r.nation = "uk" ;

## - QUATRIÈME PARTIE/ lpecom_cities/ lpecom_departments/ lpecom_regions

SELECT *
FROM lpecom_cities 
ORDER BY name ;

SELECT *
FROM lpecom_departments ;

SELECT *
FROM lpecom_regions ;

### AVEC TABLE lpecom_cities

# 1 - Quelle requête utiliser pour retrouver la ville 
# dont GPS : gps_lat = 48.66913724637683 AND gps_lng = 1.87586057971015 ?

SELECT name, gps_lat, gps_lng
FROM lpecom_cities
WHERE gps_lat = 48.66913724637683 
	AND gps_lng = 1.87586057971015 ;

# 2 - Sans jointure, quelle requête utiliser pour calculer le nombre de villes que compte le département de l'Essonne ?

SELECT COUNT(*) 
FROM lpecom_cities 
WHERE department_code = 91 ;

# 3 - Sans jointure, quelle requête utiliser pour calculer le nombre de villes en Île-de-France se terminant par "-le-Roi" ?

SELECT name 
FROM lpecom_cities 
WHERE name LIKE "%-le-Roi";

SELECT COUNT(*) 
FROM lpecom_cities 
WHERE name LIKE "%-le-Roi";

# 4 - Combien de villes possèdent le code postal (zip_code) 77320 ? Renommez la colonne de résultat n_cities.

SELECT COUNT(*) AS n_cities
FROM lpecom_cities
WHERE zip_code = 77320 ;

# 5 - Sans jointure, quelle requête utiliser pour calculer le nombre de villes commençant par "Saint-" en Seine-et-Marne ?

SELECT COUNT(*)
FROM lpecom_cities 
WHERE department_code = 77
	AND name LIKE "Saint-%" ;
    
SELECT COUNT(*) 
FROM lpecom_cities 
WHERE name LIKE "SAINT-%" 
	AND department_code = 77 ;
    
# 6 - Quelles villes possèdent un code postal (zip_code) compris entre 77210 et 77810 ?

SELECT zip_code, name
FROM lpecom_cities
WHERE zip_code BETWEEN 77210 AND 77810 
ORDER BY zip_code ;

# 7 - Sans jointure, quelles sont les deux villes de Seine-et-Marne à avoir le code postal (zip_code) le plus grand ?

SELECT zip_code, name
FROM lpecom_cities 
WHERE department_code = 77 
ORDER BY zip_code DESC 
LIMIT 2 ;

# 8 - Quel est le code postal (zip_code) le plus grand de la table lpecom_cities ?

SELECT MAX(zip_code)
FROM lpecom_cities ;

# 9 - Avec un seul WHERE et aucun OR,
# quelle est la requête permettant d'afficher les départements des régions ayant le code suivant : 75, 27, 53, 84 et 93 ?  
# Le résultat doit afficher le nom du département ainsi que le nom et le slug de la région associée.

SELECT 	r.code,
		r.name AS Nom_région, r.slug, 
		d.name AS Nom_département
FROM lpecom_regions AS r
JOIN lpecom_departments AS d
	ON r.code = d.region_code
WHERE r.code IN (75, 27, 53, 84, 93) 
ORDER BY code ;

SELECT 	d.name AS departement, d.slug,
		r.name AS region
FROM lpecom_departments AS d
JOIN lpecom_regions AS r 
	ON (d.region_code = r.code)
WHERE d.region_code IN (75, 27, 53, 84, 93) ;

# 10 - Quelle requête utiliser pour obtenir en résultat, les noms de la région, du département 
# et de chaque ville du département ayant pour code 77 ?

SELECT 	r.name AS Nom_région,
		d.name AS Nom_département,
        v.name AS Nom_ville
FROM lpecom_cities AS v
JOIN lpecom_departments AS d
	ON v.department_code = d.code
JOIN lpecom_regions AS r
	ON d.region_code = r.code
WHERE d.code = 77 ;

SELECT 	r.name AS region, 
		d.name AS departement, 
        c.name AS ville
FROM lpecom_cities AS c
INNER JOIN lpecom_departments AS d 
	ON (c.department_code = d.code)
INNER JOIN lpecom_regions AS r 
	ON (d.region_code = r.code)
WHERE d.code = 77 ;

SELECT 	r.name as region,
		d.name as departement, 
        c.name as ville,
        d.code
FROM lpecom_cities AS c
INNER JOIN lpecom_departments AS d 
	ON (c.department_code = d.code)
INNER JOIN lpecom_regions AS r 
	ON (d.region_code = r.code)
WHERE d.code = 77;

## - V/ CINQUIÈME PARTIE / lpecom_covid / lpecom_regions / lpecom_covid_vaccin_type

SELECT *
FROM lpecom_covid 
ORDER BY jour ;

SELECT *
FROM lpecom_regions ;

SELECT *
FROM lpecom_covid_vaccin_type ;

# 1 - Quelle requête utiliser pour afficher toutes les données de vaccination uniquement pour le 1er avril 2021 ?
# * 2021-04-01

SELECT *
FROM lpecom_covid
WHERE jour = '2021-04-01' ;

# 2 - Quelle requête utiliser pour afficher toutes les données de vaccination uniquement pour le 1er avril 2021 
# avec le nom de la région concernée ?

SELECT 	c.*, 
		r.name AS Nom_region
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE jour = '2021-04-01' ;

# 3 - Quelle requête utiliser pour afficher le nombre au cumulé de vaccination première dose toutes régions en 2020 ? 
# Proposez également une solution pour les vaccination deuxième dose.

SELECT SUM(n_dose1)
FROM lpecom_covid
WHERE YEAR(jour) = 2020 ;

SELECT SUM(n_dose1)
FROM lpecom_covid c
WHERE jour <= '2020-12-31';

# 4 - Quelle requête SQL utiliser pour afficher le nombre au cumulé de vaccination première dose pour la région avec le code 93 
# uniquement pour le mois de mars 2021 ?

SELECT SUM(n_dose1)
FROM lpecom_covid
WHERE id_region = 93
	AND YEAR(jour) = 2021
    AND MONTH(jour) = 03 ;
    
SELECT SUM(n_dose1)
FROM lpecom_covid c
WHERE id_region = '93'
	AND jour BETWEEN '2021-03-01' AND '2021-03-31';
    
# 5 - Quelle requête utiliser pour afficher le nombre au cumulé de vaccination deuxième dose pour la région avec le code 11 
# uniquement pour le mois de mars 2021 ?

SELECT SUM(n_dose2)
FROM lpecom_covid
WHERE id_region = 11
	AND YEAR(jour) = 2021
    AND MONTH(jour) = 03 ;
    
SELECT SUM(n_dose2)
FROM lpecom_covid c
WHERE id_region = '11'
	AND jour BETWEEN '2021-03-01' AND '2021-03-31';
    
# 6 - Quelle requête SQL utiliser pour afficher le record de vaccination première dose en une seule journée ? 
# Avec une deuxième requête, afficher les informations de la région concernée, dont son nom, ainsi que le jour du record.

SELECT MAX(n_dose1)
FROM lpecom_covid ;

SELECT 	c.jour ,
		r.name AS Nom_region
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE n_dose1 = (SELECT MAX(n_dose1)
				FROM lpecom_covid ) ;
                
SELECT 	c.* , 
		r.name
FROM lpecom_covid c
INNER JOIN lpecom_regions r 
	ON c.id_region = r.code
WHERE c.n_dose1 >= 56661 ;

# 7 - Quelle requête utiliser pour afficher le record de vaccination deuxième dose en une seule journée ? 
# Avec une deuxième requête, afficher les informations de la région concernée, dont son nom, ainsi que le jour du record.

SELECT 	c.jour ,
		r.name AS Nom_region
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE n_dose2 = (SELECT MAX(n_dose2)
				FROM lpecom_covid ) ;

SELECT c.*, r.name
FROM lpecom_covid c
INNER JOIN lpecom_regions r
	ON c.id_region = r.code
WHERE c.n_dose2 >= 21524 ;

# 8 - Quelles requêtes permettent de connaitre quelle région possède la plus grande couverture de vaccination avec une dose et deux doses ?
# Vous aurez besoin de 4 requêtes pour répondre aux deux questions. Vous aurez besoin du résultat de la première requête pour la deuxième.

SELECT 	c.id_region ,
		r.name AS Nom_region ,
        c.couv_dose1
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE couv_dose1 = (SELECT MAX(couv_dose1)
				FROM lpecom_covid ) ;
	
SELECT 	c.id_region ,
		r.name AS Nom_region ,
        c.couv_dose2
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE couv_dose2 = (SELECT MAX(couv_dose2)
				FROM lpecom_covid ) ;

# 9 - Quelle requête utiliser pour afficher le nom de la région qui a le plus faible taux de couverture de vaccination avec une dose ?

SELECT DISTINCT	c.id_region ,
				r.name AS Nom_region ,
				c.couv_dose1
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE couv_dose1 = (SELECT MIN(couv_dose1)
				FROM lpecom_covid ) ;

SELECT MIN(c.couv_dose1)
FROM lpecom_covid c ;

SELECT c.*, r.name
FROM lpecom_covid c
INNER JOIN lpecom_regions r ON c.id_region = r.code
WHERE c.jour = '2021-04-06'
AND c.couv_dose1 <= 2.80 ;

# 10 - Quelle requête utiliser pour calculer la couverture moyenne entre les différentes régions à la date la plus récente, 
# pour les vaccinations une et deux doses ? Vous renommez les colonnes de résultats : couverture_dose1_avg et couverture_dose2_avg.

SELECT 	AVG(couv_dose1) AS couverture_dose1_avg ,
		AVG(couv_dose2) AS couverture_dose2_avg
FROM lpecom_covid
WHERE jour = (SELECT jour
			FROM lpecom_covid
            ORDER BY jour DESC
            LIMIT 1 ) ;

SELECT AVG(c.couv_dose1) AS couverture_dose1_avg, AVG(c.couv_dose2) AS couverture_dose2_avg
FROM lpecom_covid c
WHERE c.jour = '2021-04-06';

# 11 - Quelle requête utiliser pour afficher les données de vaccination des régions (avec leur nom) 
# qui possèdent une couveture vaccinale supérieure à 15 % pour la première dose et supérieure à 5 % pour la deuxième dose ?

SELECT DISTINCT c.id_region ,
				r.name AS Nom_region ,
				c.couv_dose1 ,
				c.couv_dose2 
FROM lpecom_covid AS c
JOIN lpecom_regions AS r
	ON c.id_region = r.code
WHERE couv_dose1 > 15
	AND couv_dose2 > 5 
ORDER BY name ;
    
SELECT c.*, r.name
FROM lpecom_covid c
INNER JOIN lpecom_regions r 
	ON c.id_region = r.code
WHERE c.couv_dose1 >= 15
	AND c.couv_dose2 >= 5
	AND c.jour = '2021-04-06'
ORDER BY name ;

## - SIXIÈME PARTIE/ lpecom_covid_vaccin / lpecom_covid_vaccin_type / lpecom_departments

SELECT *
FROM lpecom_covid_vaccin ;

SELECT *
FROM lpecom_covid_vaccin_type ;

SELECT *
FROM lpecom_departments ;

# 1 - Sans jointure, quelle requête SQL utiliser pour afficher toutes les données de vaccination du 14 février 2021 uniquement, 
# pour le département de Seine-et-Marne (77) ?

SELECT *
FROM lpecom_covid_vaccin
WHERE jour = '2021-02-14'
	AND dep_code = 77
ORDER BY n_cum_dose1 ;

# 2 - Sans jointure, quelle requête SQL utiliser pour afficher le cumul de toutes les données de vaccination 
# pour tous les vaccins du 14 février 2021 uniquement, 
# pour les départements de l'Essonne (91) et de la Seine-et-Marne (77) ?

SELECT *
FROM lpecom_covid_vaccin
WHERE jour = '2021-02-14'
	AND (dep_code = 77 OR dep_code = 91)
ORDER BY dep_code ;

SELECT *
FROM lpecom_covid_vaccin v
WHERE v.jour = '2021-02-14'
AND v.dep_code IN (77, 91)
AND v.vaccin = 0 ;

# 3 - Sans jointure, quelle requête utiliser pour afficher la somme des vaccinations première dose réalisées uniquement avec le vaccin AstraZeneka 
# pour le mois de février 2021 pour le département de la Seine-et-Marne (77) ?

SELECT SUM(n_dose1)
FROM lpecom_covid_vaccin
WHERE vaccin = 3
	AND YEAR(jour) = 2021
    AND MONTH(jour) = 02 
    AND dep_code = 77 ;

SELECT SUM(v.n_dose1)
FROM lpecom_covid_vaccin v
WHERE v.dep_code = 77
AND v.jour BETWEEN '2021-02-01' AND '2021-02-28'
AND v.vaccin = 3 ;

# 4 - Sans jointure, quelle requête utiliser pour afficher la somme des vaccinations deuxième dose réalisées avec le vaccin AstraZeneka ou Moderna 
# pour le mois de mars 2021 pour le département de la Seine-et-Marne (77) ?

SELECT SUM(n_dose2)
FROM lpecom_covid_vaccin
WHERE vaccin IN (2,3)
	AND YEAR(jour) = 2021
    AND MONTH(jour) = 03 
    AND dep_code = 77 ;
    
SELECT SUM(v.n_dose2)
FROM lpecom_covid_vaccin v
WHERE v.dep_code = 77
AND v.jour BETWEEN '2021-03-01' AND '2021-03-31'
AND v.vaccin IN (2, 3);

# 5 - Sans jointure, quelle requête utiliser pour afficher le record de vaccination première dose avec un type de vaccin en une seule journée ?
# Avec une deuxième requête qui exploitera une jointure, afficher toutes les informations possibles pour cette journée record et sur le type de vaccin.

SELECT MAX(v.n_dose1)
FROM lpecom_covid_vaccin v
WHERE v.vaccin != 0 ;

SELECT *
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t 
	ON t.id = v.vaccin
WHERE n_dose1 = (SELECT MAX(v.n_dose1)
				FROM lpecom_covid_vaccin v
				WHERE v.vaccin != 0 ) ;

SELECT *
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t 
	ON t.id = v.vaccin
WHERE v.vaccin != 0 ;

# 6 - Sans jointure, quelle requête utiliser pour afficher le record de vaccination deuxième dose avec un type de vaccin en une seule journée ? 
# Avec une deuxième requête qui exploitera deux jointures, afficher toutes les informations possibles pour cette journée record, sur le type de vaccin et sur le département.

SELECT *
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t 
	ON t.id = v.vaccin
WHERE n_dose2 = (SELECT MAX(v.n_dose2)
				FROM lpecom_covid_vaccin v
				WHERE v.vaccin != 0 ) ;
                
# 7 - Quelle requête permet de savoir quel département possède le plus grand nombre d'injections première dose pour le vaccin AstraZeneka ?
# Avec une deuxième requête, afficher : le nom du vaccin ; le jour ; le nom et le code du département ; le nombre cumulé d'injections.

SELECT 	t.nom AS Nom_vaccin ,
		v.n_dose1 ,
        v.jour ,
        v.dep_code ,
        d.name AS Nom_department
FROM lpecom_covid_vaccin AS v
JOIN lpecom_covid_vaccin_type AS t USING(id)
JOIN lpecom_departments AS d
	ON v.dep_code = d.code
WHERE t.nom = 'AstraZeneka' 
	AND v.n_dose1 = (SELECT MAX(v.n_dose1)
					FROM lpecom_covid_vaccin) 
GROUP BY jour ;
                    
SELECT MAX(v.n_cum_dose1)
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t 
	ON t.id = v.vaccin
INNER JOIN lpecom_departments d 
	ON d.code = v.dep_code
WHERE jour = '2021-04-06'
AND v.vaccin = 3 ;

# 8 - Quelle requête permet de savoir quel département a eu le moins de vaccinations première dose avec le vaccin COMIRNATY Pfizer/BioNTech ? 
# afficher uniquement les colonnes suivantes : # le nom du vaccin ; le jour ; le nom et le code du département ; le nombre cumulé d'injections.

SELECT MIN(n_cum_dose1) 
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t ON t.id = v.vaccin
INNER JOIN lpecom_departments d ON d.code = v.dep_code
WHERE v.vaccin = 1 ;

# 9 - Quelle requête permet de connaître la moyenne de vaccinations première dose dans tous les départements pour le vaccin Moderna ? 
# Renommer la colonne de résultat avec avg_moderna

SELECT AVG(n_cum_dose1) 
FROM lpecom_covid_vaccin
WHERE vaccin = 2 ;

SELECT AVG(n_cum_dose1) AS avg_moderna
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t ON t.id = v.vaccin
INNER JOIN lpecom_departments d ON d.code = v.dep_code
WHERE v.vaccin = 2 ;

# 10 - Quelle requête utiliser pour afficher les départements (avec leur nom) qui possèdent un nombre d'injections deuxième dose 
# avec le vaccin Moderna supérieur à 9000 ou un nombre d'injections première dose avec le vaccin COMIRNATY Pfizer/BioNTech supérieur à 120000 ?

SELECT 	v.* ,
		t.nom ,
        d.name AS Nom_department
FROM lpecom_covid_vaccin AS v
JOIN lpecom_covid_vaccin_type t 
	ON t.id = v.vaccin
JOIN lpecom_departments AS d
	ON v.dep_code = d.code
WHERE (v.vaccin = 2 AND n_cum_dose2 > 9000)
	OR (v.vaccin = 1 AND n_cum_dose1 > 120000) ;

SELECT v.jour, t.nom, v.n_cum_dose1, d.code, d.name
FROM lpecom_covid_vaccin v
INNER JOIN lpecom_covid_vaccin_type t ON t.id = v.vaccin
INNER JOIN lpecom_departments d ON d.code = v.dep_code
WHERE (v.vaccin = 1 AND v.n_cum_dose1 > 120000)
OR (v.vaccin = 2 AND v.n_cum_dose2 > 9000);

## VII - SEPTIÈME PARTIE / lpecom_rpps
# données manquantes, ne pas pouvoir faire des exercices