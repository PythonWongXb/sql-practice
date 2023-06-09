-- multiple update and sub-query

use sql_invoicing;
update invoices
set payment_date = '2023-02-02'
where client_id in
    (select client_id
        from clients c
        where c.name in ('Vinte', 'Myworks')
    );

select client_id
        from clients c
        where c.name in ('Vinte', 'Myworks')

use sql_store;
update orders o
set comments = 'gold customer'
where customer_id in (
    select customer_id from customers c
    where points > 3000
    ) and comments is null ;

select * from orders o
    left join customers using(customer_id)
where points > 3000;

-- del
set foreign_key_checks = 0;
delete from shippers s
where s.shipper_id in (
    select shipper_id from orders o
    where o.comments in ('demo')
    )
  
-- aggregate functions
select
    max(i.payment_total) as max,
    min(i.payment_total) as min,
    avg(i.payment_total) as avg,
    sum(i.payment_total) as sum,
    count(*) as count,
    count(i.payment_date) as not_full_count,
    count(distinct client_id) as disint_count
from sql_invoicing.invoices i
where i.payment_date > '1990-01-01';

select
    'before half 2019' as date_range,
    sum(i.invoice_total) as total_sales,
    sum(i.payment_total) as total_payments,
    sum(i.invoice_total - i.payment_total) as what_we_expect
from sql_invoicing.invoices i
where i.payment_date between '2019-01-01' and '2019-06-30'
union
select
    'after half 2019' as date_range,
    sum(i.invoice_total) as total_sales,
    sum(i.payment_total) as total_payments,
    sum(i.invoice_total - i.payment_total) as what_we_expect
from sql_invoicing.invoices i
where i.payment_date between '2019-07-01' and '2019-12-31'
union
select
    'total 2019' as date_range,
    sum(i.invoice_total) as total_sales,
    sum(i.payment_total) as total_payments,
    sum(i.invoice_total - i.payment_total) as what_we_expect
from sql_invoicing.invoices i
where i.payment_date between '2019-01-01' and '2019-12-31';

select * from sql_invoicing.invoices
