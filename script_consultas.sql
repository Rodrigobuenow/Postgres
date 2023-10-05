--Retorna a tabela cliente.
select * from cliente

--Retorna o nome do cliente e os detalhes do telefone associado a cada cliente.
SELECT c.nome, t.ddd, t.numero
FROM cliente c
JOIN telefone t ON c.id_cliente = t.id_cliente;

--Retorna o nome dos clientes que são pessoas jurídicas (tipo 'J') e seus respectivos CNPJs.
SELECT c.nome, cpj.cnpj
FROM cliente c
JOIN clientepj cpj ON c.id_cliente = cpj.id_cliente
WHERE c.tipo = 'J';

--Retorna o nome do cliente e detalhes do endereço (se existirem) para clientes cujo endereço esteja localizado em São Paulo ('SP').
SELECT c.nome, e.rua, e.numero, e.cidade, e.uf
FROM cliente c
LEFT JOIN endereco e ON c.id_cliente = e.id_cliente
WHERE e.uf = 'SP';

--Retorna o nome dos autores de uma obra específica com ISBN '9787890123456'.
SELECT a.nome
FROM autor a
JOIN obra_autor oa ON a.id_autor = oa.id_autor
WHERE oa.isbn = '9787890123456';

--Retorna o nome do cliente e o total gasto por esse cliente em todos os pedidos.
SELECT c.nome, SUM(e.preco_venda * ip.quantidade) AS total_gasto
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN item_pedido ip ON p.id_pedido = ip.id_pedido
JOIN edicao e ON ip.numero_edicao = e.numero_edicao
GROUP BY c.nome;

--Retorna o título de obras publicadas por uma editora específica ('Editora C') e o nome dessa editora.
SELECT o.titulo, e.nome AS editora
FROM obra o
JOIN edicao ed ON o.isbn = ed.isbn
JOIN editora e ON ed.id_editora = e.id_editora
WHERE e.nome = 'Editora C';