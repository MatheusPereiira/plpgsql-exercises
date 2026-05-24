CREATE OR REPLACE FUNCTION fn_preencher_data_cadastro()
RETURNS TRIGGER AS $$
BEGIN
NEW.data_cadastro := CURRENT_DATE; 
RETURN NEW; 
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_preencher_data_cadastro
BEFORE INSERT ON clientes
FOR EACH ROW
EXECUTE FUNCTION fn_preencher_data_cadastro();