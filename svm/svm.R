movimentacao = read.table('movimentacao.csv', header=TRUE, sep=";")
attach(movimentacao)

#summary(movimentacao)

# Regression model
reg.model <- lm(quantidade~diaSemana,
                data=movimentacao)

summary(reg.model)

# Package for SVM
library(e1071)
svm.model <- svm(quantidade~ .,
                 data=movimentacao,
                 type="nu-regression",
                 kernel="radial"
)

movimentacao$forecast.quantidade.collected.svm <- predict(svm.model,
                                            data=movimentacao)

#Plot
plot(quantidade~diaSemana,
     data=movimentacao,
     pch=16,
     col="blue",
     xlab="Dia da Semana",
     ylab="Quantidade",
     main="SVM Model")

points(movimentacao$diaSemana, 
       movimentacao$forecast.quantidade.collected.svm, 
       col = "green", 
       pch=17)