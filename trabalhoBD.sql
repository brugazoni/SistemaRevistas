-- TABLES
	CREATE TABLE usuario(
		cpf varchar(14) PRIMARY KEY
			CONSTRAINT formato_cpf CHECK (cpf LIKE '___.___.___-__'),
		nome varchar(150) NOT NULL, 
		email varchar(100) NOT NULL,
			CONSTRAINT formato_email CHECK (email LIKE '%@%'),
		data_nasc date NOT NULL,
		senha integer NOT NULL
			CONSTRAINT ndigitos_senha CHECK (floor(log(abs(senha))+1) BETWEEN 6 AND 15),
		instituicao varchar(100),
		descricao varchar(1000),
		n_avaliacoes integer DEFAULT 0
			CONSTRAINT zero_avaliacoes CHECK (n_avaliacoes = 0),
		deletado boolean DEFAULT false,
			CONSTRAINT falso_deletado CHECK (deletado = false),
		experiencia integer DEFAULT 0
			CONSTRAINT zero_experiencia CHECK (experiencia = 0)
	);

	CREATE TABLE segue (
		usuario varchar(14) REFERENCES usuario(cpf) ON DELETE CASCADE,
		seguido varchar(14) REFERENCES usuario(cpf) ON DELETE CASCADE,
		PRIMARY KEY (usuario, seguido)
	);

	CREATE TABLE revisor (
		revisor varchar(14) REFERENCES usuario(cpf) ON DELETE RESTRICT,
		certificacao varchar(100) NOT NULL,
		area1 varchar(100) NOT NULL,
		area2 varchar(100),
		area3 varchar(100),
		n_revisoes integer DEFAULT 0
			CONSTRAINT zero_revisoes CHECK (n_revisoes = 0),
		PRIMARY KEY (revisor)
	);

	CREATE TABLE editor (
		editor varchar(14) REFERENCES usuario(cpf) ON DELETE RESTRICT,
		certificacao varchar(100) NOT NULL,
		especialidade_1 varchar(100) NOT NULL,
		especialidade_2 varchar(100),
		especialidade_3 varchar(100),
		n_edicoes integer DEFAULT 0
			CONSTRAINT zero_revisoes CHECK (n_edicoes = 0),
		PRIMARY KEY (editor)
	);

	CREATE TABLE revista (
		dominio varchar(150) PRIMARY KEY
		CONSTRAINT formato_dominio CHECK (dominio LIKE '%.com'),
		nome varchar(100) NOT NULL,
		n_inscritos integer DEFAULT 0
			CONSTRAINT zero_inscritos CHECK (n_inscritos = 0),
		n_volumes integer DEFAULT 0
			CONSTRAINT zero_volumes CHECK (n_volumes = 0)
	);

	CREATE TABLE assina (
		usuario varchar(14) REFERENCES usuario(cpf) ON DELETE CASCADE,
		revista varchar(150) REFERENCES revista(dominio) ON DELETE CASCADE,
		PRIMARY KEY (usuario, revista)
	);

	CREATE TABLE edicao (
		editor varchar(14) REFERENCES editor(editor) ON DELETE RESTRICT,
		revista varchar(150) REFERENCES revista(dominio) ON DELETE CASCADE,
		PRIMARY KEY (editor, revista)
	);

	CREATE TABLE volume (
		id_volume integer PRIMARY KEY,
		revista varchar(150) REFERENCES revista(dominio) ON DELETE CASCADE,
		data date NOT NULL,
		capa varchar(200) NOT NULL,
		titulo varchar(200) NOT NULL,
		n_artigos integer DEFAULT 0,
		UNIQUE (revista, data)
	);

	CREATE TABLE editorial (
		volume integer REFERENCES volume(id_volume) ON DELETE CASCADE,
		titulo varchar(200) NOT NULL,
		texto varchar(200) NOT NULL,
		imagem_editorial varchar(200),
		PRIMARY KEY (volume)
	);

	CREATE TABLE administra (
		usuario varchar(14) REFERENCES usuario(cpf) ON DELETE RESTRICT,
		revista varchar(150) REFERENCES revista(dominio) ON DELETE CASCADE,
		PRIMARY KEY (usuario, revista)
	);

	CREATE TABLE artigo_prototipo (
		id_artigo integer PRIMARY KEY,
		submissor varchar(14) REFERENCES usuario(cpf) ON DELETE CASCADE,
		titulo varchar(200) NOT NULL,
		texto varchar(200) NOT NULL,
		tema varchar(200) NOT NULL,
		data_submissao date NOT NULL
	);

	CREATE TABLE artigo (
		id integer REFERENCES artigo_prototipo(id_artigo) ON DELETE RESTRICT,
		data_publicacao date NOT NULL,
		id_volume integer REFERENCES volume(id_volume) ON DELETE CASCADE,

		PRIMARY KEY (id)
	);


	CREATE TABLE cita (
		artigo integer REFERENCES artigo(id) ON DELETE CASCADE,
		artigo_citado integer REFERENCES artigo(id) ON DELETE RESTRICT,
		PRIMARY KEY (artigo, artigo_citado)
	);


	CREATE TABLE revisa (
		revisor varchar(14) REFERENCES revisor(revisor) ON DELETE RESTRICT,
		id_artigo integer REFERENCES artigo_prototipo(id_artigo) ON DELETE CASCADE,
		aprovacao boolean DEFAULT false,
		revisao varchar(200),
		PRIMARY KEY (revisor, id_artigo)
	);


	CREATE TABLE avaliacao_artigo (
		id_artigo integer REFERENCES artigo(id) ON DELETE CASCADE,
		usuario varchar(14) REFERENCES usuario(cpf) ON DELETE CASCADE,
		datahora timestamp,
		nota real
			CONSTRAINT range_nota CHECK (nota <= 10 AND nota >= 0),
		comentario varchar(200),
		
		PRIMARY KEY(id_artigo, usuario, datahora)
	);


	CREATE TABLE anexo (
		id integer PRIMARY KEY,
		cabecalho varchar(200),
		visibilidade integer DEFAULT 0,
		data date,
		dono varchar(14) REFERENCES usuario(cpf) ON DELETE CASCADE
	);

	CREATE TABLE arquivos_anexo (
		anexo integer REFERENCES anexo(id) ON DELETE CASCADE,
		nome varchar(200) NOT NULL,
		arquivo varchar(200) NOT NULL,
		PRIMARY KEY (anexo, nome)
	)


	CREATE TABLE utiliza_anexo (
		anexo integer REFERENCES anexo(id) ON DELETE RESTRICT,
		artigo integer REFERENCES artigo(id) ON DELETE CASCADE,
		PRIMARY KEY (anexo, artigo)
	)

