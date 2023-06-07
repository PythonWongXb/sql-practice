-- cross db join tb
use sql_store;
select order_id, oi.product_id, quantity, oi.unit_price, p.unit_price from order_items oi
    join sql_inventory.products p
    on p.product_id = oi.product_id
    
-- self join
use sql_hr;
select e.employee_id, e.first_name, m.first_name as manage_first_name from employees e
    join employees m on e.reports_to = m.employee_id;

select e.employee_id, e.first_name from employees e
    where e.reports_to is null;

use sql_invoicing;
select c.client_id, c.name, c.city, pm.name as pay_method, p.date, p.amount
from payments p
join clients c on c.client_id = p.client_id
join payment_methods pm on p.payment_method = pm.payment_method_id

-- combine primary key join table
select oi.*, note
from sql_store.order_items oi
join sql_store.order_item_notes oin
    on oin.order_id = oi.order_id
    and oin.product_id = oi.product_id;
