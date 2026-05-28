CREATE OR REPLACE FUNCTION fn_vendas_total()
RETURNS TRIGGER AS $$
BEGIN
    NEW.valor_total := NEW.preco_unitario * NEW.quantidade;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_vendas_total
BEFORE INSERT ON itens_venda
FOR EACH ROW
EXECUTE FUNCTION fn_vendas_total();