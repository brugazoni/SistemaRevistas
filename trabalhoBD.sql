----------------------------------------------------------------------------------------
-- CONSULTAS

--Q1: Junções internas comm checagem de artigos publicados no futuro ao juntar
-- as tabelas de volumes com revista.

	SELECT (u.nome, r.dominio, r.nome, v.titulo, v.data, p.tema, p.titulo)
		FROM usuario u
		INNER JOIN assina a
		ON u.cpf = a.usuario
		INNER JOIN revista r
		ON a.revista = r.dominio
		INNER JOIN volume v
		ON (v.revista = r.dominio) AND (v.data > current_date)
		INNER JOIN artigo ar
		ON (ar.id_volume = v.id_volume)
		INNER JOIN artigo_prototipo p
		ON (ar.id = p.id_artigo)
		ORDER BY u.cpf;

--Q2: Consultas de revistas que vão publicar artigos sobre computação em
--agosto do ano atual, que são excluídas do grupo de revistas elegíveis para
--o aviso por já terem publicado artigos sobre computação.

-- Primeiro select: revistas que já publicaram algo relacionado a computação
SELECT r.dominio, u.cpf, u.nome, u.email, p.tema
	FROM artigo_prototipo p
	INNER JOIN artigo a
	ON ((p.id_artigo = a.id) 
		AND (p.tema LIKE 'computacao')
	    AND (a.data_publicacao < current_date))
	INNER JOIN volume v
	ON (a.id_volume = v.id_volume)
	INNER JOIN revista r
	ON (v.revista = r.dominio)
	and r.dominio not in (
		-- Segundo select: revistas que vão publicar artigos de computação em agosto desse ano
			SELECT r.dominio
			FROM artigo_prototipo p
			INNER JOIN artigo a
			ON ((p.id_artigo = a.id) 
				AND (p.tema LIKE 'computacao')
				AND (array[EXTRACT(month from a.data_publicacao), EXTRACT(year from a.data_publicacao)]
					= array[8, EXTRACT(year from current_date)]))
			INNER JOIN volume v
			ON (a.id_volume = v.id_volume)
			INNER JOIN revista r
			ON (v.revista = r.dominio)
			INNER JOIN administra ad
			ON (ad.revista = r.dominio)
			INNER JOIN usuario u
			ON (ad.usuario = u.cpf)
			)
	INNER JOIN administra ad
	ON (ad.revista = r.dominio)
	INNER JOIN usuario u
	ON (ad.usuario = u.cpf);

--Q3:
-- Junção de todos os artigos com duas junções distintas
-- com a tabela de usuários, uma como submissor e outra como revisor.
-- Ao fim, ordenamos por data de publicação.

SELECT a.id, a.data_publicacao, r.dominio, p.submissor, p.titulo, p.texto, p.tema, u1.nome as submissor, u2.nome as revisor
	FROM artigo a
	INNER JOIN artigo_prototipo p
	ON a.id = p.id_artigo
	INNER JOIN volume v
	ON a.id_volume = v.id_volume
	INNER JOIN revista r
	ON r.dominio = v.revista
	
	INNER JOIN usuario u1
	ON u1.cpf = p.submissor
	
	INNER JOIN revisa rev
	ON rev.id_artigo = a.id
	INNER JOIN usuario u2
	ON rev.revisor = u2.cpf

	ORDER BY a.data_publicacao ASC;

--Q4:
-- Junção interna de tabelas com colunas renomeadas para fazer sentido semântico com 
-- a consulta em questão. Une-se query de contribuição de anexos com outra de 
-- contribuição de artigos citados, checando se foram feitos por usuários deletados.

SELECT u.nome, u.cpf, u.email, arq.nome as contribuição, p.titulo as onde_usaram

	FROM usuario u
	INNER JOIN anexo an
	ON (u.cpf = an.dono AND u.deletado = true)
	INNER JOIN arquivos_anexo arq
	ON an.id = arq.anexo
	INNER JOIN utiliza_anexo ut
	ON ut.anexo = an.id
	INNER JOIN artigo art
	ON ut.artigo = art.id
	INNER JOIN artigo_prototipo p
	ON art.id = p.id_artigo

