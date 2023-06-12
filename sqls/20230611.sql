-- subQueries in from clause
-- only for simple search and a alias required.

use sql_invoicing;
select *
from (
        select c.client_id,
               c.name,
               (select sum(invoice_total) from invoices
                    where c.client_id = invoices.client_id
                ) as total_sale,
               (select avg(invoice_total) from invoices) as average,
               (select total_sale - average) as different
        from clients c
        order by  client_id
     ) as sales_summary
where total_sale is not null;

select *
from sql_store.orders
where (select extract(year from order_date)) = (select extract(year from current_date()))

select date_format(date_add(now(), interval 1 year), '%y');

select ifnull(comments, 'no comments')
from sql_store.orders;

select concat(first_name, ' ', last_name) as full_name,
       coalesce(phone, 'not phone'),
       ifnull(phone, 'not phone isnull')
from sql_store.customers

select order_date,
if(year(order_date) = year(now()), '1', '2') as cate
from sql_store.orders;

select
    p.product_id, name,
    (select count(oi.order_id) from sql_store.order_items oi
                               where p.product_id = oi.product_id
    ) as count,
    (select if (count = 1, 'once', 'multiple time')) as a
from sql_store.products p
having count >= 1
order by count desc;

use sql_store;
select
    p.product_id, name,
    count(*) as time2,
    if(count(*) = 1, 'once', 'multiple time')
from sql_store.products p
left join order_items oi on p.product_id = oi.product_id
where exists(
        select product_id from order_items where p.product_id = oi.product_id
          )
group by p.product_id
order by time2 desc
