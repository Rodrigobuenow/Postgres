-- Tabela de Clientes
CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL,
    tipo CHAR(1) CHECK (tipo IN ('F', 'J')) NOT NULL
);

-- Tabela de Clientes Pessoa Física
CREATE TABLE clientepj (
    id_cliente INT PRIMARY KEY,
    cnpj VARCHAR(50) UNIQUE,
    inscricao_estadual VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Clientes Pessoa Jurídica
CREATE TABLE clientepf (
    id_cliente INT PRIMARY KEY,
    cpf VARCHAR(50) UNIQUE,
    rg VARCHAR(50),
    orgao_emissor VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Telefones
CREATE TABLE telefone (
    id_telefone INT PRIMARY KEY,
    id_cliente INT,
    ddd VARCHAR(2),
    numero VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de E-mails
CREATE TABLE email (
    id_email INT PRIMARY KEY,
    id_cliente INT,
    enderco_email VARCHAR(50),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Endereços
CREATE TABLE endereco (
    id_endereco INT PRIMARY KEY,
    id_cliente INT,
    rua VARCHAR(100),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    cidade VARCHAR(50),
    uf VARCHAR(2),
    cep VARCHAR(10),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Tabela de Obras
CREATE TABLE obra (
    isbn VARCHAR(13) PRIMARY KEY,
    titulo VARCHAR(250) NOT NULL
);

-- Tabela de Autores
CREATE TABLE autor (
    id_autor INT PRIMARY KEY,
    nome VARCHAR(250) NOT NULL
);

-- Tabela de obra_autor
CREATE TABLE obra_autor (
    id INT PRIMARY key,
    isbn VARCHAR(13),
    id_autor INT,
    FOREIGN KEY (isbn) REFERENCES obra(isbn),
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

-- Tabela de Editora
CREATE TABLE editora (
	id_editora VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(250),
    cidade VARCHAR(250),
    uf VARCHAR(2)
);

-- Tabela de Edições
CREATE TABLE edicao (
    numero_edicao INT PRIMARY KEY,
    data_publicacao DATE,
    preco_venda DECIMAL(10, 2),
    isbn VARCHAR(13),
    id_editora VARCHAR(50),
    FOREIGN KEY (isbn) REFERENCES obra(isbn),
    FOREIGN KEY (id_editora) REFERENCES editora(id_editora)
);

-- Tabela de Pedidos
CREATE TABLE pedido (
    id_pedido INT PRIMARY KEY,
    data_pedido DATE,
    id_cliente INT,
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE destinatario (
    id_destinatario VARCHAR(50) PRIMARY KEY,
    id_pedido INT,
    id_cliente INT,
    data_entrega DATE,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

-- Tabela de Itens de Pedido
CREATE TABLE item_pedido (
    id_item INT PRIMARY KEY,
    isbn VARCHAR(13),
    id_pedido INT,
    numero_edicao INT,
    quantidade INT,
    FOREIGN KEY(isbn) REFERENCES obra(isbn),
    FOREIGN key (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN key (numero_edicao) REFERENCES edicao(numero_edicao)
);
