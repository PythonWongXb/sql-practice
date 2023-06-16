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


drop procedure if exists set_payment;
create procedure set_payment(
    invoice_id int,
    payment_total decimal(9, 2),
    payment_date date
)
    begin
        if payment_total < 0
            then signal sqlstate '12200' set message_text = 'whatever';
        end if;
        update invoices i
            set
                i.payment_total = ifnull(payment_total, i.payment_total),
                i.payment_date = ifnull(payment_date, i.payment_date)
        where i.invoice_id = invoice_id;
    end;

call set_payment(2, 102, '2023-10-02');
call set_payment(2, -102, '2023-10-02');


drop function if exists get_risk_factor_for_client;
create function get_risk_factor_for_client(
    client_id int
)
returns integer
    deterministic
    reads sql data
    modifies sql data
begin
    declare risk_factor decimal(9, 2) default 0;
    declare invoice_total decimal(9, 2);
    declare invoice_count int;

    select count(*), sum(i.invoice_total)
    into invoice_count, invoice_total
    from invoices i
    where i.client_id = client_id;
    set risk_factor = invoice_total / invoice_count * 5;

    return ifnull(risk_factor, 0);
end;

select *,
       get_risk_factor_for_client(client_id) as risk
from clients
order by risk

