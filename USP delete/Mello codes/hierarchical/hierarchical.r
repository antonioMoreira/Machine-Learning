
hierarchical <- function(similarities, criterion) {
	
	if (nrow(similarities) != ncol(similarities)) 
		return ("Matrix must be squared.")

	dendrogram = list()
	partition = list()
	for (i in 1:nrow(similarities)) partition[[i]] = c(i)

	level = 0
	dendrogram[[paste(level)]] = partition
	while (length(partition) > 1) {
		min = Inf
		A.id = -1
		B.id = -1
		for (i in 1:(length(partition)-1)) {
			A = partition[[i]]
			for (j in (i+1):length(partition)) {
				B = partition[[j]]
				elements = similarities[A, B]
				value = 0
				if (criterion == "single") {
					value = min(elements)
				} else if (criterion == "complete") {
					value = max(elements)
				} else if (criterion == "average") {
					value = mean(elements)
				}
				if (value < min) {
					min = value
					A.id = i
					B.id = j
				}
			}
		}

		new.partition = list()
		j = 1
		for (i in 1:length(partition)) {
			if (i != A.id && i != B.id) {
				new.partition[[j]] = partition[[i]]
				j = j + 1
			} else if (i <= A.id && i <= B.id) {
				new.partition[[j]] = c(partition[[A.id]], 
							partition[[B.id]])
				j = j + 1
			}
		}
		level = min
		dendrogram[[paste(level)]] = new.partition
		partition = new.partition
	}

	return (dendrogram)
}
