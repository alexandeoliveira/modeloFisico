.header on
.mode column

------------------------------------------
-- COMANDOS DE DEFINIÇÃO DE DADOS - DDL---
------------------------------------------
-- TABELA CLIENTE
CREATE TABLE cliente (
  idCliente INTEGER PRIMARY KEY,
  nome VARCHAR,
  cnh VARCHAR,
  telefone VARCHAR,
  dataNascimento DATE
);

-- TABELA PESSOA FISICA
CREATE TABLE fisico (
  cpf VARCHAR,
  FK_CLIENTE_idCliente INTEGER,
  PRIMARY KEY (cpf, FK_CLIENTE_idCliente),
  FOREIGN KEY (FK_CLIENTE_idCliente) REFERENCES cliente (idCliente) ON DELETE CASCADE
);

--TABELA PESSOA JURIDICA
CREATE TABLE juridico (
  cnpj VARCHAR,
  tipoOrganizacao VARCHAR,
  FK_CLIENTE_idCliente INTEGER,
  PRIMARY KEY (cnpj, FK_CLIENTE_idCliente),
  FOREIGN KEY (FK_CLIENTE_idCliente) REFERENCES cliente (idCliente) ON DELETE CASCADE
);

-- TABELA VEICULO
CREATE TABLE veiculo (
  idVeiculo INTEGER PRIMARY KEY,
  chassi VARCHAR,
  placa VARCHAR,
  kmAtual DOUBLE,
  cor VARCHAR,
  ano DECIMAL,
  modelo VARCHAR,
  FOREIGN KEY (modelo) REFERENCES carro(modeloCarro)
);

-- TABELA MOTO
CREATE TABLE moto (
  idMoto INTEGER PRIMARY KEY,
  modeloMoto VARCHAR,
  FK_itens_itens_PK INTEGER,
  FK_VEICULO_idVeiculo INTEGER,
  FOREIGN KEY (FK_itens_itens_PK) REFERENCES itensMoto (itens_PK) ON DELETE SET NULL,
  FOREIGN KEY (FK_VEICULO_idVeiculo) REFERENCES veiculo (idVeiculo) ON DELETE CASCADE    
);

-- TABELA CARRO
CREATE TABLE carro (
  idCarro INTEGER PRIMARY KEY,
  modeloCarro VARCHAR,
  FK_itens_itens_PK INTEGER,
  FK_VEICULO_idVeiculo INTEGER,
  FOREIGN KEY (FK_itens_itens_PK) REFERENCES itensCarro (itens_PK) ON DELETE SET NULL,
  FOREIGN KEY (FK_VEICULO_idVeiculo) REFERENCES veiculo (idVeiculo) ON DELETE CASCADE
);


-- TABELA ITENS DA MOTO
CREATE TABLE itensMoto (
  itens_PK INTEGER NOT NULL PRIMARY KEY,
  bagageiro BOOLEAN,
  capacete BOOLEAN,
  capa BOOLEAN
);

-- TABELA ITENS DO CARRO
CREATE TABLE itensCarro (
  itens_PK INTEGER NOT NULL PRIMARY KEY,
  arCondicionado BOOLEAN,
  centralMultimida BOOLEAN,
  direcaoHidraulica BOOLEAN,
  cambioAutomatico BOOLEAN
);


-- TABELA FILIAL
CREATE TABLE filial (
  idFilial INTEGER PRIMARY KEY
);

-- TABELA AGREGAÇÃO ALUGUEL
CREATE TABLE aluguel_aluga (
  contrato INTEGER PRIMARY KEY,
  dataInicio DATE,
  dataFim DATE,
  expedicaoCnh DATE,
  validadeCnh DATE,
  FK_CLIENTE_idCliente INTEGER,
  FK_VEICULO_idVeiculo INTEGER,
  FOREIGN KEY (FK_CLIENTE_idCliente) REFERENCES cliente (idCliente),
  FOREIGN KEY (FK_VEICULO_idVeiculo) REFERENCES veiculo (idVeiculo)
);

