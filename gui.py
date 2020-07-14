import tkinter as tk
import psycopg2


try:
    conn = psycopg2.connect("dbname='projetobd' user='postgres' host='localhost' password=''")
except:
    print "I am unable to connect to the database"


root = tk.Tk()
root.title("Projeto parte 3 : revista antibullying de divulgação científica")

texto1 = tk.Label(root,height=10,text="hmmmm amo sql hmm delicia")
texto1.pack(side = tk.TOP, expand=tk.TRUE)
texto1 = tk.Text(root, height=50,width=160)
texto1.pack()

botao1 = tk.Button(root,height=10,text="quero publicar meu artigo")
botao1.pack(side = tk.LEFT,expand=tk.TRUE)
botao2 = tk.Button(root,height=10,text="sofro bulling estoy deprimido")
botao2.pack(side = tk.LEFT,expand=tk.TRUE)
botao2 = tk.Button(root,height=10,text="quero um ovomaltino hmm delicia")
botao2.pack(side = tk.LEFT,expand=tk.TRUE)

root.mainloop()