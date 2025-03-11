USE sakila;

/*1.Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
SELECT DISTINCT(title)
	FROM film;

/*2.Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"*/
SELECT title AS peliculas_PG_13
	FROM film
    WHERE rating = "PG-13" ;
    
/*3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.*/
SELECT title AS peliculas_amazing, description AS sinopsis
	FROM film
    WHERE description LIKE '%amazing%';

/*4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/
SELECT title AS pelis_mas_de_2horas
	FROM film
    WHERE length > '120';

/*5.Recupera los nombres de todos los actores.*/
SELECT first_name
	FROM actor;

/*6.Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido*/
SELECT first_name, last_name
	FROM actor
	WHERE last_name LIKE '%Gibson%';
    
/*7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/
SELECT first_name AS actores_id_10_20
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;

/*8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.*/
SELECT title AS peliculas_categorias_excluidas
	FROM film
    WHERE rating <> "R" AND rating <> "PG-13";
    
/*9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.*/
SELECT rating AS clasificacion, COUNT(rating) AS num_peliculas
	FROM film
    GROUP BY rating;
    
/*10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
su nombre y apellido junto con la cantidad de películas alquiladas*/
SELECT c.customer_id AS id_cliente, c.first_name AS nombre, c.last_name AS apellido, COUNT(r.rental_id) AS total_peliculas_alquiladas
	FROM customer AS c
    LEFT JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
/*11.Encuentra la cantidad total de películas alquiladas por categoría y muestra el 
nombre de la categoría junto con el recuento de alquileres.*/
SELECT c.name AS categoria, COUNT(r.rental_id) AS total_alquileres
	FROM rental AS r
    INNER JOIN inventory AS i
    USING (inventory_id)
    INNER JOIN film AS f
    USING (film_id)
    INNER JOIN film_category AS fc
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
    GROUP BY fc.category_id, c.name;
    
/*12.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración.*/
SELECT rating AS clasificacion, ROUND(AVG(length)) AS duracion_media
	FROM film
    GROUP BY rating;
    
/*13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/
SELECT CONCAT(a.first_name, '  ', a.last_name) AS actores_Indian_love 
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
    WHERE f.title = "Indian Love";
    
/*14.Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/
SELECT title AS pelis_para_amantes_de_los_animales
	FROM film
    WHERE description LIKE '%dog%' OR description LIKE '%cat%';

/*15.Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor. RESPUESTA = NO*/
SELECT a.first_name AS actores_fuera_de_film_actor
	FROM actor AS a
	LEFT JOIN film_actor AS fa
	USING (actor_id)
	WHERE film_id IS NULL;

/*16.Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010*/
SELECT title AS peliculas_2005_2010
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;
    
/*17.Encuentra el título de todas las películas que son de la misma categoría que "Family"*/
SELECT f.title AS categoria_family
	FROM film AS f
    INNER JOIN film_category AS fc
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
	WHERE c.name = "Family";

/*18Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/
SELECT CONCAT(a.first_name, '  ', a.last_name) AS actores_prolificos  
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
    GROUP BY a.first_name, a.last_name
	HAVING COUNT(f.film_id) > 10;
    
/*19.Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.*/
SELECT title AS peliculas_R_mas2horas
	FROM film 
    WHERE LENGTH > 120 AND rating = 'R';
    
/*20Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración.*/
SELECT c.name AS categorias_media_mas2horas
	FROM category AS c
	INNER JOIN film_category AS fc
    USING (category_id)
	INNER JOIN film AS f
    USING (film_id)
    GROUP BY c.name
    HAVING AVG(length) > 120;
    
/*21Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado.*/
SELECT CONCAT(a.first_name, '  ', a.last_name) AS actores_min5pelis, COUNT(f.film_id) AS total_peliculas
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
    GROUP BY a.first_name, a.last_name
	HAVING COUNT(f.film_id) >= 5;
    
/*22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días
y luego selecciona las películas correspondientes.*/

-- Exploro primero las tablas y establezco la condicion
SELECT *
	FROM rental;

SELECT r.rental_id
	FROM rental AS r
    WHERE (r.return_date - r.rental_date) > 5;

-- query completa
SELECT f.title AS pelis_alquiladas_mas5dias
	FROM film AS f
	INNER JOIN inventory AS i 
	USING (film_id)
	INNER JOIN rental AS r 
	USING (inventory_id)
	WHERE r.rental_id IN (SELECT r.rental_id
							FROM rental AS R
							WHERE (r.return_date - r.rental_date) > 5);

/*23.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película
de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores*/

-- OBTENGO PRIMERO LA CONDICION CATEGORIA NO HORROR
SELECT f.film_id, c.name
				FROM film AS f
                INNER JOIN film_category AS fc
                USING (film_id)
                INNER JOIN category AS c
                USING (category_id)
				WHERE  c.name <> "Horror";

-- QUERY FINAL
SELECT CONCAT(a.first_name, '  ', a.last_name) AS actores_no_horror
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
	WHERE f.film_id NOT IN (SELECT f.film_id
				FROM film AS f
                INNER JOIN film_category AS fc
                USING (film_id)
                INNER JOIN category AS c
                USING (category_id)
				WHERE  c.name <> "Horror");
                
                
-- QUERY CON CTE
WITH actores_generos_no_horror AS                            
	(SELECT a.first_name, a.last_name, f.film_id, c.name
		FROM actor AS a
		INNER JOIN film_actor AS fa
		USING (actor_id)
		INNER JOIN film AS f
		USING (film_id)
		INNER JOIN film_category AS fc
		USING (film_id)
		INNER JOIN category AS c
		USING (category_id))

SELECT first_name, last_name, name 
	FROM actores_generos_no_horror 
    WHERE name <> "Horror";
    
    
-- OTRA OPCION CON CTE
WITH actores_generos_no_horror AS                            
	(SELECT a.first_name, a.last_name, f.film_id, c.name
		FROM actor AS a
		INNER JOIN film_actor AS fa
		USING (actor_id)
		INNER JOIN film AS f
		USING (film_id)
		INNER JOIN film_category AS fc
		USING (film_id)
		INNER JOIN category AS c
		USING (category_id))
    
SELECT first_name, last_name
	FROM actores_generos_no_horror 
    WHERE name <> "Horror"
    GROUP BY first_name, last_name;    
 
/*24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
la tabla film*/
SELECT f.title AS comedias_mas3horas
	FROM film AS f
    INNER JOIN film_category AS fc
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
	WHERE c.name = "Comedy" AND f.length > 180; 