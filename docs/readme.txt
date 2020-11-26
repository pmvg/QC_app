
Quality Control Application version 1.0

This application was been build to mainly present to user one form of interactive and graphic do and view quality control for data raw.
In the next few lines it will be discribe the ways to install and run.



1.  What is need?

a) Is need a program call R, that can be download in

https://www.r-project.org/

b) For those who wants a friendly and good interface to create and run R scripts, can download a free version of Rstudio in

https://rstudio.com/products/rstudio/download/

Note: Rstudio uses R program that is the first needed to install. 



2.  R packages need to install

shiny
shinydashboard
DT
ggplot2

In case of need to install, can be used the command

install.packages("[name of package]")

in R or Rstudio console. Rstudio also have a section for packages in bottom right window of Rstudio interface.



3.  Procedures to run

a) Using only R:

If icons had been add to desktop then click on version of choose to open R gui window. Other ways is by using explorer and run from install directory Rgui.exe or R.exe.

Exemples: 
c:\program files\R\R4.0.2\bin\R.exe (for command prompt terminal) or 
c:\program files\R\R4.0.2\bin\x64\Rgui.exe (for R interface).

In there if point 2. wasn't yet done, is time for it.
Next its need to load shiny package using command below

library(shiny)

In shiny package there is a command that is use to launch the application.

runApp()

If work directory contains R script QualityControlApp.R, only needs to run command below to launch application

runApp("QualityControlApp.R")

Otherwise there is two options:

1) full path to file must be given 

   runApp("[PATH]/QualityControlApp.R")

2) set PATH to file in question in R interface

  getwd(), to see current path
  setwd("[PATH]"), to set new path, exemple: setwd("F:/shiny")
 
  then run the command

  runApp("QualityControlApp.R")


b) Using Rstudio:

After loading R script, the code lines are show in top left window. In that window top right corner is option to Run App and next to it is down arrow that allow to choose where to see run, "Run in Window" inside Rstudio interface, "Run in Viewer Plane" bottom right window or "Run External" in browser (choose this).

After chosing, just click button Run App.


4. Files and directories should be present

a) QualityControlApp.R
b) readme.txt
c) Meta_template.tsv
d) variables.txt
e) apps directory
	e1) Check_header.R
	e2) conversions.R
	e3) ConvertUnits.R
	e4) statistic.R
	e5) sunshine.R

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



QCA version 1.0 