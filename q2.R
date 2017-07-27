# Read data from Github using an REST API
q1 <- function () {
    
    library(httr)
    
    # 1. Find OAuth settings for github:
    #    http://developer.github.com/v3/oauth/
    oauth_endpoints("github")
    
    # 2. To make your own application, register at at
    #    https://github.com/settings/applications. Use any URL for the homepage URL
    #    (http://github.com is fine) and  http://localhost:1410 as the callback url
    #
    #    Replace your key and secret below.
    myapp <- oauth_app("github",
                       key = "7ebbd549f0fab048a167",
                       secret = "5c26e3a9e9953173091e4d7952001595891dc014")
    
    # 3. Get OAuth credentials
    github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)
    
    # 4. Use API
    gtoken <- config(token = github_token)
    req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
    stop_for_status(req)
    content(req)
    
    # OR:
    #req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
    #stop_for_status(req)
    #content(req)
    
    # ==========================
    # SOLUTION IS NOT COMPLETE
    # ==========================
    
}

# Read data from an R data frame using SQL statements
q2and3 <- function () {
    # Required packages
    # install.packages("sqldf")
    
    library(sqldf)
    
    # download American Community Survey data into acs object
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
    download.file(fileURL, destfile = "./data.csv")
    acs <- read.csv("./data.csv")
    
    result <- sqldf("select pwgtp1 from acs where AGEP < 50")
    result
    
    result <- sqldf("select distinct AGEP from acs")
    result
}


# Read data from an HTML source
q4 <- function () {
    connection <- url("http://biostat.jhsph.edu/~jleek/contact.html")
    htmlCode <- readLines(connection)
    close(connection)
    
    result <- sapply(htmlCode[c(10, 20, 30, 100)], nchar)
    result
}

# Read data from a .for file
q5 <- function () {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
    dataFile <- "./data.for"
    download.file(fileURL, destfile = dataFile)
    #data <- read.fortran(dataFile, c("1X9", "2X4", "1D4.1", "5X4"))
    
    # read the fixed width data format from file
    data <- read.fwf(dataFile, c(15,4,9,4,9,4,9,4,4), skip = 4)
    
    # sum up the 4th column of data
    result <- sum(data[,4])
    result
}





