#' utc.calc {QC}
#'
#' Universal Time Coordenated Calculation
#'
#' @Description
#'
#' Calculation of diference to Universal Time Coordenated (UTC).
#'  
#' @Usage  
#'  
#' utc.calc()
#'  
#' @Arguments  
#'  
#' long       numeric value, longitude of place to calculate diference to UTC
#'
#' @Details
#'
#' This function will calculate diference to Universal Time Coordenated from determinate location based in 
#' longitude coordenate. To know what is UTC time is still need to add or subtract values of Hour and Minute 
#' given by this function.
#' 
#' @examples
#'  
#' utc.calc(-8.35)
#'
#' @Author: Pedro Gomes
#'
utc.calc <- function(long) {
#
Hour   <- 0
Minute <- 0
UTC_Time <- c()
if(long < 0) longi <- abs(long) else longi <- long
if(longi >= 0 & longi != 999.9 ) {
  cal_min <- (60*longi)/15 
  while (cal_min > 60.0) {
    cal_min <- cal_min - 60.
    Hour <- Hour + 1
  }
  Minute <- round(cal_min,digits = 0)
  if(Minute == 60.0) {
    Minute <- 0
    Hour   <- Hour + 1
  } 
} else {
  writeLines("Wrong Longitude to calculate UTC...")
  cat("Wrong Longitude to calculate UTC...", file = "log.txt", fill = TRUE, append = TRUE)
  Minute <- 99
  Hour   <- 99  
}
#assign("Hour",Hour,envir = globalenv())
#assign("Minute",Minute,envir = globalenv())
UTC_Time <- c(Hour,Minute)
return(UTC_Time)
}
# End function