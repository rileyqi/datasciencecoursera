#1
#The American Community Survey distributes downloadable data about United States communities. 
#Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
#and load the data into R. The code book, describing the variable names is here:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of 
#agriculture products. 
#Assign that logical vector to the variable agricultureLogical. 
#Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
#which(agricultureLogical) What are the first 3 values that result?
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile = "./C3W3/housing.csv",method = "curl")
housing=read.csv("./C3W3/housing.csv")
agricultureLogical <- housing$ACR ==3 & housing$AGS == 6
which(agricultureLogical)

#2
#Using the jpeg package read in the following picture of your instructor into R
#https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg
#Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
install.packages("jpeg")
library(jpeg)
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
z <- tempfile()
download.file(fileUrl,z,mode = "wb")
img <- readJPEG(z, native = TRUE)
quantile(img, na.rm = T, probs = c(0.3,0.8))

#3
#Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
#Load the educational data from this data set:
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
#Match the data based on the country shortcode. How many of the IDs match? 
#Sort the data frame in descending order by GDP rank. What is the 13th country in the resulting data frame?
#Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table 
#http://data.worldbank.org/data-catalog/ed-stats


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
#What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
OECD<-mergedata[which(mergedata$`Income Group`== "High income: OECD"),]
View(OECD)
mean(OECD[,2])

#5
#Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. 
#How many countries are Lower middle income but among the 38 nations with highest GDP?
install.packages("Hmisc")
library(Hmisc)
mergedata$Rank = cut2(mergedata$Rank, g = 5)
table(mergedata$`Income Group`, mergedata$Rank)





