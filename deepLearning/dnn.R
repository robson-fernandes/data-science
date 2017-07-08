library('neuralnet')
library(forecast)


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



a <- as.formula('venda ~ mes + grupoMilkShake + grupoSanduiche + grupoBebida + grupoAcompanhamento')

fit = neuralnet(a, data=data, 
                hidden=c(3,2), 
                threshold =0.01,
                rep=5)


plot(fit,
     col.entry="green",
     col.hidden="blue",
     col.out="red"
     , rep="best")

testdata = test.set[,c("mes","grupoMilkShake" , "grupoSanduiche", "grupoBebida", "grupoAcompanhamento", "venda")]

#predicao
pred = compute(fit,testdata[,1:5])


index <-  1:5
escala <- scale(index)


result = cbind(escala[,1], pred$net.result, testdata[,"venda"])
colnames(result) = c('Attribute', 'Prediction', 'Actual')
round(result, 4)

# prepare data for plot 
x = result[,"Attribute"]
y_act = result[,"Actual"]
y_pred = result[,"Prediction"]

par(mfrow=c(1,2))



# plot actual data
plot(x, y_act, pch=20, col=2, xlab='Attribute', ylab="Actual")
lines(x, y_act, col=8, lty=3, lwd=2)

# plot predict data
plot(x, y_pred, pch=20, col=1, xlab='Attribute', ylab="Predict")
lines(x, y_pred, col=8, lty=3, lwd=2)


#Converter Dados em valores originais
vendaOriginal <- test.setOriginal[,"venda"]
s <- pred$net.result

y.sd = sd(vendaOriginal)
y.mean = mean(vendaOriginal)

y.net = s * y.sd + y.mean
y.net

result = cbind(vendaOriginal, y.net)
colnames(result) = c('Original', 'Previsto')
round(result, 4)