-- ASC by default
SELECT
	*
FROM
	products
ORDER BY
	quantity_in_stock DESC;
    
-- order by custom math function
SELECT
	*
FROM
	products
ORDER BY
	quantity_in_stock * unit_price;
    
-- order by custom fields
SELECT
	*
FROM
	products
ORDER BY
	FIELD(name,
		'Broom - Push',
        'Island Oasis - Raspberry') DESC; 