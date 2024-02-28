-- criação de banco de dados para cenário de E-commerce

-- drop database ecommerce;
CREATE DATABASE ecommerce;
use ecommerce;

-- criação de tabela Cliente
create TABLE tabela_clients(
		idClient int auto_increment primary key,
        FName varchar(10),
        Minit char(3),
        Lname varchar(20),
        CPF char(11) not null,
        Address varchar(60),
        LegalPerson bool,		/*pessoa física?*/
        constraint unique_cpf_clients unique (CPF)
);

alter table tabela_clients auto_increment=1;

desc tabela_clients;

-- criação de tabela Produto
create table tabela_product(
		idProduct int auto_increment primary key,
        Pname varchar(30) not null,
        classification_kids bool default false,
        category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis') not null,
        avaliação float default 0,
        size varchar(10)
);

alter table tabela_product auto_increment=1;

desc tabela_product;



-- criação de tabela Pagamento
-- termine de implementar a tabela e cria a conexão com as tabelas necessárias
-- reflita a modificação no diagrama
-- criar constraints relacionadas ao pagamento
drop table tabela_payments;
create table tabela_payments(
		id_Payment int auto_increment primary key,
		idPayClient int,
        typePayment enum('Boleto','Pix','Cartão','Dois cartões'),
        limitAvailable float,
        constraint fk_idClientOrders_payments foreign key (idPayClient) references tabela_orders (idOrderClient)
);




-- criação de tabela Pedido
create table tabela_orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        tracking_code char(19),
        orderDescription varchar(255),
        sendValue float default 10,
        paymentCash bool default false,
        constraint fk_orders_client foreign key (idOrderClient) references tabela_clients(idClient)
				on update cascade /*precisa ajustar*/
);

alter table tabela_orders auto_increment=1;

desc tabela_orders;





-- criação de tabela Estoque
create table tabela_productStorage(
		idProductStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);

alter table tabela_productStorage auto_increment=1;




-- criação de tabela Fornecedor
create table tabela_Supplier(
		idSupplier int auto_increment primary key,
        SocialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null,
        constraint unique_supplier unique (CNPJ)
);

alter table tabela_Supplier auto_increment=1;

desc tabela_supplier;



-- criação de tabela Terceiro - Vendedor
create table tabela_Seller(
		idSeller int auto_increment primary key,
        SocialName varchar(255) not null,
        AbstName varchar(255),
        CNPJ char(15) not null,
        CPF char(9),
        Location varchar(255),
        contact char(11) not null,
        constraint unique_cnpj_seller unique (CNPJ),
		constraint unique_cpf_seller unique (CPF)
);

alter table tabela_Seller auto_increment=1;



-- criação de tabela Produto_Vendedor (terceiro) (tebal vermelha do diagrama)
create table tabela_productSeller(
		idPseller int,								/*é uma FOREIGN KEY que herda os valores da tabela Terveiro-Vendedor e se transforma em PK nesta tabela Produto-Vendedor. Ela não pode receber autoincrement porque ela está recebendo valores de outra tabela como uma Chave Estrangeira*/
        idPproduct int,								/*é uma FOREIGN KEY que herda valores da tabela Produto*/
        prodQuantity int default 1,
        primary key (idPseller, idPproduct),			/*chave primária composta*/
        constraint fk_product_seller foreign key (idPseller) references tabela_seller(idSeller),
        constraint fk_product_product foreign key (idPproduct) references tabela_product(idProduct)
);

desc tabela_productSeller;



-- criação de tabela Produto/Pedido (tabela vermelha diagrama)
create table tabela_productOrder(
		idPOproduct int,												/*é uma FOREIGN KEY que herda os valores*/
        idPOorder int,													/*é uma FOREIGN KEY que herda valores*/
        poQuantity int default 1,
        poStatus enum('Disponível','Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),							/*chaves primarias compostas*/
        constraint fk_productorder_seller foreign key (idPOproduct) references tabela_product(idProduct),
        constraint fk_productorder_product foreign key (idPOorder) references tabela_orders(idOrder)
);



-- criação de tabela Produto em Estoque (tabela vermelha diagrama)
create table tabela_storageLocation(
		idLproduct int,												/*é uma FOREIGN KEY que herda os valores*/
        idLstorage int,												/*é uma FOREIGN KEY que herda valores*/
        location varchar(255) not null,
		primary key (idLproduct, idLstorage),						/*chave primárias composta*/
        constraint fk_storage_location_product foreign key (idLproduct) references tabela_product(idProduct),
        constraint fk_storage_location_storage foreign key (idLstorage) references tabela_productStorage(idProductStorage)
);




-- criação de tabela Produto_fornecedor
create table tabela_productSupplier(
		idPsSupplier int,											/*é uma FOREIGN KEY que herda valores de outra tabela*/
        idPsProduct int,											/*é uma FOREIGN KEY que herda valores de outra tabela*/
        quantity int not null,
        primary key (idPsSupplier, idPsProduct),
        constraint fk_product_supplier_supplier foreign key (idPsSupplier) references tabela_supplier(idSupplier),
		constraint fk_product_supplier_product foreign key (idPsProduct) references tabela_product(idProduct)
);

show tables;