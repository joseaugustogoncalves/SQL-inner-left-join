-- L1) Heróis + equipa (LEFT JOIN aqui é equivalente ao INNER JOIN, porque id_equipa é NOT NULL
--     e existe equipa para cada herói; mas serve para comparar o “estilo”)
SELECT
  h.id,
  h.nome_capa,
  h.nivel,
  e.nome AS equipa,
  e.base_secreta
FROM herois h
LEFT JOIN equipas e ON e.id = h.id_equipa
ORDER BY e.nome, h.nivel DESC;

-- L2) Missões + equipa responsável (também dá match sempre, mas mantém o padrão para a aula)
SELECT
  m.id,
  m.titulo,
  m.dificuldade,
  m.data_inicio,
  e.nome AS equipa
FROM missoes m
LEFT JOIN equipas e ON e.id = m.id_equipa
ORDER BY m.data_inicio;

-- L3) Heróis + gadgets (aqui vê-se a diferença importante:
--     heróis SEM gadget aparecem com gadget = NULL)
SELECT
  h.id,
  h.nome_capa,
  g.nome AS gadget,
  g.tipo
FROM herois h
LEFT JOIN gadgets g ON g.id_heroi = h.id
ORDER BY h.nome_capa, g.nome;

-- L4) Missões + recompensas (missões SEM recompensa aparecem com descricao/pontos = NULL)
SELECT
  m.id,
  m.titulo,
  r.descricao,
  r.pontos
FROM missoes m
LEFT JOIN recompensas r ON r.id_missao = m.id
ORDER BY m.id, r.pontos DESC;

-- L5) Auto-join (mentor): todos os heróis + o seu mentor (se não tiver mentor, fica NULL)
SELECT
  aluno.id,
  aluno.nome_capa AS heroi,
  mentor.nome_capa AS mentor
FROM herois aluno
LEFT JOIN herois mentor ON mentor.id = aluno.id_heroi
ORDER BY aluno.nome_capa;