UNION

	SELECT u.nome, u.cpf, u.email, p_citado.titulo as contribuição, p_cita.titulo as onde_usaram
	FROM usuario u
	INNER JOIN artigo_prototipo p_citado
	ON (u.cpf = p_citado.submissor AND u.deletado = true)
	INNER JOIN cita c
	ON c.artigo_citado = p_citado.id_artigo
	INNER JOIN artigo_prototipo p_cita
	ON c.artigo = p_cita.id_artigo;


--Q5: A query é dividida em duas partes, uma para administradores
-- e outra para editores, checando sempre se pelo menos uma das especialidades
-- e pelo menos uma das áreas do usuário é "biologia", e em seguida faz junção
-- interna com trabalho especializado em revistas que já atuaram na área.

	--Primeira query: trabalha como administrador
SELECT u.nome, u.cpf, u.email
	FROM usuario u
	INNER JOIN editor ed
	ON (ed.editor = u.cpf 
		AND 
	   		((ed.especialidade_1 LIKE 'biologia')
			OR
			(ed.especialidade_2 LIKE 'biologia')
			OR
			(ed.especialidade_3 LIKE 'biologia')))
	
	INNER JOIN revisor rev
	ON (rev.revisor = u.cpf
		AND 
	   		((rev.area1 LIKE 'biologia')
			OR
			(rev.area2 LIKE 'biologia')
			OR
			(rev.area3 LIKE 'biologia')))
	
	INNER JOIN administra ad
	ON (u.cpf = ad.usuario)
	INNER JOIN revista r
	ON (ad.revista = r.dominio)
	AND r.dominio in (
		SELECT r.dominio
			FROM artigo_prototipo p
			INNER JOIN artigo a
			ON (p.id_artigo = a.id AND p.tema LIKE 'biologia')
			INNER JOIN volume v
			ON (a.id_volume = v.id_volume)
			INNER JOIN revista r
			ON (v.revista = r.dominio))

UNION
	--Segunda query: trabalha como editor
SELECT u.nome, u.cpf, u.email
	FROM usuario u
	INNER JOIN editor ed
	ON (ed.editor = u.cpf 
		AND 
	   		((ed.especialidade_1 LIKE 'biologia')
			OR
			(ed.especialidade_2 LIKE 'biologia')
			OR
			(ed.especialidade_3 LIKE 'biologia')))
	
	INNER JOIN revisor rev
	ON (rev.revisor = u.cpf
		AND 
	   		((rev.area1 LIKE 'biologia')
			OR
			(rev.area2 LIKE 'biologia')
			OR
			(rev.area3 LIKE 'biologia')))
	
	INNER JOIN edicao edita
	ON (u.cpf = edita.editor)
	INNER JOIN revista r
	ON (edita.revista = r.dominio)
	AND r.dominio in (
		SELECT r.dominio
			FROM artigo_prototipo p
			INNER JOIN artigo a
			ON (p.id_artigo = a.id AND p.tema LIKE 'biologia')
			INNER JOIN volume v
			ON (a.id_volume = v.id_volume)
			INNER JOIN revista r
			ON (v.revista = r.dominio));

-- Q6
-- União de 3 queries para subtração de conjuntos, a partir da qual
-- selecionamos os usuários com experiência e sem função no sistema.
select u.cpf, u.nome, u.data_nasc, u.instituicao
select u.cpf, u.nome, u.data_nasc, u.instituicao
	from usuario u
	where 
	u.experiencia >= 50
	and
	u.n_avaliacoes >= 20
	and u.deletado = false
	and u.cpf not in(
	select a.usuario from administra a 
		union
	select e.editor from editor e 
		union
	select r.revisor from revisor r
);

--Q7
-- Query baseada na operação de divisão entre conjuntos: partimos da ideia de que
-- representar a divisão é a mesma coisa que excluir todos os elementos que não
-- assinam revistas onde o Benedito trabalha

SELECT u.cpf, u.email
FROM usuario u
WHERE NOT EXISTS
	(( -- Primeira subquery: seleciona todas as revistas editadas pelo Benedito
	  SELECT r.dominio
	  FROM revista r
	  INNER JOIN edicao ed
	  ON (r.dominio = ed.revista AND ed.editor = '999.333.111-11'))

	  EXCEPT
	  	( -- Segunda subquery: seleciona todos os usuários que assinam revistas
	  	 SELECT ass.revista
	  	 FROM assina ass
	  	 WHERE u.cpf = ass.usuario));

