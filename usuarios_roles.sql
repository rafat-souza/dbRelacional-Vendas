-- Criação das roles
CREATE ROLE 'role_admin', 'role_app', 'role_leitura';

-- Permissão administrador
GRANT ALL PRIVILEGES ON SistemaVendas.* TO 'role_admin';

-- Permissões aplicação (acesso operacional, mas não administrativo)
GRANT SELECT, INSERT, UPDATE ON SistemaVendas.Cliente TO 'role_app';
GRANT SELECT, INSERT, UPDATE ON SistemaVendas.Pedido TO 'role_app';
GRANT SELECT, INSERT ON SistemaVendas.Item_Pedido TO 'role_app';
GRANT SELECT ON SistemaVendas.Produto TO 'role_app';
GRANT SELECT ON SistemaVendas.Categoria TO 'role_app';
GRANT EXECUTE ON PROCEDURE SistemaVendas.sp_realizar_compra TO 'role_app'; 

-- Permissões somente leitura (Relatórios/Analistas)
GRANT SELECT ON SistemaVendas.Pedido TO 'role_leitura';
GRANT SELECT ON SistemaVendas.Categoria TO 'role_leitura';
GRANT SELECT ON SistemaVendas.Produto TO 'role_leitura';
GRANT SELECT ON SistemaVendas.Item_Pedido TO 'role_leitura';
GRANT SELECT ON SistemaVendas.Log_Auditoria_Preco TO 'role_leitura';
GRANT SELECT ON SistemaVendas.vw_cliente_seguro TO 'role_leitura';

-- Criação de usuários
CREATE USER 'dba_admin'@'localhost' IDENTIFIED BY 'Admin!Forte2026';
CREATE USER 'user_aplicacao'@'localhost' IDENTIFIED BY 'App@Sistema2026';
CREATE USER 'user_relatorio'@'localhost' IDENTIFIED BY 'Read#Apenas2026';

GRANT 'role_admin' TO 'dba_admin'@'localhost';
GRANT 'role_app' TO 'user_aplicacao'@'localhost';
GRANT 'role_leitura' TO 'user_relatorio'@'localhost';

SET DEFAULT ROLE ALL TO 'dba_admin'@'localhost', 'user_aplicacao'@'localhost', 'user_relatorio'@'localhost';

FLUSH PRIVILEGES;

-- Testes
-- Logado como user_relatorio
SELECT * FROM Cliente;
SELECT * FROM vw_cliente_seguro;

-- Logado como user_aplicacao
DELETE FROM Categoria WHERE id_categoria = 1;
INSERT INTO Cliente (nome, email, telefone) VALUES 
('Mariazinha', 'mariaa@gmail.com', '11950994979');

-- Logado como dba_admin
DELETE FROM Produto WHERE id_produto = 15;