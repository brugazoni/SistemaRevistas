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
		n_avaliacoes integer DEFAULT 0,
		deletado boolean DEFAULT false,
		experiencia integer DEFAULT 0
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
		n_revisoes integer DEFAULT 0,
		PRIMARY KEY (revisor)
	);

	CREATE TABLE editor (
		editor varchar(14) REFERENCES usuario(cpf) ON DELETE RESTRICT,
		certificacao varchar(100) NOT NULL,
		especialidade_1 varchar(100) NOT NULL,
		especialidade_2 varchar(100),
		especialidade_3 varchar(100),
		n_edicoes integer DEFAULT 0,
		PRIMARY KEY (editor)
	);

	CREATE TABLE revista (
		dominio varchar(150) PRIMARY KEY
		CONSTRAINT formato_dominio CHECK (dominio LIKE '%.com'),
		nome varchar(100) NOT NULL,
		n_inscritos integer DEFAULT 0,
		n_volumes integer DEFAULT 0
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
		data_submissao date NOT NULL,

		UNIQUE (submissor, data_submissao, titulo)
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
	);


	CREATE TABLE utiliza_anexo (
		anexo integer REFERENCES anexo(id) ON DELETE RESTRICT,
		artigo integer REFERENCES artigo(id) ON DELETE CASCADE,
		PRIMARY KEY (anexo, artigo)
	);

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

		--deletados
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('999.222.111-11', 'Sumiu', 'su@miu.eu', '1990-12-04', 123456, '', 'leia o livro', 0, true, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('888.222.111-11', 'Vazou', 'va@zou.eu', '1991-12-04', 123456, 'ufscar', 'leia o livro', 0, true, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('777.222.111-11', 'Cadê', 'ca@dê.eu', '1998-12-04', 123456, 'unesp', 'leia o livro', 0, true, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('666.222.111-11', 'Feznada', 'fez@na.da', '1998-12-04', 123456, 'unesp', 'leia o livro', 0, true, 0);

		--revisor
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('321.111.111-11', 'Carlos', 'oi@eu.eu', '1982-11-04', 123456, 'unesp', 'bem chato', 0, false, 0);

		--editor
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('111.333.111-11', 'Maria', 'nois@eu.eu', '1992-08-08', 123456, '', 'só nos compiuter', 0, false, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('999.333.111-11', 'Benedito', 'ben@edito.eu', '1962-08-08', 123456, '', 'exímio editor', 0, false, 0);

		--administrador
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('144.333.111-11', 'Ângela', 'nois@eu.nois', '1992-05-08', 123456, '', 'sei administrar bolo e revista e acabou meu bolo, então', 0, false, 0);

	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('554.333.111-11', 'Carlos', 'car@los.nois', '1972-05-08', 123456, '', 'admin ai de mim', 0, false, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('700.333.111-11', 'Neusa', 'neu@sa.nois', '1982-02-18', 123456, 'puc', 'era isso ou fazer flogaum', 0, false, 0);

			--bioagradáveis
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('100.200.300-40', 'Bio', 'bio@logo.nois', '1988-02-18', 123456, 'puc', 'fitoterapeuta', 0, false, 0);
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('110.200.300-40', 'Leite', 'lo@gia.nois', '1978-02-18', 123456, 'unicamps', 'etnobotânico', 0, false, 0);
		
			--esse não vai ter artigo publicado e não pode aparecer na Q5
	INSERT INTO usuario(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia)
		VALUES('220.200.300-40', 'Ólogo', 'o@logo.nois', '1999-03-18', 123456, 'ufscar', 'micologista', 0, false, 0);

--SEGUE
	INSERT INTO segue(usuario, seguido)
		VALUES('211.111.111-11', '111.111.111-11');

--REVISOR
	INSERT INTO revisor(revisor, certificacao, area1, area2, area3, n_revisoes)
		VALUES('321.111.111-11', 'certificado sim', 'data science', 'catar coquinho', '', '13');
	INSERT INTO revisor(revisor, certificacao, area1, area2, area3, n_revisoes)
		VALUES('111.111.111-11', 'certificado sim', 'química', 'história', 'geografia', '1');
	
		--bioagradáveis
	INSERT INTO revisor(revisor, certificacao, area1, area2, area3, n_revisoes)
		VALUES('100.200.300-40', 'certificado sim', 'biologia', 'catar coquinho', '', '0');
	INSERT INTO revisor(revisor, certificacao, area1, area2, area3, n_revisoes)
		VALUES('110.200.300-40', 'certificado sim', 'data science', 'biologia', '', '0');
	INSERT INTO revisor(revisor, certificacao, area1, area2, area3, n_revisoes)
		VALUES('220.200.300-40', 'certificado sim', 'data science', '', 'biologia', '0');

--EDITOR
	INSERT INTO editor (editor, certificacao, especialidade_1, especialidade_2, especialidade_3, n_edicoes)
		VALUES ('111.333.111-11', 'editor certificado', 'compiuters', '', '', 0);

		--bioagradáveis
	INSERT INTO editor (editor, certificacao, especialidade_1, especialidade_2, especialidade_3, n_edicoes)
		VALUES ('100.200.300-40', 'editor certificado', 'biologia', '', '', 0);
	INSERT INTO editor (editor, certificacao, especialidade_1, especialidade_2, especialidade_3, n_edicoes)
		VALUES ('110.200.300-40', 'editor certificado', 'data science', 'biologia', '', 0);
	INSERT INTO editor (editor, certificacao, especialidade_1, especialidade_2, especialidade_3, n_edicoes)
		VALUES ('220.200.300-40', 'editor certificado', 'data science', '', 'biologia', 0);


		--seu benedito:
	INSERT INTO editor (editor, certificacao, especialidade_1, especialidade_2, especialidade_3, n_edicoes)
		VALUES ('999.333.111-11', 'editor certificado', 'energia sustentável', '', '', 0);

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
	INSERT INTO revista (dominio, nome, n_inscritos, n_volumes)
		VALUES('euamobd.com', 'eu <3 bd', 0, 0);

--EDICAO

	INSERT INTO edicao (editor, revista)
		VALUES ('100.200.300-40', 'revistashow.com');
	INSERT INTO edicao (editor, revista)
		VALUES ('220.200.300-40', 'cienciaehjoia.com');


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

		--neusa assina:
	INSERT INTO assina(usuario, revista)
		VALUES('700.333.111-11', 'revistadaboa.com');
	INSERT INTO assina(usuario, revista)
		VALUES('700.333.111-11', 'bomdemais.com');
	INSERT INTO assina(usuario, revista)
		VALUES('700.333.111-11', 'opiniaoboa.com');
			
--EDICAO
	INSERT INTO edicao(editor, revista)
		VALUES('111.333.111-11', 'revistadaboa.com');

	-- seu benedito:

	INSERT INTO edicao(editor, revista)
		VALUES('999.333.111-11', 'revistadaboa.com');
	INSERT INTO edicao(editor, revista)
		VALUES('999.333.111-11', 'bomdemais.com');
	INSERT INTO edicao(editor, revista)
		VALUES('999.333.111-11', 'opiniaoboa.com');

--VOLUME
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1248, 'revistadaboa.com', '2020-07-14', 'minhascapas/capashow', 'Será que eu passo em BD? E outras polêmicas', 0);

	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1348, 'cienciaehjoia.com', '2017-12-06', 'minhascapas/capashow', 'Passado 1', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1448, 'revistadaboa.com', '2015-11-08', 'minhascapas/capashow', 'Passado 2', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1002, 'bomdemais.com', '2015-11-09', 'minhascapas/capashow', 'Passado 3', 1);
	
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1500, 'revistadaboa.com', '2017-08-22', 'minhascapas/capashow', 'Passado 1', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1988, 'euamobd.com', '2020-07-24', 'minhascapas/capashow', 'Passado 1', 1);
	INSERT INTO volume (id_volume, revista, data, capa, titulo, n_artigos)
		VALUES (1989, 'euamobd.com', '2020-08-24', 'minhascapas/capashow', 'Passado 2', 1);

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
	INSERT INTO administra (usuario, revista)
		VALUES('554.333.111-11', 'bomdemais.com');
	INSERT INTO administra (usuario, revista)
		VALUES('700.333.111-11', 'cienciaehjoia.com');

	INSERT INTO administra (usuario, revista)
		VALUES('110.200.300-40', 'revistadaboa.com');

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

	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(5000, '321.111.111-11', 'Passado 1', 'seustextos/passadopassado', 'computacao-quantica', '2020-06-23');

	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(4576, '321.111.111-11', 'Passado 1', 'seustextos/passadopassado', 'computacao-quantica', '2020-07-24');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(4577, '321.111.111-11', 'Passado 2', 'seustextos/passadopassado', 'computacao-quantica', '2020-08-24');

		--artigos sobre computacao:
			--programado para agosto desse ano:
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3584, '211.111.111-11', 'artigoComputação Agosto', 'seustextos/compagosto', 'computacao', '2020-08-14');
			
			--publicado no passado:
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3585, '321.111.111-11', 'artigoComputação Passado 1', 'seustextos/passadocomp', 'computacao', '2019-07-14');
			INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3586, '211.111.111-11', 'artigoComputação Passado 2', 'seustextos/passadocomp2', 'computacao', '2019-04-14');
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(3587, '321.111.111-11', 'artigoComputação Passado 3', 'seustextos/passadocomp', 'computacao', '2017-08-14');

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

		--de usuário deletado
	INSERT INTO artigo_prototipo(id_artigo, submissor, titulo, texto, tema, data_submissao)
		VALUES(8888, '777.222.111-11', 'Meu escritor sumiu', 'meustextos/textado', 'historia', '2015-12-16');


