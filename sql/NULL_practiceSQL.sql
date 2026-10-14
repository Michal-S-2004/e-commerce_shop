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

SELECT
    order_id,
    product_id,
    unit_price / NULLIF(quantity, 0) AS price_per_unit
FROM order_items;
