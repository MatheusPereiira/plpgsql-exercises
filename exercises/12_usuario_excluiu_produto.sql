CREATE OR REPLACE FUNCTION fn_usuario_excluiu_produto()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO produtos_excluidos (
        id,
        nome,
        data_exclusao,
        usuario
    )
    VALUES (
        OLD.id,
        OLD.nome,
        CURRENT_DATE,
        CURRENT_USER
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_usuario_excluiu_produto
BEFORE DELETE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_usuario_excluiu_produto();