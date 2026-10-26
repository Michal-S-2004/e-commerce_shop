with cte as(select *, case when product_price<100 then 'cheap' when product_price>=100 and product_price<1000 then'medium' else 'expensive'end  as category
from product)
select category, count(*)
from cte 
group by category;

select c_o.order_id, count(case when o_i.unit_price<100 then 1 end) as cheap, count(case when o_i.unit_price>=100 then 1 end)  as not_cheap
from customer_orders as c_o
join order_items as o_i on o_i.order_id = c_o.order_id
group by c_o.order_id
order by c_o.order_id;

select ROUND(SUM(case when o_i.unit_price>1000 then unit_price*quantity end)::decimal*100.0/SUM(o_i.unit_price*o_i.quantity),2) as pct
from order_items as o_i;

with revenue as(select p.category_id, round(SUM(o_i.quantity* o_i.unit_price),2) as rpc
from product as p
join order_items as o_i on p.product_id = o_i.product_id
group by p.category_id
order by p.category_id)
select r.category_id, r.rpc::decimal*100.0/SUM(r.rpc) 
from revenue as r
