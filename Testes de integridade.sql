SELECT * FROM Categoria;
SELECT * FROM Pedido;
SELECT * FROM Produto;
SELECT * FROM Cliente;

INSERT INTO Categoria (nome, descricao) VALUES 
('Eletrônicos', 'Dispositivos como celulares e computadores'),
('Vestuário', 'Roupas em geral');

INSERT INTO Cliente (nome, email, telefone) VALUES 
('João Silva', 'joao@email.com', '11999999999'),
('Maria Oliveira', 'maria@email.com', '11888888888');

INSERT INTO Cliente (nome, email, telefone) VALUES 
('Pedro Souza', 'pedro@gmail.com', '11777777777'),
('Sophia Araújo', 'sophia@hotmail.com', '11444444444'),
('Luiza Cardoso', 'luiza@gmail.com', '12999999999'),
('Luana Amoedo', 'luana@outlook.com', '11222222222'),
('Ricardo Nunes', 'ricardo@gmail.com', '12888888888'),
('Matheus Vieira', 'matheus@hotmail.com', '12777777777'),
('Lucas Santos', 'lucas@gmail.com', '12555555555'),
('Joana Pereira', 'joana@outlook.com', '11555555555');

INSERT INTO Produto (nome, preco, id_categoria) VALUES 
('Notebook', 3500.00, 1),
('Smartphone', 2000.00, 1),
('Camiseta', 50.00, 2);

INSERT INTO Produto (nome, preco, id_categoria) VALUES 
('Vestido', 200.00, 2),
('Calça', 80.00, 2),
('Meias', 20.00, 2),
('Moletom', 120.00, 2);

INSERT INTO Pedido (id_cliente) VALUES 
(1), 
(2); 

SELECT 'Antes da Trigger' AS Status, id_pedido, valor_total, id_cliente FROM Pedido;

INSERT INTO Item_Pedido (id_pedido, id_produto, quantidade) VALUES 
(1, 1, 1),
(1, 3, 2);

INSERT INTO Item_Pedido (id_pedido, id_produto, quantidade) VALUES 
(2, 2, 1);

SELECT 'Depois da Trigger' AS Status, id_pedido, valor_total, id_cliente FROM Pedido;

UPDATE Cliente 
SET telefone = '11777777777' 
WHERE id_cliente = 2;

UPDATE Produto 
SET preco = 2100.00 
WHERE id_produto = 2;

SELECT id_cliente, nome, telefone FROM Cliente WHERE id_cliente = 2;
SELECT id_produto, nome, preco FROM Produto WHERE id_produto = 2;

INSERT INTO Categoria (nome, descricao) VALUES 
('Brinquedos', 'Categoria temporária para teste de delete');

SELECT * FROM Categoria WHERE nome = 'Brinquedos';

DELETE FROM Categoria 
WHERE id_categoria = 3;

INSERT INTO Categoria (nome, descricao) VALUES 
('Brinquedos', 'Brinquedos de todos os tipos');

INSERT INTO Produto (nome, preco, id_categoria) VALUES 
('Hotwheels', 50.00, 4),
('Urso de pelúcia', 30.00, 4),
('Boneca barbie', 70.00, 4),
('Lego', 300.00, 4);

SELECT * FROM Produto WHERE id_categoria = 4;

SELECT p.id_produto, 
p.nome AS nome_produto, 
p.preco, 
c.nome AS nome_categoria
FROM Produto p
INNER JOIN Categoria c ON p.id_categoria = c.id_categoria
WHERE c.nome = 'brinquedos';