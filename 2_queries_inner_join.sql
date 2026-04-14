-- Q1) Heróis + equipa (cada herói tem equipa, portanto dá sempre match)
SELECT
  h.id,
  h.nome_capa,
  h.nivel,
  e.nome AS equipa,
  e.base_secreta
FROM herois h
INNER JOIN equipas e ON e.id = h.id_equipa
ORDER BY e.nome, h.nivel DESC;

-- Q2) Missões + equipa responsável
SELECT
  m.id,
  m.titulo,
  m.dificuldade,
  m.data_inicio,
  e.nome AS equipa
FROM missoes m
INNER JOIN equipas e ON e.id = m.id_equipa
ORDER BY m.data_inicio;

-- Q3) Gadgets + herói dono + equipa do herói (cadeia de INNER JOIN)
-- (nota: heróis sem gadget não aparecem)
SELECT
  g.id,
  g.nome AS gadget,
  g.tipo,
  h.nome_capa AS heroi,
  e.nome AS equipa
FROM gadgets g
INNER JOIN herois h ON h.id = g.id_heroi
INNER JOIN equipas e ON e.id = h.id_equipa
ORDER BY e.nome, h.nome_capa, g.nome;

-- Q4) Recompensas + missão + equipa (cadeia de INNER JOIN)
-- (nota: missões sem recompensa não aparecem)
SELECT
  r.id,
  r.descricao,
  r.pontos,
  m.titulo AS missao,
  e.nome AS equipa
FROM recompensas r
INNER JOIN missoes m ON m.id = r.id_missao
INNER JOIN equipas e ON e.id = m.id_equipa
ORDER BY r.pontos DESC;

-- Q5) Auto-join: herói + mentor (só os que têm mentor aparecem)
SELECT
  aluno.id,
  aluno.nome_capa AS heroi,
  mentor.nome_capa AS mentor,
  aluno.nivel AS nivel_heroi,
  mentor.nivel AS nivel_mentor
FROM herois aluno
INNER JOIN herois mentor ON mentor.id = aluno.id_heroi
ORDER BY mentor.nome_capa, aluno.nome_capa;