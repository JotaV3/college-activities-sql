CREATE DATABASE	eleicao;
USE eleicao;

CREATE TABLE partido(
	cod INT PRIMARY KEY,
    nome VARCHAR(70) NOT NULL
);

CREATE TABLE cargo(
	cod INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(70) NOT NULL
);

CREATE TABLE zona_secao(
	num_zona INT,
    num_secao INT,
    nome VARCHAR(70) NOT NULL,
    qtd_eleitores long,
    
	PRIMARY KEY(num_zona, num_secao)
);

CREATE TABLE candidato(
	num INT PRIMARY KEY,
    cod_cargo INT,
    cod_partido INT,
    nome VARCHAR(70) NOT NULL,
    
    FOREIGN KEY(cod_cargo) REFERENCES cargo(cod),
    FOREIGN KEY(cod_partido) REFERENCES partido(cod)
);

CREATE TABLE votacao(
	num_zona INT,
    num_secao INT,
    num_candidato INT,
    qtd_votos long,
    
    PRIMARY KEY(num_zona, num_secao, num_candidato),
    FOREIGN KEY(num_zona, num_secao) REFERENCES zona_secao(num_zona, num_secao),
    FOREIGN KEY(num_candidato) REFERENCES candidato(num)
);

