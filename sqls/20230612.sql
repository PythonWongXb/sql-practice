use sql_store;
select
    concat(c.first_name, ' ' , c.last_name) as full_name,
    points,
    case
        when c.points > 3000 then 'gold'
        when c.points between 2000 and 3000 then 'silver'
        else 'bronze'
    end as 'type'
from customers c
order by points desc;

use sql_invoicing;
create view balance as
select
    c.client_id,
    c.name,
    (sum(invoice_total) - sum(i.payment_total)) as balance
from clients c
join invoices i using(client_id)
group by client_id
order by balance;

select * from balance;
