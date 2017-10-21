

#### JIA ZHU, 27720151153580 ####

### HW 4 ###
## question 1 ##

# figure 3 #
plot(price, type = "l", lwd = 2, col = "blue", xaxt='n',xlab="Time",ylab = "Price", main = " CRIX Trend")
axis(1,c(120,420,720,1020),c("2014","2015","2016","2017"))

# figure 4 #
plot(Return, type = "l", xaxt='n',xlab="Time",ylab = "Price", main = "The log returns of CRIX")
axis(1,c(120,420,720,1020),c("2014","2015","2016","2017"))

# figure 5 #
hist(Return,freq=FALSE,breaks = seq(-0.25,0.2,by=0.025))
#lines(density(Return),col="blue",lwd=2)
qqnorm(Return)
qqline(Return,col="blue",lwd=2)# figure 6 #

# figure 6 #
acf(Return)
pacf(Return)

## question 2 ##
aic = matrix(NA, 6, 6)
for (p in 0:4) {
        for (q in 0:3) {
                a.p.q = arima(Return, order = c(p, 0, q))
                aic.p.q = a.p.q$aic
                aic[p + 1, q + 1] = aic.p.q
        }
}
aic

# bic
bic = matrix(NA, 6, 6)
for (p in 0:4) {
        for (q in 0:3) {
                b.p.q = arima(Return, order = c(p, 0, q))
                bic.p.q = AIC(b.p.q, k = log(length(ret)))
                bic[p + 1, q + 1] = bic.p.q
        }
}
bic

# select p and q order of ARIMA model
fit1 = arima(ret, order = c(3, 0, 3))
plot(fit1$residuals, xaxt='n',ylab="Residuals", main="Residuals of ARMA(3,3)")
axis(1,c(120,420,720,1020),c("2014","2015","2016","2017"))

Box.test(fit1$residuals, lag = 1)

Residuals <- fit1$residuals
acf(Residuals)
