-- Adicionando criptografia hash SHA à tabela de clientes
ALTER TABLE Cliente ADD COLUMN senha_hash VARCHAR(256);

UPDATE Cliente 
SET senha_hash = SHA2('senha_padrao_123', 256) 
WHERE id_cliente =1;

-- View limitada da tabela de clientes
CREATE VIEW vw_cliente_seguro AS
SELECT id_cliente, nome, email
FROM Cliente;

SELECT * FROM vw_cliente_seguro;

-- Auditoria simples, registra as alterações de preço de produtos
CREATE TABLE Log_Auditoria_Preco (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_produto INT,
    preco_antigo DOUBLE,
    preco_novo DOUBLE,
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario_banco VARCHAR(100)
);

DELIMITER //
CREATE TRIGGER trg_audita_preco_produto
AFTER UPDATE ON Produto
FOR EACH ROW
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO Log_Auditoria_Preco (id_produto, preco_antigo, preco_novo, usuario_banco)
        VALUES (OLD.id_produto, OLD.preco, NEW.preco, CURRENT_USER());
    END IF;
END//
DELIMITER ;

