library(forecast)
library(ggplot2)
library(stringi)

setwd("~/Documents/projetos/data-science/seriesTemporais")

#Leitura do Arquivo vendas.txt
vendas = read.table('serieVendas.csv', header=TRUE, sep=";")
vendas$venda<- as.numeric(vendas$venda)

#Serie Temporal
serieTemporal <- ts(vendas$venda, start=c(2009, 1), end=c(2012, 12), frequency=12)

#Centralizar Titulo
theme_update(plot.title = element_text(hjust = 0.5))
ggplot() + ggtitle()

#Auto Plot - Serie Temporal
titleSerieTemporal <- stri_encode("S??ries Temporais - Demanda de Produtos", "", "UTF-8")
autoplot(serieTemporal, main = titleSerieTemporal, xlab="Tempo", ylab="Vendas")

# Previs??o Autom??tica - Modelo ARIMA
fitArima <- auto.arima(serieTemporal)

# Previs??o Autom??tica - Modelo Exponencial
fitExponencial <- ets(serieTemporal)

# Previs??o Autom??tica - Modelo TBATS
fitTBats <- tbats(serieTemporal)

#Teste do Modelo, Menor Valor de AIC ?? o melhor]
barplot(c(ETS=fitExponencial$aic, ARIMA=fitArima$aic, TBATS=fitTBats$AIC),
        col="light blue",
        ylab="AIC")

# predictive accuracy
accuracy(fitArima)
 
# Previs??o dos 5 pr??ximos meses
forecast(fitArima, 5)
titleForecast <- stri_encode("Previs??o de Demanda de Produtos", "", "UTF-8")
autoplot(forecast(fitArima, 5), main = titleForecast, xlab="Tempo", ylab="Vendas")