----------------------------------------------------------------------------------------
-- INSERTS

-- USUÁRIOS
		--usuário sem especializações
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('111.111.111-11', 'João', 'eu@eu.eu', '1992-12-04', 123456, 'usp', 'quem se define se 	limita sdv', 0, false, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('211.111.111-11', 'Ariel', 'vc@eu.eu', '1992-12-04', 123456, 'usp', 'slk tio', 0, false, 0);

	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('211.222.111-11', 'Joana', 'jo@ana.eu', '1993-12-04', 123456, 'unicamps', 'leia o livro', 0, false, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('211.333.111-11', 'Salomão', 'salo@mao.vc', '1999-12-08', 123456, '', 'lendo o livro', 0, false, 0);

		--revisor
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('321.111.111-11', 'Carlos', 'oi@eu.eu', '1982-11-04', 123456, 'unesp', 'bem chato', 0, false, 0);

		--editor
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('111.333.111-11', 'Maria', 'nois@eu.eu', '1992-08-08', 123456, '', 'só nos compiuter', 0, false, 0);

		--administrador
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('144.333.111-11', 'Ângela', 'nois@eu.nois', '1992-05-08', 123456, '', 'sei administrar bolo e revista e acabou meu bolo, então', 0, false, 0);

--SEGUE
	INSERT INTO segue(usuario, seguido)
		VALUES('211.111.111-11', '111.111.111-11');

--REVISOR
	INSERT INTO revisor(revisor, certificacao, area1, area2, area3, n_revisoes)
		VALUES('321.111.111-11', 'certificado sim', 'data science', 'catar coquinho', '', '0');

--EDITOR
	INSERT INTO editor (editor, certificacao, especialidade_1, especialidade_2, especialidade_3, n_edicoes)
		VALUES ('111.333.111-11', 'editor certificado', 'compiuters', '', '', 0);

--REVISTA
	INSERT INTO revista (dominio, nome, n_inscritos, n_volumes)
		VALUES('revistadaboa.com', 'revista da boa', 0, 0);
	
	INSERT INTO revista (dominio, nome, n_inscritos, n_volumes)
		VALUES('revistashow.com', 'revista show', 0, 0);
	INSERT INTO revista (dominio, nome, n_inscritos, n_volumes)
		VALUES('bomdemais.com', 'bom demais', 0, 0);
	INSERT INTO revista (dominio, nome, n_inscritos, n_volumes)
		VALUES('cienciaehjoia.com', 'ciência é joia', 0, 0);
	INSERT INTO revista (dominio, nome, n_inscritos, n_volumes)
		VALUES('opiniaoboa.com', 'revista opinada', 0, 0);

--ASSINA
	--joão assina:
	INSERT INTO assina(usuario, revista)
		VALUES('111.111.111-11', 'revistashow.com');

		--joana assina:
	INSERT INTO assina(usuario, revista)
		VALUES('211.222.111-11', 'revistadaboa.com');
	INSERT INTO assina(usuario, revista)
		VALUES('211.222.111-11', 'cienciaehjoia.com');

		--salomão assina:
	INSERT INTO assina(usuario, revista)
		VALUES('211.333.111-11', 'revistadaboa.com');
	INSERT INTO assina(usuario, revista)
		VALUES('211.333.111-11', 'bomdemais.com');
	INSERT INTO assina(usuario, revista)
		VALUES('211.333.111-11', 'opiniaoboa.com');


--EDICAO
	INSERT INTO edicao(editor, revista)
		VALUES('111.333.111-11', 'revistadaboa.com');

--VOLUME
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1248, 'revistadaboa.com', '2020-07-14', 'minhascapas/capashow', 'Será que eu passo em BD? E outras polêmicas', 0);

	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1348, 'cienciaehjoia.com', '2017-12-06', 'minhascapas/capashow', 'Passado 1', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1448, 'revistadaboa.com', '2015-11-08', 'minhascapas/capashow', 'Passado 2', 1);
	
	--volumes futuros
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1249, 'revistashow.com', '2021-08-14', 'minhascapas1/capashow1', 'Volume futuro 1', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1328, 'bomdemais.com', '2021-12-12', 'minhascapas2/capashow2', 'Volume futuro 2', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1118, 'cienciaehjoia.com', '2020-10-15', 'minhascapas3/capashow3', 'Volume futuro 3', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1878, 'opiniaoboa.com', '2021-11-06', 'minhascapas4/capashow4', 'Volume futuro 4', 1);

