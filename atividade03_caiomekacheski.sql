use `uc4atividades`;

/*01
consulta para um relatório de todas as vendas pagas em dinheiro. 
Necessários para o relatório data da venda, valor total; produtos vendidos, 
quantidade e valor unitário; nome do cliente, cpf e telefone.
Ordena-se pela data de venda, as mais recentes primeiro.*/
create index idx_venda_tipo_pagamento on venda(tipo_pagamento); 

create view venda_dinheiro as
	select venda.tipo_pagamento, venda.`data`, item_venda.nome_produto, item_venda.quantidade, item_venda.valor_unitario, 
	item_venda.subtotal, cliente.nome, cliente.cpf, cliente.telefone 
	from item_venda 
	inner join venda on venda.id = item_venda.venda_id 
	inner join cliente on cliente.id = venda.cliente_id 
	where venda.tipo_pagamento = 'D' 
	order by venda.`data`;

#explain 
select venda_dinheiro.* from venda_dinheiro; #Linhas percorridas: (antes)->805 /(depois)->251

/*02
consulta para encontrar todas as vendas de produtos de um dado fabricante
Mostrar dados do produto, quantidade vendida, data da venda.
Ordena-se pelo nome do produto.*/
create index idx_produto_fabricante on produto(fabricante);

create view venda_fabricante as
	select produto.nome, produto.fabricante, item_venda.quantidade, venda.`data`
	from item_venda
	inner join produto on produto.id = item_venda.produto_id
	inner join venda on venda.id = item_venda.venda_id
	where produto.fabricante like 'Ultralar'
	order by venda.id, produto.nome;

#explain 
select * from venda_fabricante; #Linhas percorridas: (antes)->91 /(depois)->54

/*03
Relatório de vendas de produto por cliente.
Mostrar dados do cliente, dados do produto e valor e quantidade totais de venda 
ao cliente de cada produto.*/
create index idx_nome_produto on item_venda(nome_produto);
drop view vendas_por_cliente;
create view vendas_por_cliente as
    select cliente.nome, item_venda.nome_produto, item_venda.valor_unitario, 
    sum(item_venda.quantidade) as quantidade , sum(item_venda.subtotal) as valor_total
    from item_venda
    inner join venda on item_venda.venda_id = venda.id
    inner join cliente on  cliente.id = venda.cliente_id
    inner join produto on produto.id = item_venda.produto_id
    where produto.nome = item_venda.nome_produto
	group by cliente.nome, item_venda.nome_produto, item_venda.valor_unitario
	order by cliente.nome;
    
explain   
select * from vendas_por_cliente; #Linhas percorridas: (antes)->238 /(depois)->151
