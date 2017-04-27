library(dplyr) 

vendaProdutosDataSet = read.table('vendaProdutos.csv', header=TRUE, sep=";")
attach(vendaProdutosDataSet)

#Estatistica Descritiva - Grupo de Venda
summary(vendaProdutosDataSet$desGrupoVenda)

#Filtrar Vendas KUAT 500ML
vendasKUAT_500ML <- filter(vendaProdutosDataSet, codProduto == 10106)

#Estatistica Descritiva
summary(vendasKUAT_500ML$venda)
sd(vendasKUAT_500ML$venda)

#histograma
hist(vendasKUAT_500ML$venda,
     xlab="Vendas",
     ylab="Frequencia",
     main="Histograma - Vendas KUAT 500ML",
     col = "blue" )

#Diagrama de Densidade
plot(density(vendasKUAT_500ML$venda), col="blue",
     ylab="Densidade",
     xlab="Vendas",
     main="Diagrama de Densidade - Vendas KUAT 500ML")

