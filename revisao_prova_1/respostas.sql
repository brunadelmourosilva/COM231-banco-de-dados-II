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

-- I. Se uma transação é concluída com sucesso (operação commit bem sucedida), então 
-- seus efeitos são persistentes.

-- significa durabilidade, que é a garantia de que as alterações feitas por uma transação serão permanentes, 
-- mesmo que ocorra uma falha no sistema.

-- II. Ou todas as ações da transação acontecem, ou nenhuma delas acontece.

-- significa atomicidade, que é a garantia de que todas as operações em uma transação serão executadas ou nenhuma delas será executada, 
-- evitando que o banco de dados fique em um estado inconsistente.

-- Q4 - não entendi


-- Q5

-- DISCO COM BLOCO DE 512 BYTES
-- 1 PONTEIRO PARA BLOCO DE 6 BYTES
-- 1 PONTEIRO PARA REGISTRO DE 7 BYTES
-- ARQUIVO COM 75.000 REGISTROS
-- CADA CAMPO TEM UM TAMANHO, SENDO:
	-- FilmeID (4 bytes), DiretorID (4 bytes), CategoriaID (4 bytes), Título (35 bytes), AnoLancamento(4 bytes), 
	-- Duracao (4 bytes), Resenha (50 bytes)
	-- TOTAL: 106 BYTES
	
-- A) SENDO UM ARQUIVO SEQUENCIAL(ORDENADO POR PK)
	
	-- i - ARQUIVO SEQUENCIAL - INDICE PRIMARIO - ESPARSO(filmeID)	
	-- INDICE PRIMARIO = TAMANHO DO BLOCO / TOTAL DA SOMA DE BYTES DOS REGISTROS
	-- INDICE PRIMARIO = 512 / 106 = 4,8 REGISTROS / BLOCO => 4 REGISTROS POR BLOCO
	
	-- 1 BLOCO --- 4 REGISTROS
	-- X BLOCO --- 75000 REGISTROS
	-- X = 18.750 BLOCOS(QUANTIDADE DE BLOCOS PRECISO PARA USAR/ARMAZENAR)
	
	---
	
	-- FATOR DE BLOCO DO INDICE -> CHAVE + PONTEIRO
	-- FATOR DE BLOCO DO INDICE -> TAMANHO DO BLOCO / FILMEID(4B) + PONTEIRO(6B)
	-- FATOR DE BLOCO DO INDICE -> 512 / 10 = 51 REGISTROS POR BLOCO
	
	---
	
	-- 1 BLOCO --- 51 REGISTROS
	-- X BLOCO --- 18.750 BLOCOS
	-- X = ~368 BLOCOS DE INDICE PARA ARMAZENAR 18750 REGISTROS DE INDICE
	
	---
	
	-- ii - ARQUIVO SEQUENCIAL - INDICE SECUNDÁRIO - DENSO(AnoLancamento)
	
	-- 512 / 4(BYTES) + 7(PONTEIRO DE REGISTRO) = 46 REGISTROS DE INDICE QUE CONSIGO ARMAZENAR EM UM BLOCO
	
	-- 1 BLOCO --- 46 REGISTROS
	-- X BLOCO --- 75.000 REGISTROS(POIS MEU INDICE É DENSO/SECUNDARIO)
	-- X = ~1631 BLOCOS
	
	-----

	-- ESPARSO -> FAZER 2 REGRAS DE 3
	-- DENSO -> FAZER 1 REGRA DE 3
	













select * from Northwind.products

select * from Northwind.orders