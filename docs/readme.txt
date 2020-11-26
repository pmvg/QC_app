Quality Control Application version 1.0

This application was been build to mainly present to user one form of interactive and graphic do and view quality control for data raw.
In the next few lines it will be discribe the ways to install and run.


1.  What is needed?

a) It’s needed a program called R, that can be downloaded in

https://www.r-project.org/

b) For those who want a friendly and good interface to create and run R scripts, they can download a free version of Rstudio in

https://rstudio.com/products/rstudio/download/

Note: Rstudio uses the R program that is the first needed to install the QCA application. 


2.  R packages needed to install the QCA application:

shiny
shinydashboard
DT
ggplot2

In case of need to install the packages, use the command

install.packages("[name of package]")

in R or Rstudio console. Rstudio also has a section for packages in the bottom right window of the Rstudio interface.


3.  Procedures to run the QCA

a) Using only R:

If the R or R gui icons have been added to the desktop, then click on the respective version (icon)  to open an R gui window. Another possible way is by  going to the directory containing the R package (with e.g. explorer) and run from there the executable files Rgui.exe or R.exe.

Examples: 
c:\program files\R\R4.0.2\bin\R.exe (for command prompt terminal) or 
c:\program files\R\R4.0.2\bin\x64\Rgui.exe (for R interface).

If at this point, action 2. wasn't yet done, it is time to perform it.

Next it’s needed to load the ”shiny” package using command below

library(shiny)

In the shiny package there is a command that is used to launch applications:

runApp()

If the work directory contains the R script “QualityControlApp.R”, it’s only necessary to run the command below to launch the QCA application:

runApp("QualityControlApp.R")

Otherwise(i.e. if the work directory does not contain the QualityControlApp.R) there are two options:

1) the full path to the file must be given: 

   runApp("[PATH]/QualityControlApp.R")

2) set PATH to the file in question in the R interface:

  getwd(), to see current path
  setwd("[PATH]"), to set new path, exemple: setwd("F:/shiny")
 
  then run the command

  runApp("QualityControlApp.R")


b) Using Rstudio:

After loading the R script, the code lines are shown in top left window of this application . In that window’s top right corner is the option  “Run App” and next to it is the down arrow that allows users to choose where to see the program running: "Run in Window" - inside Rstudio interface; "Run in Viewer Plane" - bottom right window; or "Run External" - in browser (note: choose this option).

After this choice, just click button “Run App”.


4.	Files and directories that should be present when running QCA

a) QualityControlApp.R
b) readme.txt
c) Meta_template.tsv
d) variables.txt
e) apps directory
	e1) check_header.R
	e2) conversions.R
	e3) convertUnits.R
	e4) statistic.R
	e5) sunshine.R
	e6) mean_or_sum.R
	e7) counter.R
	e8) conv_Wind.R
	e9) calc_latitude.R
	e10) calc_longitude.R

f) docs directory
	f1) Intro.txt
	f2) readme.txt
	f3) variables.txt
	f4) WorkingPlace_Data_Variables.txt
	f5) Upload.txt
	f6) Options.txt
	f7) Statistics.txt
	f8) Quality_Control.txt
	f9) Results.txt
	f10) Graphics.txt
	f11) Apps.txt
	f12) GEL_Val_45S_45N.txt
	f13) GEL_Val_down45S_up45N.txt
	f14) TC_Val.txt

QCA version 1.0  
