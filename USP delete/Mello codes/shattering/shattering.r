
estimating <- function(n.start=1, n.end=20, R=2, iter=500) {

	cat("#Sample size\tShattering found.\n")
	results = NULL
	for (n in n.start:n.end) {
		# dataset
		# R=2 n=5
		#
		#     atr1    atr2
		# 1    ?       ?	+
		# 2    ?       ?	+
		# 3    ?       ?	-
		# 4    ...		-
		# 5			+
		sample = NULL
		for (j in 1:R) {
			sample = cbind(sample, rnorm(mean=0, sd=1, n=n))
		}

		# clssificar no maior número de formas distintas
		shatter.ways = list()
		for (j in 1:(n*iter)) {
			w = runif(min=-1, max=1, n=R)
			b = runif(min=-1, max=1, n=1)
			labels = sample %*% w + b # Perceptron
			id = which(labels >= 0)
			nid = which(labels < 0)
			# labels = [0.1, 0.3, -0.2, -0.4, 0.9]
			# labels = [1, 1, -1, -1, 1]	-> hashtable
			labels[id] = 1
			labels[nid] = -1
			# labels = [1, 1, -1, -1, 1]	-> hashtable
			# key = "1#1#-1#-1#1"
			key = paste(labels, sep="#", collapse="")
			shatter.ways[[key]] = 1
		}

		cat(n, "\t", length(shatter.ways), "\n")
		results = rbind(results, c(n, length(shatter.ways)))
	}

	return (results)
}
