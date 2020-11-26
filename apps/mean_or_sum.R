#' mean.check {QC}
#'
#' Mean check
#'
#' @Description
#'
#' Function that checks btw published and calculated means.
#'  
#' @Usage  
#'  
#' mean.check(data1,data2,1,0.05) or mean.check(data1,data2)
#'  
#' @Arguments
#' 
#' pubData    matrix or data frame with published values.
#' 
#' calcData   matrix or data frame with calculated values.        
#' 
#' statUse    stat used for comparations, Mean = 1 or Sum = 2. Default = 1.
#' 
#' statVal    threshold value for diference btw means or sums,
#'            i.e limit of absolute value to consider values suspects. Default = 0.05.
#'
#' 
#' @Author: Pedro Gomes
#'

MS.check <- function(pubData,calcData, statUse = 1, statVal = 0.05){

# writes date of run in log file
cat("MS Check run on:", format(Sys.time(), "%a %d %b %Y %H:%M:%S"), '\n', file = "log.txt", sep = " ", append = TRUE)

if(length(pubData) == 0) return()
if(length(calcData) == 0) return()

sumDif <- c()
meanDif <- c()
FlagMS <- c()
dataTest <- c()
maxP <- length(pubData$Value)
if(statUse == 1) maxC <- length(calcData$Mean) else maxC <- length(calcData$Sum)
if(maxP < maxC) cat("Publish data less than calculated in program", '\n', file = "log.txt", sep = " ", append = TRUE)
if(maxP > maxC) cat("Calculated data less than publish in program", '\n', file = "log.txt", sep = " ", append = TRUE)
if(maxP == maxC) cat("Publish and calculated data have same size", '\n', file = "log.txt", sep = " ", append = TRUE)
if(statUse == 2) statVal <- 1
if("Hour" %in% colnames(calcData)){
  Hc <- TRUE
  MSTest <- data.frame(calcData$Year,calcData$Month,calcData$Hour)
  names(MSTest) <- c("Year","Month","Hour")
} else {
  Hc <- FALSE
  MSTest <- data.frame(calcData$Year,calcData$Month)
  names(MSTest) <- c("Year","Month")}
if("Hour" %in% colnames(pubData)) Hp <- TRUE else Hp <- FALSE

for(rl in 1:maxC){
  if(Hc){ 
    dataTest[rl] <- 10000*calcData$Year[rl] + 100*calcData$Month[rl] + calcData$Hour[rl]
  } else {dataTest[rl] <- 100*calcData$Year[rl] + calcData$Month[rl]}
  for(rm in 1:maxP){
    if(Hp){ 
      dataTest1 <- 10000*pubData$Year[rm] + 100*pubData$Month[rm] + pubData$Hour[rm]
    } else {dataTest1 <- 100*pubData$Year[rm] + pubData$Month[rm]} 
    
    if(dataTest[rl] == dataTest1){
      if(statUse == 1){
        meanDif[rl] <- abs(calcData$Mean[rl] - pubData$Value[rm])
        if(meanDif[rl] > statVal) FlagMS[rl] <- "Fail" else FlagMS[rl] <- "Pass"
      } else {
        sumDif[rl] <- abs(calcData$Sum[rl] - pubData$Value[rm])
        if(sumDif[rl] > statVal) FlagMS[rl] <- "Fail" else FlagMS[rl] <- "Pass"        
      }
      if(FlagMS[rl] == "Fail") cat("Pub ->",pubData$Value[rm],"| Cal ->",calcData$Mean[rl],"| Dif ->",meanDif[rl], '\n',file = "log.txt",sep = " ",append = TRUE)
    }
  }
}
if(statUse == 1) MSTest <- cbind(MSTest,meanDif,FlagMS) else MSTest <- cbind(MSTest,sumDif,FlagMS) 
return(MSTest)  
}
