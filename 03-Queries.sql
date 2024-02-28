-- Queries Desafio
use ecommerce;
show tables;




/* Recuperações simples com SELECT	*/						/* No Diagrama */
select * from tabela_clients;				-- tabela Cliente
select * from tabela_orders;				-- tabela Pedido
select * from tabela_productOrder;			-- tabela Produto/Pedido	(tabela vermelha diagrama)
select * from tabela_product;				-- tabela Produto
select * from tabela_storageLocation;		-- tabela Produto em Estoque (tabela vermelha diagrama)
select * from tabela_productStorage;		-- tabela Estoque
select * from tabela_productSupplier;		-- tabela Produto_fornecedor (tabela vermelha diagrama)
select * from tabela_Supplier;				-- tabela Fornecedor
select * from tabela_productSeller;			-- tabela Produto_vendedor Te (tabela vermelha diagrama)
select * from tabela_Seller;				-- tabela Terceiro - Vendedor
select * from tabela_payments;				-- tabela Pagamento




/* WHERE Statement */
-- Quais os pedidos que estão em processamento?
select idOrder from tabela_orders
where orderStatus = 'Em processamento';

-- Quais produtos possuem estoque maior que 90 unidades?
select idProductStorage from tabela_productStorage
where quantity >= 90;

-- Descubra quais clientes (pelo id cliente) possuem pagamento em boleto?
select o.idOrderClient as identificação_cliente from tabela_orders o, tabela_payments p
where o.idOrderClient = p.idPayClient and typePayment = 'Boleto';




/* Atributos derivados */
-- Quais clientes compraram via aplicativo?
select concat(c.FName,' ', c.Minit,' ', c.Lname) as Nome_Completo from tabela_clients c, tabela_orders o
where c.idClient = o.idOrderClient and o.orderDescription = 'Compra via aplicativo';

-- Calcule desconto de 10% de frete para clientes que realizam compra via web site
select idOrderClient, sendValue, sendValue*0.10 as desconto from tabela_orders
where orderDescription = 'Compra via web site';




/* Cláusulas ORDER BY e GROUP BY*/
-- Ordenação decrescente com Order By
select * from tabela_productStorage
order by quantity desc;

-- Quais os status dos pedidos dos clientes de acordo com o idOrder crescente?
select o.idOrder, concat(c.Fname,' ',c.Lname) as Nome_Completo, o.orderStatus from tabela_clients c, tabela_orders o
where (c.idClient = o.idOrderClient)
order by o.idOrder;

-- Ordenação com Count( )
select count(*) from tabela_clients;

-- Quantos estoques existem por região Group By?
select * from tabela_productStorage;
select storageLocation, count(quantity) as estoques from tabela_productStorage
group by storageLocation;




/* Statement HAVING */
-- Quantas avaliações 4 e 5 temos?
select avaliação, count(*) as quantidades_de_avaliação	-- count cria uma nova coluna informando a quantidade de linhas da condição
from tabela_product
where avaliação >= 4									-- condição
group by avaliação
having count(*) >= 1;									-- só retornará avaliações >=4 que tiveram 1 ou mais linhas (avaliações de clientes)




/* JOIN Statement */
-- Quais todos os dados dos clientes e produtos? (CROSS JOIN - gera um produto cartesiano, ou seja, não possui um atributo de junção feito com ON)
select * from tabela_clients join tabela_product; 

-- Quais clientes da base de dados realizaram pedidos e quais produtos eles compraram? (INNER JOIN)
select concat(Fname,' ',Lname) as Nome_Completo, idOrder, Pname from tabela_clients
join tabela_orders on idClient = idOrderClient
join tabela_productOrder on idOrder = idPOorder
join tabela_product on idPOproduct = idProduct;

-- Quais fornecedores e vendedores tercerizados oferecem o mesmo produto? (INNER JOIN)
select Pname as Produto, idPproduct as Tercerizado, idPsProduct as Fornecedor from tabela_product
join tabela_productSupplier on idProduct =  idPsProduct
join tabela_Supplier on idPSsupplier = idSupplier
join tabela_productSeller on idProduct = idPproduct
join tabela_seller on idPseller = idSeller;

-- Qual a relação entre clientes e pedidos? (LEFT OUTER JOIN)
/* O inner join mostraria apenas clientes que realizaram pedidos. O left outer join mostrará clientes que realizaram pedidos e
clientes que não fizeram, sendo o Null acrescentado como valor para clientes com o id não referenciado na tabela_pedidos */
select idClient, concat(Fname,' ', Lname) as Nome_Completo, idOrder from tabela_clients
left outer join tabela_orders on idClient = idOrderClient;
