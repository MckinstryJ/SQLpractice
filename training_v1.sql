# Connect with Database Managment System
# RDB - relational database | NoSQL - unorganized database
# RDBMS - mysql, sql server, oracle

# select all from specific database.table
SELECT * FROM sql_store.customers;

# remove the need of database in database.table
USE sql_store;
SELECT * FROM customers;

# selecting specific condition
SELECT * FROM customers 
-- WHERE customer_id = 1  # -- creates a comment
ORDER BY first_name;

# either... or --- and is looked at first before or
SELECT * FROM customers WHERE birth_date > '1990-01-01' OR points > 3000;

-- From order_items table, get the items
-- 		for order #6
--		where the total price is greater than 30
SELECT * FROM order_items WHERE order_id = 6 and unit_price * quantity > 30;

-- in operator which shortens multiple or operations
SELECT * FROM customers WHERE state IN ('va', 'ga', 'fl');

-- return products with quanity in stock equal to 49, 38, 72
SELECT * FROM products WHERE products.quantity_in_stock IN (49, 28, 72);

-- between operator inclusive
SELECT * FROM customers where points between 1000 AND 3000;

-- wildcard - starts with b
SELECT * FROM customers where last_name LIKE 'b%';

-- wildcard - ends with b
SELECT * FROM customers where last_name LIKE '%b';

-- wildcard - starts and ends with a
SELECT * FROM customers where last_name LIKE 'a%a';

-- get customers whose addresses contain trail or avenue
SELECT * FROM customers WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
-- phone numbers end with 9
SELECT * FROM customers WHERE phone LIKE '%9';

-- rengex - similar to like 
-- ('%abc%' in like is similar to 'abc' in regexp)
-- (^field - must start with field)
-- (field$ - must end with field)
SELECT * FROM customers WHERE last_name REGEXP 'field|mac';

-- customer has g, i or m before e
SELECT * FROM customers WHERE last_name REGEXP '[gim]e';

-- customer has a through h before e
SELECT * FROM customers WHERE last_name REGEXP '[a-h]e';

-- get customers whose
--		first names are elka or ambur
SELECT * FROM customers WHERE first_name LIKE 'elka' OR first_name LIKE 'ambur';
-- 		last names end with ey or on
SELECT * FROM customers WHERE last_name REGEXP 'ey$|on$';
--		last names start with my or contains se
SELECT * FROM customers WHERE last_name REGEXP '^my|se';
--		last names contain B followed by r or u
SELECT * FROM customers WHERE last_name REGEXP 'b[r|u]';

-- select where null
SELECT * FROM customers WHERE phone IS NULL;

-- select orders that have not shipped
SELECT * FROM orders WHERE shipped_date IS NULL;

-- ordering in descending order
SELECT * FROM customers ORDER BY first_name DESC;

-- order by total price of order id = 2
SELECT * FROM order_items WHERE order_id = 2 ORDER BY quantity * unit_price DESC;

-- limit keyword
SELECT * FROM customers LIMIT 10;
-- start 6 positions later and only show 3
SELECT * FROM customers LIMIT 6, 3;
-- get the top three loyal customers
SELECT * FROM customers ORDER BY points DESC LIMIT 3;