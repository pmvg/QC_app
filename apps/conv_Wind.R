#SUBROUTINE VENTO (wind_in,wind_out)
#******************************************************************
#* SUBROTINA PARA TRANSFORMACAO DO VENTO (NSWE EM GRAUS)          *
#*  (SUBROUTINE FOR WIND TRANSFORMATION (NSWE IN DEGREES))        *
#******************************************************************
Wind.change <- function(wind_in) {

wind <- C()
if(length(wind_in) == 0) return()         
maxlenwind <- length(wind_in$Value)        
if(maxlenwind == 0) return()
        
for(jl in 1:maxlenwind){
 if(wind_in$Value[jl] == '-' | wind_in$Value[jl] == ' ') wind[jl] <- -99      #-99.9        
 if(wind_in$Value[jl] == 'N' | wind_in$Value[jl] == 'n') wind[jl] <- 360      
 if(wind_in$Value[jl] == 'E' | wind_in$Value[jl] == 'e') wind[jl] <- 90   
 if(wind_in$Value[jl] == 'S' | wind_in$Value[jl] == 's') wind[jl] <- 180  
 if(wind_in$Value[jl] == 'W' | wind_in$Value[jl] == 'w') wind[jl] <- 270 
 if(wind_in$Value[jl] == 'C' | wind_in$Value[jl] == 'V') wind[jl] <- 0
 if(wind_in$Value[jl] == 'NE' | wind_in$Value[jl] == 'ne') wind[jl] <- 45 
 if(wind_in$Value[jl] == 'SE' | wind_in$Value[jl] == 'se') wind[jl] <- 135 
 if(wind_in$Value[jl] == 'SW' | wind_in$Value[jl] == 'sw') wind[jl] <- 225 
 if(wind_in$Value[jl] == 'NW' | wind_in$Value[jl] == 'nw') wind[jl] <- 315 
 if(wind_in$Value[jl] == 'NNE' | wind_in$Value[jl] == 'nne') wind[jl] <- 22   #22.5 
 if(wind_in$Value[jl] == 'ENE' | wind_in$Value[jl] == 'ene') wind[jl] <- 67   #67.5
 if(wind_in$Value[jl] == 'ESE' | wind_in$Value[jl] == 'ese') wind[jl] <- 112  #112.5         
 if(wind_in$Value[jl] == 'SSE' | wind_in$Value[jl] == 'sse') wind[jl] <- 157  #157.5
 if(wind_in$Value[jl] == 'SSW' | wind_in$Value[jl] == 'ssw') wind[jl] <- 202  #202.5
 if(wind_in$Value[jl] == 'WSW' | wind_in$Value[jl] == 'wsw') wind[jl] <- 247  #247.5
 if(wind_in$Value[jl] == 'WNW' | wind_in$Value[jl] == 'wnw') wind[jl] <- 292  #292.5
 if(wind_in$Value[jl] == 'NNW' | wind_in$Value[jl] == 'nnw') wind[jl] <- 337  #337.5
 if(wind_in$Value[jl] == 'c' | wind_in$Value[jl] == 'g' | wind_in$Value[jl] == 'G') wind[jl] <- 0 
 if(wind_in$Value[jl] == 'calma' | wind_in$Value[jl] == 'CALMA' | wind_in$Value[jl] == 'Calma') wind[jl] <- 0 
 if(wind_in$Value[jl] == 'v' | wind_in$Value[jl] == 'var') wind[jl] <- 0 
 if(wind_in$Value[jl] == 'VAR' | wind_in$Value[jl] == 'Var.') wind[jl] <- 0 
 if(wind_in$Value[jl] == 'VAR.' | wind_in$Value[jl] == 'Va.' | wind_in$Value[jl] == 'Va') wind[jl] <- 0 
}
return(wind)
}
