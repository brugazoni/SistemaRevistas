import psycopg2
import time

for x in range (0,80):  
    b = "Carregando" + "[" + "#" * x + "." * (79-x) + "]" 
    print (b, end="\r")
    time.sleep(0.01)

print("\nOlá, seja bem vindo ao sistema de revistas científicas" + " "*40)



try:
    connection = psycopg2.connect(user = "postgres",
                                  password = "abc123",
                                  host = "127.0.0.1",
                                  port = "5432",
                                  database = "projetobd")

    cursor = connection.cursor()
    # Printa detalhes da conexão

    #print ( connection.get_dsn_parameters(),"\n")

    # Printa a versão do PostgreSQL
    #cursor.execute("SELECT version();")
    #record = cursor.fetchone()
    #print("Você está conectado ao banco de dados!\n", record,"\n")

except (Exception, psycopg2.Error) as error :
    print ("Erro na conexão ao banco de dados! Tente novamente!\nErro:", error)
    exit()

def formataCPF(cpf):
	cpf = cpf.replace('.','')
	cpf = cpf.replace('-','')
	cpf = cpf.replace(' ','')
	cpf = cpf.replace(',','')
	cpf = cpf.replace(';','')
	cpf = cpf.replace('/','')
	cpf = cpf.replace('\\','')
	if(len(cpf)!=11):
		return "erro"
	s = cpf[:3]+'.'+cpf[3:6]+'.'+cpf[6:9]+'-'+cpf[9:11]
	return(s)


def fazer_login():
	while(True):
		print("\nDigite seu CPF em qualquer um dos formatos: 123.456.789-01, 12345678901, 123 456 789 01",end='')
		print(". Pressione apenas ENTER para voltar.")
		inp = input()
		if(inp == ''):
			return "erro","erro"
		cpf = formataCPF(inp)
		if(cpf == 'erro'):
			print("CPF no Formato incorreto")
		else:
			query = "select u.cpf, u.senha, u.nome, u.deletado from usuario u where u.cpf like '"+cpf+"';"
		#print(query)
		#query = "select * from usuario"
		cursor.execute(query)
		record = cursor.fetchall()
		#print(record)
		print()
		if(len(record) == 0):
			print("Login incorreto!")
			continue
		elif(record[0][3] == True):
			print("Sua conta foi deletada.")
			continue
		while(True):
			print("Digite sua senha. Pressione apenas ENTER para voltar.")
			inp = input()
			if(inp == ''):
				return "erro","erro"
			elif(inp == record[0][1]):
				return record[0][0], record[0][2]
			else:
				print("Senha incorreta!")

def fazer_cadastro():
	while(True):
		############ CPF
		print("Digite o seu cpf. Pressione apenas ENTER para sair")
		inp = input()
		if(inp == ''):
			return "erro","erro"
		cpf = formataCPF(inp)
		if(cpf == 'erro'):
			print("CPF no Formato incorreto")
			continue
		print("Seu CPF é", cpf)
		query = "select u.cpf from usuario u where u.cpf like '"+cpf+"';"
		cursor.execute(query)
		record = cursor.fetchall()
		if(len(record)!=0):
			print("CPF já cadastrado!")
			continue
		
		############ SENHA
		print("Digite a sua senha. A senha deve ter um tamanho mínimo de 6 caracteres e máximo de 15.")
		while(True):
			inp = input()
			if(inp == ''):
				return "erro","erro"
			if(len(inp)<6):
				print("Senha muito curta.")
				continue
			if(len(inp)>15):
				print("Senha muito comprida.")
				continue
			else:
				senha = inp
				break
		print("Digite sua senha novamente")	
		while(True):
			inp = input()
			if(senha != inp):
				print("Senha diferente da inserida. Digite novamente.")
				continue
			else:
				print("Senha confirmada. Sua senha é '"+senha+"'.Não esqueça dela!!!!!!")
				break
		############ NOME
		print("Digite seu nome:")
		while(True):
			inp = input()
			if(len(inp)<3):
				print("Seu nome é muito curto. Digite um com mais de 3 caracteres!")
				continue
			if(len(inp)>=150):
				print("Seu nome é muito comprido. Digite um com menos de 150 caracteres!")
				continue
			else:
				nome = inp
				print("Nome cadastrado, seu nome é '"+nome+"'.")
				break
		############ EMAIL
		print("Digite seu email:")
		while(True):
			inp = input()
			if(len(inp)<5):
				print("Seu email é muito curto. Digite um com mais de 5 caracteres.")
				continue
			if('@' not in inp):
				print("Seu email não é valido!")
				continue
			if(len(inp)>=100):
				print("Seu email é muito comprido. Digite um com menos de 100 caracteres!")
				continue
			else:
				email = inp
				print("Email cadastrado, seu email é '"+email+"'.")
				break
		############ DATA NASCIMENTO
		print("Digite sua data de nascimento no formato AAAA-MM-DD. Por exemplo, 3 de abril de 1993 se torna 1993-04-03")
		while(True):
			inp = input()
			if(len(inp)!=10):
				print("Sua data de nascimento não está no formato AAAA-MM-DD!")
				continue
			if(inp[4]!='-' or inp[7]!='-' or inp[:4].isdecimal() == False or inp[5:7].isdecimal() == False 
				or inp[8:10].isdecimal() == False):
				print("Sua data de nascimento não está no formato AAAA-MM-DD!")
				continue
			else:
				datanasc = inp
				print("Data de nascimento cadastrada, sua data de nascimento é '"+datanasc+"'.")
				break
		############ INSTITUIÇÃO
		print("Digite sua instituição:")
		while(True):
			inp = input()
			if(len(inp)>=100):
				print("O nome da sua instituição é muito comprido. Digite um com menos de 100 caracteres!")
				continue
			else:
				instituicao = inp
				print("Instituição cadastrada, sua instituição é '"+instituicao+"'.")
				break

		############ DESCRIÇÃO
		print("Digite uma descrição de no máximo 1000 caracteres sobre você."+
			" Você não precisa escrever agora, e você pode alterá-la quando quiser"+
			" nas opções de conta.")
		inp = input()
		if(len(inp) >= 1000):
			print("Sua descrição está muito comprida, e será considerada nula. Depois mude-a nas opções de conta.")
			inp = ""
		descricao = inp

		query = ("INSERT INTO usuario " + 
		"(cpf, nome, email, data_nasc, senha, instituicao, descricao, n_avaliacoes, deletado, experiencia) "+
			"VALUES('"+cpf+"','"+nome+"','"+email+"','"+datanasc+"','"+senha+"','"+instituicao+"','"+
		descricao + "',0,False,0);")

		print("\n"+query+"\n")

		try:
			cursor.execute(query)
		except Exception as e:
			print(e)
			print("Deu erro!")
			return "erro","erro"
		
		connection.commit()

		return cpf,nome



