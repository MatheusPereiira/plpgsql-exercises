DROP TABLE IF EXISTS itens_venda CASCADE;
DROP TABLE IF EXISTS log_status_pedidos CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS historico_salarios CASCADE;
DROP TABLE IF EXISTS funcionarios CASCADE;
DROP TABLE IF EXISTS historico_precos CASCADE;
DROP TABLE IF EXISTS produtos_backup CASCADE;
DROP TABLE IF EXISTS produtos_excluidos CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS clientes_excluidos CASCADE;
DROP TABLE IF EXISTS clientes CASCADE;

CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    data_cadastro DATE,
    data_atualizacao DATE
);

CREATE TABLE clientes_excluidos (
    id INTEGER,
    nome VARCHAR(100),
    email VARCHAR(100),
    data_exclusao DATE
);

CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    codigo VARCHAR(20) UNIQUE,
    preco NUMERIC(10,2) CHECK (preco >= 0),
    estoque INTEGER CHECK (estoque >= 0),
    data_atualizacao DATE
);

CREATE TABLE produtos_excluidos (
    id INTEGER,
    nome VARCHAR(100),
    codigo VARCHAR(20),
    preco NUMERIC(10,2),
    estoque INTEGER,
    data_exclusao DATE,
    usuario VARCHAR(100)
);

CREATE TABLE produtos_backup (
    id INTEGER,
    nome VARCHAR(100),
    codigo VARCHAR(20),
    preco NUMERIC(10,2),
    estoque INTEGER,
    data_atualizacao DATE
);

CREATE TABLE historico_precos (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER REFERENCES produtos(id),
    preco_antigo NUMERIC(10,2),
    preco_novo NUMERIC(10,2),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    salario NUMERIC(10,2) CHECK (salario >= 0)
);

CREATE TABLE historico_salarios (
    id SERIAL PRIMARY KEY,
    funcionario_id INTEGER REFERENCES funcionarios(id),
    salario_antigo NUMERIC(10,2),
    salario_novo NUMERIC(10,2),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES clientes(id),
    status VARCHAR(30),
    data_pedido DATE DEFAULT CURRENT_DATE
);

CREATE TABLE log_status_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INTEGER REFERENCES pedidos(id),
    status_antigo VARCHAR(30),
    status_novo VARCHAR(30),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE itens_venda (
    id SERIAL PRIMARY KEY,
    produto_id INTEGER REFERENCES produtos(id),
    preco_unitario NUMERIC(10,2) CHECK (preco_unitario >= 0),
    quantidade INTEGER CHECK (quantidade > 0),
    valor_total NUMERIC(10,2)
);