use atlas_database;

CREATE TABLE `estado` (
  `idEstado` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`idEstado`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO estado (sigla)
SELECT DISTINCT UF FROM atlas_desnormalizado;

CREATE TABLE `partido` (
  `idPartido` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  `sigla` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`idPartido`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `partido` VALUES
(1 ,'PARTIDO DO MOVIMENTO DEMOCRÁTICO BRASILEIRO','PMDB'),
(2 , 'PARTIDO TRABALHISTA BRASILEIRO', 'PTB'),
(3 , 'PARTIDO DEMOCRÁTICO TRABALHISTA', 'PDT'),
(4 , 'PARTIDO DOS TRABALHADORES', 'PT'),
(5 , 'DEMOCRATAS', 'DEM'),
(6 , 'PARTIDO COMUNISTA DO BRASIL', 'PCdoB'),
(7 , 'PARTIDO SOCIALISTA BRASILEIRO', 'PSB'),
(8 , 'PARTIDO DA SOCIAL DEMOCRACIA BRASILEIRA', 'PSDB'),
(9 , 'PARTIDO TRABALHISTA CRISTÃO', 'PTC'),
(10, 'PARTIDO SOCIAL CRISTÃO', 'PSC'),
(11, 'PARTIDO DA MOBILIZAÇÃO NACIONAL', 'PMN'),
(12, 'PARTIDO REPUBLICANO PROGRESSISTA', 'PRP'),
(13, 'PARTIDO POPULAR SOCIALISTA', 'PPS'),
(14, 'PARTIDO VERDE', 'PV'),
(15, 'PARTIDO TRABALHISTA DO BRASIL', 'PTdoB'),
(16, 'PARTIDO PROGRESSISTA', 'PP'),
(17, 'PARTIDO SOCIALISTA DOS TRABALHADORES UNIFICADO', 'PSTU'),
(18, 'PARTIDO COMUNISTA BRASILEIRO', 'PCB'),
(19, 'PARTIDO RENOVADOR TRABALHISTA BRASILEIRO', 'PRTB'),
(20, 'PARTIDO HUMANISTA DA SOLIDARIEDADE', 'PHS'),
(21, 'PARTIDO SOCIAL DEMOCRATA CRISTÃO', 'PSDC'),
(22, 'PARTIDO DA CAUSA OPERÁRIA', 'PCO'),
(23, 'PARTIDO TRABALHISTA NACIONAL', 'PTN'),
(24, 'PARTIDO SOCIAL LIBERAL', 'PSL'),
(25, 'PARTIDO REPUBLICANO BRASILEIRO', 'PRB'),
(26, 'PARTIDO SOCIALISMO E LIBERDADE', 'PSOL'),
(27, 'PARTIDO DA REPÚBLICA', 'PR'),
(28, 'PARTIDO SOCIAL DEMOCRÁTICO', 'PSD'),
(29, 'PARTIDO PÁTRIA LIVRE', 'PPL'),
(30, 'PARTIDO ECOLÓGICO NACIONAL', 'PEN'),
(31, 'PARTIDO REPUBLICANO DA ORDEM SOCIAL', 'PROS'),
(32, 'SOLIDARIEDADE', 'SD'),
(33, 'PARTIDO NOVO', 'PN'),
(34, 'REDE SUSTENTABILIDADE', 'REDE');

CREATE TABLE `classePopulacao` (
  `idClassePop` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NULL,
  PRIMARY KEY (`idClassePop`)
);

INSERT INTO classePopulacao (nome)
SELECT DISTINCT classe_populacao FROM atlas_desnormalizado;

CREATE TABLE `municipio` (
  `idMunicipio` INT NOT NULL ,
  `idEstado` INT NOT NULL ,
  `idClassePop` INT NOT NULL,
  `nomeMunicipio` VARCHAR(50) NULL ,
  `idh` DOUBLE NULL ,
  `gini` DOUBLE NULL ,
  `populacao` INT NULL ,
  `dataCriacao` DATETIME NULL ,
  `dataInstalacao` DATETIME NULL ,
  PRIMARY KEY (`idMunicipio`),
  FOREIGN KEY (`idEstado`) REFERENCES `estado` (`idEstado`),
  FOREIGN KEY (`idClassePop`) REFERENCES `classePopulacao` (`idClassePop`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO municipio (idMunicipio, idEstado, idClassePop, nomeMunicipio, idh, gini, populacao, dataCriacao, dataInstalacao)
SELECT codigo_municipio, (SELECT idEstado FROM estado WHERE sigla = UF), (SELECT idClassePop FROM classePopulacao WHERE classe_populacao = classePopulacao.nome), nome_municipio, idh, gini, populacao, data_criacao, data_instalacao FROM atlas_desnormalizado;

CREATE TABLE `coalizao` (
  `idCoalizao` INT NOT NULL AUTO_INCREMENT,
  `ano` INT NOT NULL,
  PRIMARY KEY (`idCoalizao`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `coligado` (
  `idColigado` INT NOT NULL,
  `idCoalizao` INT NOT NULL,
  `idPartido` INT NOT NULL,
  PRIMARY KEY (`idColigado`),
  FOREIGN KEY (`idCoalizao`) REFERENCES `coalizao` (`idCoalizao`),
  FOREIGN KEY (`idPartido`) REFERENCES `partido` (`idPartido`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `balanco` (
  `idBalanco` INT NOT NULL AUTO_INCREMENT,
  `idMunicipio` INT NOT NULL,
  `iptu` DOUBLE NULL ,
  `transferencias` DOUBLE NULL,
  `impostos` DOUBLE NULL ,
  `ano` INT NULL ,
  `receita` DOUBLE NULL,
  `itbi` DOUBLE NULL,
  `issqn` DOUBLE NULL,
  `perTransferencias` DOUBLE NULL,
  `perImpostos` DOUBLE NULL,
  PRIMARY KEY (`idBalanco`),
  FOREIGN KEY (`idMunicipio`) REFERENCES `municipio` (`idMunicipio`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2002", iptu_2002, transferencias_2002, impostos_2002, receita_orcamentaria_2002, itbi_2002, issqn_2002, percentual_transferencias_2002, percentual_impostos_2002 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2003", iptu_2003, transferencias_2003, impostos_2003, receita_orcamentaria_2003, itbi_2003, issqn_2003, percentual_transferencias_2003, percentual_impostos_2003 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2004", iptu_2004, transferencias_2004, impostos_2004, receita_orcamentaria_2004, itbi_2004, issqn_2004, percentual_transferencias_2004, percentual_impostos_2004 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2005", iptu_2005, transferencias_2005, impostos_2005, receita_orcamentaria_2005, itbi_2005, issqn_2005, percentual_transferencias_2005, percentual_impostos_2005 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2006", iptu_2006, transferencias_2006, impostos_2006, receita_orcamentaria_2006, itbi_2006, issqn_2006, percentual_transferencias_2006, percentual_impostos_2006 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2007", iptu_2007, transferencias_2007, impostos_2007, receita_orcamentaria_2007, itbi_2007, issqn_2007, percentual_transferencias_2007, percentual_impostos_2007 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2008", iptu_2008, transferencias_2008, impostos_2008, receita_orcamentaria_2008, itbi_2008, issqn_2008, percentual_transferencias_2008, percentual_impostos_2008 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2009", iptu_2009, transferencias_2009, impostos_2009, receita_orcamentaria_2009, itbi_2009, issqn_2009, percentual_transferencias_2009, percentual_impostos_2009 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2010", iptu_2010, transferencias_2010, impostos_2010, receita_orcamentaria_2010, itbi_2010, issqn_2010, percentual_transferencias_2010, percentual_impostos_2010 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2011", iptu_2011, transferencias_2011, impostos_2011, receita_orcamentaria_2011, itbi_2011, issqn_2011, percentual_transferencias_2011, percentual_impostos_2011 FROM atlas_desnormalizado;

INSERT INTO balanco (idMunicipio, ano, iptu, transferencias, impostos, receita, itbi, issqn, perTransferencias, perImpostos)
SELECT codigo_municipio, "2012", iptu_2012, transferencias_2012, impostos_2012, receita_orcamentaria_2012, itbi_2012, issqn_2012, percentual_receitas_2012, percentual_impostos_2012 FROM atlas_desnormalizado;

CREATE TABLE `mandato` (
  `idMandato` INT NOT NULL AUTO_INCREMENT,
  `ano` INT NULL,
  `ano_fim` INT NULL,
  `continuidade` BOOLEAN NULL,
  `perVotosVencedor` DOUBLE NULL,
  `idMunicipio` INT NOT NULL,
  `idCoalizao` INT NULL,
  `idPartido` INT NULL,
  PRIMARY KEY (`idMandato`),
  FOREIGN KEY (`idMunicipio`) REFERENCES `municipio` (`idMunicipio`),
  FOREIGN KEY (`idCoalizao`) REFERENCES `coalizao` (`idCoalizao`),
  FOREIGN KEY (`idPartido`) REFERENCES `partido` (`idPartido`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO mandato (ano, perVotosVencedor, idMunicipio, idPartido)
SELECT "2000", percentual_votosvencedor_2000, codigo_municipio, (SELECT idPartido FROM partido WHERE sigla = partido_prefeito_2000) FROM atlas_desnormalizado;

INSERT INTO mandato (ano, continuidade, perVotosVencedor, idMunicipio, idPartido)
SELECT "2004", continuidade_2004, percentual_votosvencedor_2004, codigo_municipio, (SELECT idPartido FROM partido WHERE sigla = partido_prefeito_2004) FROM atlas_desnormalizado;

INSERT INTO mandato (ano, continuidade, perVotosVencedor, idMunicipio, idPartido)
SELECT "2008", continuidade_2008, percentual_votosvencedor_2008, codigo_municipio, (SELECT idPartido FROM partido WHERE sigla = partido_prefeito_2008) FROM atlas_desnormalizado;

INSERT INTO mandato (ano, continuidade, perVotosVencedor, idMunicipio, idPartido)
SELECT "2012", continuidade_2012, percentual_votosvencedor_2012, codigo_municipio, (SELECT idPartido FROM partido WHERE sigla = partido_prefeito_2012) FROM atlas_desnormalizado;

CREATE TABLE `regime` (
  `idRegime` INT NOT NULL AUTO_INCREMENT,
  `nomeCargo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idRegime`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO regime (nomeCargo) VALUES
("Estatutario"),
("SVP"),
("CLT"),
("Estagiario"),
("Comissionado");

CREATE TABLE `escolaridade` (
  `idEscolaridade` INT NOT NULL AUTO_INCREMENT,
  `escolaridade` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idEscolaridade`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO escolaridade(escolaridade) VALUES
("Sem Instrução"),
("Fundamental"),
("Médio"),
("Superior"),
("Pos");

CREATE TABLE `cargo` (
  `idCargo` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NULL,
  `ano` INT NULL,
  `idEscolaridade` INT NOT NULL,
  `idRegime` INT NOT NULL,
  `idMandato` INT NOT NULL,
  PRIMARY KEY (`idCargo`),
  FOREIGN KEY (`idEscolaridade`) REFERENCES `escolaridade` (`idEscolaridade`),
  FOREIGN KEY (`idRegime`) REFERENCES `regime` (`idRegime`),
  FOREIGN KEY (`idMandato`) REFERENCES `mandato` (`idMandato`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_seminstrucao_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_seminstrucao_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_fundamental_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_fundamental_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_fundamental_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_medio_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_medio_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_medio_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_superior_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_superior_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_superior_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_pos_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_pos_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estatutarios_pos_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estatutario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

-- clt --

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_seminstrucao_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_seminstrucao_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_fundamental_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_fundamental_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_fundamental_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_medio_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_medio_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_medio_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_superior_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_superior_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_superior_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_pos_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_pos_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_clt_pos_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "CLT"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

-- comissionados

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_seminstrucao_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_seminstrucao_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_fundamental_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_fundamental_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_fundamental_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_medio_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_medio_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_medio_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_superior_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_superior_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_superior_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_pos_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_pos_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_somentecomissionados_pos_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "Comissionado"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

-- estagiarios
INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estagiarios_fundamental_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estagiario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estagiarios_fundamental_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estagiario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estagiarios_medio_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estagiario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_estagiarios_medio_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "Estagiario"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

-- SVP

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_seminstrucao_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_seminstrucao_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Sem Instrução"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_fundamental_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_fundamental_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_fundamental_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Fundamental"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_medio_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_medio_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_medio_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Médio"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_superior_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_superior_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_superior_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Superior"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_pos_2005, "2005", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2004") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_pos_2008, "2008", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2008") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;

INSERT INTO cargo (quantidade, ano, idEscolaridade, idRegime, idMandato)
SELECT ad_svp_pos_2014, "2014", (SELECT idEscolaridade FROM escolaridade WHERE escolaridade = "Pos"), (SELECT idRegime FROM regime WHERE nomeCargo = "SVP"), (SELECT idMandato FROM mandato WHERE idMunicipio = codigo_municipio and mandato.ano = "2012") FROM atlas_desnormalizado, municipio WHERE idMunicipio = codigo_municipio;


CREATE TABLE `tipoDirecao` (
  `idTipoDirecao` INT NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idTipoDirecao`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO tipoDirecao (tipo) VALUES
("Indicação"),
("Concurso"),
("Eleição"),
("Outra forma");

CREATE TABLE `programaEducacao` (
  `idProgramaEducacao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idProgramaEducacao`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO programaEducacao (nome)
SELECT DISTINCT edu_programa FROM atlas_desnormalizado;


CREATE TABLE `orgao` (
  `idOrgao` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idOrgao`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO orgao (nome)
SELECT DISTINCT edu_agestaodosrecursosestasobaresponsabilidade FROM atlas_desnormalizado;

CREATE TABLE `educacao` (
  `idEducacao` INT NOT NULL AUTO_INCREMENT,
  `leiOrganica` BOOLEAN NULL,
  `idMunicipio` INT NOT NULL,
  `idOrgao` INT NOT NULL,
  `idTipoDirecao` INT NOT NULL,
  `idProgramaEducacao` INT NULL,
  PRIMARY KEY (`idEducacao`),
  FOREIGN KEY (`idMunicipio`) REFERENCES `municipio` (`idMunicipio`),
  FOREIGN KEY (`idOrgao`) REFERENCES `orgao` (`idOrgao`),
  FOREIGN KEY (`idTipoDirecao`) REFERENCES `tipoDirecao` (`idTipoDirecao`),
  FOREIGN KEY (`idProgramaEducacao`) REFERENCES `programaEducacao` (`idProgramaEducacao`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO educacao (leiOrganica, idMunicipio, idOrgao, idTipoDirecao, idProgramaEducacao)
SELECT IF (edu_leiorganicadefine="SIM",1,0), codigo_municipio, (SELECT idOrgao FROM orgao WHERE nome = edu_agestaodosrecursosestasobaresponsabilidade), (SELECT idTipoDirecao FROM tipoDirecao WHERE tipo = "Indicação"), (SELECT idProgramaEducacao FROM programaEducacao WHERE nome = edu_programa) FROM atlas_desnormalizado WHERE edu_diretoresindicacao = "Sim";

INSERT INTO educacao (leiOrganica, idMunicipio, idOrgao, idTipoDirecao, idProgramaEducacao)
SELECT IF (edu_leiorganicadefine="SIM",1,0), codigo_municipio, (SELECT idOrgao FROM orgao WHERE nome = edu_agestaodosrecursosestasobaresponsabilidade), (SELECT idTipoDirecao FROM tipoDirecao WHERE tipo = "Concurso"), (SELECT idProgramaEducacao FROM programaEducacao WHERE nome = edu_programa) FROM atlas_desnormalizado WHERE edu_diretoresconcurso = "Sim";

INSERT INTO educacao (leiOrganica, idMunicipio, idOrgao, idTipoDirecao, idProgramaEducacao)
SELECT IF (edu_leiorganicadefine="SIM",1,0), codigo_municipio, (SELECT idOrgao FROM orgao WHERE nome = edu_agestaodosrecursosestasobaresponsabilidade), (SELECT idTipoDirecao FROM tipoDirecao WHERE tipo = "Eleição"), (SELECT idProgramaEducacao FROM programaEducacao WHERE nome = edu_programa) FROM atlas_desnormalizado WHERE edu_diretoreseleicao = "Sim";

INSERT INTO educacao (leiOrganica, idMunicipio, idOrgao, idTipoDirecao, idProgramaEducacao)
SELECT IF (edu_leiorganicadefine="SIM",1,0), codigo_municipio, (SELECT idOrgao FROM orgao WHERE nome = edu_agestaodosrecursosestasobaresponsabilidade), (SELECT idTipoDirecao FROM tipoDirecao WHERE tipo = "Outra forma"), (SELECT idProgramaEducacao FROM programaEducacao WHERE nome = edu_programa) FROM atlas_desnormalizado WHERE edu_diretoresoutraforma = "Sim";


CREATE TABLE `saude` (
  `idSaude` INT NOT NULL AUTO_INCREMENT,
  `idMunicipio` INT NOT NULL,
  `equipesPSF` INT NULL,
  `encontrosCS` INT NULL,
  PRIMARY KEY (`idSaude`),
  FOREIGN KEY (`idMunicipio`) REFERENCES `municipio` (`idMunicipio`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO saude (idMunicipio, equipesPSF, encontrosCS)
SELECT codigo_municipio, saude_quantidadeequipespsf, saude_quantidadedereunioesultimos12meses FROM atlas_desnormalizado;
