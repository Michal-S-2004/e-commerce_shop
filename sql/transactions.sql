begin;
update  customer_orders
set order_price = 9999
where order_id = 1

select order_id, order_price
from customer_orders
where order_id = 1;

rollback;

select order_id, order_price
from customer_orders
where order_id = 2;

begin;
update customer_orders
set order_price = order_price+100
where order_id = 2;

select order_id, order_price
from customer_orders
where order_id in(3,4,5) ;


begin;
update customer_orders
set order_price =
    case
        when order_id = 3 then order_price + 50
        when order_id = 4 then order_price + 100
        when order_id = 5 then order_price + 150
        else order_price
    end
where order_id in (3, 4, 5);




