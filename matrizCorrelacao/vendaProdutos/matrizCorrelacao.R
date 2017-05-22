vendaProdutosDataSet = read.table('vendaProdutos.csv', header=TRUE, sep=";")
attach(vendaProdutosDataSet)

mc.vendaProdutosDataSet <- vendaProdutosDataSet[1:1000, c("codProduto", "codGrupoVenda","quantidade", "venda")]


library(corrplot)

M <- cor(mc.vendaProdutosDataSet)
corrplot(M, method="circle")

corrplot(M, method="number")