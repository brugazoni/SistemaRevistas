import psycopg2
import time


for x in range (0,80):  
    b = "Carregando" + "[" + "#" * x + "." * (60-x) + "]" 
    print (b, end="\r")
    time.sleep(0.01)

print("Olá, seja bem vindo ao sistema de revistas científicas" + " "*40)



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

def formataCPF():
	return 3

def fazerlogin():
	while(True):
		print("\nDigite seu cpf no formato 123.456.789-0",end='')
		print(". Pressione apenas ENTER para voltar.")
		inp = input()
		if inp == '':
			return "erro","erro"
		else:
			query = "select u.cpf, u.senha, u.nome, u.deletado from usuario u where u.cpf like '"+inp+"';"
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
			elif(int(inp) == record[0][1]):
				return record[0][0], record[0][2]
			else:
				print("Senha incorreta!")







cpf = ''
mainloop = True
while(mainloop):
	login = True
	while(login):
		print("O que deseja fazer?,",
			"\n1 - Fazer Login\n2 - Fazer Cadastro\n3 - Entrar sem login\n4 - Sair\n")
		inp = int(input())

		if(inp == 1):#LOGIN
			cpf,nome = fazerlogin()
			if(cpf == 'erro'):
				continue
			else:
				login = False
				break
		elif(inp == 2):#CADASTRO
			cpf,nome = fazercadastro()
			if(cpf == 'erro'):
				continue
			else:
				login = False
				break
		elif(inp == 3):
			login = False
			break
		elif(inp == 4):
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
			"\n1 - Ver as revistas disponíveis\n2 - Buscar artigos","\n3 - Ver revistas em que trabalho",
			"\n4 - Criar uma revista\n5- Opções de conta\n6 - Sair\n")
		inp = input()



















postgreSQL_select_Query = ("SELECT (u.nome, r.dominio, r.nome, v.titulo, v.data, p.tema, p.titulo) "+
		"FROM usuario u "+
		"INNER JOIN assina a "+
		"ON u.cpf = a.usuario "+
		"INNER JOIN revista r "+
		"ON a.revista = r.dominio "+
		"INNER JOIN volume v "+
		"ON (v.revista = r.dominio) AND (v.data > current_date) "+
		"INNER JOIN artigo ar "+
		"ON (ar.id_volume = v.id_volume) "+
		"INNER JOIN artigo_prototipo p "+
		"ON (ar.id = p.id_artigo) "+
		"ORDER BY u.cpf;")


query = "SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'usuario'"

print(postgreSQL_select_Query)

cursor.execute(query)
query = cursor.fetchall() 



print("Print each row and it's columns values")
for row in query:
	for i in row:
		print("  ", i, end='')
	print('\n')