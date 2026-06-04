CREATE OR REPLACE FUNCTION fn_historico_salario()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.salario <> NEW.salario THEN
        INSERT INTO historico_salarios (
            funcionario_id,
            salario_antigo,
            salario_novo
        )
        VALUES (
            OLD.id,
            OLD.salario,
            NEW.salario
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tg_historico_salario
AFTER UPDATE ON funcionarios
FOR EACH ROW
EXECUTE FUNCTION fn_historico_salario();