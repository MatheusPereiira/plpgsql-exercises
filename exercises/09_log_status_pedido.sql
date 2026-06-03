CREATE OR REPLACE FUNCTION fn_log_status_pedido()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.status <> NEW.status THEN
        INSERT INTO log_status_pedidos (
            pedido_id,
            status_antigo,
            status_novo
        )
        VALUES (
            OLD.id,
            OLD.status,
            NEW.status
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_log_status_pedido
AFTER UPDATE ON pedidos
FOR EACH ROW
EXECUTE FUNCTION fn_log_status_pedido();