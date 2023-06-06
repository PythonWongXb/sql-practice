select * from sql_store.customers;
select points, city, count(*) as num from sql_store.customers
group by points, city
order by points DESC ;
# IN
select * from sql_store.customers where state not in ('GA', 'CO');
# between
select * from sql_store.customers where birth_date between '1986-03-28' and '1992-05-23';
# like
# - %: any
# - _: one operator
select * from sql_store.customers where customers.last_name like '%b%';
select * from sql_store.customers where customers.last_name like 'b____y';
select * from sql_store.customers
         where (customers.address like '%Trail%' or customers.address like '%Avenue%')
         and customers.phone like '%9';

# regexp
select * from sql_store.customers
    where last_name regexp '^b|c|l$';
select * from sql_store.customers
    where last_name regexp '[gim]e';

# order by
select * from sql_store.customers
    order by state, last_name;
    
select *, quantity * unit_price as total_price from sql_store.order_items
    where order_id = '2'
    order by total_price desc;