--ARTIGO
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3551, '2020-11-05', 1248);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3552, '2020-11-06', 1248);

	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3587, '2017-12-06', 1348);

	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3579, '2015-11-08', 1448);

	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3586, '2015-11-09', 1002);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (4576, '2020-07-24', 1988);
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (4577, '2020-08-24', 1989);
	INSERT INTO artigo (id, data_publicacao, id_volume)
		VALUES (5000, '2020-06-23', 1002);
			


		--de usuário deletado
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (8888, '2017-12-06', 1348);

		--artigos de computação para Q2
			-- programado para agosto que invalida Q2
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3584, '2020-08-22', 1448);
			--publicados anteriormente
	INSERT INTO artigo (id, data_publicacao, id_volume)
			VALUES (3585, '2017-08-22', 1448);


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
		--cita artigo de usuário deletado
	INSERT INTO cita (artigo, artigo_citado)
			VALUES (3584, 8888);

--REVISA
		--aceitos
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3551, true, 'minhasrevisoes/tabembom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3552, true, 'minhasrevisoes/muitobom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3559, true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3579, true, 'minhasrevisoes/tabom.txt');

	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',3753, true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',3583 , true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',9553 , true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',9583 , true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',9593 , true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',3587 , true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',3586 , true, 'minhasrevisoes/tabom.txt');
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11',3584 , true, 'minhasrevisoes/tabom.txt');

		--não aceito
	INSERT INTO revisa (revisor, id_artigo, aprovacao, revisao)
		VALUES('321.111.111-11', 3553, false, 'minhasrevisoes/tabemruim.txt');

