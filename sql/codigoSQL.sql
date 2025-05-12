
/* SCRIPT PARA ORGANIZAÇÃO DOS DADOS DA IMUNOLOG */

-- BANCO ------------------------------------------------------------------------------------ 

CREATE DATABASE bdImunolog; 

USE bdImunolog; 

-- TABELAS ----------------------------------------------------------------------------------
 
CREATE TABLE empresa ( 
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT, 
    nomeComercial VARCHAR(100) NOT NULL, 
    razaoSocial VARCHAR(100),
    cnpj CHAR(18) NOT NULL UNIQUE, 
    dataContratacao DATE, 
    statusEmpresa ENUM('ATIVO', 'INATIVO', 'PENDENTE') DEFAULT 'ATIVO' -- Adicionado status 
) AUTO_INCREMENT = 1001; 

CREATE TABLE endereco ( 
    idEndereco INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    cep CHAR(9) NOT NULL, 
    logradouro VARCHAR(255) NOT NULL, 
    numero VARCHAR(10) NOT NULL, 
    complemento VARCHAR(50), 
    bairro VARCHAR(100), 
    cidade VARCHAR(100) NOT NULL, 
    estado CHAR(2) NOT NULL, -- Sigla
	isSedePrincipal BOOLEAN NOT NULL,
    CONSTRAINT fkEndereçoEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
); 

CREATE TABLE enderecoTransporte( 
    idEndereco INT PRIMARY KEY AUTO_INCREMENT, 
    cep CHAR(9) NOT NULL, 
    logradouro VARCHAR(255) NOT NULL, 
    numero VARCHAR(10) NOT NULL, 
    complemento VARCHAR(50), 
    bairro VARCHAR(100), 
    cidade VARCHAR(100) NOT NULL, 
    estado CHAR(2) NOT NULL -- Sigla 
); 
 
CREATE TABLE contato ( 
    idContato INT PRIMARY KEY AUTO_INCREMENT, 
    fkEmpresa INT NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    cargo VARCHAR(50), 
    email VARCHAR(100) UNIQUE, 
    telefone1 VARCHAR(20), 
    telefone2 VARCHAR(20),  
    isContatoPrincipal BOOLEAN, 
    CONSTRAINT fkContatoEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
); 

CREATE TABLE usuario ( 
    idUsuario INT PRIMARY KEY AUTO_INCREMENT, 
    fkEmpresa INT NOT NULL, 
    nome VARCHAR(100) NOT NULL, 
    senha VARCHAR(255) NOT NULL,
    telefone VARCHAR(20), 
    cargo VARCHAR(50),
    ativo BOOLEAN DEFAULT TRUE, 
    ultimoLogin DATETIME NULL,
    permGerencia BOOLEAN DEFAULT FALSE,
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
); 

CREATE TABLE transporte ( 
    idTransporte INT PRIMARY KEY AUTO_INCREMENT,
    identificadorVeiculo VARCHAR(50) NOT NULL UNIQUE,
    fkEmpresa INT NOT NULL, 
    tipoTransporte VARCHAR(50), 
    marcaTransp VARCHAR(100),
    anoFabricacao INT NULL, 
    capacVolume DECIMAL(10, 2) NULL, 
    capacPeso DECIMAL(10, 2) NULL, 
    statusTransporte ENUM('OPERACIONAL', 'EM MANUTENCAO', 'INATIVO') DEFAULT 'OPERACIONAL', 
    CONSTRAINT fkTransporteEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa) 
); 

CREATE TABLE sensor ( 
    idSensor INT PRIMARY KEY AUTO_INCREMENT, 
    numeroSerie VARCHAR(100) NOT NULL UNIQUE, -- Número de série único do fabricante 
    modelo VARCHAR(50), -- Ex: ‘LM35’, ‘DHT22’, ‘MarcaX ModeloY’ 
    fkTransporte INT NULL, -- Sensor pode estar em estoque antes de associar a um transporte 
    dataInstalacao DATE NULL, 
    ultimaManutencao DATE NULL, 
    proximaManutencaoProgramada DATE NULL, 
    statusSensor ENUM('ATIVO', 'INATIVO', 'EM MANUTENCAO', 'FALHA', 'EM ESTOQUE') DEFAULT 'EM ESTOQUE', 
    CONSTRAINT fkSensorTransporte FOREIGN KEY (fkTransporte) REFERENCES transporte(idTransporte)
); 

CREATE TABLE produto ( 
    idProduto INT PRIMARY KEY AUTO_INCREMENT, 
    nomeProduto VARCHAR(100) NOT NULL UNIQUE DEFAULT 'Imunoglobulina', 
    descricao TEXT, 
    temperaturaMinima DECIMAL(4, 2) NOT NULL,  
    temperaturaMaxima DECIMAL(4, 2) NOT NULL,  
    instrucoesArmazenamento TEXT 
); 

CREATE TABLE statusProtocolo ( 
    idStatusProtocolo INT PRIMARY KEY AUTO_INCREMENT, 
    nomeStatus VARCHAR(50) NOT NULL UNIQUE, 
    descricaoStatus TEXT 
); 

