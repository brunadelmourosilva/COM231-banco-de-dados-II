-- SCHEMA: northwind

-- DROP SCHEMA IF EXISTS northwind ;

CREATE SCHEMA IF NOT EXISTS northwind
    AUTHORIZATION postgres;
	

	
-- Q1

create view questao_1 as
select o.orderdate, od.unitprice, od.productid from Northwind.order_details as od 
join Northwind.orders as o on o.orderid = od.orderid
where od.productid = 14 and o.orderdate >= '1996-06-05 00:00:00'
order by o.orderdate asc

start transaction;

select * from questao_1;

update Northwind.order_details as od
set unitprice = unitprice * 1.20 
from Northwind.orders as o
where o.orderid = od.orderid
and od.productid = 14 and o.orderdate >= '1996-06-05 00:00:00';

select * from questao_1;

commit;

select * from questao_1;

-- Q2

-- a
alter table northwind.orders add column qtdProdutos int default 0

-- b
alter table northwind.orders add column maisDesconto int default 0

-- c
-- quantity products per order
select orderid, count(productid) as product_quantity from northwind.order_details
group by orderid
order by orderid asc

-- attribute qtdProdutos added
select * from northwind.orders
order by orderid asc

-- i don't now how to transfer the values to the orders table

-- Q3
















select * from Northwind.products

select * from Northwind.orders