--AVALIACAO_ARTIGO
	INSERT INTO avaliacao_artigo (id_artigo, usuario, datahora, nota, comentario)
		VALUES (3551, '111.111.111-11', current_timestamp, 9.5, '/comentarios/parabensmerecido.txt');
	INSERT INTO avaliacao_artigo (id_artigo, usuario, datahora, nota, comentario)
		VALUES (5000, '100-200-300-40', current_timestamp, 9, '/comentarios/parabensmuitoshowcomp.txt');

--ANEXO
	INSERT INTO anexo (id, cabecalho, visibilidade, data, dono)
		VALUES (654, '/cabecalholalala', 0, '2020-07-14', '111.111.111-11');

		-- anexos de usuários deletadoss
	INSERT INTO anexo (id, cabecalho, visibilidade, data, dono)
		VALUES (10, '/cabecalholalala', 0, '2020-07-14', '999.222.111-11');
	INSERT INTO anexo (id, cabecalho, visibilidade, data, dono)
		VALUES (11, '/cabecalholalala', 0, '2020-07-14', '888.222.111-11');


--ARQUIVOS_ANEXO
	INSERT INTO arquivos_anexo (anexo, nome, arquivo)
		VALUES (654, 'arquivo_que_comprova_que_eu_devo_passar_em_bd.jpg', '/fakenews/einsteinbombouBDeagora?');

		-- arquivos de anexos de usuários deletados
	INSERT INTO arquivos_anexo (anexo, nome, arquivo)
		VALUES (10, 'anexo do sumido', '/dados');
	INSERT INTO arquivos_anexo (anexo, nome, arquivo)
		VALUES (11, 'anexo do deletado', '/coisas');

