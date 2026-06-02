CREATE OR REPLACE FUNCTION fn_historico_preco()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.preco <> NEW.preco THEN
        INSERT INTO historico_precos (
            produto_id,
            preco_antigo,
            preco_novo
        )
        VALUES (
            OLD.id,
            OLD.preco,
            NEW.preco
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_historico_preco
AFTER UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_historico_preco();