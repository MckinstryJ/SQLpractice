-- inner joins - combining only rows where customer id is in both
USE sql_store;
SELECT * FROM orders 
	INNER JOIN customers 
		ON orders.customer_id = customers.customer_id;
-- shows all information (customer_id twice)
SELECT order_id, o.customer_id, first_name, last_name FROM orders o
	JOIN customers c
		ON o.customer_id = c.customer_id;

-- join with product table - pid, name, quanity, order price
SELECT o.product_id, name, quantity_in_stock, o.unit_price FROM order_items o
JOIN products p
		ON o.product_id = p.product_id;

-- if in other database
SELECT * FROM order_items oi JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;
    
-- self join - if you want all employees that have a manager as an example
USE sql_hr;
SELECT e.first_name as "Employee Name", m.first_name as "Manager Name" FROM employees e 
	JOIN employees m ON e.reports_to = m.employee_id;
    
-- join 3 tables
USE sql_store;
SELECT 
	o.order_id,
    o.order_date,
    c.first_name,
    c.last_name,
    os.name AS status
FROM orders o 
	JOIN customers c ON o.customer_id = c.customer_id
    JOIN order_statuses os ON o.status = os.order_status_id;
    
-- join payment methods with payments and clients
USE sql_invoicing;
SELECT 
	date,
    c.name,
    amount,
    pm.name as payment_method
    FROM payments as p
		JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
        JOIN clients c ON p.client_id = c.client_id;
        
-- joining on two conditions (order id and product id
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id;

-- implicit join (if you forget the where then you get a cross join)
SELECT *
	FROM orders o, customers c 
		WHERE o.customer_id = c.customer_id;

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
    FROM orders o
    LEFT JOIN customers c ON c.customer_id = o.customer_id
    ORDER BY c.customer_id;
-- left join (if they are in left no matter if there is a match with right)
-- right join (if they are in right no matter if there is a match with left)
-- cross join (every combination of the join)
-- self join (joining on itself - earlier example of employee and their manager)
-- natural join (join on columns that match)

-- using - replacing c.customer_id = o.customer_id
SELECT
	c.customer_id,
    c.first_name,
    o.order_id
    FROM orders o
    LEFT JOIN customers c USING (customer_id)
    ORDER BY c.customer_id;
    
-- using - multiple conditions
SELECT * FROM order_items oi JOIN order_item_notes oin
	USING (order_id, product_id);
    
-- union - combining queries together
-- whatever is queried first will be the column name
SELECT first_name as column_1 FROM customers
UNION
SELECT name FROM shippers;

-- inserting a row
INSERT INTO customers (
	last_name,
    first_name,
    birth_date,
    address,
    city,
    state)
VALUES(
	'Smith',
    'John', 
    '1990-01-01',
    'address',
    'city',
    'CA');
    
-- insert multiple rows in one command
INSERT INTO shippers (name)
	VALUES 
		('Shipper1'),
        ('Shipper2'),
        ('Shipper3');
        
-- insert in hiarchary rows (multiple tables)
INSERT INTO orders (customer_id, order_date, status)
	VALUES (1, '2019-01-02', 1);

-- get last inserted id
INSERT INTO order_items
	VALUES
		(LAST_INSERT_ID(), 1, 1, 2.95),
        (LAST_INSERT_ID(), 2, 1, 2.95);
        
-- archive data with subquery        
CREATE TABLE orders_archived 
	AS SELECT * FROM orders;
    
-- update a single row
USE sql_invoicing;
UPDATE invoices
	SET payment_total = 10, payment_date = '2019-03-01'
    WHERE invoice_id = 1;
    
-- update multiple records with multiple ids
USE sql_invoicing;
UPDATE invoices
	SET
		payment_total = invoice_total * 0.5,
        payment_date = due_date
    WHERE client_id IN (3, 4);
    
-- DELETE info
DELETE FROM invoices WHERE client_id = (
	SELECT * FROM clients WHERE name = 'Myworks'
    );