#' day.duration {QC}
#'
#' Sunshine Duration
#'
#' @Description
#'
#' Function that calculates one approximation of daily maximum sunshine. To work properly needs 
#' date (Year, Month and Day) and localization (Latitude, Longitude, Altitude).
#'  
#' @Usage 
#'  
#' day.duration(objData, objLocal,"sub-daily") 
#'  
#' @Arguments  
#'  
#' objData    data frame with Year, Month and Day values.
#' objLocal   data frame with lat, long and alt values.
#' period     time period of observations. Can be monthly, daily or sub-daily. Default is sub-daily.
#'
#' @Details
#'
#' Based in one algorithm this function will calculates approximately max sunshine for a year month and day
#' in determinate location.
#'
#' @Author: Pedro Gomes
#'

day.duration <- function(objData,objLocal) {

# writes date of run in log file
cat("Max Sun light calculation run on:", format(Sys.time(), "%a %d %b %Y %H:%M:%S"), '\n', file = "log.txt", sep = " ", append = TRUE)
  
iyear <- c()
imonth <- c()
iday <- c()
max_solar_day <- c()
Dif <- c()
solar_day <- data.frame()
FlagSun <- c()

if(length(objData) == 0) {
  cat("Data values not found, can't calculate max sunshine", file = "log.txt", fill = TRUE, append = TRUE)
  return()
} else {
  kleng <- length(objData$Year)
  iyear   <- objData$Year
  imonth  <- objData$Month
  iday    <- objData$Day
} 
if(length(objLocal) == 0) {
  cat("Localization values not found, can't calculate max sunshine", file = "log.txt", fill = TRUE, append = TRUE)
  return()
} else {
  lat  <- as.numeric(objLocal$val[objLocal$opts == "Lat"])
  long <- as.numeric(objLocal$val[objLocal$opts == "Lon"])
  alt  <- as.numeric(objLocal$val[objLocal$opts == "Alt"])
}
for(jj in 1:kleng){
# Julian day number (of date user want)
jdn1 <- (1461*(iyear[jj]+4800+(imonth[jj]-14)/12))/4
jdn2 <- (367*(imonth[jj]-2-12*((imonth[jj]-14)/12)))/12
jdn3 <- (3*((iyear[jj]+4900+(imonth[jj]-14)/12)/100))/4
jdn4 <- iday[jj]-32075
jd   <- c(jdn1,jdn2,-jdn3,jdn4)
jdn  <- sum (jd)

# n = number of days since 1/1/2000 12:00
n <- jdn-2451545.0+0.0008   

# mean solar noon
jmean <- n-(long/360.0)

# Solar mean anomaly m
m1 <- 357.5291+(0.98569928*jmean)
m <- m1 %% 360
mrad <- (m*pi)/180.0
mrad1 <- 2*mrad
mrad2 <- 3*mrad
  
# Equation of center
c <- (1.9148 * sin(mrad))+(0.0200 * sin(mrad1))+(0.0003 * sin(mrad2))

# Ecliptic longitude
lambda1 <- m+c+180.0+102.9372
lambda <- lambda1 %% 360
lambdarad <- (lambda*pi)/180.0
  
#Solar transit
#jtransit <- 2451545.0 + jmean + (0.0053*sin(mrad)) - (0.0069*sin(2*lambdarad))

# declination of the sun
delta1 <- sin(lambdarad) * sin(0.409105)  #23.44 = 0.409105 rad
delta  <- asin(delta1)

# hour angle (w)
if(alt > 200.0) correc <- -0.83 - ((2.076*sqrt(alt))/60) else correc <- -0.83

#print(correc)
correc_rad <- (correc*pi)/180.0
lat_rad <- (lat*pi)/180.0
w1 <- sin(correc_rad) - (sin(lat_rad)*delta1)
w2 <- cos(lat_rad)*cos(delta)
w3 <- w1 / w2
w <- acos(w3)
w <- (w*180.0)/pi

#sunset (in julian)
#sunset <- jtransit + (w/360.0)
  
#sunrise (in julian)
#jsunrise <- jtransit - (w/360.0)
  
max_solar_day[jj] <- as.numeric(format((w/15)*2, digits = 3))
if(max_solar_day[jj] > 24.0) max_solar_day[jj] <- 24.0  
if(max_solar_day[jj] < 0.0) max_solar_day[jj] <- 0.0 

}

# Diference btw max_solar_day and value
if("Value" %in% colnames(objData)) sun_value <- objData$Value
if("sum" %in% colnames(objData)) sun_value <- objData$sum
for(jj in 1:kleng){
if(length(sun_value[jj]) > 0) Dif[jj] <- max_solar_day[jj] - sun_value[jj]
Dif[jj] <- as.numeric(format(Dif[jj], digits = 3))
if(Dif[jj] < 0.0) FlagSun[jj] <- "Fail" else FlagSun[jj] <-"Pass"
}
solar_day <- data.frame(objData["Year"],objData["Month"],objData["Day"],max_solar_day,sun_value,Dif,FlagSun)


#assign("solar_day",solar_day,envir = globalenv())

return(solar_day)

}
# End function day.duration