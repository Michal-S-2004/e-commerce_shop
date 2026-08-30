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

SELECT product_name, product_price, CASE WHEN product_price>5000 THEN 'premium' WHEN product_price<=5000 THEN 'normal' end as price_category from product

select first_name, last_name, created_at, case when created_at>= '01-01-2026' then 'new' else 'old' end as customer_category from customers

select order_id, case when order_price<1000 then 'small' when order_price between 1000 and  3000 then 'medium' else 'large' end as order_category from customer_orders

select c.first_name, c.last_name, c_o.order_price, case when c_o.order_price >=6000 then 'VIP' else 'usual' end as order_category from customers as c join customer_orders as c_o on c.customer_id = c_o.customer_id

select c_o.order_id, e.first_name, e.last_name, case when c_o.order_price >=6000 then 'VIP' else 'usual' end as order_category from employees as e join customer_orders as c_o on e.employee_id = c_o.employee_id

select count(*) as number_of_customers, case when created_at>= '01-01-2026' then 'new' else 'old' end as customer_category from customers group by case when created_at>= '01-01-2026' then 'new' else 'old' end

select c.customer_id, c.first_name, c.last_name, count(c_o.order_id) as number_of_orders from customers as c left join customer_orders as c_o on c.customer_id = c_o.customer_id group by c.customer_id order by number_of_orders 



select c.first_name, c.last_name from customers as c where c.first_name in ('Kasia', 'Katarzyna', 'Michal')


select * from categories as c left join product as p on c.category_id = p.category_id


select c.last_name from customers as c left join customer_orders as c_o on c.customer_id = c_o.customer_id group by c.customer_id having count(c_o.order_id) = 0


select c.first_name, c.last_name, c_o.order_id, p.product_name from customers as c left join customer_orders as c_o on c.customer_id = c_o.customer_id left join order_items as o_i on c_o.order_id = o_i.order_id left join product as p on o_i.product_id =p.product_id



select e.last_name, e.first_name, sum(o_i.quantity*o_i.unit_price)  from employees as e left join customer_orders as c_o on e.employee_id = c_o.employee_id left join  order_items as o_i on c_o.order_id = o_i.order_id group by e.last_name, e.first_name

     

with number_of_orders as (select count(c_o.order_id) as amount, c_o.customer_id as customer_id from customer_orders as c_o group by c_o.customer_id )
select c.customer_id, nof.amount from customers as c left join number_of_orders as nof on c.customer_id = nof.customer_id

with number_of_orders as (select count(c_o.order_id) as amount, c_o.customer_id as customer_id from customer_orders as c_o group by c_o.customer_id )
select c.customer_id, nof.amount from customers as c join number_of_orders as nof on c.customer_id = nof.customer_id where nof.amount>3

select c.last_name, c.first_name, sum(order_price) from customers as c join customer_orders as c_o on c.customer_id = c_o.customer_id group by c_o.customer_id, c.last_name, c.first_name  having sum(order_price)>5000

with number_of_orders as (select count(c_o.order_id) as amount, c_o.employee_id as employee from customer_orders as c_o group by c_o.employee_id)
select e.first_name, e.last_name, nof.amount from employees as e left join number_of_orders as nof  on nof.employee = e.employee_id	  group by e.first_name, e.last_name, nof.amount order by e.last_name


select p.product_id, case when p.product_price<1000 then 'cheap' when p.product_price between 1000.01 and 3000 then 'regular' else 'expensive' end as category from product as p 

select c.customer_id, case when c.created_at between '2025-01-01' and '2025-12-31' then '2025' when c.created_at between '2024-01-01' and '2024-12-31' then '2024' else '2026'  end as year_of_acc_creation from customers as c
select c.customer_id, to_char(c.created_at, 'YYYY') as year_of_account_creation from customers as c

with average as (select avg(c_o.order_price) as overall_avg from customer_orders as c_o)
select c.customer_id, c.last_name, c.first_name, sum(c_o.order_price) as revenue from customers as c 
left join customer_orders as c_o on c.customer_id = c_o.customer_id cross join average as a group by c.customer_id, c.first_name, c.last_name, a.overall_avg having sum(c_o.order_price)>a.overall_avg order by revenue desc

select cat.category_id, count(p.product_id) as amount_of_products from categories as cat left join product as p on cat.category_id = p.category_id group by cat.category_id having count(p.product_id)>7

with number_of_orders as (select count(c_o.order_id) as amount, c_o.customer_id as customer_id from customer_orders as c_o group by c_o.customer_id ),
customer_category as (select c.customer_id as customer_id, case when nof.amount >4 then 'VIP' else 'regular' end as category from customers as c left join number_of_orders as nof on nof.customer_id = c.customer_id)
select c.first_name, c.last_name, c_c.category from customers as c left join customer_category as c_c on c.customer_id = c_c.customer_id group by c.first_name, c.last_name, c_c.category


with orders_daily as (select count(*) as amount, date(c_o.order_date)  from customer_orders as c_o group by date(c_o.order_date)),
dates_with_good_sales as (select * from orders_daily where orders_daily.amount>1)
select * from dates_with_good_sales order by dates_with_good_sales.amount DESC


