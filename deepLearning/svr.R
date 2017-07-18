#Link
#https://www.svm-tutorial.com/2014/10/support-vector-regression-r/

#Limpa workspace
ls()
rm(list=ls())
graphics.off()

#Load Library
library(e1071)
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


#Nova Colecao - Treinamento
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

data <- as.data.frame(data)

# Colecao de Teste
data.test = cbind(test.set[,"mes"], 
             test.set[,"quantidadeProduto"], 
             test.set[,"grupoMilkShake"],
             test.set[,"grupoSanduiche"], 
             test.set[,"grupoBebida"], 
             test.set[,"grupoAcompanhamento"],
             test.set[,"grupoPrato"],
             test.set[,"grupoAdicional"],
             test.set[,"grupoBrinde"],
             test.set[,"venda"])

colnames(data.test) = c('mes', 
                   'quantidadeProduto',
                   'grupoMilkShake', 
                   'grupoSanduiche', 
                   'grupoBebida', 
                   'grupoAcompanhamento', 
                   "grupoPrato",
                   "grupoAdicional",
                   "grupoBrinde",
                   'venda')

data.test <- as.data.frame(data.test)

svm.Model <- svm(venda  ~ 
                      grupoMilkShake + 
                      grupoSanduiche + 
                      grupoBebida + 
                      grupoAcompanhamento + 
                      grupoPrato + 
                      grupoAdicional + 
                      grupoBrinde + 
                      quantidadeProduto   + 
                      mes, data = data)

# perform a grid search
tuneResult <- tune(svm, venda  ~ 
                     grupoMilkShake + 
                     grupoSanduiche + 
                     grupoBebida + 
                     grupoAcompanhamento + 
                     grupoPrato + 
                     grupoAdicional + 
                     grupoBrinde + 
                     quantidadeProduto   + 
                     mes, data = data,
                   ranges = list(epsilon = seq(0,0.02), cost = 2^(2:8))
)
print(tuneResult)
# Draw the tuning graph
plot(tuneResult)

summary(svm.Model)

tunedModel <- tuneResult$best.model

p <- predict(tunedModel, data.test)


testdata = test.set[,c('mes', 
                       'quantidadeProduto',
                       'grupoMilkShake', 
                       'grupoSanduiche', 
                       'grupoBebida', 
                       'grupoAcompanhamento', 
                       "grupoPrato",
                       "grupoAdicional",
                       "grupoBrinde",
                       'venda')]

index <-  1:9
escala <- scale(index)


result = cbind(escala[,1], p, testdata[,"venda"])
colnames(result) = c('Attribute', 'Prediction', 'Actual')
round(result, 4)

# prepare data for plot 
x = result[,"Attribute"]
y_act = result[,"Actual"]
y_pred = result[,"Prediction"]



#Converter Dados em valores originais
vendaOriginal <- test.setOriginal[,"venda"]
s <- p

y.sd = sd(vendaOriginal)
y.mean = mean(vendaOriginal)

y.net = s * y.sd + y.mean
y.net

result = cbind(vendaOriginal, y.net)
colnames(result) = c('Original', 'Previsto')
round(result, 4)

#mean absolute percentage error
mape <- mape(y = result[, 'Original'], yhat = result[, 'Previsto'])
mape*100
