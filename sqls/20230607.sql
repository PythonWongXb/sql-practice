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
