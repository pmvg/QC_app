#' hour.compare {QC}
#'
#' Hour values treshold compare
#'
#' @Description
#'
#' Function will compare hour values to a determinate limit value and attribute a "Pass" or "Fail value as flag.
#'  
#' @Usage 
#'  
#' hour.compare(objData,value,oper="all") 
#'  
#' @Arguments  
#'  
#' objData    data frame with values to be tested.
#' val        value limit to test each data value.
#' oper       operator to compare values. Can be "less","greater","equal","all". Default = "all"
#'
#' @Details
#'
#' Function will compare hour values to a determinate limit value and attribute a "Pass" or "Fail value as flag,
#' this way pointing to a possible error in data value.
#'
#' objdata must have in his header one column named Value. This function will identify values under this column name 
#' as object to compare.
#' 
#' For oper = "equal" the attribute value can take character values to compare, others oper values must be numeric based.
#' 
#' oper attribute gives chance to say which type of check is use.
#' 
#' @example 
#' 
#' For example sunshine hours can have hour values and for each hour cant get more than 1 hour of sun.
#' 
#' hour.compare(data,1,"less")
#' 
#' will check each value on data if is less than 1, "PAss" if true otherwise "Fail".
#'
#' @Author: Pedro Gomes
#' 

hour.compare <- function(objdata,val,oper="all"){

# writes date of run in log file
cat("Compare hourly values with a limit run on:", format(Sys.time(), "%a %d %b %Y %H:%M:%S"), '\n', file = "log.txt", sep = " ", append = TRUE)

maxl <- length(objdata$Value)

# Checks data presence
#assign("objdata",objdata, envir = globalenv())
if(maxl == 0) return()  

flagL <- c()
flagG <- c()
flagE <- c()

if("Hour" %in% colnames(objdata)){
  Flag_1h <- data.frame(objdata["Year"],objdata["Month"],objdata["Day"],objdata["Hour"],objdata["Minute"])
} else {
  Flag_1h <- data.frame(objdata["Year"],objdata["Month"],objdata["Day"])
}
if(oper == "less" | oper == "all"){
  for(i in 1:maxl){
    if(objdata$Value[i] <= val) flagL[i] <- "Pass" else flagL[i] <- "Fail"
  }
  Flag_1h <- data.frame(Flag_1h,objdata["Value"],val,flagL)  
}  
if(oper == "greater" | oper == "all"){
  Flag_1h <- data.frame(Flag_1h,objdata["Value"],val,flagG)    
}
if(oper == "equal" | oper == "all"){
  Flag_1h <- data.frame(Flag_1h,objdata["Value"],val,flagE)    
}
#assign("Flag_1h",Flag_1h, envir = globalenv())
return(Flag_1h)  
}
 
