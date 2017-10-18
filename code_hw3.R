
#### JIA ZHU, 27720151153580 ####

### HW 3 ###
## question 1 ##

# install stuff for hash calculation
install.packages("digest")
# call the library doing the hashes
library("digest")
digest("I learn a lot from this class when I am proper listening to the professor")
#"a8d3e4701672195e5dcd16ea9b062279"
digest("I do not learn a lot from this class when I am absent and playing on my phone")
#"059ab10d478614d2eab3d70cfccd3fcc"

digest("I learn a lot from this class when I am proper listening to the professor","sha256")
#"c16700de5a5c1961e279135f2be7dcf9c187cb6b21ac8032308c715e1ce9964c"
digest("I do not learn a lot from this class when I am absent and playing on my phone","sha256")
#"f5e2cba48dac097355d0bb310fdbd5bd38a22a5c8e8215cd1ae67014cfc35b91"


## question 3 ##
install.packages("rjson", repos="http://cran.us.r-project.org")
library("rjson")
json_file = "http://crix.hu-berlin.de/data/crix.json"
json_data = fromJSON(file=json_file)
crix_data_frame = as.data.frame(json_data)

a <- 1:1175
n <- 2*a
m <- n-1

time <- t(crix_data_frame[m])
price <- t(crix_data_frame[n])
mydata <- cbind(time,price)

ts.plot(price)

install.packages("tseries")
library(tseries)
adf.test(price)
#p-value = 0.99, accept H0: price is nonstationary

acf(price)
pacf(price)

install.packages("forecast")
library(forecast)
auto.arima(price)# ARIMA(5,2,0)
