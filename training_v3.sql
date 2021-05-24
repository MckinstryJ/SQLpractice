-- change to database
USE sql_hr;
-- select all from database
SELECT * FROM employees;
-- select specific condition
SELECT * FROM employees WHERE job_title = "Account Executive";
-- create a database
CREATE database database_example;
-- delete database
DROP database database_example;
-- insert into database
INSERT INTO employees 
	VALUES (
		33333, 
        'John', 
        'McKinstry', 
        'Cloud ML Engineer', 
        125000, 
        37270, 
        1);
-- update table
UPDATE employees set salary = 126000 where employee_id = 33333;
SELECT * FROM employees where employee_id = 33333;
DESCRIBE employees;
-- delete a row
DELETE FROM employees where employee_id = 33333;

-- CRUD complete --

-- create new table
create table testTable (
	ID int(4) not null,
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    telephone varchar(12),
    email varchar(50),
    zip_code varchar(10) not null,
    PRIMARY KEY (ID)
);
SELECT * FROM testTable;

-- joins
use sql_store;
SELECT 
	o.order_id as "Order Number", 
    first_name AS "Name",
	name AS "Status"
FROM customers c, orders o, order_statuses os where c.customer_id = o.customer_id AND o.status = os.order_status_id;

-- left join - joining customer with an order and the status that is related to the order
SELECT
	o.order_id AS "Order Number",
    first_name AS "Customer Name",
    os.name as "Status"
FROM orders o
LEFT JOIN customers c USING(customer_id)
JOIN order_statuses os ON o.status = os.order_status_id;

-- aggreates
select COUNT(*) AS "Number of Orders" from orders;
SELECT 
	customer_id AS "Cusomter ID", 
    COUNT(*) AS "Number of Orders" 
FROM orders GROUP BY customer_id;

-- math functions
USE sql_invoicing;
SELECT 
	client_id AS "Client No.", 
    payment_total / invoice_total AS "% paid",
    invoice_total - payment_total AS "Remaining"
FROM invoices;

-- subquery - compute the average of the payment total and use that as the metric
-- using the given metric find the id and number where its payment total is greater than metric
SELECT 
	invoice_id,
    number
FROM invoices WHERE payment_total > (
	SELECT AVG(payment_total) FROM invoices
);

-- create a table based on query
CREATE TABLE customer_payments
(
	customer_id int(11),
    pay_date date,
    first_name varchar(50),
    last_name varchar(50),
    pay_amount double,
    pay_type varchar(50),
    primary key (customer_id)
);

INSERT INTO customer_payments
SELECT 
	customer_id AS "Customer ID",
    date AS "Date", 
    first_name AS "First Name", 
    last_name AS "Last Name", 
    SUM(amount) AS "Amount",
    pm.name AS "Payment Type"
FROM sql_store.customers c
	JOIN payments p ON client_id = customer_id
    JOIN payment_methods pm ON payment_method_id = payment_method
GROUP BY customer_id;

-- create a view (live table that doesn't need to be archived)
CREATE VIEW customer_payment_totalscustomer_payment_totals AS
SELECT 
	customer_id AS "Customer ID",
    date AS "Date", 
    first_name AS "First Name", 
    last_name AS "Last Name", 
    SUM(amount) AS "Amount",
    pm.name AS "Payment Type"
FROM sql_store.customers c
	JOIN payments p ON client_id = customer_id
    JOIN payment_methods pm ON payment_method_id = payment_method
GROUP BY customer_id;

-- place info in csv file
-- 1. find location of where you can upload and download data
-- 2. change outfile location to that folder
SHOW VARIABLES LIKE "secure_file_priv";
SELECT 
	customer_id AS "Customer ID",
    date AS "Date", 
    first_name AS "First Name", 
    last_name AS "Last Name", 
    SUM(amount) AS "Amount",
    pm.name AS "Payment Type"
FROM sql_store.customers c
	JOIN payments p ON client_id = customer_id
    JOIN payment_methods pm ON payment_method_id = payment_method
GROUP BY customer_id
INTO outfile 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_total_payments.csv'
FIELDS ENCLOSED BY '"' TERMINATED BY ',' ESCAPED BY '\\'
LINES TERMINATED BY '\r\n';

-- Loading data from file
-- first delete all records
-- load from csv file (data / columns must match schema)
load data
infile 'C://ProgramData/MySQL/MySQL Server 8.0/Uploads/customer_total_payments.csv'
into table customers_load
fields enclosed by '"' terminated by ',' escaped by '\\'
lines terminated by '\r\n';

-- set variabes
set @oldCustomerNumber := 3;
set @newCustomerNumber := 13;

select * from customer_payments where customer_id = @newCustomerNumber;
update customer_payments 
set customer_id = @newCustomerNumber 
where customer_id = @oldCustomerNumber;

-- transactions
set sql_safe_updates = 0;

start transaction;
-- add update code
-- all must work correctly or none will ensuring they are all updated correctly
commit;
set sql_safe_updates = 1;

-- updating all items in table with currency format
update products
set unit_price = format(unit_price * 1.10, 2)
where product_id >= 0;


