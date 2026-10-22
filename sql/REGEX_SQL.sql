select substring(shipping_address from '\d{2}-\d{3}') as postal_code
from customer_orders;

select substring(shipping_address from '^([Aa]leja|[Aa]l\.)')
from customer_orders;