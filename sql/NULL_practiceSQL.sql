SELECT *
FROM customers
WHERE email IS NULL;

SELECT *
FROM customers
WHERE email IS NOT NULL;

SELECT
    customer_id,
    first_name,
    COALESCE(last_name, 'Brak nazwiska') AS last_name
FROM customers;
