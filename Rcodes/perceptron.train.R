#Implementação do percepetron
# ----------------------------------


# Gera um hiperplano no espaço de dados
# 		↳ um "degrau"
f <- function(net, energy = 0.5){
	print(net)
    
    if(net >= energy)
		return(1)
	else
		return(0)
}

# Ajusta o peso com o gradiente descendente
# em função do parâmetro eta(η) e do vetor de derivadas 
# parciais do erro ao quadrado :
#   wi(t+1) = w(t) - η* ∂E²/∂wi
gradientDescent <- function(weights, eta, dE2){
    return(weights-eta*dE2)
}

#Função retorna a derivada do erro ao quadrado
#	E² = (y-[(∑wixi)+θ])²
#	  ∂E²/∂wi = -2xi(y-[(∑wixi)+θ]) = -2xi*error
#	  ∂E²/∂θ = -2(y-[(∑wixi)+θ])    = -2*error
#   (!) error = (y-ŷ) = y-[(∑wixi)+θ]
derivateError2 <- function(error, x){
  # x = [x1, x2, ..., xn, 1]
	return(-2*x*(error))
}

perceptron.test <- function(x, weights){
  net = c(as.numeric(x),1) %*% weights
  return(f(net))
}


# aprendizado supervisionado (ou semi-supervisionado?)
#   "hello world do ml"
# → Equações de adaptação dos pesos wi e θ
#	    E² = (y-[(∑wixi)+θ])²
# 	    wi(t+1) = w(t) - η* ∂E²/∂wi
#	      ∂E²/∂wi = -2wi(y-[(∑wixi)+θ])
#	      ∂E²/∂θ = -2(y-[(∑wixi)+θ])
perceptron.train <- function(dataset, eta=0.1, threshold = 1e-3){

	# pressupõe que a classe de treinamento está na última coluna
	classId = ncol(dataset)

	# recorta as colunas do dataset para obter	
	# dados de aprendizado (n colunas)
	X = dataset[,1:(classId-1)]
	
	# recorta a última coluna do dataset para obter as
	# classes de aprendizado
	Y = dataset[,classId]
	
	#	weights = [w1 w2 ... wn θ]
	#		↳ |weights| =  n + 1
	#	Gera vetor pesos iniciais aleatórios com base no tamanho do dataset
	weights = runif(n=ncol(X)+1, min = -0.5, max= 0.5)

	sqerror = 2 * threshold
	
	while(sqerror > threshold){
	  sqerror = 0

        for(i in 1:nrow(dataset)){
      		# i-ésima linha do conjunto X de treinamento
      		x = as.numeric(X[i,])
      
      		# i-ésimo valor esperado de Y
      		y = Y[i]
      
      		# aplicando essa linha no percepetron
      		# 	utiliza o operador de multiplicação matricial para obter 'net'
      		#	pesos * (X[i,],1)
      		#	ps: concatena com [1] por causa de theta
      		net = c(x,1) %*% weights
      		
      		# ŷ valor obtido da função de ativação
      		ŷ = f(net)
      		
      		# cálculo do erro = (y-ŷ)
      		# 	portanto, erro² = (y-ŷ)² = E²
      		error = (y-ŷ)
          sqerror = sqerror + error^2
      		
      		# vetor com a derivada da função erro ao quadrado aplicado a cada peso
      		dE2 = derivateError2(c(x,1),error)
      		
      		weights = gradientDescent(weights, eta, dE2)
  	    }
	  
	  # normalizando o erro
	  sqerror = sqerror / nrow(X)
	  #cat("sqerror = ", sqerror, '\n')
	}

  return(weights)
}