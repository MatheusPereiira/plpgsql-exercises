CREATE OR REPLACE FUNCTION fn_backup_cliente_excluido()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO clientes_excluidos (
        id,
        nome,
        email,
        data_exclusao
    )
    VALUES (
        OLD.id,
        OLD.nome,
        OLD.email,
        CURRENT_DATE
    );

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_backup_cliente_excluido
BEFORE DELETE ON clientes
FOR EACH ROW
EXECUTE FUNCTION fn_backup_cliente_excluido();