CREATE TABLE protocolo ( 
    idProtocolo INT PRIMARY KEY AUTO_INCREMENT, 
    fkTransporte INT NOT NULL, 
    fkStatusProtocolo INT NOT NULL,
    fkEnderecoOrigem INT NOT NULL,
    fkEnderecoDestino INT NOT NULL,
    dtPartidaEstimada DATETIME NOT NULL, 
    dtChegadaEstimada DATETIME NOT NULL, 
    dtPartidaFeita DATETIME NULL, 
    dtChegadaFeita DATETIME NULL, 
    responsProtocolo VARCHAR(100),
    observacoes TEXT, 
    CONSTRAINT fkProtocoloTransporte FOREIGN KEY (fkTransporte) REFERENCES transporte(idTransporte), 
    CONSTRAINT fkProtocoloStatus FOREIGN KEY (fkStatusProtocolo) REFERENCES statusProtocolo(idStatusProtocolo), 
    CONSTRAINT fkProtocoloEndOrigem FOREIGN KEY (fkEnderecoOrigem) REFERENCES enderecoTransporte(idEndereco), 
    CONSTRAINT fkProtocoloEndDestino FOREIGN KEY (fkEnderecoDestino) REFERENCES enderecoTransporte(idEndereco) 
); 

CREATE TABLE protocoloProduto ( 
    idProtocoloProduto INT PRIMARY KEY AUTO_INCREMENT, 
    fkProtocolo INT NOT NULL, 
    fkProduto INT NOT NULL, 
    lote VARCHAR(50) NOT NULL UNIQUE,
    quantidade INT NOT NULL,
    unidadeMedida VARCHAR(20) DEFAULT 'Caixa', 
    CONSTRAINT fkProtoProd_Protocolo FOREIGN KEY (fkProtocolo) REFERENCES protocolo(idProtocolo), 
    CONSTRAINT fkProtoProd_Produto FOREIGN KEY (fkProduto) REFERENCES produto(idProduto)
); 

CREATE TABLE leitura ( 
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    fkProtocolo INT NOT NULL, 
    fkSensor INT NOT NULL, 
    temperatura DECIMAL(5, 2) NOT NULL,
    dtLeitura DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT fkLeituraProtocolo FOREIGN KEY (fkProtocolo) REFERENCES protocolo(idProtocolo) ON DELETE CASCADE, 
    CONSTRAINT fkLeituraSensor FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor)  
); 

-- DADOS -------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO statusProtocolo(nomeStatus, descricaoStatus) VALUES 
('PENDENTE', 'Protocolo criado, aguardando início do transporte.'), 
('CARREGAMENTO', 'Veículo no local de origem para carregamento.'), 
('EM TRANSITO', 'Transporte em andamento.'), 
('DESCARREGAMENTO', 'Veículo no local de destino para descarregamento.'), 
('CONCLUIDO', 'Transporte finalizado com sucesso.'), 
('CANCELADO', 'Transporte foi cancelado.'), 
('ATRASADO', 'Transporte está atrasado em relação ao previsto.'), 
('ALERTA TEMPERATURA', 'Houve registro de temperatura fora do range durante o transporte.'); 

INSERT INTO produto (nomeProduto, descricao, temperaturaMinima, temperaturaMaxima, instrucoesArmazenamento) VALUES 
('Imunoglobulina Humana', 'Solução injetável de imunoglobulina humana G', 2.00, 8.00, 'Manter refrigerado entre 2°C e 8°C. Não congelar. Proteger da luz.'),
('Imunoglobulina Canina', 'Solução injetável de imunoglobulina canina G', 2.00, 8.00, 'Manter refrigerado entre 2°C e 8°C. Não congelar. Proteger da luz.'); 

INSERT INTO empresa (nomeComercial, razaoSocial, cnpj, dataContratacao, statusEmpresa) VALUES 
('MedLife Farma', 'MedLife Farmaceutica Ltda', '12.345.678/0001-90', '2024-10-15', 'ATIVO'); 

INSERT INTO endereco (fkEmpresa, cep, logradouro, numero, complemento, bairro, cidade, estado, isSedePrincipal) VALUES 
(1001, '04547-000', 'Rua Exemplo Partida', '123', 'Bloco A', 'Vila Olímpia', 'São Paulo', 'SP', TRUE);
 
INSERT INTO contato (fkEmpresa, nome, cargo, email, telefone1, isContatoPrincipal) VALUES 
(1001, 'Carlos Alberto Silva', 'Gerente Logística', 'carlos.silva@medlife.com.br', '+55 11-98765-4321', TRUE), 
(1001, 'Patricia Fernandes Lima', 'Farmacêutica Responsável', 'patricia.lima@medlife.com.br', '+55 11-91234-5678', FALSE); 

INSERT INTO usuario (fkEmpresa, nome, senha, telefone, cargo, ativo, permGerencia) VALUES 
(1001, 'Carlos Alberto Silva', '$2b$10$abcdefghijklmnopqrstuvwx...', '+55 11-98765-4321', 'Gerente Logística', TRUE, TRUE), 
(1001, 'Marcos Antonio Ribeiro', '$2b$10$zyxwutsrqponmlkjihgfedc...', NULL, 'Operador', TRUE, FALSE); 