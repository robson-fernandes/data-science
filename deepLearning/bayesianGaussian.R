#Limpa workspace
ls()
rm(list=ls())
graphics.off()

library(bnlearn)
library(forecast)
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


#conjunto de teste
test.setOriginal <- dados[85:90, ]
test.set = test.setOriginal
test.set$mes <- as.double(test.set$mes)
test.set <- scale(test.set)

#Nova Colecao
data = cbind(training.set[,"mes"], 
             training.set[,"quantidadeProduto"], 
             training.set[,"grupoMilkShake"],
             training.set[,"grupoSanduiche"], 
             training.set[,"grupoBebida"], 
             training.set[,"grupoAcompanhamento"],
             training.set[,"grupoPrato"],
             training.set[,"grupoAdicional"],
             training.set[,"grupoBrinde"],
             training.set[,"venda"])

colnames(data) = c('mes', 
                   'quantidadeProduto',
                   'grupoMilkShake', 
                   'grupoSanduiche', 
                   'grupoBebida', 
                   'grupoAcompanhamento', 
                   "grupoPrato",
                   "grupoAdicional",
                   "grupoBrinde",
                   'venda')

testdata = test.set[,
                    c('mes', 
                      'quantidadeProduto',
                      'grupoMilkShake', 
                      'grupoSanduiche', 
                      'grupoBebida', 
                      'grupoAcompanhamento', 
                      "grupoPrato",
                      "grupoAdicional",
                      "grupoBrinde",
                      'venda')]
df.testeData = as.data.frame(testdata)


df.data = as.data.frame(data)
fit = mmhc(df.data)

acyclic(fit)
directed(fit)

score(fit, df.data)

#Ajustes no Grafo
fit <- drop.arc(fit, "venda", "mes")
fit <- drop.arc(fit, "grupoBrinde", "venda")

fit <- set.arc(fit, "mes", "quantidadeProduto")

fit <- set.arc(fit, "quantidadeProduto", "venda")

fit <- set.arc(fit, "grupoSanduiche", "venda")
fit <- set.arc(fit, "grupoMilkShake", "venda")
fit <- set.arc(fit, "grupoAcompanhamento", "venda")

#fit <- set.arc(fit, "grupoBrinde", "venda")
fit <- drop.arc(fit, "quantidadeProduto", "grupoAcompanhamento")
fit <- drop.arc(fit, "quantidadeProduto", "grupoMilkShake")
fit <- drop.arc(fit, "quantidadeProduto", "grupoSanduiche")
fit <- drop.arc(fit, "grupoSanduiche", "grupoMilkShake")

plot(fit)


fitted <- bn.fit(fit, data = df.data, method="mle")


pred = predict(fitted, "venda", df.testeData)  # predicts the value of node C given test set
cbind(pred, df.testeData[,"venda"])  

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
y.net = scaleToOriginal(vendaOriginal,pred)

result = cbind(vendaOriginal, y.net)
colnames(result) = c('Original', 'Previsto')
round(result, 4)

#mean absolute percentage error
mape <- mape(y = result[, 'Original'], yhat = result[, 'Previsto'])
mape*100