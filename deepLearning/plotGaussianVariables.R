library(mixtools)

dados = read.table('dados.csv', header=TRUE, sep=";")
attach(dados)

training.setOriginal <- dados[1:85, ]
training.set <- training.setOriginal
training.set$mes <- as.double(training.set$mes)
training.set <- scale(training.set)


venda <- training.set[,"grupoAcompanhamento"]


shapiro.test(venda)