--Q8 Sugere revistas que um usuário ainda não conhece com base em suas avaliações de artigos.
-- Identifique revistas que um usuário não assinou, administrou ou editou com volume lançado no mês atual, revista que não possui artigos que
-- o usuario revisou ou submeteu (em suma, o usuráio no cãonhece a revista),
-- e que tenham pelo menos um artigo com o mesmo tema de um artigo que
-- este usuário avaliou com nota pelo menos 8. Mostre cpf, nome e email do usuário, nome da revista e tema do artigo.

--considerando um usuario com o cpf 100.200.300-40:
SELECT u.cpf, u.nome, u.email, r.dominio, p.tema
FROM usuario u
INNER JOIN revista r
ON u.cpf LIKE '100.200.300-40' AND r.dominio NOT IN
	--Essa subquery seleciona todas as revistas que o usuário conhece, ou seja,
	-- interagiu com, ou assinando, administrando, editando, submetendo artigos ou revisando artigos.
	-- Isso para que as revistas da query principal sejam filtradas devidamente.
	(SELECT r2.dominio
	FROM revista r2
	INNER JOIN usuario u2
	ON u2.cpf LIKE '100.200.300-40'
	INNER JOIN assina ass
	ON u2.cpf = ass.usuario AND r2.dominio = ass.revista
	INNER JOIN administra adm
	ON u2.cpf = adm.usuario AND r2.dominio = adm.revista
	
	INNER JOIN volume v2
	ON (r2.dominio = v2.revista)
	INNER JOIN artigo a2
	ON a2.id_volume = v2.id_volume
	INNER JOIN revisa rev
	ON u2.cpf = rev.revisor AND rev.id_artigo = a2.id
	INNER JOIN edicao ed
	ON u2.cpf = ed.editor AND r2.dominio = ed.revista
	INNER JOIN artigo_prototipo p2
	ON a2.id = p2.id_artigo AND p2.submissor = u2.cpf
	)
INNER JOIN volume v
ON (r.dominio = v.revista) AND (EXTRACT(MONTH FROM v.data) = EXTRACT(MONTH FROM current_date))
INNER JOIN artigo a
ON a.id_volume = v.id_volume
INNER JOIN artigo_prototipo p
ON p.id_artigo = a.id AND p.tema IN
	--Nesta subquery são selecionados todos os temas de artigos que o usuário em questão já avaliou e deu nota maior ou igual a 8,
	-- para que a query principal identifique os artigos que contenham esse tema para seleção.
	(SELECT p2.tema
	FROM artigo_prototipo p2
	INNER JOIN usuario u3
	ON u3.cpf LIKE '100.200.300-40'
	INNER JOIN avaliacao_artigo av
	ON p2.id_artigo = av.id_artigo AND av.usuario = u3.cpf
 	AND av.nota >= 8);

--Q9
--Mostra, para todo volume na base de dados, o título do volume,
--nome da revista, número de artigos no volume, titulo de cada artigo no volume, nota média das avaliações
--de cada artigo e a soma de número de citações dele.
SELECT v.titulo, r.nome, v.n_artigos, COUNT(c.artigo_citado) as citacoes_totais, p.titulo as artigo, AVG(av.nota) as media_artigo
	FROM volume v
	LEFT JOIN revista r
	ON v.revista = r.dominio
	LEFT JOIN artigo a
	ON a.id_volume = v.id_volume
	LEFT JOIN cita c
	ON c.artigo_citado = a.id
	LEFT JOIN artigo_prototipo p
	ON a.id = p.id_artigo
	LEFT JOIN avaliacao_artigo av
	ON a.id = av.id_artigo
	GROUP BY v.titulo, av.nota, p.titulo, c.artigo_citado, r.nome, v.n_artigos;

-- Q10

	---------------------
	--Selecionamos todas as revistas e informações de seus administradores que nunca publicaram
	-- uma imagem em seu editorial. Para isso, selecionamos todas as revistas que publicaram 
	-- ao menos uma imagem em seus editoriais, e obtemos o conjunto complementar.
	select r.dominio, u.nome, u.cpf, u.email
	from usuario u 
	inner join administra a
	on (a.usuario = u.cpf)
	inner join revista r
	on (a.revista = r.dominio) and
	r.dominio not in(
	select r.dominio
	from revista r
	inner join volume v
	on (r.dominio = v.revista)
	inner join editorial e
	on (v.id_volume = e.volume)
	group by r.dominio
	having count(case 
				when e.imagem_editorial is not null and e.imagem_editorial <> ''
					then 1 end)>0 
	)

