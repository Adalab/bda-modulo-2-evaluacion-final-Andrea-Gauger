Readme Evaluación Módulo 2 Andrea Gauger

# Prueba de Evaluación - Módulo SQL

## Descripción del Proyecto
Este repositorio contiene la prueba de evaluación correspondiente al módulo de SQL del Bootcamp de Data Analyst. El objetivo de esta prueba es evaluar la capacidad de escribir queries SQL eficientes, limpias y correctas para resolver problemas típicos relacionados con bases de datos y análisis de datos.

## Estructura de la Base de Datos
La base de datos utilizada para esta evaluación es una base de datos de gestión de alquileres de películas. Las tablas relevantes incluyen:

- actor: Información sobre los actores y actrices.
- film: Información sobre las películas disponibles para alquilar.
- rental: Registros de alquileres de películas, que incluyen las fechas de alquiler y devolución.
- inventory: Información sobre el inventario de películas.
- film_category: Relación entre las películas y sus categorías.
- category: Categorías a las que pertenecen las películas (por ejemplo, "Action", "Family", "Comedy").

## Consultas SQL Realizadas
1. Encuentra la cantidad total de películas alquiladas por cada cliente.
Descripción: Se busca obtener el ID, nombre y apellido de cada cliente junto con la cantidad total de películas que han alquilado.

sql
Copiar
SELECT c.customer_id AS id_cliente, 
       c.first_name AS nombre, 
       c.last_name AS apellido, 
       COUNT(r.rental_id) AS total_peliculas_alquiladas
FROM customer AS c
LEFT JOIN rental AS r 
    ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

2. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días.
Descripción: Se utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días, y luego seleccionamos las películas correspondientes.

sql
Copiar
SELECT f.title, r.inventory_id
FROM film AS f
INNER JOIN inventory AS i 
    USING (film_id)
INNER JOIN rental AS r 
    USING (inventory_id)
WHERE r.rental_id IN (
    SELECT r.rental_id
    FROM rental AS r
    WHERE (r.return_date - r.rental_date) > 5
);

3. Encuentra si algún actor no aparece en ninguna película en la tabla film_actor.
Descripción: Identificamos actores que no están asociados a ninguna película en la base de datos.

sql
Copiar
SELECT a.first_name, a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

4. Encuentra el título de todas las películas que son de la misma categoría que "Family".
Descripción: Se seleccionan las películas que pertenecen a la misma categoría que "Family", utilizando una subconsulta.

sql
Copiar
SELECT f.title
FROM film AS f
INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
INNER JOIN category AS c
    ON fc.category_id = c.category_id
WHERE c.name = "Family";

## Requisitos
SQL compatible con MySQL.
Acceso a las tablas actor, film, rental, inventory, film_category y category dentro de una base de datos de ejemplo de alquiler de películas.
Uso de las funciones estándar de SQL como JOIN, COUNT, GROUP BY, subconsultas y operadores lógicos.

## Instalación
Clona este repositorio:

bash
Copiar
git clone <url_del_repositorio>
Carga el archivo SQL (si se proporciona) en tu servidor de base de datos MySQL.

Asegúrate de que las tablas necesarias estén disponibles para ejecutar las consultas proporcionadas.

## Conclusión
Esta prueba de evaluación tiene como objetivo poner a prueba los conocimientos adquiridos sobre SQL, incluyendo el uso de JOIN, funciones de agregación, subconsultas y operaciones de filtrado. Las consultas desarrolladas resuelven problemas reales relacionados con bases de datos de gestión de alquileres de películas.

Este README proporciona un resumen claro del proyecto y las consultas realizadas, junto con instrucciones sencillas sobre cómo usar el código. Puedes adaptarlo o agregar más detalles si lo consideras necesario. ¡Buena suerte!



