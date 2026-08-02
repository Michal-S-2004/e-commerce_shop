select * from customers
select first_name, last_name from customers
select product_name from product where product_price>3000
select product_name from product order by product_price desc
select last_name, first_name from customers order by last_name
select product_name from product order by product_price desc limit 5
select last_name, first_name from customers  where created_at > '2026-01-01' order by last_name


select last_name, first_name from customers where first_name like 'A%'
select product_name from product where product_name like '%Samsung%'
select product_name from product where category_id = 1 or category_id = 3 or  category_id = 5
select product_name from product where category_id in (1,3,5)
select order_id from customer_orders where current_date - order_date <=30
select count(*) customer_id from customers
select count(*) product_id from product group by category_id
select avg(product_price) from product group by category_id
select category_id, MAX(product_price) from product group by category_id 
SELECT product_name,
       product_price,
       category_id
FROM product
WHERE product_price IN (
    SELECT MAX(product_price)
    FROM product
    GROUP BY category_ida
);

select p.product_price, p.product_name, p.category_id from product as p where p.product_price = (select min(p2.product_price) from product as p2 where p2.category_id = p.category_id)
select p.product_price, p.product_name, p.category_id from product as p where p.product_price > (select avg(p2.product_price) from product as p2 where p2.category_id = p.category_id)

select c.customer_id, c.last_name from customers as c  where customer_id IN(select c2.customer_id from customer_orders as c2 group by customer_id having count(order_id) = 1 )
select order_date, COUNT(*) as orders_daily from customer_orders group by order_date order by order_date
select order_date, count(*) as number_of_orders from customer_orders group by order_date having count(*)>3

select c.category_id, c.category_name from categories as c where c.category_id IN (select category_id from product where product_price > 3000 group by category_id having count(*)>1)

select p.product_name from product as p where p.product_id not in(select product_id from order_items)

select customer_id, first_name from customers where customer_id in(select c_o.customer_id from customer_orders as c_o group by customer_id having sum(order_price)>=avg(order_price))

select category_id, category_name from categories where category_id in (select p.category_id from product as p group by p.category_id having avg(product_price)> (select avg(product_price) from product))

select c_o.order_id, c_o.order_date, c.first_name, c.last_name from customer_orders as c_o join customers as c on c_o.customer_id = c.customer_id

select p.product_name, p.product_price, c.category_name from product as p join categories as c on p.category_id = c.category_id

select p.product_name, c.category_name, p.product_price from product as p join categories as c on p.category_id = c.category_id where p.product_price>3000

select c_o.order_price, c_o.order_id, c.last_name, e.last_name from customer_orders as c_o join customers as c on c_o.customer_id = c.customer_id join employees as e on e.employee_id  = c_o.employee_id

select p.product_name, p.product_price, c.category_name from product as p join categories as c on p.category_id = c.category_id

select c.last_name, p.product_name, o_i.unit_price, o_i.quantity from customers as c join customer_orders as c_o on  c.customer_id = c_o.customer_id 
join order_items as o_i on c_o.order_id = o_i.order_id join product as p on o_i.product_id = p.product_id

select count(*) as number_of_products, c.category_id from categories as c join product as p on c.category_id = p.category_id group by c.category_id

select sum(o_i.quantity*o_i.unit_price), p.product_name from order_items as o_i join product as p on o_i.product_id = p.product_id group by product_name

select p.product_name, sum(o_i.quantity*o_i.unit_price) as income from product as p join order_items as o_i on p.product_id = o_i.product_id group by p.product_name order by income desc limit 5