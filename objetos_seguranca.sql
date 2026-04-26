-- Adicionando criptografia hash SHA à tabela de clientes
ALTER TABLE Cliente ADD COLUMN senha_hash VARCHAR(256);

UPDATE Cliente 
SET senha_hash = SHA2('senha_padrao_123', 256) 
WHERE id_cliente =1;
