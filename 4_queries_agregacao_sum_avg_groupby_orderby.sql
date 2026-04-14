-- A1) Pontos totais de recompensas por missão
--     - LEFT JOIN para aparecerem também missões sem recompensa
--     - SUM(r.pontos) soma os pontos das recompensas da missão
--     - COALESCE(...,0) troca NULL por 0 nas missões sem recompensas
SELECT
  m.id,
  m.titulo,
  COALESCE(SUM(r.pontos), 0) AS pontos_totais
FROM missoes m
LEFT JOIN recompensas r ON r.id_missao = m.id
GROUP BY m.id
ORDER BY pontos_totais DESC, m.id ASC;

-- A2) Quantos gadgets cada herói tem
--     - LEFT JOIN para incluir heróis sem gadget
--     - COUNT(g.id) conta gadgets; quando não há, dá 0 (porque g.id fica NULL)
SELECT
  h.id,
  h.nome_capa,
  COUNT(g.id) AS total_gadgets
FROM herois h
LEFT JOIN gadgets g ON g.id_heroi = h.id
GROUP BY h.id, h.nome_capa
ORDER BY total_gadgets DESC, h.nome_capa;

-- A3) Média de nível dos heróis por equipa (AVG + GROUP BY)
--     - AVG(h.nivel) calcula a média do nível dentro de cada equipa
--     - ROUND(...,2) arredonda para ficar “bonito” na aula
-- valor → número ou expressão numérica
-- casas_decimais → quantidade de casas decimais a manter
-- positiva → casas decimais
-- zero → inteiro
--negativa → arredondar à dezena, centena, etc.

SELECT
  e.id,
  e.nome AS equipa,
  ROUND(AVG(h.nivel), 2) AS media_nivel
  -- ROUND(122, -2) AS arredondamento_exemplo
  -- ROUND(4.3, 2)
FROM equipas e
INNER JOIN herois h ON h.id_equipa = e.id
GROUP BY e.id, e.nome
ORDER BY media_nivel DESC;

-- A4) Total de pontos de recompensas por equipa
--     - Passa pela cadeia: equipas -> missoes -> recompensas
--     - LEFT JOIN em recompensas para equipas com missões sem recompensa não “perderem” essas missões
--     - Se uma equipa não tivesse recompensas nenhumas, ficaria com 0 por causa do COALESCE

-- A função COALESCE serve para substituir valores NULL pelo primeiro valor não nulo disponível.
-- Em termos simples: COALESCE devolve o primeiro valor que não seja NULL.
-- SELECT COALESCE(NULL, 10, 20);
-- SELECT COALESCE(NULL, NULL, 'Sem valor');
-- A palavra COALESCE vem do latim coalescere, que significa:
-- “juntar”, “fundir”, “unir”, “tornar‑se um só”
-- Em inglês técnico e científico, to coalesce significa reunir vários valores possíveis num único resultado final.
SELECT
  e.id,
  e.nome AS equipa,
  COALESCE(SUM(r.pontos), 0) AS pontos_equipa
FROM equipas e
INNER JOIN missoes m ON m.id_equipa = e.id
LEFT JOIN recompensas r ON r.id_missao = m.id
GROUP BY e.id, e.nome
ORDER BY pontos_equipa DESC, e.nome;

-- A5) Estatísticas por equipa: nº de heróis, nível médio e nível máximo
--     - COUNT(h.id): quantos heróis na equipa
--     - AVG(h.nivel): média do nível
--     - MAX(h.nivel): o maior nível na equipa
SELECT
  e.id,
  e.nome AS equipa,
  COUNT(h.id) AS total_herois,
  ROUND(AVG(h.nivel), 2) AS media_nivel,
  MAX(h.nivel) AS nivel_maximo
FROM equipas e
LEFT JOIN herois h ON h.id_equipa = e.id
GROUP BY e.id, e.nome
ORDER BY total_herois DESC, media_nivel DESC;