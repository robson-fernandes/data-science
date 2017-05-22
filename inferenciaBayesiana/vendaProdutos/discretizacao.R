library(bnlearn) 
library(Rgraphviz)


vendaProdutosDataSet = read.table('vendaProdutos.csv', header=TRUE, sep=";")
attach(vendaProdutosDataSet)

train.vendaProdutosDataSet = vendaProdutosDataSet[1:100, c("quantidade","venda")]

## venda - distribuicao
hist(train.vendaProdutosDataSet$venda)

## standard transformation for flow cytometry data
ntrain.vendaProdutosDataSet <- asinh(train.vendaProdutosDataSet$venda)

## assess distribution of data
hist(ntrain.vendaProdutosDataSet)

ntrain.vendaProdutosDataSet <- as.data.frame(ntrain.vendaProdutosDataSet)
dsachs <- discretize(ntrain.vendaProdutosDataSet, method = "hartemink", breaks = 3,
                     ibreaks = 60, idisc = "quantile")




#def.par <- par(no.readonly = TRUE) # save default
#layout(mat=rbind(1:2,3:4))

### convert continuous variables into categories (there are 3 types of flowers)
### default is equal interval width

#vendaDiscretize <- discretize(x, "cluster", categories=3)
#vendaDiscretize
#table(vendaDiscretize)

