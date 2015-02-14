complete <- function(directory, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used
    
    ## Return a data frame of the form:
    ## id nobs
    ## 1  117
    ## 2  1041
    ## ...
    ## where 'id' is the monitor ID number and 'nobs' is the
    ## number of complete cases
    
# note: read.csv() function needs the header parameter.
# note: is.na() function will force data frames into matrices.
# note: complete.cases() does exactly this.
    
    files <- list.files(directory, full.names = TRUE)
    ## Store full path names to a  files (character vector) to read the files directly
    monitor_data <- lapply(files[id], function(x) read.csv(x, header = TRUE))
    ## Store all selected monitors' data to monitor_data (list)
    logical_vector <- lapply(monitor_data, function(x) !is.na(x))
    valid_logical <- lapply(logical_vector, function(x) x[x[,'Date'] == TRUE & x[,'sulfate'] == TRUE
                                                          & x[,'nitrate'] == TRUE & x[,'ID'] == TRUE,])
    nobs <- sapply(valid_logical, nrow)
    ## Count the number of rows which contain all 'TRUE' values.
    data.frame('id' = id, 'nobs' = nobs)
    ## Combine the two vectors into a data frame
    
    
}