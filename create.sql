DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;


-- TABLES
	CREATE TABLE usuario(
		cpf varchar(14) PRIMARY KEY
			CONSTRAINT formato_cpf CHECK (cpf LIKE '___.___.___-__'),
		nome varchar(150) NOT NULL, 
		email varchar(100) NOT NULL,
			CONSTRAINT formato_email CHECK (email LIKE '%@%'),
		data_nasc date NOT NULL,
		senha varchar(16) NOT NULL
			CONSTRAINT ndigitos_senha CHECK (length(senha) BETWEEN 6 AND 15),
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
	);


	CREATE TABLE utiliza_anexo (
		anexo integer REFERENCES anexo(id) ON DELETE RESTRICT,
		artigo integer REFERENCES artigo(id) ON DELETE CASCADE,
		PRIMARY KEY (anexo, artigo)
	)
