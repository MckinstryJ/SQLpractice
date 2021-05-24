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
