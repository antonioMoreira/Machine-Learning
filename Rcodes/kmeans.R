# Aprendizado não-supervisionado

# → A variável 'clusters' deve ser informada pelo usuário e diz
# 	quantos agrupamentos devem ser feitos em cima do dataset.
# → Threshold diz respeito ao erro aceitável da distância euclidiana dos centrômeros
# 	em relação aos pontos
kmeans <- function(dataset, clusters = 2, threshold = 1e-3){
	dataset = as.matrix(dataset)
	
	# v = [2, 4, 6, 8, 10]
	# size = 3
	# sample(v, size): vetor de tamanho SIZE com elementos aleatórios de v
	# Neste caso "escolhe" aletóriamente (amostra) pontos do dataset para inicializar os clusters,
	# (ids contém o índice dos pontos escolhidos)  
	ids = sample(1:nrow(dataset), size = clusters)

	# Recorta os pontos de acordo com os índices de ids para formar os centrômeros
	centers = dataset[ids,]

	# rep: replicate
	# cria um vetor com nrow(dataset) zeros para armazenar
	# qual centromero está mais próximo de cada ponto
	closest = rep(0, nrow(dataset))

	# inicializa a divergẽncia com duas vezes o threshold
	div = 2 *threshold
	
	while(div > threshold){

		for(i in 1:nrow(dataset)){
			#variável recebe a i-ésima linha do dataset
			row = dataset[i,]

			# reliza a distância euclidiana entre dois vetores
			# row = [r1, r2, ..., rn]
			# cl = [c1, c2, ..., cn]
			# 	euclidean = sqrt(⅀(ri-ci)²)
			# 	euclidean é um vetor que armazena a distância entre
			#	um ponto e todos os centrômeros ∴ têm a mesma dimensão que centers
			euclidean = apply(centers, 1, function(cl){
				sqrt(sum((row-cl)^2))
			})
		
			# pega o id do centrômero mais próximo ao ponto i
			# id ∈ [1:clusters]
			id = sort.list(euclidean, dec=F)[1]
			
			# armazena o id do cluster mais ponto do ponto da linha i
			# no vetor closest
			closest[i] = id
		}

		old = centers
		
		# atualizando os centrômeros
		for(i in 1:clusters){
			# which retorna um vetor com o id de todas as ocorrências do
			# centrômero i no vetor de closest
			# (!) closest armazena ids
			id = which(closest == i)

			# colMens realiza a média entre pontos mais próximos 
			# do centrômero i
			centers[i,] = colMeans(dataset[id,])  
		}	

		# calcula a divergência entre o centrômero antigo e o novo
		# através da norma euclidiana
		div = sqrt(sum((old - centers)^2))
		print(div)
	} 

	return(centers)
}