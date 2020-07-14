-- TABLES
	CREATE TABLE usuario(
		cpf varchar(14) PRIMARY KEY
			CONSTRAINT formato_cpf CHECK (cpf LIKE '___.___.___-__'),
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
	INSERT INTO usuario(cpf, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('111.111.111-11', 'eu@eu.eu', '1992-12-04', 123456, 'usp', 'quem se define se 	limita sdv', 0, false, 0);
	INSERT INTO usuario(cpf, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('211.111.111-11', 'vc@eu.eu', '1992-12-04', 123456, 'usp', 'slk tio', 0, false, 0);

		--revisor
	INSERT INTO usuario(cpf, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('321.111.111-11', 'oi@eu.eu', '1982-11-04', 123456, 'unesp', 'bem chato', 0, false, 0);

		--editor
	INSERT INTO usuario(cpf, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('111.333.111-11', 'nois@eu.eu', '1992-08-08', 123456, '', 'só nos compiuter', 0, false, 0);

		--administrador
	INSERT INTO usuario(cpf, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('144.333.111-11', 'nois@eu.nois', '1992-05-08', 123456, '', 'sei administrar bolo e revista e acabou meu bolo, então', 0, false, 0);

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

--ASSINA
	INSERT INTO assina(usuario, revista)
		VALUES('111.111.111-11', 'revistadaboa.com');

--EDICAO
	INSERT INTO edicao(editor, revista)
		VALUES('111.333.111-11', 'revistadaboa.com');

--VOLUME
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1248, 'revistadaboa.com', 2020-07-14, 'minhascapas/capashow', 'Será que eu passo em BD? E outras polêmicas', 0);

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
		--não aceitos
		VALUES(3553, '321.111.111-11', 'Protótipo tenso', 'meustextos/textaotenso', 'hmmmmmm', '2020-07-14');

--ARTIGO
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3551, '2020-11-05', 1248);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3552, '2020-11-06', 1248);

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
