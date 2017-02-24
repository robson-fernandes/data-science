#Leitura do Arquivo vendas.txt
vendas = read.table('vendas.txt', header=T)
attach(vendas)

#Diagrama de Dispersao
plot(trimestre, venda, col=c('red', 'blue', 'green'))

#Coeficiente de Correlacao
cor(trimestre,venda)

#Teste de Hipoteses para a o Coeficiente de Correlacao
cor.test(trimestre,venda)

#Ajuste do Modelo de Regressao Linear
ajuste.modeloLinear = lm(venda ~ trimestre)
ajuste.modeloLinear

#Teste de Significancia do Modelo
summary(ajuste.modeloLinear)

#Teste de Normalidade
shapiro.test(residuals(ajuste.modeloLinear))

# Previsao de Vendas
predict(ajuste.modeloLinear, newdata=data.frame(trimestre=14))

#Reta ajustada no Diagrama de Dispersao
plot(trimestre, venda, col=c('red', 'blue', 'green'))
abline(ajuste.modeloLinear)

#Coeficiente de Determinacao
summary(ajuste.modeloLinear)$r.squared