-- TABELA ENDEREÇO
CREATE TABLE endereco (
  idEndereco INTEGER,
  rua INTEGER,
  cep VARCHAR,
  cidade VARCHAR,
  estado VARCHAR,
  numero INTEGER,
  complemento VARCHAR,
  FK_CLIENTE_idCliente INTEGER,
  FK_FILIAL_idFilial INTEGER,
  PRIMARY KEY (idEndereco, FK_CLIENTE_idCliente, FK_FILIAL_idFilial)
  FOREIGN KEY (FK_CLIENTE_idCliente) REFERENCES cliente (idCliente) ON DELETE CASCADE,
  FOREIGN KEY (FK_FILIAL_idFilial) REFERENCES filial (idFilial) ON DELETE CASCADE
);

-- TABELA RELACIONEMENTO LOCAÇÃO
CREATE TABLE loca (
  FK_ALUGUEL_ALUGA_contrato INTEGER,
  FK_FILIAL_idFilial INTEGER,
  FOREIGN KEY (FK_ALUGUEL_ALUGA_contrato) REFERENCES aluguel_aluga (contrato) ON DELETE RESTRICT,
  FOREIGN KEY (FK_FILIAL_idFilial) REFERENCES filial(idFilial) ON DELETE SET NULL
);

  --------------------------------------------
  -- COMANDOS DE MANIPULAÇÃO DE DADOS - DML --
  --------------------------------------------
-- INSERÇÃO DOS DADOS
INSERT INTO cliente VALUES
(1,'Marcos Pereira', 12526153946, '91985643852', '1994-10-30'),
(2,'Kelly Medeiros', 67959593706, '91982637549', '1969-12-13'),
(3,'Raylander Machado', 55185525919, '91998768453', '1984-09-26'),
(4,'Gabriel Brandão', 88664906847, '91981435789', '1987-11-13'),
(5,'Yasmim Silva', 12690759727, '91983578709', '1989-05-15'),
(6,'Ana Oliveira', 11260077360, '91991648695', '1991-01-12'),
(7,'Maria Rufino', 11694557287, '91992548704', '1977-11-03'),
(8,'Valéria Souza', 88059638739, '91992548795', '1973-08-56');

INSERT INTO fisico VALUES 
('682.986.960-93', 3),
('280.859.840-83', 6),
('528.961.370-68', 4),
('951.886.260-55', 5),
('117.109.730-13', 7),
('430.333.440-54', 1);

INSERT INTO juridico VALUES
('23.266.410/0001-84', 'MEI', 2),
('15.280.812/0001-05', 'EPP', 8);

INSERT INTO veiculo VALUES
(1, '6pV Yb257h 31 9P3787', 'MOP-6969', 31234.5, 'vermelho', 2019, 'Uno'),
(2, '1AR xaNK8C X7 4A3182', 'BYB-7612', 23546.2, 'vermelho', 2019, 'Punto'),
(3, '10A 7wDDxw 5t 584325', 'KYY-7629', 12556.9, 'prata', 2020, 'Compass'),
(4, '2D8 BNUA78 2f Vh6321', 'NEQ-9080', 43464.5, 'preto', 2018, 'Titan'),
(5, '52f HhZb6A d7 A13538', 'NDP-4298', 76525.5, 'azul', 2017, 'Fan'),
(6, '52f HhZb6A d7 A13538', 'MWH-2550', 34578.4, 'preto', 2018, 'Jeep'),
(7, '1AG ARPWN3 b0 Ec7958', 'MBV-0570', 23445.7, 'branco', 2018, 'Gol'),
(8, '1m0 kApfAA kh vc7510', 'KFM-0133', 51045.4, 'branco', 2016, 'Siena'),
(9, '2Hb dl6Lfw yp Up4063', 'IVK-7117', 4587.2, 'prata', 2021, 'Bros'),
(10,'88F AA7caC Tz zx6290', 'NAP-0268', 2345.5, 'branco', 2021, 'Strada');

