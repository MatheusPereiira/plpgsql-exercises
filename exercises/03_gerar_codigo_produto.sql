CREATE OR REPLACE FUNCTION gerar_codigo_produto()
RETURNS TRIGGER AS $$
BEGIN 
NEW.codigo := 'PROD-' || NEW.id;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_gerar_codigo_produto
BEFORE INSERT ON produtos
FOR EACH ROW
EXECUTE FUNCTION gerar_codigo_produto();