corr <- function(directory, threshold = 0) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files
    
    ## 'threshold' is a numeric vector of length 1 indicating the
    ## number of completely observed observations (on all
    ## variables) required to compute the correlation between
    ## nitrate and sulfate; the default is 0
    
    ## Return a numeric vector of correlations
    
# note: NULL, NA, NaN are all place holders only and cannot be compared using logical operators.
# note: numeric(0) cannot be compared either, use length(numeric(0)) instead.
# note: when coercing a data frame into matrix, consider it's data class/type.
# note: for lists, pay attention to the difference between '[' &'[[' when subsetting!
# note: to return a certain value, just type the variable name at the end in the function.
    
    files <- list.files(directory, full.names = TRUE)
    data <- lapply(files, function(x) read.csv(x, header = TRUE))
    # Store all the data to the list 'data'
    valid_data <- lapply(data, function(x) x[!is.na(x$Date) & !is.na(x$sulfate) & !is.na(x$nitrate) & !is.na(x$ID),])
    # Store all complete cases in valid_data
    if (is.null(valid_data) == TRUE){
        numeric(0)
    }
    else {
        correlations <- numeric(0)
        # Initialize the data set that pass the threshold requirement
        for (i in seq_along(valid_data)){
            if (nrow(valid_data[[i]]) >= threshold){
                correlations <- c(correlations, cor(valid_data[[i]]$sulfate, valid_data[[i]]$nitrate))
            }
            
        }
        # Select the data frames which pass the threshold requirement
       correlations
    }

}
 