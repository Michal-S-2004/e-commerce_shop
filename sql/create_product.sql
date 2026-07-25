create table product(
product_id SERIAL primary key,
product_name VARCHAR(100),
product_price NUMERIC(10,2) not null,
category_id INT not null,

constraint fk_products_category
foreign key (category_id)
references categories(category_id));
