-- see all users
select * from mysql.user;

-- create a user
CREATE USER 'john'@'localhost' IDENTIFIED BY 'helloworld';

-- grant all privileges
GRANT ALL PRIVILEGES ON *.* TO 'john'@'localhost';

-- revoke permissions
REVOKE ALTER ON *.* FROM 'john'@'localhost';

-- Show permissions
SHOW GRANTS FOR 'john'@'localhost';

-- finalize changes
FLUSH PRIVILEGES;

-- create user for specific view
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'helloworld';
GRANT SELECT ON sql_invoicing.customer_payment_totals TO 'bob'@'localhost';

-- deleting user
drop user 'bob'@'localhost';

-- see all system variables
SHOW VARIABLES WHERE Variable_Name LIKE '%dir';

-- run mysql command in command prompt
-- 1. move to MySQL Server \ bin
-- 2. run 'mysql -e "select * from sql_invoicing.customer_payment_totals" -u bob -p
-- this will ask for bob's login password and the sql will show as a table

-- doing the same but pushing to file
-- mysql.exe -e "select * from sql_invoicing.customer_payment_totals" 
-- -u john -p > 
-- C:\Users\xzten\Desktop\Databases\MySQL\SQL Course Materials\customer.txt

-- can do it with a dump aka data export

-- actual dump command
-- run 'mysqldump -u john -p sql_hr employees > C:\Users\xzten\backups\customer.sql'

-- journaling - continues to grow until database is backed up
-- committing the data is called "truncating" the log file

-- everything done is saved to a binary log
-- can completely reproduce the database (will contain usernames, passwords, etc)

-- Creating a Trigger
CREATE TABLE tblcustomer (
	employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL
);

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON tblcustomer
    FOR EACH ROW 
 INSERT INTO employees_audit
 SET action = 'update',
     employeeNumber = OLD.employeeNumber,
     lastname = OLD.lastname,
     changedat = NOW();

INSERT INTO tblcustomer VALUES (10, 'McKinstry');
UPDATE tblcustomer
SET 
	lastName = 'Smith'
WHERE 
	employeeNumber = 10;
    
SELECT * FROM tblcustomer;
SELECT * FROM employees_audit;
