USE sakila;
SELECT first_name,last_name FROM actor;
SELECT CONCAT(first_name," ",last_name) AS 'Actor Name' FROM actor;
SELECT actor_id,first_name,last_name FROM actor WHERE first_name='Joe';
SELECT*FROM actor WHERE last_name LIKE '%gen%';
SELECT*FROM actor WHERE last_name LIKE '%LI%' ORDER BY last_name,first_name;
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
ALTER TABLE actor ADD description BLOB; 
ALTER TABLE actor DROP COLUMN description;
SELECT DISTINCT last_name,count(last_name) AS 'count' from actor GROUP BY last_name;
 SELECT DISTINCT last_name,count(last_name) AS 'count' from actor GROUP BY last_name HAVING count>1;
UPDATE actor SET first_name = 'HARPO' WHERE first_name = 'GROUCHO' AND last_name='WILLIAMS';
SET SQL_SAFE_UPDATES = 0;
UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO';
SHOW CREATE TABLE address;
SELECT staff.first_name,staff.last_name,address.address FROM staff INNER JOIN address ON address.address_id=staff.address_id;
SELECT SUM(payment.amount) AS total_amount, staff.first_name, staff.last_name 
FROM payment 
INNER JOIN staff ON payment.staff_id=staff.staff_id
 WHERE payment.payment_date>='2005-08-01 00:00:00' AND payment.payment_date <'2005-09-01 00:00:00' 
 GROUP BY payment.staff_id;
 SELECT film.title, count(film_actor.film_id) AS actor_count FROM film
 INNER JOIN film_actor ON film.film_id = film_actor.film_id
 GROUP BY film.title;
 SELECT film.title, COUNT(inventory.inventory_id) 
 FROM inventory
 INNER JOIN film ON film.film_id = inventory.film_id
 WHERE film.title = 'Hunchback Impossible'
 GROUP BY film.title;
SELECT customer.first_name, customer.last_name, SUM(payment.amount)
FROM customer
INNER JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id
ORDER BY customer.last_name;
SELECT film.title FROM film 
WHERE title LIKE 'K%' OR title LIKE 'Q%' AND language_id IN 
(SELECT language_id FROM language WHERE name='English');
SELECT first_name, last_name FROM actor
WHERE actor_id 
IN (SELECT actor_id FROM film_actor WHERE film_id 
	IN(	SELECT film_id FROM film WHERE title='Alone Trip'));
SELECT customer.first_name, customer.last_name, customer.email
FROM customer 
INNER JOIN address on customer.address_id=address.address_id
INNER JOIN city on address.city_id = city.city_id
INNER JOIN country on country.country_id=city.country_id
WHERE country.country='Canada';
SELECT title FROM film 
WHERE film_id 
IN(SELECT film_id FROM film_category 
	WHERE category_id IN(SELECT category_id FROM category WHERE name = 'family'));
SELECT film.title, COUNT(rental.rental_id) AS frequency FROM film
INNER JOIN inventory ON film.film_id = inventory.film_id 
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY frequency DESC;
SELECT store.store_id, SUM(payment.amount) AS total_business FROM store
INNER JOIN inventory ON store.store_id=inventory.store_id
INNER JOIN rental ON inventory.inventory_id=rental.inventory_id
INNER JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY store_id;
SELECT store.store_id,city.city,country.country FROM store
INNER JOIN address ON store.address_id=address.address_id
INNER JOIN city ON address.city_id=city.city_id
INNER JOIN country ON city.country_id=country.country_id
GROUP BY store_id;
SELECT category.name, SUM(payment.amount) AS gross FROM category
INNER JOIN film_category ON category.category_id=film_category.category_id
INNER JOIN inventory ON film_category.film_id=inventory.film_id
INNER JOIN rental ON inventory.inventory_id=rental.inventory_id
INNER JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY category.name
ORDER BY gross DESC
LIMIT 5;
CREATE TABLE top_5_genres AS (
SELECT category.name AS category_name, SUM(payment.amount) AS gross FROM category
INNER JOIN film_category ON category.category_id=film_category.category_id
INNER JOIN inventory ON film_category.film_id=inventory.film_id
INNER JOIN rental ON inventory.inventory_id=rental.inventory_id
INNER JOIN payment ON rental.rental_id=payment.rental_id
GROUP BY category.name
ORDER BY gross DESC
LIMIT 5
);
ALTER TABLE top_5_genres
CHANGE COLUMN category_name genre VARCHAR(50);
ALTER TABLE top_5_genres
CHANGE COLUMN gross total_gross DOUBLE;
DROP TABLE top_5_genres;
