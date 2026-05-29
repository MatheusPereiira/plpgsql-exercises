CREATE OR REPLACE FUNCTION fn_vendas_estoque()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE produtos
    SET estoque = estoque - NEW.quantidade
    WHERE id = NEW.produto_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_vendas_estoque
AFTER INSERT ON itens_venda
FOR EACH ROW
EXECUTE FUNCTION fn_vendas_estoque();