def ver_revistas(cpf):
	query = "select r.nome, r.dominio, r.n_volumes, r.n_inscritos from revista r"
	cursor.execute(query)
	record = cursor.fetchall()
	if(len(record) == 0):
		print("Não há revistas cadastradas no sistema")
		return
	for i in record:
		for j in i:
			print(j,end=' ')
			a = len(str(j))
			if(a<50):
				print((50-a)*" ")
		print()

	return

def recomendacoes(cpf):
	query = ("SELECT u.cpf, u.nome, u.email, r.dominio, p.tema FROM usuario u "
+"INNER JOIN revista r ON u.cpf LIKE '"+cpf+"' AND r.dominio NOT IN "
+"(SELECT r2.dominio FROM revista r2 INNER JOIN usuario u2 ON u2.cpf LIKE '"+cpf+"'  "
	+"INNER JOIN assina ass ON u2.cpf = ass.usuario "
	+"AND r2.dominio = ass.revista INNER JOIN administra adm ON u2.cpf = "
	+"adm.usuario AND r2.dominio = adm.revista INNER JOIN volume v2 ON (r2.dominio = v2.revista) "
	+"INNER JOIN artigo a2 ON a2.id_volume = v2.id_volume INNER JOIN revisa "
	+"rev ON u2.cpf = rev.revisor AND rev.id_artigo = a2.id INNER JOIN edicao ed ON u2.cpf =" 
	+"ed.editor AND r2.dominio = ed.revista INNER JOIN artigo_prototipo p2 ON a2.id = "
	+"p2.id_artigo AND p2.submissor = u2.cpf ) INNER JOIN volume v ON (r.dominio = v.revista) "
+"AND (EXTRACT(MONTH FROM v.data) = EXTRACT(MONTH FROM current_date)) "
+"INNER JOIN artigo a ON a.id_volume = v.id_volume INNER JOIN "
+"artigo_prototipo p ON p.id_artigo = a.id AND p.tema IN (SELECT p2.tema FROM artigo_prototipo " 
	+"p2 INNER JOIN usuario u3 ON u3.cpf LIKE '"+cpf+"' INNER JOIN avaliacao_artigo "
		+"av ON p2.id_artigo = av.id_artigo AND av.usuario = u3.cpf AND av.nota >= 8);")
	#print(query)
	cursor.execute(query)
	record = cursor.fetchall()
	if(len(record) == 0):
		print("Não há revistas recomendadas a você no sistema")
		return
	for i in record:
		for j in i:
			print(j,end=' ')
			a = len(str(j))
			if(a<50):
				print((50-a)*" ")
		print()

	return



cpf = ""
mainloop = True
while(mainloop):
	login = True
	while(login):
		print("O que deseja fazer?,",
			"\n1 - Fazer Login\n2 - Fazer Cadastro\n3 - Sair\n")
		inp = int(input())

		if(inp == 1):#LOGIN
			cpf,nome = fazer_login()
			if(cpf == 'erro'):
				continue
			else:
				login = False
				break
		elif(inp == 2):#CADASTRO
			cpf,nome = fazer_cadastro()
			if(cpf == 'erro'):
				continue
			else:
				login = False
				break
		elif(inp == 3):
			for x in range (0,100):  
				b = "Saindo" + "[" + "#" * x + "." * (99-x) + "]"
				print (b, end="\r")
				time.sleep(0.01)
			print("\n\n")
			login = False
			mainloop = False
			break
	########################################
	if(mainloop == False):
		break
	print()
	sistema = True
	while(sistema):
		print("Bem vindo ao sistema de revistas, " + nome + ". O que deseja fazer?\n",
			"\n1 - Ver as revistas disponíveis\n2 - Ver recomendacoes de revistas",
			"\n3 - Sair\n")
		
		inp = int(input())
		
		if(inp == 1):#LOGIN
			ver_revistas(cpf)

		if(inp == 2):#LOGIN
			recomendacoes(cpf)

		elif(inp == 3):
			for x in range (0,80):  
				b = "Saindo" + "[" + "#" * x + "." * (79-x) + "]"
				print (b, end="\r")
				time.sleep(0.01)
			print("\n\n")
			login = False
			mainloop = False
			break














