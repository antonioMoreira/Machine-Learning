# Função recebe um conjunto de dados (dataset) e uma pergunta (query) que, este exemplo, são
# dois valores, um para Temperatura outro pra Umidade, e classifica por knn, com k vizinhos
# próximos 

knn <- function(dataset, query, k=1){
	#Temperatura	Umidade		Jogar?
	#	34			78			N
	#	32			65			N
	#	26			89			S
	#	22			56			S

	# é a classe que tem o resultado, i.e., que deseja-se obter como resposta (S ou N, neste caso)
	# este codigo pressupoe sempre que o atributo classificador esta sempre na ultima coluna
	classId = ncol(dataset)

	# - aplica uma função (function) nas linhas (opção = 1, obs: coluna = 2)
	# 	em cima do conjunto de dados (dataset)
	# - a variavel 'row' é pq a fç recebe a linha toda
	E = apply(dataset, 1, function(row){
			# Algelim:
			#	X = [x1, x2, ..., xn]
			#	Y = [y1, y2, ..., yn]
			#	X - Y = [(x1-y1), (x2-y2), ..., (xn-yn)]
			# 
			#	Query e row[1:(classId-1)] têm dimensão igual
			sqrt(sum((query - as.numeric(row[1:(classId-1)]))^2)) #distancia euclidiana
		})

	# ordena de modo crescente, em seguida retorna os k primeiros elementos
	# a função sort.list não retorna os VALORES ordenados, retorna o índice deles ordenados
	# > v = c(4 ,12, 7, 5)
	# > sort.list(v)
	# [1] 1 4 3 2
	ids = sort.list(E, dec=F)[1:k]
	
	#	Vec = [v1, v2, ..., vn] : vetor com n elementos 
	#	Index = [i1, i2, ..., im] : vetor com m elementos (m<n)
	#	Vec[Index] = [V[i1], V[i2], ..., V[im]]
	# recorta as classes de ocorrência
	classes = dataset[ids, classId]

	# só ocorrências unicas
	U = unique(classes)

	# rep : replica elementos de vetores e listas
	#	A = [a1, ..., an]
	#	rep([a1,..,an], x) : replica o vetor A 'x' vezes em um vetor ou lista
	# cria um vetor com 0's do tamanho do vetor U	
	R = rep(0, length(U)) # vetor de respostas (votos)

	for(i in 1:length(U)){
		# conta quantas vezes as classes observadas aparecem
		R[i] = sum(U[i] == classes)
	}
	
	id = which.max(R)

	ret = list()
	ret$U = U
	ret$R = R
	ret$class = as.character(U[id])
	
	return (ret) # é uma lista
}