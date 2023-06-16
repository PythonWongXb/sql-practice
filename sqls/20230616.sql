drop procedure if exists get_invoice_by_client_id;
create procedure get_invoice_by_client_id(client_id int)
    begin
        select *
        from invoices i
        where i.client_id = client_id;
    end;

call get_invoice_by_client_id(3)
