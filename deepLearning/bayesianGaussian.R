library(bnlearn)
library(forecast)
library(StatMeasures)

dados = read.table('dados.csv', header=TRUE, sep=";")
attach(dados)


training.setOriginal <- dados[1:85, ]
training.set <- training.setOriginal
training.set$mes <- as.double(training.set$mes)
training.set <- scale(training.set)


#conjunto de teste
test.setOriginal <- dados[85:90, ]
test.set = test.setOriginal
test.set$mes <- as.double(test.set$mes)
test.set <- scale(test.set)

#Nova Colecao
data = cbind(training.set[,"mes"], 
             training.set[,"grupoMilkShake"],
             training.set[,"grupoSanduiche"], 
             training.set[,"grupoBebida"], 
             training.set[,"grupoAcompanhamento"],
             training.set[,"venda"])

colnames(data) = c('mes', 
                   'grupoMilkShake', 
                   'grupoSanduiche', 
                   'grupoBebida', 
                   'grupoAcompanhamento', 
                   'venda')

testdata = test.set[,c("mes","grupoMilkShake" , "grupoSanduiche", "grupoBebida", "grupoAcompanhamento", "venda")]
df.testeData = as.data.frame(testdata)


df.data = as.data.frame(data)
fit = rsmax2(df.data)

score(fit, df.data)

#fit <- drop.arc(fit, "venda", "mes")
#fit <- set.arc(fit, "mes", "venda")

#fit <- set.arc(fit, "grupoMilkShake", "venda")
#fit <- set.arc(fit, "grupoAcompanhamento", "venda")

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