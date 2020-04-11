install.packages("quantmod")
install.packages("PerformanceAnalytics")

library(quantmod)
library(PerformanceAnalytics)

getSymbols.yahoo('AAPL', env = globalenv(), return.class = "xts", from = '2002-01-01', to=Sys.Date(), periodicity = 'daily')
View(AAPL)

chartSeries(AAPL, theme="black",
            TA='addBBands();addBBands(draw="p");addVo();addMACD();addRSI();addSMA()',
            subset = 'last 50 weeks')
