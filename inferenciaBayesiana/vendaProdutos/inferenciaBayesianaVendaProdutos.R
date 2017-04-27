library(bnlearn) 
library(Rgraphviz)

vendaProdutosDataSet = read.table('vendaProdutos.csv', header=TRUE, sep=";")
attach(vendaProdutosDataSet)

#Modelo da Rede Bayesiana
dag <- model2network("[codProduto][codGrupoVenda|codProduto][quantidadeIntervalo|codGrupoVenda][vendaIntervalo|quantidadeIntervalo:codGrupoVenda][desDiaSemana|vendaIntervalo]")
plot(dag)

train.vendaProdutosDataSet = vendaProdutosDataSet[1:200000, c("quantidadeIntervalo", "vendaIntervalo", "desDiaSemana", "codProduto", "codGrupoVenda")]

##Definir todas as variaveis do conjunto como categoricas
train.vendaProdutosDataSet$quantidadeIntervalo = as.factor(train.vendaProdutosDataSet$quantidadeIntervalo)
train.vendaProdutosDataSet$vendaIntervalo = as.factor(train.vendaProdutosDataSet$vendaIntervalo)
train.vendaProdutosDataSet$desDiaSemana = as.factor(train.vendaProdutosDataSet$desDiaSemana)
train.vendaProdutosDataSet$codProduto = as.factor(train.vendaProdutosDataSet$codProduto)
train.vendaProdutosDataSet$codGrupoVenda = as.factor(train.vendaProdutosDataSet$codGrupoVenda)

bn_df <- data.frame(train.vendaProdutosDataSet)

#Criacao da Rede
#
# Algoritmo um hibrido HC (Hill Climbing). 
#
# Esses algoritmo foi utilizado por
# ser representativo em sua categoria
# e apresentarem bom desempenho se comparado a outros algoritmos
res <- hc(bn_df)
g <- graphviz.plot(res)


#Formatacao da Rede Bayesiana
style <- list(node=list(fillcolor="#70B2E1",
                        textCol="white", 
                        color="gray", 
                        fontsize=11,
                        fontcolor="white",
                        height=3,
                        lwd=2
),
edge=list(color="#70B2E1",arrowsize=".3")

)

defAttrs <- getDefaultAttrs()

z <- letters[1:numNodes(g)]
z <- c("quantidade","venda", "dia", "produto", "grupo")
names(z) <- nodes(g)
nAttrs <- list()
nAttrs$label <- z
nAttrs
plot(g, nodeAttrs=nAttrs, attrs=style)


#Treinamento
#O algoritmo EM - usado para encontrar a maxima probabilidade de parametros
# de modelos estatisticos com base em dados nao observados. 

#Expectation-Maximization (EM) Algorithm
fittedbn <- bn.fit(res, data = bn_df, method="mle")


#Inferencia
# Qual a Probabilidade de Venda entre 0-50
# Dado que seja Domingo, 
# Grupo de Vendas = BEBIDAS
# Produto = KUAT 500ML
a <- cpquery(fittedbn, 
             event = (vendaIntervalo == "0-50"),
             evidence = (desDiaSemana =="Domingo"  & codGrupoVenda=="1" & codProduto == "10106") )

percentual = a * 100
percentual