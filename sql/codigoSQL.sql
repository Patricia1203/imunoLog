
/* SCRIPT PARA ORGANIZAÇÃO DOS DADOS DA IMUNOLOG */

-- banco de dados:

create database bdImunolog;

use bdImunolog;
create table empresa (
idEmpresa int primary key auto_increment,
nomeComercial varchar(30) NOT NULL,
cnpj char(18)NOT NULL,
cep char(9) NOT NULL,
numero varchar(9) NOT NULL,
complemento varchar(30),
dataContratacao date,
qtdSensor INT
) AUTO_INCREMENT = 0573;

create table usuario (
idUsuario int auto_increment,
nome varchar(50),
usuarioRespons tinyint(1),
senha varchar(30),
email varchar(50),
telefone varchar(30),
fkEmpresa int,
ativo tinyint(1),
constraint fkUsuarioEmpresa foreign key (fkEmpresa) references empresa(idEmpresa),
constraint pkUsuarioEmpresa primary key (idUsuario, fkEmpresa)
);

create table transporte (
idTransporte varchar(30),
tipoTransporte varchar(50),
fkEmpresa int,
constraint pkTransporteEmpresa primary key (idTransporte, fkEmpresa),
constraint pkTransporteEmpresa foreign key (fkEmpresa) references empresa(idEmpresa)
);

create table sensor (
idSensor int primary key auto_increment,
nome varchar(30),
dataInstalacao date,
dataManutencao date,
fkTransporte varchar(30) null,
fkEmpresa int null,
constraint chkSensorTransp foreign key (fkTransporte) references transporte(idTransporte),
constraint chkSensorTranspEmpresa foreign key (fkEmpresa) references transporte(fkEmpresa),
constraint chkSensorEmpresa foreign key (fkEmpresa) references empresa(idEmpresa));


create table protocolo (
idProtocolo int auto_increment,
fkTransporte varchar(30),
fkEmpresa int,
responsavel varchar(50),
statusProtocolo varchar(45),
cepPartida char(9),
cepDestino char(9),
dataPartida date,
dataDestino date,
ocorrenciaSens varchar(150),
constraint chkProtocoloTransp foreign key (fkTransporte) references transporte(idTransporte),
constraint chkProtocoloTranspEmpresa foreign key (fkEmpresa) references transporte(fkEmpresa),
constraint pkProtocoloTranspEmpr primary key (idProtocolo, fkTransporte, fkEmpresa)
);

create table leitura (
idLeitura int auto_increment,
fkProtocolo int,
fkSensor int,
temperatura float,
dataLeitura datetime default current_timestamp ,
constraint fkSensorLeitura foreign key (fkSensor) references sensor(idSensor),
constraint fkSensorProtocolo foreign key (fkProtocolo) references protocolo(idProtocolo),
constraint pkLeituraSensor primary key (idLeitura, fkSensor, fkProtocolo));

INSERT INTO empresa (nomeComercial, cnpj, cep, numero, complemento, dataContratacao, qtdSensor) VALUES
('MedLife Farmacêutica', '12.345.678/0001-90', '0454-427', '1000', 'Sala 501', '2024-10-15', 5),
('Vitalis Laboratórios', '98.765.432/0001-21', '0131-832', '200', 'Andar 12', '2024-11-10', 2),
('BioTech Medicamentos', '45.678.912/0001-34', '0501-740', '1500', 'Bloco B', '2024-11-20', 4),
('Farma Lux', '32.165.498/0001-76', '0409-210', '300', NULL, '2025-02-05', 4);


INSERT INTO usuario (nome, usuarioRespons, senha, email, telefone, fkEmpresa, ativo) VALUES
('Carlos Alberto Silva', 1, 'MedLife@2023', 'carlos.silva@medlife.com.br', '+55 11-98765-4321', 573, 1),
('Ana Maria Santos', 1, 'Vitalis#123', 'ana.santos@vitalis.com.br', '+55 21-99876-5432', 574, 0),
('Roberto Carlos Ferreira', 1, 'BioTech789', 'roberto.ferreira@biotech.com.br', '+55 31-98765-1234', 575, 1),
('Fernanda Caramico', 1, 'FarmaLux!22', 'fernanda.caramico@farmalux.com.br', '+55 41-91234-5678', 576, 1),
('Marcos Antonio Ribeiro', 0, 'MedLife456', NULL, NULL, 573, 1),
('Patricia Fernandes Lima', 1, 'Med@Pat123', 'patricia.lima@medlife.com.br', '+55 11-91234-5678', 573, 1),
('Mariana Cristina Almeida', 1, 'BioTech@Mar1', 'mariana.almeida@biotech.com.br', '+55 31-92345-6789', 575, 1),
('Rodrigo Mendes Souza', 0, 'FarmaLux@Rod', NULL, NULL, 576, 1),
('Leonardo Augusto Barbosa', 1, 'LeoFarma#123', 'leonardo.barbosa@farmalux.com.br', '+55 41-94567-8901', 576, 1);