--UTILIZA_ANEXO
	INSERT INTO utiliza_anexo (anexo, artigo)
			VALUES (654, 3551);

		--artigos que usam anexos de usuários deletados
	INSERT INTO utiliza_anexo (anexo, artigo)
			VALUES (10, 3753);
	INSERT INTO utiliza_anexo (anexo, artigo)
			VALUES (11, 3583);


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

--Q2: FUNCIONANDO!

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
	ON (ad.usuario = u.cpf)

--Q3:

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
	ON c.artigo = p_cita.id_artigo


--Q5

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
)

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
	  	 WHERE u.cpf = ass.usuario))
--Q8 

-- Sugere revistas que um usuário ainda não conhece com base em suas avaliações de artigos.
-- Identifique revistas que um usuário não assinou, administrou ou editou com volume lançado no mês atual, revista que não possui artigos que
-- o usuario revisou ou submeteu (em suma, o usuráio no cãonhece a revista),
-- e que tenham pelo menos um artigo com o mesmo tema de um artigo que
-- este usuário avaliou com nota pelo menos 8. Mostre cpf, nome e email do usuário, nome da revista e tema do artigo.

--considerando um usuario com o cpf 100.200.300-40:

SELECT u.cpf, u.nome, u.email, r.dominio, p.tema
FROM usuario u
INNER JOIN revista r
ON u.cpf LIKE '100.200.300-40' AND r.dominio NOT IN
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
	(SELECT p2.tema
	FROM artigo_prototipo p2
	INNER JOIN usuario u3
	ON u3.cpf LIKE '100.200.300-40'
	INNER JOIN avaliacao_artigo av
	ON p2.id_artigo = av.id_artigo AND av.usuario = u3.cpf
 	AND av.nota >= 8)

-- Q10

--
	---------------------
	--1 - SELECIONA TODAS AS REVISTA QUE JÁ PUBLICARAM AO MENOS UMA IMAGEM NO EDITORIAL. Ou seja,
	--pelo menos um dos editoriais deve conter uma imagem não nula ou não vazia. (FEITO)
	--Depois eu tenho que pegar o complementar disso pra conseguir todas as revistas que nunca publicaram nenhuma imagem
	--
	--2 - depois eu ainda tenho que pegar as revistas que não publicaram um editorial com imagem nos últimos 6 meses e dar um
	-- union com o resultado do (1)

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


