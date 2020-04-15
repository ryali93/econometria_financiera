library(quantmod)
library(PerformanceAnalytics)
library(tseries)
library(urca)

# Ejercicio Nivel 1 - 01
getSymbols.yahoo('MSFT', env = globalenv(), return.class = "xts", from = '2002-01-01', to=Sys.Date(), periodicity = 'daily')
View(MSFT)
chartSeries(MSFT, theme="black")

# Ejercicio Nivel 1 - 02
getSymbols.yahoo('TSLA', env = globalenv(), return.class = "xts", from = '2002-01-01', to=Sys.Date(), periodicity = 'daily')
View(TSLA)
chartSeries(TSLA$TSLA.Close, theme="black")

# Ejercicio Nivel 1 - 03
getSymbols.yahoo('AAPL', env = globalenv(), return.class = "xts", from = '2002-01-01', to=Sys.Date(), periodicity = 'daily')
chartSeries(AAPL, theme="black")

chart.TimeSeries(AAPL$AAPL.Close, main = "APPL")
AAPL_Ret = Return.calculate(AAPL$AAPL.Close, method = "compound")
AAPL_Ret = AAPL_Ret[-1,]

chartSeries(AAPL$AAPL.Close, name = "Cierre de APPLE")
addTA(AAPL_Ret, on=NA, col = "darkgreen", legend="Retorno")


# Ejercicio Nivel 2 - 01
getSymbols.yahoo("KO", env = globalenv(), return.class = "xts", from = '2019-01-01', to=Sys.Date())
getSymbols.yahoo("DAX", env = globalenv(), return.class = "xts", from = '2019-01-01', to=Sys.Date())
getFX("EUR/USD")

KO_Ret = Return.calculate(KO$KO.Close, method = "compound")
DAX_Ret = Return.calculate(DAX$DAX.Close, method = "compound")
EURUSD_Ret = Return.calculate(EURUSD, method = "compound")

chartSeries(KO, theme = "black")
addTA(DAX)
addTA(EURUSD)

chartSeries(KO_Ret, theme = "black")
addTA(DAX_Ret)
addTA(EURUSD_Ret)

# Verificando la presencia de raiz unitaria
adf.test(diff(KO$KO.Close)[-1], alternative = "stationary")$p.value # p-value < 0.05: no tiene RU
adf.test(diff(DAX$DAX.Close)[-1], alternative = "stationary")$p.value # p-value < 0.05: no tiene RU
adf.test(diff(EURUSD)[-1], alternative = "stationary")$p.value # p-value < 0.05: no tiene RU

adf.test(diff(KO_Ret[-1,])[-1,], alternative = "stationary")$p.value # p-value < 0.05: no tiene RU
adf.test(diff(DAX_Ret[-1,])[-1,], alternative = "stationary")$p.value # p-value < 0.05: no tiene RU
adf.test(diff(EURUSD_Ret[-1,])[-1,], alternative = "stationary")$p.value # p-value < 0.05: no tiene RU

# Ejercicio Nivel 3 - 01
USDPEN <- read.csv("E:/2020/econometria/data/Diarias-20200412-124109.csv", sep = ",")
USDPEN$Fecha = as.POSIXct(USDPEN$Fecha, format="%d/%m/%Y")
USDPEN = xts(USDPEN$USDPEN, USDPEN$Fecha)
chartSeries(USDPEN, theme="black")

#_______________________________________________________________________________





library(urca)
ur.df(EURUSD_Ret[-1,], type=c("trend"), selectlags = c("BIC"))
