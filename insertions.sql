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
		VALUES (5000, '100.200.300-40', current_timestamp, 9, '/comentarios/parabensmuitoshowcomp.txt');

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