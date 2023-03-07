#Loading the rvest package
library('rvest')
library('tidyr')
library('skimr')

#Specifying the url for desired website to be scraped
url <- 'https://www.cardekho.com/used-2015-2023-year+cars+0-100000-km+2-lakh-to-3-lakh+3-lakh-to-5-lakh+in+aurangabad'

#Reading the web page
webpage <- read_html(url)

#Creating 3 features for the dataframe
car_name <- html_nodes(webpage,'.listViewCard div div~ div+ div a , #carList-3636593 a')
km_driven <-  html_nodes(webpage,'.dotsDetails')
price <- c(4.25,4.80,3.30,4.90,2.65,2.82,4.30,4.40,3.40,4.51,4.81,4.40,4.20,3.30,3.10,3.90,3.00,3.00,3.15,4.95,4.60,5.00,4.75,3.75,2.40,4.75)

#Assigning it new variable
cars <- html_text(car_name)
kms <- html_text(km_driven)
final_price <-price

#Viewing the top 5 elements of each column
head(cars)
view(cars)
head(kms)
view(kms)
head(final_price)
view(final_price)

#Calculating NA in cars
sum(is.na(cars))
sum(is.na(kms))
sum(is.na(final_price))

summary(final_price)

plot(final_price)
boxplot(final_price, data = final_price, ylab = "Prices in lakh")
ggplot(data = final_price,aes(x=final_price))+geom_bar()
#Combining all into one datafram
scrap_df <- data.frame(car_name = cars,kil = kms,prices = final_price)
str(scrap_df)
##separate(scrap_df,col=kil,into=c('kms','fuel_type','transmission'), sep='•')
View(scrap_df)

#Visualizing the dataframe
library('ggplot2')

ggplot(scrap_df,aes(x=final_price,y=kil))+
  geom_point(aes(size=fuel_type,col=trnsmission))






