CREATE OR REPLACE FUNCTION fn_nome_maiusculo_update()
RETURNS TRIGGER AS $$
BEGIN
    NEW.nome := UPPER(NEW.nome);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_nome_maiusculo_update
BEFORE UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_nome_maiusculo_update();