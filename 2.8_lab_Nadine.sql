-- 2.8 Lab - Nadine (use sakila)

-- Task 1: Write a query to display for each store its store ID, city, and country.

SELECT st.store_id, ci.city, co.country
FROM sakila.store st
JOIN sakila.address ad
ON ad.address_id = st.address_id
JOIN sakila.city ci USING (city_id)
JOIN sakila.country co USING (country_id)
GROUP BY st.store_id
ORDER BY st.store_id ASC;

-- Task 2: Write a query to display how much business, in dollars, each store brought in.
SELECT sto.store_id, ROUND(SUM(p.amount)) AS 'Business in Dollars'
FROM sakila.payment p
JOIN sakila.staff sta USING (staff_id)
JOIN sakila.store sto USING (store_id)
GROUP BY sto.store_id;

-- Task 3: Which film categories are longest?
SELECT c.name, AVG(f.length)
FROM sakila.category c
JOIN sakila.film_category fc USING (category_id)
JOIN sakila.film f USING (film_id)
GROUP BY c.name
ORDER BY AVG(f.length) DESC;
-- Answer: to find out the longest films per category on average, I used AVG. Alternative: In order to find out the longest film per category, exchange AVG with MAX

-- Task 4: Display the most frequently rented movies in descending order.
SELECT f.title, COUNT(r.rental_id) 
FROM sakila.rental r
JOIN sakila.inventory i USING (inventory_id)
JOIN sakila.film f USING (film_id)
GROUP BY f.title
ORDER BY COUNT(rental_id) DESC;
-- Answer: Most frequently rented movie: Bucket Brotherhood, 34 times

-- Task 5: List the top five genres in gross revenue in descending order.
SELECT c.name, SUM(p.amount)
FROM sakila.category c
JOIN sakila.film_category fc USING (category_id)
JOIN sakila.inventory i USING (film_id)
JOIN sakila.rental r USING (inventory_id)
JOIN sakila.payment p USING (customer_id)
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- Task 6: Is "Academy Dinosaur" available for rent from Store 1?
SELECT st.store_id, f.title
FROM sakila.film f
JOIN sakila.inventory i USING (film_id)
JOIN sakila.store st USING (store_id)
WHERE title='Academy Dinosaur' AND st.store_id=1
GROUP BY st.store_id;
-- Answer: Yes, 'Academy Dinosaur' is available for rent from Store 1.

-- Task 7: Get all pairs of actors that worked together.

SELECT f.film_id, f2.actor_id, f3.actor_id, CONCAT(a1.first_name, ' ', a1.last_name), CONCAT(a2.first_name, ' ', a2.last_name)
FROM sakila.film f
JOIN sakila.film_actor f2 ON f.film_id = f2.film_id
JOIN sakila.actor a1 ON f2.actor_id = a1.actor_id
JOIN sakila.film_actor f3 ON f.film_id = f3.film_id
JOIN sakila.actor a2 ON f3.actor_id = a2.actor_id
WHERE CONCAT(a1.first_name, ' ', a1.last_name) <> CONCAT(a2.first_name, ' ', a2.last_name)
ORDER BY f.film_id ASC;

-- Answer: I could not figure out how to get rid of the duplicates :(

-- BONUS QUESTIONS (for now - till next week):

-- Task 8: Get all pairs of customers that have rented the same film more than 3 times.

-- Task 9: For each film, list actor that has acted in more films.
