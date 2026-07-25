create table customer_orders(
order_id SERIAL primary key,
customer_id INT not null,
employee_id INT not null,
shipping_address VARCHAR(100) not null,
order_price numeric(10,2) not null,

constraint fk_customer_orders_customers
foreign key (customer_id)
references customers(customer_id),

constraint fk_customer_orders_employees
foreign key (employee_id)
references employees(employee_id));


ALTER TABLE customer_orders
ADD COLUMN order_date DATE NOT NULL;

ALTER TABLE customer_orders
ADD CONSTRAINT chk_order_price
CHECK (order_price >= 0);

