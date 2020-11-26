#******************************************************************
#* function for conversion mmhg -> mbar / hPa                     *
#******************************************************************
mb_hpa <- function(mmhg){
 1.333224*mmhg
}
#******************************************************************
#* function for conversion atm -> mbar / hPa                      *
#******************************************************************
mbhpa <- function(atm){
 1013.25*atm 
}
#******************************************************************
#* function for conversion psi -> mbar / hPa                      *
#******************************************************************
hpa_mb <- function(psi){
 68.948*psi 
}
#******************************************************************
#* function for conversion fahrenheit -> celsius                  *
#******************************************************************
fcelsius <- function(fahrenheit){
 (5*(fahrenheit-32))/9 
}
#******************************************************************
#* function for conversion kelvin -> celsius                      *
#******************************************************************
kcelsius <- function(kelvin){
 kelvin-273.15 
}
#******************************************************************
#* function for conversion hour.minutes in hours (Sunshine)       *
#******************************************************************
call_hours <- function(hour_minute){
  dec_val <- (hour_minute-floor(hour_minute))/0.6
  round(floor(hour_minute) + dec_val, digits = 1)
}
# End function call_hours
#******************************************************************
#* function for conversion tenths in oktas (clouds)               *
#******************************************************************
cloud_oktas <- function(cloud_tenths){
  if(cloud_tenths == 10) oktas <- 8
  if(cloud_tenths == 9 ) oktas <- 7
  if(cloud_tenths == 7 | cloud_tenths == 8) oktas <- 6
  if(cloud_tenths == 6) oktas <- 7
  if(cloud_tenths == 5) oktas <- 6
  if(cloud_tenths == 4) oktas <- 5
  if(cloud_tenths == 3) oktas <- 4
  if(cloud_tenths == 2 | cloud_tenths == 3) oktas <- 2
  if(cloud_tenths == 1) oktas <- 1
  if(cloud_tenths == 0) oktas <- 0
  return(oktas)
}

