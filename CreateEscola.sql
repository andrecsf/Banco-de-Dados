CREATE DATABASE IF NOT EXISTS EscolaMusica;
USE EscolaMusica;

CREATE TABLE Orquestra (
    id_orquestra INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    data_criacao DATE NOT NULL
);

CREATE TABLE Sinfonia (
    id_sinfonia INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    compositor VARCHAR(100) NOT NULL,
    data_criacao DATE NOT NULL,
    id_orquestra INT NOT NULL,
    FOREIGN KEY (id_orquestra) REFERENCES Orquestra(id_orquestra) ON DELETE CASCADE
);

CREATE TABLE Musico (
    id_musico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    identidade VARCHAR(20) NOT NULL UNIQUE,
    nacionalidade VARCHAR(50) NOT NULL,
    data_nascimento DATE NOT NULL,
    id_orquestra INT NOT NULL,
    FOREIGN KEY (id_orquestra) REFERENCES Orquestra(id_orquestra) ON DELETE CASCADE
);

CREATE TABLE Funcao (
    id_funcao INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcao VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Instrumento (
    id_instrumento INT AUTO_INCREMENT PRIMARY KEY,
    nome_instrumento VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Musico_Instrumento (
    id_musico INT NOT NULL,
    id_instrumento INT NOT NULL,
    PRIMARY KEY(id_musico, id_instrumento),
    FOREIGN KEY (id_musico) REFERENCES Musico(id_musico) ON DELETE CASCADE,
    FOREIGN KEY (id_instrumento) REFERENCES Instrumento(id_instrumento) ON DELETE CASCADE
);

CREATE TABLE Musico_Funcao_Sinfonia (
    id_musico INT NOT NULL,
    id_sinfonia INT NOT NULL,
    id_funcao INT NOT NULL,
    id_instrumento INT NOT NULL,
    data_assumicao DATE NOT NULL,
    PRIMARY KEY(id_musico, id_sinfonia, id_funcao),
    FOREIGN KEY (id_musico) REFERENCES Musico(id_musico) ON DELETE CASCADE,
    FOREIGN KEY (id_sinfonia) REFERENCES Sinfonia(id_sinfonia) ON DELETE CASCADE,
    FOREIGN KEY (id_funcao) REFERENCES Funcao(id_funcao) ON DELETE CASCADE,
    FOREIGN KEY (id_instrumento) REFERENCES Instrumento(id_instrumento) ON DELETE CASCADE
);