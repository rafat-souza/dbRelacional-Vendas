CREATE DATABASE IF NOT EXISTS SistemaVendas;
USE SistemaVendas;

CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    telefone VARCHAR(20)
);

CREATE TABLE Categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(255)
);

CREATE TABLE Produto (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    preco DOUBLE NOT NULL CHECK (preco > 0),
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

CREATE TABLE Pedido (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    valor_total DOUBLE DEFAULT 0,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

CREATE TABLE Item_Pedido (
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    PRIMARY KEY (id_pedido, id_produto),
    FOREIGN KEY (id_pedido) REFERENCES Pedido(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

DELIMITER //

CREATE TRIGGER trg_atualiza_valor_pedido
AFTER INSERT ON Item_Pedido
FOR EACH ROW
BEGIN
    DECLARE v_preco DOUBLE;

    -- Obtém o preço do produto que está sendo inserido no pedido
    SELECT preco INTO v_preco 
    FROM Produto 
    WHERE id_produto = NEW.id_produto;

    -- Atualiza o campo valor_total na tabela Pedido
    UPDATE Pedido 
    SET valor_total = valor_total + (v_preco * NEW.quantidade)
    WHERE id_pedido = NEW.id_pedido;
END//

DELIMITER ;

