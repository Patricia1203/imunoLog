CREATE DATABASE IF NOT EXISTS bdImunolog;

USE bdImunolog;

-- Tabela EMPRESA
CREATE TABLE IF NOT EXISTS empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nomeComercial VARCHAR(100) NOT NULL,
    cnpj CHAR(18) NOT NULL UNIQUE,
    cep CHAR(9) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(50),
    cidade VARCHAR(50),
    uf CHAR(2),
    dataContratacao DATE,
    qtdSensor INT
);

-- Tabela USUARIO
CREATE TABLE IF NOT EXISTS usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    telefone1 VARCHAR(20),
    telefone2 VARCHAR(20),
    fkEmpresa INT NOT NULL,
    usuarioRespons TINYINT(1) DEFAULT 0,
    ativo TINYINT(1) DEFAULT 1,
    CONSTRAINT fkUsuarioEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS transporte (
    idTransporte VARCHAR(30),
    tipoTransporte VARCHAR(50) NOT NULL,
    fkEmpresa INT NOT NULL,
    PRIMARY KEY (idTransporte, fkEmpresa),
    CONSTRAINT fkTransporteEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

CREATE TABLE IF NOT EXISTS sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    dataInstalacao DATE NOT NULL,
    dataManutencao DATE,
    transporteId VARCHAR(30),
    fkEmpresa INT,
    CONSTRAINT fkSensorTransporte FOREIGN KEY (transporteId, fkEmpresa) REFERENCES transporte(idTransporte, fkEmpresa)
);

CREATE TABLE IF NOT EXISTS protocolo (
    idProtocolo INT PRIMARY KEY AUTO_INCREMENT,
    transporteId VARCHAR(30),
    fkEmpresa INT,
    responsavel VARCHAR(100) NOT NULL,
    statusProtocolo VARCHAR(50),
    cepPartida CHAR(9),
    cepDestino CHAR(9),
    dataPartida DATE,
    dataDestino DATE,
    ocorrenciaSens TEXT,
    CONSTRAINT fkProtocoloTransporte FOREIGN KEY (transporteId, fkEmpresa) REFERENCES transporte(idTransporte, fkEmpresa)
);

CREATE TABLE IF NOT EXISTS leitura (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    protocoloId INT NOT NULL,
    sensorId INT NOT NULL,
    temperatura FLOAT NOT NULL,
    dataLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fkLeituraSensor FOREIGN KEY (sensorId) REFERENCES sensor(idSensor),
    CONSTRAINT fkLeituraProtocolo FOREIGN KEY (protocoloId) REFERENCES protocolo(idProtocolo)
);

/* Inserções
INSERT INTO empresa (nomeComercial, cnpj, cep, logradouro, numero, complemento, bairro, cidade, uf) VALUES
('MedLife Farmacêutica', '12.345.678/0001-90', '04547-427', 'Av. Paulista', '1000', 'Sala 501', 'Bela Vista', 'São Paulo', 'SP'),
('Vitalis Laboratórios', '98.765.432/0001-21', '01318-320', 'Rua Augusta', '200', 'Andar 12', 'Consolação', 'São Paulo', 'SP'),
('BioTech Medicamentos', '45.678.912/0001-34', '05017-400', 'Av. Sumaré', '1500', 'Bloco B', 'Perdizes', 'São Paulo', 'SP'),
('Farma Lux', '32.165.498/0001-76', '04092-100', 'Rua Domingos de Morais', '300', NULL, 'Vila Mariana', 'São Paulo', 'SP');

INSERT INTO usuario (nome, email, senha, telefone1, telefone2, fkEmpresa) VALUES
('Carlos Alberto Silva', 'carlos.silva@medlife.com.br', 'MedLife@2023', '+55 11-98765-4321', '+55 11-91234-5678', 1),
('Ana Maria Santos', 'ana.santos@vitalis.com.br', 'Vitalis#123', '+55 21-99876-5432', NULL, 2),
('Roberto Carlos Ferreira', 'roberto.ferreira@biotech.com.br', 'BioTech789', '+55 31-98765-1234', NULL, 3),
('Fernanda Caramico', 'fernanda.caramico@farmalux.com.br', 'FarmaLux!22', '+55 41-91234-5678', NULL, 4);

INSERT INTO transporte (idTransporte, tipoTransporte, fkEmpresa) VALUES
('RS1122B', 'Caminhão Refrigerado', 1),
('SC3344C', 'Avião Refrigerado', 1),
('ES5566E', 'Navio Refrigerado', 1),
('BA7788F', 'Caminhão Refrigerado', 1);

INSERT INTO sensor (nome, dataInstalacao, dataManutencao, transporteId, fkEmpresa) VALUES
('SensorTemp-001', '2025-01-10', '2025-04-15', 'RS1122B', 1),
('SensorTemp-002', '2025-02-15', NULL, 'RS1122B', 1),
('SensorTemp-003', '2025-04-20', NULL, 'ES5566E', 1),
('SensorTemp-004', '2025-04-12', NULL, 'BA7788F', 1);

INSERT INTO protocolo (transporteId, fkEmpresa, responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, ocorrenciaSens) VALUES
('RS1122B', 1, 'Rafael Cunha Lopes', 'EM TRANSITO', '04547-000', '01311-000', '2023-04-28', '2023-06-01', 'Sensor falhou e foi reiniciado'),
('SC3344C', 1, 'Ana Maria Santos', 'A CAMINHO DO LOCAL DE CARREGAMENTO', '01311-000', '05010-000', '2023-04-28', '2023-05-28', 'Nenhuma ocorrência'),
('ES5566E', 1, 'Rafael Cunha Lopes', 'FINALIZADO', '05010-000', '04094-000', '2023-04-28', '2023-06-05', 'Nenhuma ocorrência'),
('BA7788F', 1, 'Larissa Souza Barbosa', 'INICIANDO TRANSPORTE', '04094-000', '04547-000', '2025-04-28', '2025-04-30', 'Nenhuma ocorrência');

INSERT INTO leitura (protocoloId, sensorId, temperatura, dataLeitura) VALUES
(1, 1, 5.2, '2023-06-01 08:00:00'),
(1, 1, 5.0, '2023-06-01 08:05:00'),
(1, 1, 4.9, '2023-06-01 08:10:00'),
(1, 1, 5.1, '2023-06-01 08:15:00'),
(1, 1, 5.4, '2023-06-01 08:20:00'),
(1, 1, 5.6, '2023-06-01 08:25:00'),
(1, 1, 5.7, '2023-06-01 08:30:00'),
(1, 1, 5.9, '2023-06-01 08:35:00'),
(1, 1, 6.0, '2023-06-01 08:40:00'),
(1, 1, 6.2, '2023-06-01 08:45:00');*/