INSERT INTO transporte (idtransporte, tipoTransporte, fkEmpresa) VALUES
('RS1122B', 'Caminhão Refrigerado', 573),
('SC3344C', 'Avião Refrigerado', 574),
('ES5566E', 'Navio Refrigerado', 575),
('BA7788F', 'Caminhão Refrigerado', 576),
('MT9900H', 'Avião Refrigerado', 573),
('GO1122K', 'Navio Refrigerado', 574),
('AM3344L', 'Caminhão Refrigerado', 575),
('RR5566M', 'Avião Refrigerado', 576),
('AP7788N', 'Navio Refrigerado', 573),
('TO9900P', 'Caminhão Refrigerado', 574),
('AC1122Q', 'Avião Refrigerado', 575),
('RO3344R', 'Navio Refrigerado', 576),
('DF5566S', 'Caminhão Refrigerado', 573),
('MS7788T', 'Avião Refrigerado', 574),
('CE9900U', 'Navio Refrigerado', 575),
('PE1122V', 'Caminhão Refrigerado', 576);

INSERT INTO sensor (nome, dataInstalacao, dataManutencao, fkTransporte, fkEmpresa) VALUES
('SensorTemp-001', '2025-01-10', '2025-04-15', 'RS1122B', 573),
('SensorTemp-002', '2025-02-15', NULL, 'RS1122B', 573),
('SensorTemp-003', '2025-04-20', NULL, 'ES5566E', 575),
('SensorTemp-004', '2025-04-12', NULL, 'BA7788F', 576),
('SensorTemp-005', '2025-02-18', NULL, 'MT9900H', 573),
('SensorTemp-006', '2025-02-01', NULL, 'GO1122K', 574),
('SensorTemp-007', '2025-04-05', NULL, 'AM3344L', 575),
('SensorTemp-008', '2025-04-15', NULL, 'RR5566M', 576),
('SensorTemp-009', '2025-02-20', NULL, 'AP7788N', 573),
('SensorTemp-010', '2025-04-10', NULL, 'AC1122Q', 575),
('SensorTemp-011', '2025-04-15', NULL, 'RO3344R', 576),
('SensorTemp-012', '2025-02-01', NULL, 'DF5566S', 573),
('SensorTemp-013', '2025-03-05', NULL, 'MS7788T', 574),
('SensorTemp-014', '2025-04-10', NULL, 'CE9900U', 575),
('SensorTemp-015', '2025-04-15', NULL, 'PE1122V', 576);

INSERT INTO protocolo (responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, fkTransporte, fkEmpresa, ocorrenciaSens) VALUES
('Rafael Cunha Lopes', 'EM TRANSITO', '04547-000', '01311-000', '2023-04-28', '2023-06-01', 'RS1122B', 573, 'Sensor com falha na leitura da temperatura - Arumado'),
('Ana Maria Santos', 'A CAMINHO DO LOCAL DE CARREGAMENTO', '01311-000', '05010-000', '2023-04-28', '2023-05-28', 'SC3344C', 574, 'Nenhuma Ocorrência'),
('Rafael Cunha0 Lopes', 'A CAMINHO DO LOCAL DE CARREGAMENTO', '05010-000', '04094-000', '2023-04-28', '2023-06-05', 'ES5566E', 575, 'Nenhuma Ocorrência'),
('Beatriz Moura', 'CANCELADO', '04547-000', '01311-000', '2023-04-25', '2023-05-30', 'MT9900H', 573, 'Nenhuma Ocorrência'),
('Bruno Martins Pereira', 'A CAMINHO DO LOCAL DE CARREGAMENTO', '01311-000', '05010-000', '2023-04-28', '2023-04-28', 'GO1122K', 574, 'Nenhuma Ocorrência'),
('Larissa Souza Barbosa', 'INICIANDO TRANSPORTE', '04094-000', '04547-000', '2025-04-28', '2025-04-30', 'BA7788F', 576, 'Nenhuma Ocorrência');

INSERT INTO leitura (fkProtocolo, fkSensor, temperatura, dataLeitura) VALUES
(1, 1, 5.2, '2023-06-01 08:00:00'),
(1, 1, 5.0, '2023-06-01 08:05:00'),
(1, 1, 4.9, '2023-06-01 08:10:00'),
(1, 1, 5.1, '2023-06-01 08:15:00'),
(1, 1, 5.4, '2023-06-01 08:20:00'),
(1, 1, 5.6, '2023-06-01 08:25:00'),
(1, 1, 5.7, '2023-06-01 08:30:00'),
(1, 1, 5.9, '2023-06-01 08:35:00'),
(1, 1, 6.0, '2023-06-01 08:40:00'),
(1, 1, 6.2, '2023-06-01 08:45:00');