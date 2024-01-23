
a. Informations d’un film (id_film) : titre, année, durée (au format HH:MM) et réalisateur

/* Duree * 60 convertit la durée totale du film de minutes en secondes* 
%H représente les heures et %i représente les minutes. */
SELECT Film.Titre, Film.AnneeSortie, TIME_FORMAT(SEC_TO_TIME(Film.Duree*60), '%H:%i') 
AS Duree, Realisateur.Nom, Realisateur.Prenom
FROM Film
INNER JOIN Realisateur ON Film.IdRealisateur = Realisateur.IdRealisateur
WHERE Film.IdFilm = 6;

b. Liste des films dont la durée excède 2h15 classés par durée (du + long au + court)

SELECT Titre, AnneeSortie, TIME_FORMAT(SEC_TO_TIME(Duree * 60), '%H:%i') 
FROM Film
WHERE Duree > 135  /*2h15 en minutes*/
ORDER BY Duree DESC; 

c. Liste des films d’un réalisateur (en précisant l’année de sortie)

SELECT Titre, AnneeSortie
FROM Film
WHERE IdRealisateur = 1;

d. Nombre de films par genre (classés dans l’ordre décroissant)

SELECT Genre.NomGenre, COUNT(Film.IdFilm) AS NombreFilms
FROM Genre
INNER JOIN Appartient ON Genre.IdGenre = Appartient.IdGenre
INNER JOIN Film ON Appartient.IdFilm = Film.IdFilm
GROUP BY Genre.IdGenre
ORDER BY NombreFilms DESC;

e. Nombre de films par réalisateur (classés dans l’ordre décroissant)

SELECT Realisateur.Nom, Realisateur.Prenom, COUNT(Film.IdFilm) AS NombreFilms
FROM Realisateur
INNER JOIN Film ON Realisateur.IdRealisateur = Film.IdRealisateur
GROUP BY Realisateur.IdRealisateur
ORDER BY NombreFilms DESC;

f. Casting d’un film en particulier (id_film) : nom, prénom des acteurs + sexe

SELECT Film.titre, Acteur.Nom, Acteur.Prenom, Acteur.Sexe
FROM JoueDans
INNER JOIN Acteur ON JoueDans.IdActeur = Acteur.IdActeur
INNER JOIN Film ON JoueDans.id_film = Film.IdFilm
WHERE JoueDans.IdFilm = 3;

g. Films tournés par un acteur en particulier (id_acteur) avec leur rôle et l’année de
sortie (du film le plus récent au plus ancien)

SELECT Film.Titre, JoueDans.IdRole, Film.AnneeSortie, Acteur.Nom, Acteur.Prenom
FROM JoueDans
INNER JOIN Film ON JoueDans.IdFilm = Film.IdFilm
INNER JOIN Acteur ON JoueDans.IdActeur = Acteur.idActeur
WHERE JoueDans.IdActeur = 1
ORDER BY Film.AnneeSortie DESC;

h. Liste des personnes qui sont à la fois acteurs et réalisateurs

/* CONCAT pour comparer le couple Nom Prénom*/
SELECT CONCAT(Nom, ' ', Prenom) AS NomPrenom
FROM Acteur
WHERE CONCAT(Nom, ' ', Prenom) IN (
SELECT CONCAT(Nom, ' ', Prenom)
FROM Realisateur);

j. Nombre d’hommes et de femmes parmi les acteurs

SELECT Sexe, COUNT(*) AS NombreActeurs
FROM Acteur
GROUP BY Sexe;

k. Liste des acteurs ayant plus de 50 ans (âge révolu et non révolu)

SELECT idActeur, DateNaissance, nom, prenom 
FROM Acteur 
WHERE YEAR(CURDATE()) - YEAR(dateNaissance) >= 50 /*CURDATE date du jour YEAR Année */

l. Acteurs ayant joué dans 3 films ou plus

SELECT Acteur.IdActeur, Acteur.Nom, Acteur.Prenom
FROM Acteur 
JOIN JoueDans ON Acteur.IdActeur = JoueDans.IdActeur
GROUP BY Acteur.IdActeur, Acteur.Nom, Acteur.Prenom
HAVING COUNT(JoueDans.IdFilm) >= 3