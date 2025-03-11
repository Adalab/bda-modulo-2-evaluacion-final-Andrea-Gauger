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
    
-- 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
SELECT rating, COUNT(rating)
	FROM film
    GROUP BY rating;
    
-- 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, 
-- su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id)
	FROM customer AS c
    INNER JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
##########    ME DOY CUENTA QUE ESTA PIDIENDO POR CADA CLIENTE ##########
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) 
	FROM customer AS c
    LEFT JOIN rental AS r
    USING (customer_id)
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
-- 11. Encuentra la cantidad total de películas alquiladas por categoría y 
-- muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT c.name, COUNT(r.rental_id)
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






    
    