INSERT INTO itensMoto VALUES
(11, 1, 1, 1),
(12, 0, 1, 1),
(13, 0, 1, 0);

INSERT INTO itensCarro VALUES
(21, 1, 1, 1, 0),
(22, 1, 1, 1, 1),
(23, 1, 1, 1, 1),
(24, 1, 1, 1, 0),
(25, 1, 1, 1, 1),
(26, 0, 1, 0, 1),
(27, 0, 1, 0, 0);

INSERT INTO moto VALUES
(100, 'Bros', 11, 9),
(101, 'Titan', 13, 4),
(102, 'Fan', 12, 5);

INSERT INTO carro VALUES
(200, 'Gol', 21, 7),
(201, 'Compass', 22, 3),
(202, 'Uno', 23, 1),
(203, 'Jeep', 24, 6),
(204, 'Siena', 25,8),
(205, 'Punto', 26, 2),
(206, 'Strada', 27, 10);

INSERT INTO filial VALUES (1), (2), (3);

INSERT INTO aluguel_aluga VALUES
(1001, 2019-12-25, 2020-01-10, 2018-03-06, 2022-03-06, 1, 1),
(1002, 2020-01-23, 2020-01-28, 2019-10-12, 2022-10-12, 2, 2),
(1003, 2020-02-04, 2020-03-01, 2019-08-17, 2023-08-17, 3, 3),
(1004, 2020-02-06, 2020-02-20, 2019-01-16, 2022-01-16, 4, 6),
(1005, 2020-05-09, 2020-06-15, 2019-05-12, 2022-05-12, 1, 7),
(1006, 2020-06-24, 2020-06-12, 2017-12-19, 2021-12-19, 5, 8),
(1007, 2020-09-21, 2020-10-03, 2019-10-11, 2024-10-11, 6, 6),
(1008, 2020-12-23, 2021-01-03, 2019-01-04, 2023-01-04, 7, 5),
(1009, 2021-02-02, 2021-03-14, 2020-03-23, 2024-03-23, 8, 10),
(1010, 2021-03-12, 2021-03-12, 2020-03-22, 2023-03-22, 2, 9);

INSERT INTO endereco VALUES
(51, 'Avenida Barão do Rio Branco', '68742-145', 'Castanhal', 'PA', 23442, 'Nova Olinda', 1, 0),
(52, 'Alameda Mazar Alli', '68744-582', 'Castanhal', 'PA', 34234, 'Ianetama', 0, 2),
(53, 'Alameda Carlos Gomes', '68745-210', 'Castanhal', 'PA', 21343, 'Santa Lídia', 3, 0),
(54, 'Travessa Benfica', '68742-630', 'Castanhal', 'PA', 56574, 'Nova Olinda', 4, 0),
(55, 'Alameda da Delegacia', '68742-561', 'Castanhal', 'PA', 23245, 'Cristo Redentor', 5, 0),
(56, 'Rua Coronel Leal', '68742-035', 'Castanhal', 'PA', 67432, 'Nova Olinda', 6, 0),
(57, 'Rua Olavo Bilac', '68745-078', 'Castanhal', 'PA', 23245, 'Santa Lídia', 7, 0),
(58, 'Travessa Sete de Setembro', '68743-709', 'Castanhal', 'PA', 12343, 'Novo Estrela', 0, 8);

INSERT INTO loca VALUES
(1001, 1),
(1002, 2),
(1003, 3),
(1004, 3),
(1005, 3),
(1006, 2),
(1007, 2),
(1008, 1),
(1009, 3),
(1010, 1);

  --------------------------------------------
  -- COMANDOS DE CONSULTA DE DADOS - DQL --
  --------------------------------------------

