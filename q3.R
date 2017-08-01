q1 <- function() {
    
    library(dplyr)
    
    # download American Community Survey data
    # data code book: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    dataFile <- "./data_idahohousing.csv"
    download.file(fileURL, destfile = dataFile)
    data <- read.csv(dataFile)
    
    # Create a logical vector that identifies the households on greater than 10 acres who sold 
    # more than $10,000 worth of agriculture products. Assign that logical vector to the variable 
    # agricultureLogical. Apply the which() function like this to identify the rows of the data 
    # frame where the logical vector is TRUE. 
    # which(agricultureLogical)
    # What are the first 3 values that result?
    
    # Variables
    # ACR: Lot size
    #      3. House on ten or more acres
    # AGS: Sales of Agriculture Products
    #      6. $10000+
    
    agricultureLogical <- data$ACR==3 & data$AGS==6
    result <- which(agricultureLogical)
    result
}