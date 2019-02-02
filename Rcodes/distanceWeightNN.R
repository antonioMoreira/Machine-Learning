# função para calculo de peso cuja função de distancia é euclideana
# 		w(xi,xj) = 1/exp(dist(xi,xj)²/2σ²)
weight <- function(xi, xj, sigma){
	euclidean = sqrt(sum((xi-xj)^2))
	return( exp(-(euclidean^2)/(2*(sigma^2))) )
} 


# em dataset a última coluna é a classe
# 		f(xi) = (∑ yj*w(xi,xj))/(∑ w(xi,xj))
dwnn <- function(dataset, query, sigma = 0.5){
	
	if(length(query) != (ncol(dataset)-1))
		return("Length error!")

	#considera que a classe de aprendizado está na última coluna do dataset
	classId = ncol(dataset)

	# function() é aplicada em todas a linhas do dataset
	w = apply(dataset, 1, function(row){
			# vetor query tem a mesma dimensão que row[1:(classId-1)]
			#	query 				= [q1, q2, ..., qn]
			#	row[1:(classId-1)]	= [r1, r2, ..., rn]
			# 	aplica a função de peso no ponto i e na query em relação ao sigma
			rowAux = as.double(row)[1:(classId-1)]
			weight(query, rowAux, sigma)
		})

	Y = dataset[,classId]

	result = sum(w*Y) / sum(w)

	return(result)
}