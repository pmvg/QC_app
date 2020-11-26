convertUnits <- function(valUnits,matrixData){
# R Script to call conversion functions to convert data to SI units.
# functions need should be in the script file "conversions.R".
# Temperatures 
if(valUnits == "C"){
  cat(valUnits, "conversion not needed, already in SI Units.", file = "log.txt", sep = " ", fill = TRUE, append = TRUE) }
if(valUnits == "K"){ matrixData$Value <- kcelsius(matrixData$Value) }
if(valUnits == "F"){ matrixData$Value <- fcelsius(matrixData$Value) }
# pressures & tensions
if(valUnits == "hPa" | valUnits == "mbar"){
  cat(valUnits, "conversion not needed, already in SI Units.", file = "log.txt", sep = " ", fill = TRUE, append = TRUE) }
if(valUnits == "psi"){ matrixData$Value <- hpa_mb(matrixData$Value) }
if(valUnits == "atm"){ matrixData$Value <- mbhpa(matrixData$Value) }
if(valUnits == "mmhg"){ matrixData$Value <- mb_hpa(matrixData$Value) }  
# hours 
if(valUnits == "h"){
  cat(valUnits, "conversion not needed, already in SI Units.", file = "log.txt", sep = " ", fill = TRUE, append = TRUE) }
if(valUnits == "hmin"){ matrixData$Value <- call_hours(matrixData$Value) }
# clouds
if(valUnits == "Okta"){
  cat(valUnits, "conversion not needed, already in SI Units.", file = "log.txt", sep = " ", fill = TRUE, append = TRUE) }
if(valUnits == "tenths"){ matrixData$Value <- cloud_oktas(matrixData$Value) }
return(matrixData)
}