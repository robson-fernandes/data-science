library(mixtools)

dados = read.table('dados.csv', header=TRUE, sep=";")
attach(dados)

training.setOriginal <- dados[1:85, ]
training.set <- training.setOriginal
training.set$mes <- as.double(training.set$mes)
training.set <- scale(training.set)


venda <- training.set[,"venda"]


mixmdl = normalmixEM(venda)
plot(mixmdl,which=2)
lines(density(wait), lty=2, lwd=2)
