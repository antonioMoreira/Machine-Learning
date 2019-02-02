#Computacionalmente mais eficiente
# var(X) = mean(x²) - mean(x)²
# O(n)
varX <- function(X, len){
  meanX = 0
  aux = 0
  
  for(i in 1:len){
    aux = X[i]^2 + aux
    meanX = X[i] + meanX
  }
  
  aux = aux/len
  meanX = (meanX/len)^2
  
  return(aux-meanX)
}

dispersionMeasures <- function(X){
  
  # runif(10,min,max)
  #   Cria um veto com 10 números REAIS entre min e max
  
  # sample(1:10, 20, replace = TRUE)
  #   Cria um vetor com 20 números INTEIROS aleatórios entre 1:10
  
  lenX <- length(X)
  meanX = mean(X)
  
  z = X-meanX
  
  dm = sum(abs(z))/lenX
  #var = sum(z^2)/lenX
  #var = mean(X^2)-mean(X)^2
  var = varX(X, lenX)
  dp = sqrt(var)
  
  retList = list()
  
  retList$'Median Deviation' = dm
  retList$'Variance' = var
  retList$'Standard Deviation' = dp

  return(retList)
}