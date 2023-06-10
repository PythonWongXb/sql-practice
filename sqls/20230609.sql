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

-- group by
select sum(i.invoice_total) as sale_total, c.name as userName, city
from sql_invoicing.invoices i
left join sql_invoicing.clients c using (client_id)
where i.invoice_date > '2019-01-07'
group by client_id, client_id
order by sale_total desc;

select date, c.name as clientName, pc.name as payMethod, amount
from sql_invoicing.payments p
left join sql_invoicing.payment_methods pc
    on pc.payment_method_id = p.payment_method
left join sql_invoicing.clients c
    using (client_id)
where p.date > '2019-01-01'
group by date, client_id, pc.name, amount
order by date;

select distinct date, count(*) from sql_invoicing.payments
group by date;

select date, amount from sql_invoicing.payments

-- where and having
select c.name as client_name, sum(p.amount) as total_pay, c.city
from sql_invoicing.payments p
join sql_invoicing.clients c using (client_id)
group by client_name, c.city
having total_pay > 100

-- sub queries
select *
from employees e
where salary > (
    select avg(salary) from employees
    )
order by salary;

select avg(salary) from employees;

-- in operator
select c.name
from sql_invoicing.clients c
where client_id not in (
    select distinct client_id
    from sql_invoicing.invoices
);

-- join vs sub queries
use sql_store;
-- join better in this
select distinct customer_id, c.first_name, c.last_name
from orders o
left join order_items oi using(order_id)
left join customers c using(customer_id)
where product_id = 3;
-- sub queries
select customer_id, c.first_name, c.last_name
from customers c
where c.customer_id in (
    select o.customer_id
    from orders o
    left join order_items oi using(order_id)
    where product_id = 3
)
