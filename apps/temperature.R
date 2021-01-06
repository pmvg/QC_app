#' T.check {QC}
#'
#' Temperature check
#'
#' @Description
#'
#' Function that will do four checks to temperature series.
#'  
#' @Usage  
#'  
#' T.check(data1,period="daily")
#'  
#' @Arguments
#' 
#' objdata...   data.frames or matrix with data values
#' 
#' objmeta...   information about variable(s) of objdata(s).
#' 
#' period       time interval between observation. Can be "sub-daily" if observations between hours,
#'              "daily" if observations between days or "monthly" if one per month. Default is "sub-daily".
#'
#' @Details
#'
#' From objdata to objdata3 
#' 
#' @Author: Pedro Gomes
#'

T.check <- function(objdata,objdata1=NA,objdata2=NA,objdata3=NA,
                    objmeta,objmeta1=NA,objmeta2=NA,objmeta3=NA,
                    period="sub-daily"){
  
# writes date of run in log file
cat("T Check run on:", format(Sys.time(), "%a %d %b %Y %H:%M:%S"), '\n', file = "log.txt", sep = " ", append = TRUE)
  
# Checks data presence
  
  return()  
}




































SUBROUTINE T_verif (DIA,COD1,HH,PARAM)
!******************************************************************
!* SUBROTINA: VERIFICACAO DA OSCILACAO DIARIA DA TEMPERATURA      *
!* (ROUTINE: TEMPERATURE DAILY OSCILATION VERIFICATION)           *
!******************************************************************
IMPLICIT NONE
INTEGER II,DIA
INTEGER, PARAMETER :: MAXV=100
INTEGER COD1,HH
REAL PARAM(MAXV,MAXV)
REAL INTD,INTDT,AMP
REAL DIFU,DIFD,DIFUD,DIF2U,DIF2D,DIF2UD
CHARACTER (LEN=1) FLAGpre(MAXV,MAXV)
CHARACTER (LEN=5) CPAR(MAXV,MAXV)

   DIFU=0.
   DIFD=0.
   DIFUD=0.
   DIF2U=0.
   DIF2D=0.
   DIF2UD=0.
   IF (II.GT.1) THEN
    IF (PARAM(II-1,COD1).NE.-99.9) THEN
	 DIFU=PARAM(II,COD1)-PARAM(II-1,COD1)
    END IF
	IF (ABS(DIFU).GT.6.) THEN
	 WRITE (1,'(A18,I2,A20,F4.1,A20,I2)') 'PRE CHECK: ON DAY ',II,' VALUE HIGHER/LOWER ',ABS(DIFU),' POINTS THAT ON DAY ',II-1
	END IF
   END IF
   DIFU=0.
   IF (HH.GE.9.AND.HH.LT.12) THEN
    INTD=0.3                             ! DIFFERENCE BTW 1 DAY OBS
!	INTDT=0.6                            ! DIFFERENCE BTW 2 DAYS OBS
   END IF
   IF (HH.GE.12) THEN
    INTD=0.2
!	INTDT=0.4
   END IF
   INTDT=INTD+0.01
   IF (HH.GE.9) THEN
!****
    IF (II.EQ.1) THEN
	 IF (PARAM(II+1,COD1).NE.-99.9) THEN
      DIFD=PARAM(II,COD1)-PARAM(II+1,COD1)
	 END IF
	 IF (PARAM(II+1,COD1).NE.-99.9.AND.PARAM(II+2,COD1).NE.-99.9) THEN
	  DIFUD=PARAM(II+1,COD1)-PARAM(II+2,COD1)
	  DIF2D=PARAM(II,COD1)-PARAM(II+2,COD1)
	 END IF
     IF (ABS(DIFD).GT.INTDT) THEN
	  IF (ABS(DIF2D).GT.(INTDT*2).AND.ABS(DIFUD).LT.INTDT) THEN
       FLAGpre(II,COD1)='9'
	  ELSE
       FLAGpre(II,COD1)='0'
	  END IF
	 END IF
    END IF
!****
    IF (II.EQ.DIA) THEN
	 IF (PARAM(II-1,COD1).NE.-99.9) THEN
      DIFU=PARAM(II,COD1)-PARAM(II-1,COD1)
	 END IF
!	 IF (PARAM(II-2,COD1).NE.-99.9) THEN
!      DIFD=PARAM(II,COD1)-PARAM(II-2,COD1)
!	 END IF
	 IF (PARAM(II-1,COD1).NE.-99.9.AND.PARAM(II-2,COD1).NE.-99.9) THEN
	  DIFUD=PARAM(II-1,COD1)-PARAM(II-2,COD1)
	 END IF
     IF (FLAGpre(II-1,COD1).EQ.'0'.OR.FLAGpre(II-1,COD1).EQ.'M') THEN
      IF (ABS(DIFU).GT.INTDT.AND.ABS(DIFUD).LT.INTDT) THEN
       FLAGpre(II,COD1)='9'
      ELSE
       FLAGpre(II,COD1)='0'
      END IF
	 END IF
    END IF
!****
    IF (II.GT.1.AND.II.LE.DIA-1) THEN
