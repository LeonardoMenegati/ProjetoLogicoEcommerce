-- inserção de dados e queries

use ecommerce;

show tables;

-- persistindo/inserindo dados nas tuplas da tabela Cliente
insert into tabela_clients (FName, Minit, Lname, CPF, Address, LegalPerson)
		values ('Maria','M','Silva',12346789,'rua silva de prata 29, Carangola - Cidade das Flores',1),
				('Matheus','O','Pimentel',987654321,'rua alaemeda 289, Centro - Cidade das Flores',0),
                ('Ricardo','F','Silva',45678913,'rua alemeda vinha 1009, Centro - Cidade das Flores',1),
                ('Julia','S','França',789123456,'rua laranjeiras 861, Centro - Cidade das Flores',1),
                ('Roberta','G','Assis',98745631,'avenidade koller 19, Centro - Cidade das Flores',0),
                ('Isabela','M','Cruz',654789123,'rua alemeda das flores 28, Centro- Cidade das Flores',1);

-- persistindo/inserindo dados na tuplas da tabela Produto
insert into tabela_product (Pname, classification_kids, category, avaliação, size)
		values ('Fone de ouvido', false, 'Eletrônico', 4, null),
				('Barbie Elsa', true, 'Brinquedos', 3, null),
                ('Body Carters', true, 'Vestimenta', 5, null),
                ('Microfone Vedo - Youtuber', false, 'Eletrônico', 4, null),
                ('Sofá retrátil', false, 'Móveis', 3, '3x57x80'),
                ('Farinha de arroz', false, 'Alimentos', 2, null),
                ('Fire Stick Amazon', false, 'Eletrônico', 3, null);

-- persistindo/inserindo dados na tuplas da tabela Pedido
insert into tabela_orders (idOrderClient, orderStatus, tracking_code, orderDescription, sendValue, paymentCash)
		values (1, default, 'Compra via aplicativo', 0909384728492857493, null, 1),
				(2, default, 'Compra via aplicativo', 8572957385738295748, 50, 0),
				(3, 'Confirmado', null, 9385628463829574834, null, 1),
				(4, default, 'Compra via web site', 7392758463527485636, 150, 0);

-- persistindo/inserindo dados na tuplas da tabela Produto/Pedido (tabela vermelha diagrama)
insert into tabela_productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
				(1, 5, 2, null),
				(2, 5, 1, null),
				(3, 6, 1, null);

-- persistindo/inserindo dados na tuplas da tabela Estoque
insert into tabela_productStorage (storageLocation, quantity) values
				('Rio de Janeiro', 1000),
				('Rio de Janeiro', 500),
				('São Paulo', 10),
                ('São Paulo', 100),
                ('São Paulo', 10),
                ('Brasília', 60);

-- persistindo/inserindo dados na tuplas da tabela PRODUTO EM Estoque (tabela vermelha do diagrama)
insert into tabela_storageLocation (idLproduct, idLstorage, location) values
				(1, 2, 'RJ'),
                (2, 6, 'GO');

-- persistindo/inserindo dados na tuplas da tabela Fornecedor
insert into tabela_supplier (SocialName, CNPJ, contact) values
				('Almeida e filhos', 123456789123456, '21985474'),
                ('Eletrônicos Silva', 854519649143457, '21985484'),
                ('Eletrônicos Valma', 934567893934695, '21975474');

-- persistindo/inserindo dados na tuplas da tabela PRODUTO_FORNECEDOR (tabela vermelha do diagrama)
insert into tabela_productSupplier (idPsSupplier, idPsProduct, quantity) values
				(1,1,500),
                (1,2,400),
                (2,4,633),
                (3,3,5),
                (2,5,10);

-- persistindo/inserindo dados na tuplas da tabela Terceiro - Vendedor
insert into tabela_seller (SocialName, AbstName, CNPJ, CPF, location, contact) values
				('Tech eletronics', null, 12345678956321, null, 'Rio de Janeiro', 219946287),
                ('Botique Durgas', null, 86845678957890, 123456783, 'Rio de Janeiro', 219567895),
                ('Kids World', null, 45678912336544, null, 'São Paulos', 1198657484);

-- persistindo/inserindo dados na tuplas da tabela PRODUTO_VENDEDOR (terceiro) (tabela vermelha do diagrama)
insert into tabela_productSeller (idPseller, idPproduct, prodQuantity) values
				(7,1,80),
                (8,3,10);
/*como os primeiros atributos dessa tabeça vermelha são chaves estrangeiras e compostas, precisamos consultar os números de id das outras tabelas para informar os número corretos, senão dará erro*/
select * from tabela_seller;
select * from tabela_product;

select * from tabela_clients, tabela_orders
where idClient = idOrderClient;



-- persistindo/inserindo dados na tuplas da tabela Payments
insert into tabela_payments (idPayClient, typePayment, limitAvailable) values
				(1,'Cartão', 3000),
                (2,'Boleto', null),
                (3,'Boleto', null);



/*Consultas SQL com QUERIES*/

select count(*) from tabela_clients;

select * from tabela_clients as c, tabela_orders as o
where c.idClient = o.idOrderClient;

select Fname, Lname, idOrder, orderStatus from tabela_clients c, tabela_orders o
where c.idClient = o.idOrderClient;

-- utilizando concat para unir dois atributos e utilizando as para renomear os nomes das colunas
select concat(Fname,' ', Lname) as Cliente, idOrder as Requisição, orderStatus as Processamento from tabela_clients c, tabela_orders o
where c.idClient = o.idOrderClient;

-- inserindo uma nova tupla
insert into tabela_orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
		values (2, default, 'Compra via aplicativo', null, 1);

-- GROUP BY agrupando informações
select * from tabela_clients as c, tabela_orders as o
		where c.idClient = o.idOrderClient
		GROUP BY idOrder;

-- GROUP BY agrupando informações com Count( )
-- resultará em cinco linhas informando a quantidade de pessoas existentes em cada grupo idOrder
select COUNT(*) from tabela_clients as c, tabela_orders as o
		where c.idClient = o.idOrderClient
		GROUP BY idOrder;

-- Statement JOIN
select * from tabela_clients
		left outer JOIN tabela_orders ON idClient = idOrderClient;

-- Quantos pedidos foram realizados por clientes?
-- count mostra a quantidade de tuplas
 select c.idClient, c.Fname, count(*) from tabela_clients c
		inner join tabela_orders o on c.idClient = o.idOrderClient
        inner join tabela_productOrder p on p.idPOorder =o.idOrder
        group by idClient;

