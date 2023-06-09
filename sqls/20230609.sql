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
