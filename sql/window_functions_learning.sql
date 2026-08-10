select c_o.order_id, round(c_o.order_price,2), round(avg(c_o.order_price) over(), 2) as average_price from customer_orders as c_o

select c_o.order_id, c_o.employee_id, e.first_name, e.last_name, round(avg(c_o.order_price) over(partition by c_o.employee_id)) as average from employees as e 
join customer_orders as c_o on e.employee_id = c_o.employee_id

select c_o.order_id, c_o.employee_id, c_o.order_price, count(*) over(partition by c_o.employee_id) as orders_per_employee from customer_orders as c_o 


select c_o.order_id, c_o.employee_id, c_o.order_price, max(c_o.order_price) over(partition by c_o.employee_id) from customer_orders as c_o

select c_o.order_id, c_o.order_price,c_o.order_date, row_number() over(order by c_o.order_date) from customer_orders as c_o 

select c_o.employee_id, c_o.order_id, c_o.order_date, row_number() over(partition by c_o.employee_id order by c_o.order_date ) from customer_orders as c_o

