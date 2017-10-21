
Byte <- read.csv("byte.csv",header = TRUE)
plot(Byte, type="l", col="blue", main="The development of compute memory")

plot(Byte, type="p", main="B-spline examples")
lines(smooth.spline(Byte, spar = 0.1),type = "l", col="red")
lines(smooth.spline(Byte, spar = 0.9),type = "l", col="blue")

