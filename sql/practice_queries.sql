select c_o.order_id, round(c_o.order_price,2), round(avg(c_o.order_price) over(), 2) as average_price from customer_orders as c_o

select c_o.order_id, c_o.employee_id, e.first_name, e.last_name, round(avg(c_o.order_price) over(partition by c_o.employee_id)) as average from employees as e 
join customer_orders as c_o on e.employee_id = c_o.employee_id

select c_o.order_id, c_o.employee_id, c_o.order_price, count(*) over(partition by c_o.employee_id) as orders_per_employee from customer_orders as c_o 


select c_o.order_id, c_o.employee_id, c_o.order_price, max(c_o.order_price) over(partition by c_o.employee_id) from customer_orders as c_o

select c_o.order_id, c_o.order_price,c_o.order_date, row_number() over(order by c_o.order_date) from customer_orders as c_o 

select c_o.employee_id, c_o.order_id, c_o.order_date, row_number() over(partition by c_o.employee_id order by c_o.order_date ) from customer_orders as c_o


select c_o.order_id, c_o.order_price, rank() over(order by c_o.order_price desc) from customer_orders as c_o

select c_o.employee_id, c_o.order_id, c_o.order_price, rank() over(partition by c_o.employee_id order by c_o.order_price desc) from customer_orders as c_o

select p.product_id, p.product_name, p.product_price, cat.category_id, rank() over(partition by cat.category_id order by p.product_price desc) from product as p 
join categories as cat on cat.category_id = p.category_id

select c_o.order_id, c_o.order_date, c_o.order_price, lag(c_o.order_price)  over(order by c_o.order_date) as previous_price from customer_orders as c_o

select c_o.order_id, c_o.order_date, c_o.order_price, lag(c_o.order_price)  over(order by c_o.order_date) as previous_price, round((c_o.order_price - lag(c_o.order_price) over(order by c_o.order_date)),2) as difference 
from customer_orders as c_o

select c_o.order_id, c_o.order_price, sum(c_o.order_price) over(order by order_date, order_id) from customer_orders as c_o

select c_o.order_id, c_o.employee_id, c_o.order_price, sum(c_o.order_price) over(partition by employee_id order by order_date, order_id) from customer_orders as c_o

select c_o.order_id, c_o.order_price, c_o.order_price/(sum(c_o.order_price) over(order by order_id)) as percentage from customer_orders as c_o

select c_o.order_id, c_o.order_price, 100*c_o.order_price/sum(c_o.order_price)  over() as percentage from customer_orders as c_o

select c_o.order_id, c_o.order_date, c_o.order_price, (avg(c_o.order_price) over(order by c_o.order_date rows between 2 preceding and current row))as moving_average from customer_orders as c_o

select c_o.order_id, c_o.order_date, c_o.order_price,c_o.employee_id, round((avg(c_o.order_price) over(partition by c_o.employee_id order by c_o.order_date rows between 2 preceding and current row )),2) 
as moving_average  from customer_orders as c_o

select c_o.order_id, c_o.order_date, c_o.order_price, sum(c_o.order_price) over(order by order_date, order_id) from customer_orders as c_o


select c_o.order_id, c_o.order_date, c_o.order_price, avg(c_o.order_price) over(order by order_date, order_id rows between 4 preceding and current row ) as moving_average,
case when c_o.order_price>avg(c_o.order_price) over(order by order_date, order_id rows between 4 preceding and current row ) then 'above average' when c_o.order_price = avg(c_o.order_price) over(order by order_date, order_id rows between 4 preceding and current row ) then 'equals average' else 'below average' end as price_category
from customer_orders as c_o

select c_o.order_id, c_o.order_price,c_o.order_price - lead(c_o.order_price,2) over(order by c_o.order_date) as change, ntile(6) over(order by c_o.order_price) as groups from customer_orders as c_o

select c_o.order_id, sum(c_o.order_price) over(order by c_o.order_date, c_o.order_id), rank() over(order by c_o.order_date, c_o.order_id) from customer_orders as c_o

select c_o.order_id, c_o.order_price, first_value(c_o.order_price) over(order by c_o.order_price ) from customer_orders as c_o

select c_o.employee_id, e.first_name, e.last_name, c_o.order_price, first_value(c_o.order_price) over(partition by c_o.employee_id order by c_o.order_price desc ) as top_order from customer_orders as c_o
join employees as e on e.employee_id = c_o.employee_id


select c_o.employee_id, c_o.order_id, c_o.order_price, round(avg(c_o.order_price) over(partition by c_o.employee_id ),2) as average from customer_orders as c_o

select c_o.order_date, c_o.order_id, c_o.order_price, coalesce(c_o.order_price - lag(c_o.order_price) over(order by c_o.order_date),0) from customer_orders as c_o


explain analyze select c_o.employee_id, c_o.order_id, c_o.order_price, dense_rank() over(partition by c_o.employee_id order by c_o.order_price desc ) from customer_orders as c_o

select c_o.order_id, c_o.order_price, c_o.order_date, round(avg(c_o.order_price) over(order by c_o.order_date rows between 3 preceding and current row),2) as moving_average from customer_orders as c_o

select c_o.employee_id, c_o.order_id, c_o.order_price, first_value(c_o.order_price) over(partition by c_o.employee_id order by c_o.order_price desc ) as most_expensive_order from customer_orders as c_o

explain analyze select * from customer_orders where customer_id = 100
create index idx_c_o_customer_id on customer_orders(customer_id)
drop index idx_c_o_customer_id

explain analyze
select *
from customer_orders
where order_price between 3000 and 5000

create index idx_c_o_order_price on customer_orders(order_price)

select e.employee_id, e.first_name, e.last_name, count(c_o.order_id), sum(c_o.order_price), avg(c_o.order_price) 
from employees as e 
left join customer_orders as c_o on e.employee_id = c_o.employee_id
group by e.employee_id, e.first_name, e.last_name
order by sum(c_o.order_price) desc

with ranking as(
select cat.category_name, p.product_name, sum(o_i.quantity) as products_sold, dense_rank() over( partition by cat.category_name order by sum(o_i.quantity) desc ) as ranking
from categories as cat
join product as p on cat.category_id = p.category_id 
join order_items as o_i on o_i.product_id = p.product_id
group by cat.category_name, p.product_name)

select * from ranking where ranking = 1


select c_o.order_id, c_o.employee_id, c_o.order_price, 100* c_o.order_price/sum(c_o.order_price) over(partition by c_o.employee_id) as percentage from customer_orders as c_o

select order_id, employee_id, order_price from customer_orders where order_price <200 union select order_id, employee_id, order_price from customer_orders where order_price>800

select order_id, employee_id, order_price from customer_orders where order_price >400 intersect select order_id, employee_id, order_price from customer_orders where employee_id = 5
