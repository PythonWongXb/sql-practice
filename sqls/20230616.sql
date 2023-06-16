drop procedure if exists get_invoice_by_client_id;
create procedure get_invoice_by_client_id(client_id int)
    begin
        select *
        from invoices i
        where i.client_id = client_id;
    end;

call get_invoice_by_client_id(3)


drop procedure if exists get_payments;
create procedure get_payments(client_id int, payment_method_id tinyint)
    begin
        select p.invoice_id, c.client_id, c.name, pm.name
        from payments p
        left join payment_methods pm on pm.payment_method_id = p.payment_method
        left join clients c on p.client_id = c.client_id
        where
            p.client_id = ifnull(client_id, p.client_id)
            and pm.payment_method_id = ifnull(payment_method_id, pm.payment_method_id);
    end;

call get_payments(null, null);
call get_payments(1, null);
call get_payments(5, 1);
