-- using
use sql_invoicing;

select date, c.name as client, amount, pm.name, i.number as invoiceNum
from payments p
left join clients c
    using (client_id)
left join invoices i
    using (invoice_id)
left join payment_methods pm
    on p.payment_method = pm.payment_method_id
