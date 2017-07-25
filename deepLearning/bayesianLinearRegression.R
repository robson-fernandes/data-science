#Limpa workspace
ls()
rm(list=ls())
graphics.off()

library(arm)
library(StatMeasures)

dados.grupos = read.table('dados-grupos.csv', header=TRUE, sep=";")
attach(dados.grupos)

dados.vendas = read.table('dados-vendas.csv', header=TRUE, sep=";")
attach(dados.vendas)


dados <-  cbind(dados.grupos$mes, 
                dados.grupos$quantidadeProduto,
                dados.vendas$venda, 
                dados.grupos$grupoMilkShake, 
                dados.grupos$grupoSanduiche, 
                dados.grupos$grupoBebida,
                dados.grupos$grupoAcompanhamento,
                dados.grupos$grupoPrato,
                dados.grupos$grupoAdicional,
                dados.grupos$grupoBrinde,
                dados.grupos$grupoItensComposicao)

colnames(dados) <- c("mes", 
                     "quantidadeProduto", 
                     "venda",
                     "grupoMilkShake", 
                     "grupoSanduiche",
                     "grupoBebida",
                     "grupoAcompanhamento",
                     "grupoPrato",
                     "grupoAdicional",
                     "grupoBrinde",
                     "grupoItensComposicao"
)

training.setOriginal <- dados[1:85, ]
training.set <- training.setOriginal
training.set[,"mes"] <- as.double(training.set[,"mes"])
training.set <- scale(training.set)
training.set <- as.data.frame(training.set)

#conjunto de teste
test.setOriginal <- dados[85:90, ]
test.set = test.setOriginal
test.set$mes <- as.double(test.set$mes)
test.set <- scale(test.set)
test.set <- as.data.frame(test.set)


fit.bayes <- bayesglm(venda ~ 
                        mes +
                        quantidadeProduto  +
                        grupoMilkShake + 
                        grupoSanduiche + 
                        grupoBebida +
                        grupoAcompanhamento +
                        grupoPrato + 
                        grupoAdicional,
                      
                      family=gaussian(link = "identity"),
                      data=training.set,
                      prior.df= Inf,
                      prior.mean = 0,
                      prior.scale = NULL,
                      maxit = 100)

summary(fit.bayes)
ypred.bayes <- predict.glm(fit.bayes,newdata = test.set,se.fit = T)


#Funcao Escala para Original
scaleToOriginal <- function(value,prediction){
  
  s <- prediction
  
  y.sd = sd(value)
  y.mean = mean(value)
  
  y.net = s * y.sd + y.mean
  
  return(y.net)
}

#Converter Dados em valores originais
vendaOriginal <- test.setOriginal[,"venda"]
pred <- ypred.bayes$fit
y.net = scaleToOriginal(vendaOriginal,pred)

result = cbind(vendaOriginal, y.net, c(1:6))
colnames(result) = c('original', 'previsto','indice')
round(result, 4)

#mean absolute percentage error
mape <- mape(y = result[, 'original'], yhat = result[, 'previsto'])
mape*100


library(plotly)

r.df = as.data.frame(result)

f <- list(
  family = "Verdana",
  size = 14,
  color = "#000000"
)
x <- list(
  title = "Indice",
  titlefont = f
)
y <- list(
  title = "Venda",
  titlefont = f
)

p <- plot_ly(r.df, 
             x = ~indice,
             y = ~original, 
             name = "Original", 
             type = 'scatter',
             mode = 'lines') %>%
            layout(xaxis = x, yaxis = y)  %>%
          add_trace(y = ~previsto , name = "Bayesian Generalized Linear Models", connectgaps = TRUE)
p