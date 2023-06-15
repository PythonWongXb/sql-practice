create or replace view invoicing_balance as
select (invoice_total - payment_total) as balance
from invoices i;

delimiter $$
create procedure get_balance()
begin
    select * from
    invoicing_balance
    where balance > 0;
end$$
delimiter ;

call get_balance()
