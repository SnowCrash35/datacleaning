q1 <- function() {
    
    # The American Community Survey distributes downloadable data about United States communities. 
    # Download the 2006 microdata survey about housing for the state of Idaho using download.file()
    # from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
    # and load the data into R. 
    #
    # The code book, describing the variable names is here:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
    
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
    dataFile <- "./data_idahohousing.csv"
    download.file(fileURL, destfile = dataFile)
    data <- read.csv(dataFile)
    
    # Apply strsplit() to split all the names of the data frame on the characters "wgtp".
    # What is the value of the 123 element of the resulting list?
    
    splitnames <- strsplit(names(data), "wgtp")
    
    result <- splitnames[123]
    result
}

q2 <- function() {
    
    library(stringr)
    
    # Load the Gross Domestic Product data for the 190 ranked countries in this data set: 
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
    
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    dataFile <- "./data_gdp.csv"
    download.file(fileURL, destfile = dataFile)
    gdp <- read.csv(dataFile)
    
    # Clean the GDP data
    gdp <- gdp[-c(1:4), c(1,2,4,5)]; # remove empty columns and unwanted top rows
    names(gdp) <- c("CountryCode", "Ranking", "Economy", "MillionsUSD") # rename columns
    gdp <- gdp[c(1:190),] # remove empty trailing rows
    gdp$Ranking <- as.numeric(as.character(gdp$Ranking)) # convert Ranking from factor to numeric
    
    
    # Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? 
    # Original data sources: 
    # http://data.worldbank.org/data-catalog/GDP-ranking-table 
    
    gdp$MillionsUSD <- gsub(",","",gdp$MillionsUSD)
    str_trim(gdp$MillionsUSD)
    gdp$MillionsUSD <- as.in(gdp$MillionsUSD)
    
    result <- mean(gdp$MillionsUSD)
    result
    
    # Question 3
    # In the data set from Question 2 what is a regular expression that would allow you to count the number
    # of countries whose name begins with "United"? Assume that the variable with the country names in it 
    # is named countryNames. How many countries begin with United?
    
    result2 <- grep("^United", gdp$Economy)
    result2
    
}


q4 <- function() {
    
    # Load the Gross Domestic Product data for the 190 ranked countries in this data set:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
    dataFile <- "./data_gdp.csv"
    download.file(fileURL, destfile = dataFile)
    gdp <- read.csv(dataFile, header = TRUE)
    
    # Clean the GDP data
    gdp <- gdp[-c(1:4), c(1,2,4,5)]; # remove empty columns and unwanted top rows
    names(gdp) <- c("CountryCode", "Ranking", "Economy", "MillionsUSD") # rename columns
    gdp <- gdp[c(1:190),] # remove empty trailing rows
    gdp$Ranking <- as.numeric(as.character(gdp$Ranking)) # convert Ranking from factor to numeric
    
    
    # Load the educational data from this data set:
    # https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
    dataFile2 <- "./data_edu.csv"
    download.file(fileURL, destfile = dataFile2)
    edu <- read.csv(dataFile2, header = TRUE)
    
    
    # Match the data based on the country shortcode. Of the countries for which the end of the fiscal year
    # is available, how many end in June?
    # Original data sources: 
    # http://data.worldbank.org/data-catalog/GDP-ranking-table
    # http://data.worldbank.org/data-catalog/ed-stats
    data <- merge(gdp, edu, by.x="CountryCode", by.y="CountryCode", all = FALSE)
    
    # subset rows that have "Fiscal year end" in the Special.Notes column
    junefiscal <- grep("^Fiscal year end: June", data$Special.Notes)
    result <- length(junefiscal)
    result
}

q5 <- function() {
    
    # You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly
    # traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price
    # and get the times the data was sampled.
    library(quantmod)
    amzn = getSymbols("AMZN",auto.assign=FALSE)
    sampleTimes = index(amzn)
    
    # How many values were collected in 2012?
    year2012 <- sampleTimes[grep("^2012", sampleTimes)]
    result <- length(year2012)
    print("Number of sample times in year 2012")
    result
    
    # How many values were collected on Mondays in 2012?
    yearday2012 <- format(year2012, "%A")
    mon2012 <- grep("Monday", yearday2012)
    result <- length(mon2012)
    print("Number of values collected on Mondays in 2012")
    result
}