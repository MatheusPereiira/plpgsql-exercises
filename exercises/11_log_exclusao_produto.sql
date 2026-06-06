CREATE OR REPLACE FUNCTION fn_excluir_produto_log()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO produtos_excluidos (
        id,
        nome,
        data_exclusao
    )
    VALUES (
        OLD.id,
        OLD.nome,
        CURRENT_DATE
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_excluir_produto_log
BEFORE DELETE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_excluir_produto_log();