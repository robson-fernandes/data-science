#Leitura do Arquivo vendas.txt
vendas = read.table('vendas.txt', header=T)
attach(vendas)

#Diagrama de Dispers??o
plot(trimestre, venda, col=c('red', 'blue', 'green'))

#Coeficiente de Correla????o
cor(trimestre,venda)

#Teste de Hip??teses para a o Coeficiente de Correla????o
cor.test(trimestre,venda)

#Ajuste do Modelo de Regress??o Linear
ajuste.modeloLinear = lm(venda ~ trimestre)
ajuste.modeloLinear

#Teste de Normalidade
shapiro.test(residuals(ajuste.modeloLinear))

# Previs??o de Vendas
predict(ajuste.modeloLinear, newdata=data.frame(trimestre=14))

#Reta ajustada no Diagrama de Dispers??o
plot(trimestre, venda, col=c('red', 'blue', 'green'))
abline(ajuste.modeloLinear)

#Coeficiente de Determina????o
summary(ajuste.modeloLinear)$r.squared

