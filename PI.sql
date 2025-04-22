
/* SCRIPT PARA ORGANIZAÇÃO DOS DADOS DA IMUNOLOG */

-- banco de dados:

create database bdImunolog;
use bdImunolog;

-- tabelas:

create table empresa ( idEmpresa int primary key auto_increment,
					   razaoSocial varchar(30) NOT NULL,
                       cnpj char(18)NOT NULL,
                       cep char(9) NOT NULL,
                       numero varchar(9) NOT NULL,
                       complemento varchar(30),
                       dataContratacao date,
                       email varchar(50),
					   qtdSensor INT
);
                       
                     
create table telefone ( idTelefone int auto_increment,
                        tipo varchar(7),
                        constraint chkTipo check (tipo in ('Fixo', 'Celular')),
                        ddi int,
                        ddd int,
                        numero char(9),
                        fkEmpresa int,
						constraint chkTelefoneEmpresa primary key (idTelefone, fkEmpresa),
                        constraint chkTelefoneEmpresa foreign key (fkEmpresa) references empresa(idEmpresa) );
                        

create table usuario ( idUsuario int auto_increment,
                       nome varchar(30),
                       nomeMeio varchar(30),
                       sobrenome varchar(30),
                       tipo_usuario ENUM('Avançado', 'Básico'),
                       login varchar(30),
                       senha varchar(30),
					   fkEmpresa int,
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

create table sensor ( idSensor int primary key auto_increment,
                      nome varchar(30),
                      dataInstalacao date,
                      dataManutencao date,
                      fkTransporte varchar(30) null,
                      fkEmpresa int null,
					  constraint chkSensorTransp foreign key (fkTransporte) references transporte(idTransporte),
					  constraint chkSensorTranspEmpresa foreign key (fkEmpresa) references transporte(fkEmpresa),
					  constraint chkSensorEmpresa foreign key (fkEmpresa) references empresa(idEmpresa));
                      

create table leitura ( idLeitura int auto_increment,
                       fkSensor int,
                       temperatura float,
                       dataLeitura datetime default current_timestamp ,
                       constraint chkLeituraSensor foreign key (fkSensor) references sensor(idSensor),
                       constraint pkLeituraSensor primary key (idLeitura, fkSensor));
                       
create table protocolo ( idProtocolo int auto_increment,
                       fkTransporte varchar(30),
                       fkEmpresa int,
                       responsavel varchar(50),
                       statusProtocolo varchar(45),
                       cepPartida char(9),
                       cepDestino char(9),
                       dataPartida date,
                       dataDestino date,
                       constraint chkProtocoloTransp foreign key (fkTransporte) references transporte(idTransporte),
					   constraint chkProtocoloTranspEmpresa foreign key (fkEmpresa) references transporte(fkEmpresa),
					   constraint pkProtocoloTranspEmpr primary key (idProtocolo, fkTransporte, fkEmpresa)
);
                       

                       
-- inserts:

-- Inserindo empresas farmacêuticas
INSERT INTO empresa (razaoSocial, cnpj, cep, numero, complemento, dataContratacao, email) VALUES
('MedLife Farmacêutica Ltda', '12.345.678/0001-90', '0454-427', '1000', 'Sala 501', '2020-05-15', 'contato@medlife.com.br'),
('Vitalis Laboratórios SA', '98.765.432/0001-21', '0131-832', '200', 'Andar 12', '2021-02-10', 'comercial@vitalis.com'),
('BioTech Medicamentos', '45.678.912/0001-34', '0501-740', '1500', 'Bloco B', '2022-01-20', 'suporte@biotechmed.com.br'),
('Farma Lux', '32.165.498/0001-76', '0409-210', '300', NULL, '2021-11-05', 'atendimento@farmalux.com');

-- Inserindo telefones das empresas
INSERT INTO telefone (tipo, ddi, ddd, numero, fkEmpresa) VALUES
('Celular', 55, 11, 987654321, 1),
('Fixo', 55, 11, 23456789, 2),
('Celular', 55, 11, 998877665, 3),
('Fixo', 55, 19, 37218888, 4);

-- Inserindo usuários (funcionários das empresas)
INSERT INTO usuario (nome, nomeMeio, sobrenome, tipo_usuario, login, senha, fkEmpresa) VALUES
('Carlos', 'Alberto', 'Silva', 'Avançado', 'carlos.silva', 'MedLife@2023', 1),
('Ana', 'Maria', 'Santos', 'Avançado', 'ana.santos', 'Vitalis#123', 2),
('Roberto', 'Carlos', 'Ferreira','Básico', 'roberto.fer', 'BioTech789', 3),
('Juliana', 'Cristina', 'Oliveira','Avançado', 'juliana.oliv', 'FarmaLux!22', 4),
('Marcos', 'Antonio', 'Ribeiro','Básico', 'marcos.rib', 'MedLife456', 1),
('Patricia', 'Fernandes', 'Lima', 'Avançado', 'patricia.lima', 'Med@Pat123', 1),
('Fernando', 'Henrique', 'Costa', 'Avançado', 'fernando.costa', 'Vital@Fern1', 2),
('Mariana', 'Cristina', 'Almeida', 'Avançado', 'mariana.almeida', 'BioTech@Mar1', 3),
('Rodrigo', 'Mendes', 'Souza', 'Avançado', 'rodrigo.souza', 'FarmaLux@Rod', 4),
('Leonardo', 'Augusto', 'Barbosa', 'Avançado', 'leonardo.barbosa', 'LeoFarma#123', 4);

-- Inserindo transportes (veículos para medicamentos)
INSERT INTO transporte (idtransporte, tipoTransporte, fkEmpresa) VALUES
('RS1122B', 'Caminhão Refrigerado', 1),
('SC3344C', 'Avião Refrigerado', 2),
('ES5566E', 'Navio Refrigerado', 3),
('BA7788F', 'Caminhão Refrigerado', 4),
('MT9900H', 'Avião Refrigerado', 1),
('GO1122K', 'Navio Refrigerado', 2),
('AM3344L', 'Caminhão Refrigerado', 3),
('RR5566M', 'Avião Refrigerado', 4),
('AP7788N', 'Navio Refrigerado', 1),
('TO9900P', 'Caminhão Refrigerado', 2),
('AC1122Q', 'Avião Refrigerado', 3),
('RO3344R', 'Navio Refrigerado', 4),
('DF5566S', 'Caminhão Refrigerado', 1),
('MS7788T', 'Avião Refrigerado', 2),
('CE9900U', 'Navio Refrigerado', 3),
('PE1122V', 'Caminhão Refrigerado', 4);

-- Inserindo sensores (para monitoramento de temperatura)
INSERT INTO sensor (nome, dataInstalacao, dataManutencao, fkTransporte, fkEmpresa) VALUES
('SensorTemp-001', '2023-01-10', '2023-07-10', 'RS1122B', 1),
('SensorTemp-002', '2023-01-15', NULL, 'RS1122B', 1),
('SensorTemp-003', '2023-03-20', NULL, 'ES5566E', 3),
('SensorTemp-004', '2023-04-12', '2023-10-12', 'BA7788F', 4),
('SensorTemp-005', '2023-05-18', NULL, 'MT9900H', 1),
('SensorTemp-006', '2023-06-01', NULL, 'GO1122K', 2),
('SensorTemp-007', '2023-06-05', NULL, 'AM3344L', 3),
('SensorTemp-008', '2023-07-15', NULL, 'RR5566M', 4),
('SensorTemp-009', '2023-07-20', NULL, 'AP7788N', 1),
('SensorTemp-010', '2023-08-10', NULL, 'AC1122Q', 3),
('SensorTemp-011', '2023-08-15', NULL, 'RO3344R', 4),
('SensorTemp-012', '2023-09-01', NULL, 'DF5566S', 1),
('SensorTemp-013', '2023-09-05', NULL, 'MS7788T', 2),
('SensorTemp-014', '2023-09-10', NULL, 'CE9900U', 3),
('SensorTemp-015', '2023-09-15', NULL, 'PE1122V', 4);



-- Inserindo protocolos de transporte (para medicamentos sensíveis)
INSERT INTO protocolo (responsavel, statusProtocolo, cepPartida, cepDestino, dataPartida, dataDestino, fkTransporte, fkEmpresa) VALUES
('Carlos Alberto Silva', 'EM TRANSITO', '04547-000', '01311-000', '2023-06-01', '2023-06-01', 'RS1122B', 1),
('Ana Maria Santos', 'CONCLUIDO', '01311-000', '05010-000', '2023-05-28', '2023-05-28', 'SC3344C', 2),
('Roberto Ferreira', 'AGUARDANDO', '05010-000', '04094-000', '2023-06-05', '2023-06-05', 'ES5566E', 3),
('Marcos Ribeiro', 'CANCELADO', '04547-000', '01311-000', '2023-05-30', '2023-05-30', 'MT9900H', 1),
('Ana Maria Santos', 'EM TRANSITO', '01311-000', '05010-000', '2023-06-02', '2023-06-02', 'GO1122K', 2);

select * from sensor;

use bdImunolog;

select * from empresa;
select * from empresa where idEmpresa = 4;
select * from usuario where fkEmpresa = 4;

SELECT e.razaoSocial, t.tipoTransporte 
FROM empresa AS e 
JOIN transporte AS t ON e.idEmpresa = t.fkEmpresa 
WHERE t.fkEmpresa = 4 ;

select 