with revenue_per_customer as (select c_o.customer_id as customer_id, sum(c_o.order_price) as revenue from customer_orders as c_o group by c_o.customer_id),
average_revenue as (select avg(r_p_c.revenue) as avg_revenue from customer_orders as c_o left join revenue_per_customer as r_p_c on r_p_c.customer_id = c_o.customer_id ),
customer_status as (select c.first_name, c.last_name,  r_p_c.revenue, case when r_p_c.revenue>a_r.avg_revenue then 'VIP' else 'regular'end as status 
from customers as c join customer_orders as c_o on c.customer_id = c_o.customer_id left join revenue_per_customer as r_p_c on r_p_c.customer_id = c_o.customer_id cross join average_revenue as a_r group by c.first_name, c.last_name, r_p_c.revenue  )
select * from customer_status


select * from customers where extract(year from created_at) = 2026

select p.product_name, extract(month from c_o.order_date) from product as p left join order_items as o_i on p.product_id = o_i.product_id left join customer_orders as c_o on c_o.order_id = o_i.order_id group by extract(month from c_o.order_date)  , p.product_name

select * from customer_orders where order_date < current_date - interval '180 days'

select p.product_name, extract(year from c_o.order_date) as calendar_year, count (p.product_id) as amount from product as p 
left join order_items as o_i on p.product_id = o_i.product_id left join customer_orders as c_o on c_o.order_id = o_i.order_id
group by p.product_name, extract(year from c_o.order_date) order by amount desc


select c.customer_id, c.first_name, c.last_name from customers as c join customer_orders as c_o on c.customer_id = c_o.customer_id where date(c_o.order_date) - date(c.created_at) <= 30

select c.customer_id, min(current_date - date(c_o.order_date)) as days_from_last_order from customers as c join customer_orders as c_o on c.customer_id = c_o.customer_id group by c.customer_id order by min(current_date - date(c_o.order_date))

select c.customer_id, c.first_name, c.last_name, max(c_o.order_date) as last_order_date from customers as c left join customer_orders as c_o on c.customer_id = c_o.customer_id group by c.customer_id, c.first_name, c.last_name having max(c_o.order_date) < current_date - interval '90 days' or max(c_o.order_date) is null

select extract(year from c_o.order_date)::int as calendar_year, extract(quarter from c_o.order_date)::int as calendar_quarter, sum(c_o.order_price) as revenue from customer_orders as c_o group by extract(year from c_o.order_date)::int, extract(quarter from c_o.order_date)::int order by calendar_year, calendar_quarter


select e.first_name, e.last_name, count(*) as amount_of_orders from employees as e join customer_orders as c_o on e.employee_id = c_o.employee_id group by e.first_name, e.last_name order by amount_of_orders desc limit 1

select e.first_name, e.last_name, sum(order_price) as total_sales from employees as e join customer_orders as c_o on e.employee_id = c_o.employee_id group by e.first_name, e.last_name order by total_sales desc limit 1

with products_sold_overall as (select p.product_id, p.category_id,  coalesce(sum(o_i.quantity),0) as amount_of_products from product as p join order_items as o_i on p.product_id = o_i.product_id group by p.product_id, p.category_id),
products_per_category as (select cat.category_name, cat.category_id, sum(p_s_o.amount_of_products) as products_by_category from categories as cat join products_sold_overall as p_s_o on p_s_o.category_id = cat.category_id 
group by cat.category_name, cat.category_id ),
products_per_category_average as (select avg(p_p_r.products_by_category) as average from products_per_category as p_p_r)
select cat.category_name, p_p_r.products_by_category from categories as cat join products_per_category as p_p_r on cat.category_id = p_p_r.category_id
cross join products_per_category_average as p_p_c_a where p_p_r.products_by_category > p_p_c_a.average 


with customers_spendings_on_categories as (
    select cat.category_id, cat.category_name, c.customer_id, c.last_name, c.first_name,
           sum(o_i.quantity * o_i.unit_price) as revenue
    from categories as cat
    join product as p on p.category_id = cat.category_id
    join order_items as o_i on o_i.product_id = p.product_id
    join customer_orders as c_o on o_i.order_id = c_o.order_id
    join customers as c on c_o.customer_id = c.customer_id
    group by cat.category_id, cat.category_name, c.customer_id, c.last_name, c.first_name
),
max_revenue_per_category as (
    select category_id, max(revenue) as max_revenue
    from customers_spendings_on_categories
    group by category_id
)
select c_s.category_name, c_s.first_name, c_s.last_name, c_s.revenue
from customers_spendings_on_categories as c_s
join max_revenue_per_category as m_r
    on c_s.category_id = m_r.category_id
    and c_s.revenue = m_r.max_revenue
    
create view category_revenue as
select cat.category_id, cat.category_name, SUM(o_i.quantity) AS amount_of_products_sold, SUM(o_i.quantity * p.product_price) as revenue 
from customer_orders as c_o 
join order_items as o_i on o_i.order_id = c_o.order_id join product as p on p.product_id = o_i.product_id join categories as cat on cat.category_id = p.category_id
group by cat.category_id, cat.category_name;


select * from category_revenue;

DROP VIEW category_revenue;

select order_id, employee_id, order_price from customer_orders where order_price <200 union select order_id, employee_id, order_price from customer_orders where order_price>800

select order_id, employee_id, order_price from customer_orders where order_price >400 intersect select order_id, employee_id, order_price from customer_orders where employee_id = 5
