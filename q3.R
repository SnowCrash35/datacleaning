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


q2 <- function() {
    
    library(jpeg)
    
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
    dataFile <- "./pic.jpg"
    # mode = "wb" required for binary file download, otherwise they get corrupted
    download.file(fileURL, destfile = dataFile, mode = "wb")
    data <- readJPEG(dataFile, native = TRUE)
    
    # Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data?
    # (some Linux systems may produce an answer 638 different for the 30th quantile)
    
    result <- quantile(data, c(0.3, 0.8))
    result
}




q3 <- function() {
    
    library(dplyr)
    
    # Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    dataFile <- "./data_gdp.csv"
    download.file(fileURL, destfile = dataFile)
    gdp <- read.csv(dataFile, header = TRUE)
    
    # Clean the GDP data
    gdp <- gdp[-c(1:4), c(1,2,4,5)]; # remove empty columns and unwanted top rows
    names(gdp) <- c("CountryCode", "Ranking", "Economy", "Millions USD") # rename columns
    gdp <- gdp[c(1:190),] # remove empty trailing rows
    gdp$Ranking <- as.numeric(as.character(gdp$Ranking)) # convert Ranking from factor to numeric
    
    
    # Load the educational data from this data set:
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    dataFile2 <- "./data_edu.csv"
    download.file(fileURL, destfile = dataFile2)
    edu <- read.csv(dataFile2, header = TRUE)
    
    # Match the data based on the country shortcode. How many of the IDs match? 
    data <- merge(gdp, edu, by.x="CountryCode", by.y="CountryCode", all = FALSE)
    
    # Original data sources: 
    #  http://data.worldbank.org/data-catalog/GDP-ranking-table
    #  http://data.worldbank.org/data-catalog/ed-stats
    
    # Sort the data frame in descending order by GDP rank (so United States is last).
    # What is the 13th country in the resulting data frame?
    adata <- arrange(data, desc(data$Ranking))
    
    print("Number of matches")
    print(nrow(adata))
    
    print("13th Ranked Country")
    print(adata$Economy[13])
    
    
    # Question 4:
    # What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group? 
    
    hioecd <- subset(adata, Income.Group=="High income: OECD")
    hinoecd <- subset(adata, Income.Group=="High income: nonOECD")
    
    print("Average Ranking of High Income: OECD group")
    mean(hioecd$Ranking)
    
    print("Average Ranking of High Income: nonOECD group")
    mean(hinoecd$Ranking)
    
    # Question 5:
    # Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group.
    # How many countries are Lower middle income but among the 38 nations with highest GDP?
    
    # answer is 5, but did not use quantile to generate tables
    #qdata <- quantile(adata, probs = seq(0, 1, 0.25), na.rm = TRUE)
    
}

q4 <- function() {
    
}




