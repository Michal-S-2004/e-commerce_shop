create or replace view products_and_categories as 
select p.product_id, p.product_name, p.product_price, cat.category_name from product as p left join categories as cat on cat.category_id = p.category_id

select * from products_and_categories


create or replace view vw_order_item_details as 
select c_o.order_id, p.product_name, o_i.quantity, o_i.unit_price, o_i.quantity*o_i.unit_price as price from customer_orders as c_o
join order_items as o_i on  c_o.order_id = o_i.order_id join product as p on p.product_id = o_i.product_id

select * from vw_order_item_details