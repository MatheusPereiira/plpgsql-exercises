CREATE OR REPLACE FUNCTION fn_auditoria_produto_excluido()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO produtos_excluidos (
        id,
        nome,
        codigo,
        preco,
        estoque,
        data_exclusao,
        usuario
    )
    VALUES (
        OLD.id,
        OLD.nome,
        OLD.codigo,
        OLD.preco,
        OLD.estoque,
        CURRENT_DATE,
        CURRENT_USER
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_auditoria_produto_excluido
BEFORE DELETE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_auditoria_produto_excluido();