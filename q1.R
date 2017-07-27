q1 <- function() {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    download.file(fileURL, destfile = "./data.csv")
    data <- read.csv("./data.csv")
    over1M <- data$VAL==24
    result <- sum(over1M==TRUE, na.rm=TRUE)
    result
}

q3 <- function() {
    library(xlsx)
    
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
    datafile <- "./data.xlsx"
    download.file(fileURL, destfile = datafile, mode = "wb")
    data <- read.xlsx(datafile, sheetIndex = 1, startRow = 18, endRow = 23)
    dat <- data[,7:15]
    result <- sum(dat$Zip*dat$Ext,na.rm=T)
    result
}

q4 <- function() {
    library(XML)
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
    datafile <- ".data.xml"
    download.file(fileURL, destfile = datafile)
    doc <- xmlTreeParse(datafile, useInternalNodes=TRUE)
    rootNode <- xmlRoot(doc)
    zipcodes <- xpathSApply(rootNode, "//zipcode", xmlValue)
    result <- sum(zipcodes=="21231")
    result
}

q5 <- function() {
    library(data.table)
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    datafile <- "./data2.csv"
    download.file(fileURL, destfile = datafile)
    DT <- fread(datafile)
    
}