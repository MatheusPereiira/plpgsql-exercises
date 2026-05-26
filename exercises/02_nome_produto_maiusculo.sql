CREATE OR REPLACE FUNCTION fn_produto_nome_maiusculo()
RETURNS TRIGGER AS $$
BEGIN
NEW.nome := UPPER(NEW.nome); 
RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_produto_nome_maiusculo
BEFORE INSERT ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_produto_nome_maiusculo();