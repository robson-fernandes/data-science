library(forecast)
library(ggplot2)
library(stringi)

#Leitura do Arquivo vendas.txt
vendas = read.table('serieVendas.csv', header=TRUE, sep=";")
vendas$venda<- as.numeric(vendas$venda)

#Serie Temporal
serieTemporal <- ts(vendas$venda, start=c(2010, 1), end=c(2016, 12), frequency=12)

#Centralizar Titulo
theme_update(plot.title = element_text(hjust = 0.5))
ggplot() + ggtitle()

#Auto Plot - Serie Temporal
titleSerieTemporal <- stri_encode("Séries Temporais - Vendas de Produtos", "", "UTF-8")
autoplot(serieTemporal, main = titleSerieTemporal, xlab="Tempo", ylab="Vendas")

# Previsao - Modelo ARIMA
fitArima <- auto.arima(serieTemporal)

# Previsao - Modelo Exponencial
fitExponencial <- ets(serieTemporal)

# Previsao - Modelo TBATS
fitTBats <- tbats(serieTemporal)

fitExponencial$aic
fitArima$aic
fitTBats$AIC

#Teste do Modelo - AIC]
barplot(c(ETS=fitExponencial$aic, ARIMA=fitArima$aic, TBATS=fitTBats$AIC),
        col="light blue",
        ylab="AIC")

# Precisão dos Modelos
accuracy(fitExponencial)
accuracy(fitArima)
accuracy(fitTBats)

# Previsão dos 6 proximos meses
forecast(fitArima, 6)

#Plot
titleForecast <- stri_encode("Previsão de Vendas de Produtos", "", "UTF-8")
autoplot(forecast(fitArima, 6), main = titleForecast, xlab="Tempo", ylab="Vendas")