--EDITORIAL
	INSERT INTO editorial (volume, titulo, texto, imagem_editorial)
		VALUES (1248, 'Rezando pra passar em BD', 'meustextos/minhasoracoes/oracaopoderosa', 'minhasimagens/eurezando.jpg');

--ADMINISTRA
	INSERT INTO administra (usuario, revista)
		VALUES ('144.333.111-11', 'revistadaboa.com');

--ARTIGO_PROTOTIPO
		--aceitos e publicados
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3551, '211.111.111-11', '10 razões pra a gente passar em BD, você não vai acreditar na 6!', 'meustextos/textao', 'súplicas', '2020-07-14');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3552, '321.111.111-11', 'Mais 10 razões pra a gente passar em BD, você não vai acreditar na 3!', 'meustextos/textao', 'súplicas', '2020-07-14');

	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3559, '321.111.111-11', 'Passado 1', 'seustextos/passado', 'historia', '2018-07-14');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3579, '321.111.111-11', 'Passado 2', 'seustextos/passadopassado', 'biologia', '2019-07-14');

		--não aceitos
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3553, '321.111.111-11', 'Protótipo tenso', 'meustextos/textaotenso', 'hmmmmmm', '2020-07-14');
		--aceitos no futuro ou passado e programados para serem publicados no futuro
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3753, '321.111.111-11', 'artigoFuturo 1', 'meustextos/textaos', 'biologia', '2020-11-14');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3583, '321.111.111-11', 'artigoFuturo 2', 'meustextos/textaos', 'computacao', '2021-11-14');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(9553, '321.111.111-11', 'artigoFuturo 3', 'meustextos/textaos', 'joguinho de tiro', '2020-12-15');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(9583, '211.111.111-11', 'artigoFuturo 4', 'meustextos/texts', 'ciencia de dados', '2019-12-15');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(9593, '211.111.111-11', 'artigoFuturo 5', 'meustextos/textei', 'historia', '2019-12-16');


--ARTIGO
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3551, '2020-11-05', 1248);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3552, '2020-11-06', 1248);

	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3559, '2017-12-06', 1348);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3579, '2015-11-08', 1448);

		--programados para publicação futura
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3753, '2021-08-14', 1249);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3583, '2021-12-12', 1328);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (9553, '2020-10-15', 1118);

			-- futuro e mesmo volume (na opiniaoboa.com)
		INSERT INTO artigo (id, data_publicacao, id_volume)
				VALUES (9583, '2021-11-06', 1878);
		INSERT INTO artigo (id, data_publicacao, id_volume)
				VALUES (9593, '2021-12-07', 1878);



--CITA
	INSERT INTO cita (artigo, artigo_citado)
			VALUES (3551, 3552);

--REVISA
		--aceitos
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3551, true, 'minhasrevisoes/tabembom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3552, true, 'minhasrevisoes/muitobom.txt');
		--não aceitos
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3553, false, 'minhasrevisoes/tabemruim.txt');

--AVALIACAO_ARTIGO
	INSERT INTO avaliacao_artigo (id_artigo, usuario, datahora, nota, comentario)
		VALUES (3551, '111.111.111-11', current_timestamp, 9.5, '/comentarios/parabensmerecido.txt');

--ANEXO
	INSERT INTO anexo (id, cabecalho, visibilidade, data, dono)
		VALUES (654, '/cabecalholalala', 0, '2020-07-14', '111.111.111-11');

--ARQUIVOS_ANEXO
	INSERT INTO arquivos_anexo (anexo, nome, arquivo)
		VALUES (654, 'arquivo_que_comprova_que_eu_devo_passar_em_bd.jpg', '/fakenews/einsteinbombouBDeagora?');

--UTILIZA_ANEXO
	INSERT INTO utiliza_anexo (anexo, artigo)
			VALUES (654, 3551);

----------------------------------------------------------------------------------------
-- CONSULTAS

--Q1:

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

