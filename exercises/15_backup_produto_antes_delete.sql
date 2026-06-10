CREATE OR REPLACE FUNCTION fn_backup_produto()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO produtos_backup (
        id,
        nome,
        codigo,
        preco,
        estoque,
        data_atualizacao
    )
    VALUES (
        OLD.id,
        OLD.nome,
        OLD.codigo,
        OLD.preco,
        OLD.estoque,
        OLD.data_atualizacao
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_backup_produto
BEFORE DELETE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_backup_produto();