# Regression Tree Example
library(rpart)


vendaProdutosDataSet = read.table('vendaProdutos.csv', header=TRUE, sep=";")
attach(vendaProdutosDataSet)

train.vendaProdutosDataSet = vendaProdutosDataSet[1:200000, c("quantidadeIntervalo", "vendaIntervalo", "desDiaSemana", "codProduto", "codGrupoVenda")]


# grow tree 
fit <- rpart(vendaIntervalo ~  quantidadeIntervalo + desDiaSemana , 
             method="class", data=train.vendaProdutosDataSet)

printcp(fit) # display the results 
plotcp(fit) # visualize cross-validation results 
summary(fit) # detailed summary of splits

# create additional plots 
#par(mfrow=c(1,2)) # two plots on one page 
#rsq.rpart(fit) # visualize cross-validation results  	

# plot tree 
plot(fit, uniform=TRUE, 
     main="Regression Tree for Mileage ")
text(fit, use.n=TRUE, all=TRUE, cex=.8)