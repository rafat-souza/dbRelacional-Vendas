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