!**
	 IF (PARAM(II-1,COD1).NE.-99.9.AND.PARAM(II+1,COD1).NE.-99.9) THEN
      DIFUD=PARAM(II-1,COD1)-PARAM(II+1,COD1)
	  DIFU=PARAM(II-1,COD1)-PARAM(II,COD1)
  	  DIFD=PARAM(II,COD1)-PARAM(II+1,COD1)
	 END IF
!**
	 IF (ABS(DIFU).GT.INTDT.AND.ABS(DIFD).GT.INTDT) THEN
!	   WRITE (1,*) 'DAY 1', II
	  IF (ABS(DIFUD).LT.(INTDT*2)) THEN
        FLAGpre(II,COD1)='9'
	  ELSE
	   IF (II.GT.2.AND.II.LT.DIA-1) THEN
	    IF (PARAM(II-2,COD1).NE.-99.9.AND.PARAM(II+2,COD1).NE.-99.9) THEN
	     DIF2U=PARAM(II-2,COD1)-PARAM(II,COD1)
		 DIF2D=PARAM(II,COD1)-PARAM(II+2,COD1)
		 IF (ABS(DIF2U).LT.(INTDT*2).OR.ABS(DIF2D).LT.(INTDT*2)) THEN
          FLAGpre(II,COD1)='M'
         ELSE
          FLAGpre(II,COD1)='9'
		 END IF
	    ELSE
         FLAGpre(II,COD1)='9'
		END IF
	   ELSE
        FLAGpre(II,COD1)='9'
       END IF
	  END IF
     END IF
!****
     IF (ABS(DIFD).LT.INTDT.AND.ABS(DIFU).GT.INTDT) THEN
!	 WRITE (1,*) 'DAY 2',II
      IF (PARAM(II-2,COD1).NE.-99.9.AND.PARAM(II-1,COD1).NE.-99.9.AND.II.GT.2) THEN
       DIF2UD=PARAM(II-2,COD1)-PARAM(II-1,COD1)
	  ELSE
	   DIF2UD=0.7
	  END IF
	  IF (ABS(DIFUD).LT.(INTDT*2).AND.ABS(DIF2UD).LT.INTDT) THEN
!	  	 WRITE (1,*) 'DAY 2.0.1',II
       FLAGpre(II,COD1)='9'
	  ELSE
	   IF (II.GT.2) THEN
!	   WRITE (1,*) 'DAY 2.1 ', II
        IF (PARAM(II-2,COD1).NE.-99.9) THEN
	     DIF2U=PARAM(II-2,COD1)-PARAM(II,COD1)
         IF (ABS(DIF2U).GT.(INTDT*2)) THEN
 	      FLAGpre(II,COD1)='9'
		 ELSE
		  FLAGpre(II,COD1)='0'
		 END IF
		ELSE
         FLAGpre(II,COD1)='M'
		END IF
	   ELSE
!	    WRITE (1,*) 'DAY 2.2 ', II
!	    IF (PARAM(II+2,COD1).NE.-99.9) THEN
!	     DIF2D=PARAM(II,COD1)-PARAM(II+2,COD1)
		 IF (ABS(DIFUD).LT.(INTDT*2)) THEN
          FLAGpre(II,COD1)='9'
         ELSE
          FLAGpre(II,COD1)='M'
		 END IF
!	    ELSE
!         FLAGpre(II,COD1)='M'
!	    END IF
	   END IF
	  END IF
     END IF
!****
	 IF (ABS(DIFD).GT.(INTDT).AND.ABS(DIFU).LT.INTDT) THEN
!	   WRITE (1,*) 'DAY 3', II
      IF (PARAM(II+2,COD1).NE.-99.9.AND.PARAM(II+1,COD1).NE.-99.9.AND.II.LT.DIA-1) THEN
       DIF2UD=PARAM(II+2,COD1)-PARAM(II+1,COD1)
	  ELSE
	   DIF2UD=0.7
	  END IF
	  IF (ABS(DIFUD).LT.(INTDT*2).AND.ABS(DIF2UD).LT.INTDT) THEN
        FLAGpre(II,COD1)='9'
	  ELSE
	   IF (II.LT.DIA-1) THEN
        IF (PARAM(II+2,COD1).NE.-99.9) THEN
	     DIF2D=PARAM(II,COD1)-PARAM(II+2,COD1)
         IF (ABS(DIF2D).GT.(INTDT*2)) THEN
 	      FLAGpre(II,COD1)='9'
		 ELSE
		  FLAGpre(II,COD1)='0'
		 END IF
		ELSE
         FLAGpre(II,COD1)='M'
		END IF
	   ELSE
	    IF (PARAM(II-2,COD1).NE.-99.9) THEN
	     DIF2U=PARAM(II-2,COD1)-PARAM(II,COD1)
		 IF (ABS(DIF2U).GT.(INTDT*2)) THEN
          FLAGpre(II,COD1)='9'
         ELSE
          FLAGpre(II,COD1)='0'
		 END IF
	    ELSE
         FLAGpre(II,COD1)='M'
	    END IF
	   END IF
	  END IF
     END IF
!****
    END IF
   END IF
END