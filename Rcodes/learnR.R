# Print
paste("Hello", "world")

# Criar vetor (RStudio : Global enviroment)
#	foo		int [1:10] 1 2 3 4 ...
foo <- 1:10
foo



# MANIPULAR DATASETS

# A)	Para visualizar datasets, insluso no package 'datasets'
# 		explorar 'Filter'
View(iris)

# B) 	Plots
plot(iris)
hist(iris$Sepal.Lenght)
dygraph(mdeaths) # library(dygraphs)

#para documentação
?dygraph


#Shortcuts
	↑ : last cmd
	ctrl + ↑ : list cmds
	Tab : complemention
	
	ctrl + enter = run select code
	ctrl + shift + s = source
	ctrl + shift + enter = source with echo
	ctrl + 1 : source code
	ctrl + 2 : console
	
	alt + - : <-
	alt + shift + k : Shortcuts references
	ctrl + shift + c : comment

	#Multiple cursors
		ctrl + alt + (↓, ↑, click)


#OBJETOS
	#Lista todos os objetos
	objects()
	ls()
	
	#Remover objetos
	rm(obj1, obj2, obj3, ... , objN)

	str(x) # exibe a estrutura (structure) de um objeto x
	
