DELIMITER //

CREATE PROCEDURE sp_realizar_compra(
    IN p_id_cliente INT,
    IN p_itens JSON 
)
BEGIN
    DECLARE v_id_pedido INT;
    DECLARE v_indice INT DEFAULT 0;
    DECLARE v_quantidade_itens INT;
    DECLARE v_id_produto INT;
    DECLARE v_quantidade INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL; 
    END;

    START TRANSACTION;

    INSERT INTO Pedido (id_cliente) VALUES (p_id_cliente);
    SET v_id_pedido = LAST_INSERT_ID();

    SET v_quantidade_itens = JSON_LENGTH(p_itens);

    -- Loop para extrair e inserir cada item do pedido
    WHILE v_indice < v_quantidade_itens DO

        SET v_id_produto = JSON_UNQUOTE(JSON_EXTRACT(p_itens, CONCAT('$[', v_indice, '].id_produto')));
        SET v_quantidade = JSON_UNQUOTE(JSON_EXTRACT(p_itens, CONCAT('$[', v_indice, '].quantidade')));

        INSERT INTO Item_Pedido (id_pedido, id_produto, quantidade) 
        VALUES (v_id_pedido, v_id_produto, v_quantidade);

        SET v_indice = v_indice + 1;
    END WHILE;

    COMMIT;
END//

DELIMITER ;

-- Teste
CALL sp_realizar_compra (1, '[
	{"id_produto": 1, "quantidade": 2}, 
    {"id_produto": 3, "quantidade": 4}
]');