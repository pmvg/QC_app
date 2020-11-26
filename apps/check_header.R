Check_header <- function(headerData, type = "data"){
  
  hcorrect <- "Not tested"
  hwrong <- "Not tested"
  hcheck <- FALSE

  if("Year" %in% headerData){
    hcorrect <- "Year"
  } else {
    hwrong <- "Year"
  }
  if("Month" %in% headerData){
    if(hcorrect == "Not tested"){
      hcorrect <- "Month"      
    } else {
      hcorrect <- paste(hcorrect,"Month",sep = " ")      
    }
  } else {
    if(hwrong == "Not tested"){
      hwrong <- "Month"      
    } else {
      hwrong <- paste(hwrong,"Month",sep = " ")      
    }
  }
  if(type == "data"){
  if("Day" %in% headerData){
    if(hcorrect == "Not tested"){
      hcorrect <- "Day"      
    } else {
      hcorrect <- paste(hcorrect,"Day",sep = " ")      
    }
  } else {
    if(hwrong == "Not tested"){
      hwrong <- "Day"      
    } else {
      hwrong <- paste(hwrong,"Day",sep = " ")      
    }
  }
  }
  if("Hour" %in% headerData){
    if(hcorrect == "Not tested"){
      hcorrect <- "Hour"      
    } else {
      hcorrect <- paste(hcorrect,"Hour",sep = " ")      
    }
  } else {
    if(hwrong == "Not tested"){
      hwrong <- "Hour"      
    } else {
      hwrong <- paste(hwrong,"Hour",sep = " ")      
    }
  }
  if("Minute" %in% headerData){
    if(hcorrect == ""){
      hcorrect <- "Minute"      
    } else {
      hcorrect <- paste(hcorrect,"Minute",sep = " ")      
    }
  } else {
    if(hwrong == "Not tested"){
      hwrong <- "Minute"      
    } else {
      hwrong <- paste(hwrong,"Minute",sep = " ")      
    }
  }
  if("Value" %in% headerData){
    if(hcorrect == "Not tested"){
      hcorrect <- "Value"      
    } else {
      hcorrect <- paste(hcorrect,"Value",sep = " ")      
    }
  } else {
    if(hwrong == "Not tested"){
      hwrong <- "Value"      
    } else {
      hwrong <- paste(hwrong,"Value",sep = " ")      
    }
  }
  if (hwrong != "Not tested"){
    hcheck <- TRUE
  }
  if (hwrong == "Not tested" & hcorrect != "Not tested") {
    hcorrect <- "All correct"
    hwrong <- "None"
  } 
  if (hcorrect == "Not tested" & hwrong != "Not tested") {
    hcorrect <- "None"
    hwrong <- "All wrong"
  }

  hget <- data.frame(hcorrect,hwrong,hcheck)
  

  return(hget)

}