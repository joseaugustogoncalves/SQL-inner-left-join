DROP DATABASE IF EXISTS clube_herois;
CREATE DATABASE clube_herois;
USE clube_herois;

-- 1) equipas
CREATE TABLE equipas (
  id INT(11) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(60) NOT NULL,
  base_secreta VARCHAR(60) NOT NULL,
  PRIMARY KEY (id)
);

-- 2) herois (FKs logo a seguir à PK: id_equipa e id_heroi)
CREATE TABLE herois (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_equipa INT(11) NOT NULL,
  id_heroi INT(11) NULL, -- mentor (auto-relacionamento)
  nome VARCHAR(60) NOT NULL,
  nome_capa VARCHAR(60) NOT NULL,
  nivel INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_herois_equipas
    FOREIGN KEY (id_equipa) REFERENCES equipas(id),
  CONSTRAINT fk_herois_mentor
    FOREIGN KEY (id_heroi) REFERENCES herois(id)
);

-- 3) missoes (FK logo a seguir à PK: id_equipa)
CREATE TABLE missoes (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_equipa INT(11) NOT NULL,
  titulo VARCHAR(80) NOT NULL,
  dificuldade VARCHAR(20) NOT NULL,
  data_inicio DATE NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_missoes_equipas
    FOREIGN KEY (id_equipa) REFERENCES equipas(id)
);

-- 4) gadgets (FK logo a seguir à PK: id_heroi)
CREATE TABLE gadgets (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_heroi INT(11) NOT NULL,
  nome VARCHAR(60) NOT NULL,
  tipo VARCHAR(30) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_gadgets_herois
    FOREIGN KEY (id_heroi) REFERENCES herois(id)
);

-- 5) recompensas (FK logo a seguir à PK: id_missao)
CREATE TABLE recompensas (
  id INT(11) NOT NULL AUTO_INCREMENT,
  id_missao INT(11) NOT NULL,
  descricao VARCHAR(100) NOT NULL,
  pontos INT(11) NOT NULL,
  PRIMARY KEY (id),
  CONSTRAINT fk_recompensas_missoes
    FOREIGN KEY (id_missao) REFERENCES missoes(id)
);

-- -------------------
-- Dados de exemplo
-- -------------------
INSERT INTO equipas (nome, base_secreta) VALUES
('liga do cafe', 'cantina subterranea'),
('debuggers anonimos', 'sala 404');

-- herois (vamos garantir: há heróis sem mentor E (mais importante) pelo menos 1 herói sem gadget)
INSERT INTO herois (id_equipa, id_heroi, nome, nome_capa, nivel) VALUES
(1, NULL, 'Rita',  'Capita SQL',     9);  -- id=1

INSERT INTO herois (id_equipa, id_heroi, nome, nome_capa, nivel) VALUES
(1, 1,    'Bruno', 'Null-Man',       6),  -- id=2
(1, 1,    'Ines',  'Lady Join',      7),  -- id=3
(2, NULL, 'Tiago', 'Captain Index',  8),  -- id=4
(2, 4,    'Sofia', 'Ms. Backup',     5),  -- id=5
(2, NULL, 'Leo',   'Sir Semicolon',  4);  -- id=6 (vai ficar sem gadget de propósito)

-- missoes (vamos garantir: existe missão sem recompensa)
INSERT INTO missoes (id_equipa, titulo, dificuldade, data_inicio) VALUES
(1, 'Salvar o servidor da cantina',        'facil',   '2026-04-01'), -- id=1
(1, 'Recuperar a chave primaria perdida',  'media',   '2026-04-05'), -- id=2  (vai ficar sem recompensa)
(2, 'Derrotar o bug fantasma',             'dificil', '2026-04-03'), -- id=3
(2, 'Ajustar o timezone do servidor',      'media',   '2026-04-07'); -- id=4

-- gadgets (mais gadgets; manter herói id=6 sem nenhum)
INSERT INTO gadgets (id_heroi, nome, tipo) VALUES
(1, 'capa anti-erro',          'defesa'),
(1, 'scanner de tabelas',      'analise'),
(2, 'caneca infinita',         'suporte'),
(2, 'detector de nulls',       'analise'),
(3, 'lupa de joins',           'analise'),
(3, 'corda de integridade',    'utilitario'),
(4, 'chave inglesa do index',  'performance'),
(5, 'pendrive sagrado',        'backup'),
(5, 'escudo anti-delete',      'defesa');

-- recompensas (mais recompensas; manter missão id=2 sem recompensa)
INSERT INTO recompensas (id_missao, descricao, pontos) VALUES
(1, 'medalha de integridade referencial', 100),
(1, 'cupao de cafe',                       30),
(1, 'autocolante "eu amo SQL"',            10),
(3, 'titulo "mestre dos joins"',          150),
(3, 'skin lendaria de debugger',           60),
(4, 'voucher de armazenamento na cloud',   80),
(4, 'trofeu "rei do log"',                 40);


INSERT INTO
    equipas (nome, base_secreta)
VALUES (
        'Nasa delta force',
        'Nasa sem recompensa base'
    );

INSERT INTO missoes (id_equipa, titulo, dificuldade, data_inicio) VALUES
(3, 'Salvar a lua do Trump', 'Complicada',   '2026-04-15');