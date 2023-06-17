drop trigger if exists payments_after_insert;
create trigger payments_after_insert
    after insert on payments
    for each row
begin
    update invoices i
        set payment_total = i.payment_total + new.amount
    where i.invoice_id = new.invoice_id;
   insert into payments_audit
        values (new.client_id, new.date, new.amount, 'Insert', now());
end;

drop trigger if exists payments_after_delete;
create trigger payments_after_delete
    after delete on payments
    for each row
begin
    update invoices i
        set payment_total = i.payment_total - 10000
    where i.invoice_id = old.invoice_id;
    insert into payments_audit
        values (old.client_id, old.date, old.amount, 'Delete', now());
end;
# 
# delete from payments
#     where invoice_id in (4, 5, 6, 7);
# 
# update invoices i
#     set payment_total = i.payment_total + 10000
#     where invoice_id in (4, 5, 6, 7);
# 
# insert into payments
# values
#     (default, 5, 4, '2023-01-01', 10000, 1),
#     (default, 5, 5, '2023-01-01', 10000, 1),
#     (default, 5, 6, '2023-01-01', 10000, 1),
#     (default, 5, 7, '2023-01-01', 10000, 1)
