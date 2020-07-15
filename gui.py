from tkinter import *
import psycopg2

try:
    connection = psycopg2.connect(user = "postgres",
                                  password = "abc123",
                                  host = "127.0.0.1",
                                  port = "5432",
                                  database = "projetobd")

    cursor = connection.cursor()
    # Print PostgreSQL Connection properties
    print ( connection.get_dsn_parameters(),"\n")

    # Print PostgreSQL version
    cursor.execute("SELECT version();")
    record = cursor.fetchone()
    print("You are connected to - ", record,"\n")

except (Exception, psycopg2.Error) as error :
    print ("Error while connecting to PostgreSQL", error)
def clickIniciar():
	print(a)



postgreSQL_select_Query = "select * from usuario"

cursor.execute(postgreSQL_select_Query)
print("Selecting rows from mobile table using cursor.fetchall")
query = cursor.fetchall() 

print("Print each row and it's columns values")
for row in query:
	for i in row:
		print("  ", i, end='')
	print('\n')



janela_inicial = Tk()

botao1 = Button(janela_inicial,height=10,text="quero publicar meu artigo")
botao1.pack(side = LEFT,expand=TRUE)


exit()


root.title("Projeto parte 3 : revista antibullying de divulgação científica")

texto1 = Label(root,height=10,text="hmmmm amo sql hmm delicia")



texto1 = Label(root,height=10,text="hmmmm amo sql hmm delicia")
texto1.pack(side = TOP, expand=TRUE)
texto1 = Text(root, height=50,width=160)
texto1.pack()


botao2 = Button(root,height=10,text="sofro bulling estoy deprimido")
botao2.pack(side = LEFT,expand=TRUE)
botao2 = Button(root,height=10,text="quero um ovomaltino hmm delicia")
botao2.pack(side = LEFT,expand=TRUE)

root.mainloop()