.print '1ª CONSULTA'
.print '- Quantidade de Clientes'
SELECT COUNT (idCliente) FROM cliente;

.print
.print '2ª CONSULTA'
.print '- Cliente nascidos a partir de 1990'
SELECT idCliente, nome FROM cliente WHERE dataNascimento BETWEEN '1990-01-01' AND '2000-01-01';

.print
.print '3ª CONSULTA'
.print '- Média de quilometragem dos Veiculos'
SELECT AVG(kmAtual) FROM veiculo;

.print
.print '4ª CONSULTA'
.print '- Veiculo com maior quilometragem'
SELECT idVeiculo, placa, kmAtual FROM veiculo WHERE kmAtual = (SELECT MAX(kmAtual) FROM veiculo);

.print
.print '5ª CONSULTA'
.print 'Modelos de Carros'
SELECT v.idVeiculo, v.placa, c.modeloCarro FROM veiculo v, carro c ON v.modelo = c.modeloCarro;

.print
.print '6ª CONSULTA'
.print 'Modelos de Carros com inicial P'
SELECT v.idVeiculo, v.placa, c.modeloCarro FROM veiculo v, carro c ON v.modelo = c.modeloCarro WHERE c.modeloCarro LIKE 'P%';

.print
.print '7ª CONSULTA'
.print 'Modelos de Carros que não iniciam com P'
SELECT v.idVeiculo, v.placa, c.modeloCarro FROM veiculo v, carro c ON v.modelo = c.modeloCarro WHERE c.modeloCarro NOT LIKE 'P%';

.print
.print '8ª CONSULTA'
.print 'Nome dos Clientes em Ordem Alfabética'
SELECT nome, cnh FROM cliente ORDER BY nome;

.print
.print '9ª CONSULTA'
.print 'Mostrando o menor Cep'
SELECT MIN(cep) FROM endereco;

.print
.print '10ª CONSULTA'
.print 'Média quilometragem das motos'
SELECT AVG(kmAtual) FROM veiculo WHERE idVeiculo IN (4, 5, 9);

.print
.print '11ª CONSULTA'
.print 'Média quilometragem dos Carros. Com duas casas decimais'
SELECT ROUND((AVG(kmAtual)),2) FROM veiculo WHERE idVeiculo NOT IN (4, 5, 9);

.print
.print '12ª CONSULTA'
.print 'Mostrando complementos dos endereços dos Clientes sem repetir valores'
SELECT DISTINCT complemento FROM endereco;

.print
.print '13ª CONSULTA'
.print 'Mostrando clientes Pessoa Fisica'
SELECT c.nome, f.cpf FROM cliente c, fisico f ON FK_CLIENTE_idCliente = idCliente ORDER BY nome;

.print
.print '14ª CONSULTA'
.print 'Mostrando clientes Pessoa Juridica'
SELECT c.nome, j.cnpj FROM cliente c, juridico j ON FK_CLIENTE_idCliente = idCliente;

.print
.print '15ª CONSULTA'
.print 'Mostrado as Datas de Encerramento de Contratos depois dos anos 2000'
SELECT c.nome, a.contrato, a.dataFim FROM cliente c, aluguel_aluga a ON FK_CLIENTE_idCliente = idCliente WHERE dataFim > 2000 ORDER BY dataFim ;

.print
.print '16ª CONSULTA'
.print 'Mostrando a quantidade de vezes que um complemento se repete'
SELECT DISTINCT COUNT(idEndereco), complemento FROM endereco GROUP BY complemento ORDER BY COUNT(idEndereco);

.print
.print '17ª CONSULTA'
.print 'Mostrando o numero de contratos que cada filial tem'
SELECT DISTINCT f.idFilial, COUNT(l.FK_ALUGUEL_ALUGA_contrato) FROM loca l, filial f ON FK_FILIAL_idFilial = idFilial GROUP BY idFilial;