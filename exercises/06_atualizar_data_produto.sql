CREATE OR REPLACE FUNCTION fn_produtos_data()
RETURNS TRIGGER AS $$
BEGIN
    NEW.data_atualizacao := CURRENT_DATE;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_produtos_data
BEFORE UPDATE ON produtos
FOR EACH ROW
EXECUTE FUNCTION fn_produtos_data();