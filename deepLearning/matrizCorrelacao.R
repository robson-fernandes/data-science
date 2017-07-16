library(corrplot)

dados = read.table('dados.csv', header=TRUE, sep=";")
attach(dados)

training.setOriginal <- dados[1:85, ]
training.set <- training.setOriginal
training.set$mes <- as.double(training.set$mes)
training.set <- scale(training.set)


M <- cor(training.set,method = "pearson")
#Matriz de correlacao - Color
corrplot(M, method="color")

#Matriz de correlacao - Numerico
corrplot(M, method="number")

