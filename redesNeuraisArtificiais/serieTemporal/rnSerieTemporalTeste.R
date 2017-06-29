#ver este artigo
#https://www.otexts.org/fpp/9/3


library(forecast)
library(dplyr)
library(ggplot2)

#Leitura do Arquivo vendas.txt
vendasDataSet = read.table('serieVendas.csv', header=TRUE, sep=";")
vendasDataSet$venda<- as.numeric(vendasDataSet$venda)

#Conversion Data
vendasDataSet$data<- as.Date(vendasDataSet$data)
vendasDataSet$venda<- as.numeric(vendasDataSet$venda)

#Filter DataSet
vendasTreinamento <- vendasDataSet %>% 
  select(data,venda) %>% 
  filter(data >= as.Date("2010-01-01") & data <= as.Date("2016-12-01"))


#Serie Temporal
serieTemporal <- ts(vendasTreinamento$venda, start=c(2010, 1), end=c(2016, 12), frequency=12)


#Neural Network Time Series Forecasts
fitNeuralNetwork <- nnetar(serieTemporal, decay=0.5, maxit=150, repeats = 20)
fitArima <- auto.arima(serieTemporal)
fitETS <- ets(serieTemporal)

plot(forecast(fitNeuralNetwork))
lines(serieTemporal)

accuracy(fitNeuralNetwork)

forecast(fitNeuralNetwork, 6)


plot(serieTemporal)
lines(fitted(fitNeuralNetwork), col='red')
lines(fitted(fitArima, h=2), col='green')
lines(fitted(fitETS, h=3), col='blue')
legend("topleft", legend=paste("h =",c("Neural Network", "Arima", "ETS")), col=2:4, lty=1)