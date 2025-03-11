USE sakila;

-- 1. Selecciona todos los nombres de las películas sin que aparezcan duplicados.
SELECT DISTINCT(title)
	FROM film;

-- 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
SELECT title   -- , rating -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM film
    WHERE rating = "PG-13";
    
-- 3.  Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
SELECT title, description
	FROM film
    WHERE description LIKE '%amazing%';

-- 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
SELECT title   -- , length -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM film
    WHERE length > '120';

-- 5. Recupera los nombres de todos los actores.
SELECT first_name
	FROM actor;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT first_name, last_name
	FROM actor
	WHERE last_name LIKE '%Gibson%';
    
-- 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT first_name  -- , actor_id -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;

-- 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.
SELECT title  -- , rating -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM film
    WHERE rating <> "R" AND rating <> "PG-13";
    
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film 
-- y muestra la clasificación junto con el recuento.
SELECT rating, COUNT(rating) AS num_peliculas
	FROM film
    GROUP BY rating;
    
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
-- su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS n_peliculas_alquiladas
	FROM customer AS c
    INNER JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
##########    ME DOY CUENTA QUE ESTA PIDIENDO POR CADA CLIENTE ##########
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS n_peliculas_alquiladas
	FROM customer AS c
    LEFT JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y 
-- muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name, COUNT(r.rental_id) AS recuento_alquileres
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
    
-- 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
-- muestra la clasificación junto con el promedio de duración.
SELECT rating, ROUND(AVG(length)) AS promedio_duracion
	FROM film
    GROUP BY rating;
    
-- 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT a.first_name, a.last_name  -- , f.title -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
    WHERE f.title = "Indian Love";
    
-- 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
SELECT title  -- , description -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM film
    WHERE description LIKE '%dog%' OR description LIKE '%cat%';

######################## NO LO ENTIENDO, PREGUNTAR A CÉSAR ################################
-- 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.    
SELECT *
	FROM actor AS c
	INNER JOIN film_actor AS fa
	USING (actor_id)
	WHERE film_id IS  NULL;

###########################################################################################

-- 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT title  -- , release_year -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;
    
-- 17. Encuentra el título de todas las películas que son de la misma categoría que "Family".
SELECT f.title, c.name
	FROM film AS f
    LEFT JOIN film_category AS fc
    USING (film_id)
    LEFT JOIN category AS c
    USING (category_id)
	WHERE c.name = "Family";

SELECT f.title, c.name
	FROM film AS f
    INNER JOIN film_category AS fc
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
	WHERE c.name = "Family"; 

SELECT f.title, c.name
	FROM film AS f
    LEFT JOIN film_category AS fc
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
	WHERE c.name = "Family";

-- 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
SELECT a.first_name, a.last_name  -- , COUNT(f.film_id) -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
    GROUP BY a.first_name, a.last_name
	HAVING COUNT(f.film_id) > 10;
    
-- 19.  Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
SELECT title, length, rating
	FROM film 
    WHERE LENGTH > 120 AND rating = 'R';
    
-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
-- muestra el nombre de la categoría junto con el promedio de duración.
SELECT c.name, ROUND(AVG(length))
	FROM category AS c
	INNER JOIN film_category AS fc
    USING (category_id)
	INNER JOIN film AS f
    USING (film_id)
    GROUP BY c.name
    HAVING AVG(length) > 120;
    
-- 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
-- con la cantidad de películas en las que han actuado.
SELECT a.first_name, a.last_name, COUNT(f.film_id) AS num_peliculas
	FROM actor AS a
    INNER JOIN film_actor AS fa
    USING (actor_id)
    INNER JOIN film AS f
    USING (film_id)
    GROUP BY a.first_name, a.last_name
	HAVING COUNT(f.film_id) >= 5;
    
-- 22.  Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. 
-- Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días
-- y luego selecciona las películas correspondientes.

####### ESTO NO LO PEDIA ASÍ PERO YA LO TENÍA HECHO ###########
SELECt f.title
	FROM film AS f
    INNER JOIN inventory AS i
    USING (film_id)
    INNER JOIN rental AS r
    USING (inventory_id)
    WHERE r.return_date - r.rental_date > 5
    GROUP BY f.title;
###############################################################

SELECT *
	FROM rental;

SELECT r.rental_id
	FROM rental AS r
    WHERE (r.return_date - r.rental_date) > 5;

-- código final
SELECT f.title, r.inventory_id
	FROM film AS f
	INNER JOIN inventory AS i 
	USING (film_id)
	INNER JOIN rental AS r 
	USING (inventory_id)
	WHERE r.rental_id IN (SELECT r.rental_id
							FROM rental AS R
							WHERE (r.return_date - r.rental_date) > 5)
	GROUP BY f.title;

-- código final CON UNA VARIACIÓN
SELECT f.title, r.inventory_id
	FROM film AS f
	INNER JOIN inventory AS i 
	USING (film_id)
	INNER JOIN rental AS r 
	USING (inventory_id)
	WHERE r.rental_id IN (SELECT r.rental_id
							FROM rental AS R
							WHERE (r.return_date - r.rental_date) > 5)
	GROUP BY f.title;

-- 23.  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película
-- de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
-- categoría "Horror" y luego exclúyelos de la lista de actores
-- OBTENGO PRIMERO LA CONDICION CATEGORIA NO HORROR
SELECT f.film_id, c.name
				FROM film AS f
                INNER JOIN film_category AS fc
                USING (film_id)
                INNER JOIN category AS c
                USING (category_id)
				WHERE  c.name <> "Horror";

-- QUERY FINAL
SELECT a.first_name, a.last_name
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
    WHERE name <> "Horror"
    ORDER BY name;
    
    
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
 
-- 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
-- la tabla film.
SELECT f.title  -- , c.name, f.length  -- lo dejo comentado para que se pueda ver la comprobación en caso de que haga falta.
	FROM film AS f
    INNER JOIN film_category AS fc
    USING (film_id)
    INNER JOIN category AS c
    USING (category_id)
	WHERE c.name = "Comedy" AND f.length > 180; 
 
 
 
