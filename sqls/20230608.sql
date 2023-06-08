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

-- insert 
insert into orders (customer_id, order_date, status)
    values
        (1, '2023-06-08', 1);

select last_insert_id();
insert into order_items
    values
        (last_insert_id(), 1, 1, 2.2),
        (last_insert_id(), 2, 2, 3.2);

select * from products;

-- copy all
create table order_archived as
select * from orders;

-- copy part
insert into order_archived
select * from orders
where order_date < '2022-01-01';

-- copy test
use sql_invoicing;
create table invoices_archived as
select i.*, c.name as client_name
from invoices i
left join clients c using(client_id)
where payment_date is not null;

-- update single row
update invoices
set payment_date = '2023-01-22', payment_total = 10.2
where invoice_id = 1;

update invoices
set payment_date = null, payment_total = default
where invoice_id = 1;

update invoices
set payment_date = due_date, payment_total = invoice_total * 0.5
where invoice_id = 3;

select *
from invoices;

-- update mutiple row
update invoices
set payment_date = due_date, payment_total = invoice_total * 0.5
where client_id in (3, 1);

select *
from invoices
where client_id in (3, 1);


