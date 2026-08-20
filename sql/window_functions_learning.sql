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

