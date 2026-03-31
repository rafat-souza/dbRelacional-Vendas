INSERT INTO Categoria (nome, descricao) VALUES 
('Eletrônicos', 'Dispositivos como celulares e computadores'),
('Vestuário', 'Roupas em geral');

INSERT INTO Cliente (nome, email, telefone) VALUES 
('João Silva', 'joao@email.com', '11999999999'),
('Maria Oliveira', 'maria@email.com', '11888888888');

INSERT INTO Produto (nome, preco, id_categoria) VALUES 
('Notebook', 3500.00, 1),
('Smartphone', 2000.00, 1),
('Camiseta', 50.00, 2);

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
