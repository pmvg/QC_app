#' counter.if {QC}
#'
#' Sunshine Duration
#'
#' @Description
#'
#' Function that counts number of elements in vector UP, DOWN or EQUAL to a specify value.
#'  
#' @Usage 
#'  
#' counter.if(objData, value) 
#'  
#' @Arguments  
#'  
#' objData    Vector of values.
#' value      numeric value to be limit to test. Default is 0
#'
#' @Details
#'
#' Function will take each value from vector objData and test if is greater, equal or lower than value given.
#' After that counts the number of cases exists in each.
#'
#' @Author: Pedro Gomes
#' 
counter.if <- function(objData, value = 0) {

# writes date of run in log file
cat("Counter run on:", format(Sys.time(), "%a %d %b %Y %H:%M:%S"), '\n', file = "log.txt", sep = " ", append = TRUE)  

if(length(objData) == 0) return()

maxlenn <- length(objData)
counterup <- 0
counterdown <- 0
countereq <- 0

# counting
for(ji in 1: maxlenn){
  if(objData[ji] > value) counterup <- counterup + 1
  if(objData[ji] < value) counterdown <- counterdown + 1
  if(objData[ji] == value) countereq <- countereq + 1
}
# percentage

percup <- as.numeric(format((counterup / maxlenn) * 100, digits = 4))
percdown <- as.numeric(format((counterdown / maxlenn) * 100, digits = 4))
perceq <- as.numeric(format((countereq / maxlenn) * 100, digits = 4))

val_c <- c(counterup, counterdown, countereq, percup, percdown, perceq)
  
return(val_c)
}