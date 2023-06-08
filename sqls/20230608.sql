-- using
use sql_invoicing;

select date, c.name as client, amount, pm.name, i.number as invoiceNum
from payments p
left join clients c
    using (client_id)
left join invoices i
    using (invoice_id)
left join payment_methods pm
    on p.payment_method = pm.payment_method_id

-- cross join
select p.name, s.name
from products p
cross join shippers s

-- unions
select customer_id, first_name, points, 'Bronze' as type
from customers c
where points < 2000
union
select customer_id, first_name, points, 'Silver' as type
from customers c
where points between 2000 and 3000
union
select customer_id, first_name, points, 'Gold' as type
from customers c
where points > 3000
order by points

-- mutiple row insert
use sql_store;
insert into shippers (name)
    values
        ('shipper1'),
        ('shipper2'),
        ('shipper3');

select * from shippers;
