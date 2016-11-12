#1
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./C3W3/housing.csv",method = "curl")
housing=read.csv("./C3W3/housing.csv")
agricultureLogical <- housing$ACR ==3 & housing$AGS == 6
which(agricultureLogical)

#2
install.packages("jpeg")
library(jpeg)
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
z <- tempfile()
download.file(fileUrl,z,mode = "wb")
img <- readJPEG(z, native = TRUE)
quantile(img, na.rm = T, probs = c(0.3,0.8))

#3
fileUrl1<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
fileUrl2<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
install.packages("data.table")
library(data.table)
download.file(fileUrl1, destfile = "./C3W3/product.csv",method = "curl")
download.file(fileUrl2, destfile = "./C3W3/educational.csv",method = "curl")
product=read.csv("./C3W3/product.csv", skip = 4, nrows = 190)
gdp <- product[, c(1, 2, 4, 5)]
colnames(gdp) <- c("CountryCode", "Rank", "CountryName", "GDPValue")
edu=fread("./C3W3/educational.csv")

mergedata=merge(gdp,edu,by = "CountryCode")
View(mergedata)
nrow(mergedata)

install.packages("plyr")
library(plyr)
ordered<-arrange(mergedata, desc(Rank))
View(ordered)
ordered[13,3]

#4
OECD<-mergedata[which(mergedata$`Income Group`== "High income: OECD"),]
View(OECD)
mean(OECD[,2])

#5
install.packages("Hmisc")
library(Hmisc)
mergedata$Rank = cut2(mergedata$Rank, g = 5)
table(mergedata$`Income Group`, mergedata$Rank)





