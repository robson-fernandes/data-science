library(forecast)
library(ggplot2)
library(stringi)
library(dplyr)
library(tseries)

#Read File GOOG_NASDAQ.csv
googNasdaq = read.table('GOOG_NASDAQ.csv', header=TRUE, sep=",")

#Conversion Data
googNasdaq$Date<- as.Date(googNasdaq$Date)
googNasdaq$Close<- as.numeric(googNasdaq$Close)

#Filter DataSet
googNasdaq <- googNasdaq %>% 
  select(Date,Close) %>% 
  filter(Date >= as.Date("2005-01-01") & Date <= as.Date("2016-12-31"))

googNasdaq <- arrange(googNasdaq,Date)


#Time Series
timeSeries <- ts(googNasdaq$Close, start=c(2005, 1), end=c(2016, 12), frequency=12)

#Time Series Decomposition
#timeSeriesComponents <- decompose(timeSeries)
#autoplot(timeSeriesComponents)

#Seasonally Adjusting
#timeSeriesSeasonallyAdjusted <- timeSeries - timeSeriesComponents$seasonal
#autoplot(timeSeriesSeasonallyAdjusted)


# Stationary Test
#adf <- adf.test(timeSeries)
#adf

#Centralizar Titulo
theme_update(plot.title = element_text(hjust = 0.5))
ggplot() + ggtitle()

#Auto Plot - Serie Temporal
timeSeriesTitle <- stri_encode("Times Series - Google Nasdaq", "", "UTF-8")
autoplot(timeSeries, main = timeSeriesTitle, xlab="Time", ylab="Close")

#Fit - ARIMA Model
fitArima <- auto.arima(timeSeries)

#Fit - Exponencial Model
fitExponencial <- ets(timeSeries)

#Fit - TBATS Model
fitTBats <- tbats(timeSeries)

#AIC Test
fitExponencial$aic
fitArima$aic
fitTBats$AIC


#AIC Test - Plot
barplot(c(ETS=fitExponencial$aic, ARIMA=fitArima$aic, TBATS=fitTBats$AIC),
        col="light blue",
        ylab="AIC")

# Models Accuracy
accuracy(fitExponencial)
accuracy(fitArima)
accuracy(fitTBats)

# Previsao do 1 Semestre de 2017
forecast <- forecast(fitArima, 6)


#Plot
titleForecast <- stri_encode("Times Series Forecast - Google Nasdaq", "", "UTF-8")
autoplot(forecast, main = titleForecast, xlab="Time", ylab="Close")
