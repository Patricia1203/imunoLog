CREATE DATABASE MTC;
use MTC;

CREATE TABLE cadastroempresa (
	idempresa INT PRIMARY KEY AUTO_INCREMENT, 
    nomeempresa VARCHAR(30) NOT NULL, 
    senhaempresa VARCHAR(20) NOT NULL,
	emailempresa VARCHAR(30) NOT NULL, 
    numtelefone BIGINT NOT NULL, 
    cnpj BIGINT NOT NULL
);

CREATE TABLE sensor (
	idsensor INT PRIMARY KEY AUTO_INCREMENT, 
    statusSensor CHAR(8) NOT NULL,
		CONSTRAINT chkStatus CHECK(statusSensor IN ('Ativo', 'Inativo')),
    codigoViagem CHAR(5) NOT NULL
);

CREATE TABLE alerta (
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    dataAlerta DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    localizacaoAlerta VARCHAR(45) NOT NULL,
    temperaturaMaxima DECIMAL(3,1) NOT NULL,
    temperaturaMinima DECIMAL(3,1) NOT NULL
);

CREATE TABLE viagem (
	idviagem INT PRIMARY KEY AUTO_INCREMENT, 
    placaVeiculo CHAR(7) NOT NULL, 
    datapartida DATETIME NOT NULL, 
	datachegada DATETIME, 
    localsaida VARCHAR(45) NOT NULL, 
    localchegada VARCHAR(45) NOT NULL, 
    codigoResponsavel CHAR(5) NOT NULL,
    codigoViagem CHAR(5) NOT NULL
);

CREATE TABLE responsavel (
	idResponsavel INT PRIMARY KEY AUTO_INCREMENT,
    nomeResponsavel VARCHAR(45) NOT NULL,
    sobrenomeResponsavel VARCHAR(45) NOT NULL,
    crfResponsavel VARCHAR(6)
);

-- INSERINDO CADASTRO DE EMPRESA
INSERT INTO cadastroempresa VALUES 
	(DEFAULT, 'Droga Raia', '12345', 'drogaraia@gmail.com', 11995372291, 27236237000199),
    (DEFAULT, 'DrogaSil', '251712Droga', 'drogasil@gmail.com', 11973520084, 13562982000182),
    (DEFAULT, 'Indústria Irmãos José', 'Josés#ABC', 'irmaosjose@gmail.com', 11981548221, 74926348000132);

-- INSERINDO CADASTRO DE VIAGEM
INSERT INTO viagem VALUES
	(DEFAULT, 'WYU5L81', '2025-11-29 23:12:00', '2025-11-30 10:00:00', 'Industria de Remedios', 'Drogasil', 'João', '12345', 'ABWXQ'),
	(DEFAULT, 'YWS9Q35', '2025-08-28 11:00:00', '2025-08-28 12:00:00', 'Indústria Irmãos José', 'DrogaFarma', 'Amanda', '54321', 'KASHQ'),
	(DEFAULT, 'BVQ1K09', '2025-05-07 16:32:12', '2025-05-07 18:12:35', 'Indústria Farmacos Livres', 'PromoFarma', 'Lucas', '76381', 'OUYMS');

-- INSERINDO ALERTAS
INSERT INTO alerta (localizacaoAlerta, temperaturaMaxima, temperaturaMinima) VALUES
	('São Paulo - SP', 15.8, 2.8),
	('São Luís - MA', 15.8, 3.9),
	('Rio de Janeiro - RJ', 15.8, 1.0);

-- CONSULTANDO DADOS DE UMA VIAGEM
SELECT codigoViagem 'Código da viagem', 
	   nomeResponsavel 'Nome do responsável', 
	   placaVeiculo 'Placa do veículo',
       localSaida 'Local de saída',
       localChegada 'Local de chegada'
       FROM viagem;
       
-- CONSULTANDO UM ALERTA
SELECT dataAlerta 'Data e hora do alerta',
	   localizacaoAlerta 'Localização do alerta',
       temperaturaMaxima 'Temperatura máxima atingida',
       temperaturaMinima 'Temperatura mínima atingida'
       FROM alerta;