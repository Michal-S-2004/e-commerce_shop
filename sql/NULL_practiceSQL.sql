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

SELECT
    product_id,
    product_name,
    CASE
        WHEN price IS NULL THEN 'Brak ceny'
        WHEN price = 0 THEN 'Cena zerowa'
        ELSE 'Cena dodatnia'
    END AS price_status
FROM product;
