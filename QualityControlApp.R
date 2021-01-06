# Quality Control Application version 1.0
#
# This application was been build as one form of interactive and graphic
# do and view quality control for data raw.
#
# Author: Pedro Gomes
#

library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(ggplot2)
library(DT)

# External functions
source("./apps/conversions.R")
source("./apps/convertUnits.R")
source("./apps/counter.R")
source("./apps/statistic.R")  
source("./apps/sunshine.R") 
source("./apps/check_header.R")
source("./apps/mean_or_sum.R")
source("./apps/compare_h.R")

ui <- dashboardPage(
dashboardHeader(title = "Quality Control"),
dashboardSidebar(
 sidebarMenu(
  menuItem("Intodution", tabName = "intro", icon = icon("info")),
  menuItem("Working Place", tabName = "appset", icon = icon("briefcase")),
  menuItem("Upload Data", tabName = "updata", icon = icon("upload")),
  menuItem("Options", tabName = "dataD", icon = icon("cogs")),
  menuItem("Data", tabName = "rawdata", icon = icon("database")),
  menuItem("Variables", tabName = "variableslist", icon = icon("list")),
  menuItem("Metadata", tabName = "metavalues", icon = icon("table")),
  menuItem("Statistic", tabName = "statvalues", icon = icon("table")),
  menuItem("Quality Control", tabName = "qc", icon = icon("laptop-code")),
  menuItem("Results", tabName = "log", icon = icon("cogs")),
  menuItem("Graphics", tabName = "graph", icon = icon("chart-area")),
  menuItem("Help", tabName = "helpSys", icon = icon("question")),
  tags$br(),
  tags$hr(),
  menuItem("Apps", tabName = "aplic", icon = icon("medapps")),
  tags$hr()
)),
dashboardBody(
tabItems(
 tabItem(
  tabName = "intro",
  tags$strong(tags$h1("Introdution")),
  tags$h4("This application was build to create a interative system to run quality control tests over data raw field."),
  tags$h4("Also has the ability to calculate basic statistic and graphic view over data fields."),
  tags$h4("It uses shiny + shinydashboard + shinydashboardPlus to create a html page that can be upload in the
          operating system browser."),
  tags$h4("Also uses R software named DT and ggplot2 to form and presentate tables and graphics respectively."),
  tags$h4("More information will be available on app in help section.")),
#
# Working directory tab
#
 tabItem(
  tabName = "appset",
  fluidRow(
  box(
  title = "Warning",
  solidHeader = TRUE,
  status = "warning",
  width = 5,
  tags$b(tags$h4("Address below is where App is and will used for everything.")),
  tags$b(tags$h4("To choose another place just copy App to desired directory.")))),              
  fluidRow(
  box(
   title = "Work place",
   solidHeader = TRUE,
   status = "primary",
   width = 5,
   textInput("setwork","(App Working place location)", value = getwd())))),
#
# Upload files tab
#
 tabItem(
  tabName = "updata",
  tabsetPanel(
  tabPanel(
  title = "Data Set",
  tags$br(),
  sidebarLayout(
  sidebarPanel(
  width = 2,
  radioButtons("filesnumb","Number of data files",c("Data" = 1,"Data + 1" = 2,"Data + 2" = 3,"Data + 3" = 4)),
  tags$hr(),
  tags$h4("SEF file?"),
  tags$h5("(Station Exchange Format)"),
  checkboxInput("sef","Data", value = TRUE),
  conditionalPanel(
   condition = "input.filesnumb > 1",
   checkboxInput("sef1","Data 1", value = TRUE)),
  conditionalPanel(
   condition = "input.filesnumb > 2",
   checkboxInput("sef2","Data 2", value = TRUE)),
  conditionalPanel(
   condition = "input.filesnumb > 3",
   checkboxInput("sef3","Data 3", value = TRUE))),
  mainPanel(
  width = 10,
  box(
   title = "Data",
   status = "primary",
   solidHeader = TRUE,
   width = 3,
   fileInput("fileIn","File to upload..."),
   radioButtons("sep","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"),
   tags$hr(),
   radioButtons("decsep","Decimal Separator",choices = c(Point = ".", Comma = ",")),                
   tags$hr(),
   checkboxInput("head","Header?", value = TRUE)),
   conditionalPanel(
    condition = "input.filesnumb > 1",
    box(
     title = "Data 1",
     status = "primary",
     solidHeader = TRUE,
     width = 3,
     fileInput("fileIn1","File to upload..."),
     radioButtons("sep1","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"),
     tags$hr(),
     radioButtons("decsep1","Decimal Separator",choices = c(Point = ".", Comma = ",")),                
     tags$hr(),
     checkboxInput("head1","Header?", value = TRUE))), 
   conditionalPanel(
    condition = "input.filesnumb > 2",
    box(
     title = "Data 2",
     status = "primary",
     solidHeader = TRUE,
     width = 3,
     fileInput("fileIn2","File to upload..."),
     radioButtons("sep2","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"),
     tags$hr(),
     radioButtons("decsep2","Decimal Separator",choices = c(Point = ".", Comma = ",")),                
     tags$hr(),
     checkboxInput("head2","Header?", value = TRUE))),
   conditionalPanel(
    condition = "input.filesnumb > 3",
    box(
    title = "Data 3",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("fileIn3","File to upload..."),
    radioButtons("sep3","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"),
    tags$hr(),
    radioButtons("decsep3","Decimal Separator",choices = c(Point = ".", Comma = ",")),                
    tags$hr(),
    checkboxInput("head3","Header?", value = TRUE)))))),
## Stats
  tabPanel(
   title = "Statistic",
   tags$br(),
   fluidRow(
   box(
    title = "Upload file...",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("DataStat","File to upload..."),
    radioButtons("sepstat","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"),
    tags$hr(),
    radioButtons("decsepstat","Decimal Separator",choices = c(Point = ".", Comma = ",")),                
    tags$hr(),
    checkboxInput("headstat","Header?", value = TRUE),
    checkboxInput("seffile","SEF file?")))),
## Varlist
  tabPanel(
   title = "Variables List",
   tags$br(),
   fluidRow(
   box(
    title = "Variables List",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    checkboxInput("defaultvar","Use default file...", value = TRUE))),
   fluidRow(
   box(
    title = "Variables",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("variablelist","File to upload..."),
    radioButtons("sepvar","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/")),
    tags$hr(),
    checkboxInput("headvar","Header?")))),
## Metadata
  tabPanel(
   title = "Metadata",
   tags$br(),
   fluidRow(
   box(
    title = "Warning:",
    status = "warning",
    solidHeader = TRUE,
    width = 3,
    tags$h5("This is dataframe (12,2) with specific format that comes within SEF files (first 12 lines)."),
    tags$h5("See", tags$a(href = "https://datarescue.climate.copernicus.eu/st_formatting-land-stations",target="_BLANC","SEF format")))),
   fluidRow(
   box(
    title = "Loading Metadata...",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("metad","File to upload..."),
    radioButtons("metasep","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t")),
   conditionalPanel(condition = "input.filesnumb > 1",
   box(
    title = "Loading Metadata 1...",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("metad1","File to upload..."),
    radioButtons("metasep1","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"))),
   conditionalPanel(condition = "input.filesnumb > 2",
   box(
    title = "Loading Metadata 2...",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("metad2","File to upload..."),
    radioButtons("metasep2","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"))),
   conditionalPanel(condition = "input.filesnumb > 3",
   box(
    title = "Loading Metadata 3...",
    status = "primary",
    solidHeader = TRUE,
    width = 3,
    fileInput("metad3","File to upload..."),
    radioButtons("metasep3","Separator",choices = c(Comma = ",", Space = " ", Tab ="\t", Semicolon = ";", Slash = "/"), selected = "\t"))))))),
#
# Quality Control tab
#
 tabItem(
  tabName = "qc",
  fluidRow(
  box(
   title = "Tests",
   status = "primary",
   solidHeader = TRUE,
   checkboxInput("check1","Gross Limits Errors check"),
   checkboxInput("check2","Temporal Consistency check"),
   checkboxInput("check3","Internal Consistency check"),
   uiOutput("MS"),
   checkboxInput("check5","Temperatures check"),
   checkboxInput("check6","Sunshine check")),
  box(
   title = "Log",
   status = "primary",
   solidHeader = TRUE,
   verbatimTextOutput("Intextlog")))),
#
# Results tab
#
 tabItem(
  tabName = "log",
  fluidRow(
   tags$br(),
   navlistPanel(
     tabPanel("Warnings",
      fluidRow(
       box(
        title = "Warning",
        solidHeader = TRUE,
        status = "warning",
        width = 5,
        tags$b(tags$h4("Depending on size of dataset, processing information in certain tab panels will take some time.")),
        ))),
     "Tests",
     tabPanel("GEL - Gross Errors Limits"),
     tabPanel("TC - Temporal Consistency"),
     tabPanel("IC - Internal Consistency"),
     tabPanel("MS - Mean or Sum",
              column(width = 7, DT :: dataTableOutput("getMS"))),
     tabPanel("Temperature"),
     tabPanel("Sunshine",
              tabsetPanel(
                tabPanel(title = "Daily",
                         tags$br(),
                         column(width = 7, DT :: dataTableOutput("getSun")),
                         column(width = 5, tags$br(), tags$br(), tags$br(), tags$br(),
                                infoBoxOutput("up", width = 8),
                                infoBoxOutput("equal", width = 8),
                                infoBoxOutput("down", width = 8))),
                tabPanel(title = "Sub-daily",
                         tags$br(),
                         column(width = 7, DT :: dataTableOutput("getSun_sd")))
     )),
     tags$br(),tags$br(),
     tabPanel("Meta",
              column(width = 7,
              DT :: dataTableOutput("Metatab"))),
     widths = c(1,11))
  )),
#
# Statistic tab
#
 tabItem(
  tabName = "statvalues",
  tabsetPanel(
## Publish
  tabPanel(
  title = "Publish",
  tags$br(),
  fluidRow(
    column(width = 2, offset = 1, uiOutput("get_yrs1")),
    column(width = 2, selectInput("months1","Month",choices = c("All","January"=1,"Febuary"=2,"March"=3,"April"=4,"May"=5,"June"=6,
                                                                "July"=7,"August"=8,"September"=9,"October"=10,"November"=11,"December"=12)))),
   fluidRow(
    column(width = 9, offset = 1, DT::dataTableOutput("pubStats")))  
  ),
## Calculated
  tabPanel(
    title = "Calculated",
    tags$br(),
    fluidRow(
      column(width = 2, offset = 1, uiOutput("get_yrs")),
      column(width = 2, selectInput("months","Month",choices = c("All","January"=1,"Febuary"=2,"March"=3,"April"=4,"May"=5,"June"=6,
                                                                 "July"=7,"August"=8,"September"=9,"October"=10,"November"=11,"December"=12))),
      
      column(width = 3, offset = 1, radioButtons("fileTypeTab1", label = NULL, choices = c(CSV = "csv", TSV = "tsv", TXT = "txt"), selected = "png", inline = TRUE),
                                    downloadButton("downloadData","Download File..."))),
    fluidRow(
      column(width = 9, offset = 1, DT::dataTableOutput("calcStats")))   
  ))),
#
# Graphics tab
#
 tabItem(
  tabName = "graph",
  tabsetPanel(
## Histogram
  tabPanel(
   title = "Histogram",
   tags$br(),
   fluidRow(
   column(width = 12, plotOutput("histGraph"))),
   tags$hr(),
   fluidRow(
     column(width = 8, offset = 2, align = "center", uiOutput("forplot"))),
   tags$br(),
   fluidRow(
     column(width = 12, align = "center", radioButtons("filePlotType", label = NULL, choices = c(BMP = "bmp", JPEG = "jpeg", PNG = "png", PDF = "pdf"), selected = "png", inline = TRUE)),
   ),
   fluidRow(
     column(width = 12, align = "center", downloadButton("downloadHist","Download File...")))
   ),
## Time plot
  tabPanel(
    title = "Time plot",
    tags$br(),
    fluidRow(
    column(width = 7,
     fluidRow(
     plotOutput("plotGraph")),
     tags$br(),
     tags$hr(),
     fluidRow(
     column(width = 5, offset = 1,
      uiOutput("graph_get_yrs"),
      selectInput("gmonths","Month",
                  choices = c("All","January"=1,"Febuary"=2,"March"=3,"April"=4,"May"=5,"June"=6,
                              "July"=7,"August"=8,"September"=9,"October"=10,"November"=11,"December"=12)),
      uiOutput("hourRange"),
      dateRangeInput('dateRange',
                     label = 'Time interval (yyyy-mm-dd)',
                     start = Sys.Date(), end = Sys.Date())),
     column(width = 5, offset = 1,
      radioButtons("fileTypeTemp", label = NULL, choices = c(BMP = "bmp", JPEG = "jpeg", PNG = "png", PDF = "pdf"), selected = "png", inline = TRUE),
      downloadButton("downloadTimePlot","Download Plot..."),
      tags$hr(),
      radioButtons("fileTypeTab", label = NULL, choices = c(CSV = "csv", TSV = "tsv", TXT = "txt"), selected = "txt", inline = TRUE),
      downloadButton("downloadTimeTable","Download Table...")
    ))),
    column(width = 5,
           boxPlus(
             title = "Data Table",
             status = "primary",
             solidHeader = TRUE,
             width = 12,
             collapsible = TRUE,
             DT::dataTableOutput("plottabels"))))),
  tabPanel(
   title = "Desviation from mean",
   tags$br(),
   
   fluidRow(
     column(width = 7,
            fluidRow(
              plotOutput("DesvMean")),
            tags$br(),
            tags$hr(),
            fluidRow(
              column(width = 5, offset = 1,
                     uiOutput("dev_get_yrs"),
                     selectInput("dmmonths","Month",
                                 choices = c("All","January"=1,"Febuary"=2,"March"=3,"April"=4,"May"=5,"June"=6,
                                             "July"=7,"August"=8,"September"=9,"October"=10,"November"=11,"December"=12)),
                     uiOutput("hourRange1"),
                     dateRangeInput('dateRange1',
                                    label = 'Time interval (yyyy-mm-dd)',
                                    start = Sys.Date(), end = Sys.Date())),
              column(width = 5, offset = 1,
                     radioButtons("fileTypeDev1", label = NULL, choices = c(BMP = "bmp", JPEG = "jpeg", PNG = "png", PDF = "pdf"), selected = "png", inline = TRUE),
                     downloadButton("downloadDev","Download Plot..."),
                     tags$hr(),
                     radioButtons("fileTypeDev", label = NULL, choices = c(CSV = "csv", TSV = "tsv", TXT = "txt"), selected = "txt", inline = TRUE),
                     downloadButton("downloadDevTable","Download Table...")
              ))),
     column(width = 5,
            boxPlus(
              title = "Data Table",
              status = "primary",
              solidHeader = TRUE,
              width = 12,
              collapsible = TRUE,
              DT::dataTableOutput("plottabels1")))))   
   

#  tabPanel(
#   title = "Anomaly 2",
#   plotOutput("withggplot22"))
  )),
#
# Raw data tables
#
 tabItem(
  tabName = "rawdata",
  tags$br(),
  sidebarLayout(
    sidebarPanel(
      width = 2,
      fluidRow(
       selectInput("choosedata", "Tables", choices = c("Data","Data 1","Data 2","Data 3"), selected = "Data")),
      tags$hr(),
      tags$br(),
      fluidRow(
        checkboxInput("rawSeffile", "SEF File"),
        radioButtons("fileTypeRaw", label = "Type of file", choices = c(CSV = "csv", TSV = "tsv", TXT = "txt"), selected = "tsv"),
        downloadButton("downloadRawTable","Download Table...")       
      )),
    mainPanel(
      width =7,
      DT::dataTableOutput("contents")
  ))),
#
# Variables List tab
#
tabItem(
  tabName = "variableslist",
  tags$br(),
  fluidRow(
    column(width = 8, offset = 1, DT::dataTableOutput("varcontents")))),
#
# Metadata tab
#
 tabItem(
  tabName = "metavalues",
  fluidRow(
  column(width = 2, offset = 1,
    selectInput("choosemeta", "Info List", choices = c("Metadata","Metadata from Data 1","Metadata from Data 2","Metadata from Data 3"),
                selected = "Metadata"))),
  fluidRow(
  column(width = 5, offset = 1, DT::dataTableOutput("metacontents")),
  column(width = 5,
   tags$br(),
   tags$br(),
   infoBoxOutput("metaVbl", width = 12),
   infoBoxOutput("metaNumbH", width = 12),
   infoBoxOutput("metaNumbY", width = 12),
   infoBoxOutput("metaMeta", width = 12)))),
#
# Options tab
#
 tabItem(
  tabName = "dataD",
  tabsetPanel(
  tabPanel(
    title = "Options",
    tags$br(),
    fluidRow(
      box(
        title = "Statistics", 
        solidHeader = TRUE, 
        status = "primary", 
        width = 2,
#        align = "center",
        radioButtons("statsOnOff", label = NULL, choices = c("Available" = 1, "Not Available" = 2), selected = 2, inline = TRUE)
      ),
      box(
        title = "Stat Used", 
        solidHeader = TRUE, 
        status = "primary", 
        width = 2,
#        align = "center",
        radioButtons("statused", label = NULL, choices = c("Mean" = 1, "Sum" = 2), selected = 1, inline = TRUE)
      ),
      box(
        title = "Time Period", 
        solidHeader = TRUE, 
        status = "primary", 
        width = 2,
        radioButtons("timeperiod", label = NULL, choices = c("monthly", "daily", "sub-daily"), selected = "sub-daily", inline = TRUE)
)),
    fluidRow(
      box(
       status = "primary", 
       width = 12,
       align = "center",
       tags$b(tags$h3("Thresholds"))),
      box(
       title = "Mean-Sum", 
       solidHeader = TRUE, 
       status = "primary", 
       width = 2,
       numericInput("msDif", label = NULL, 0.05)),
      box(
        title = "Oscillation", 
        solidHeader = TRUE, 
        status = "primary", 
        width = 2,
        numericInput("osciDif", label = NULL, 10.0))),
    fluidRow(
      box(
       title = "Gross Error Limits [45S - 45N]",
       solidHeader = TRUE, 
       status = "primary", 
       collapsible = TRUE,
       collapsed = TRUE,
       width = 6,
       DT::dataTableOutput("GELtab")),
      box(
       title = "Gross Error Limits [down 45S - up 45N]",
       solidHeader = TRUE, 
       status = "primary", 
       collapsible = TRUE,
       collapsed = TRUE,
       width = 6,
       DT::dataTableOutput("GELtab1"))),
    fluidRow(
      box(
       title = "Temporal Consistency",
       solidHeader = TRUE, 
       status = "primary",
       collapsible = TRUE,
       collapsed = TRUE,
       width = 5,
       DT::dataTableOutput("TCtab")))
  ),  
## Header
  tabPanel(
   title = "Header Check",
   tags$br(),
   fluidRow(
     box(
       title = "Data",
       status = "primary",
       solidHeader = TRUE,
       width = 12,
       fluidRow(
         column(width = 1,align = "center",tags$h4(icon("check"))),
         column(width = 5,verbatimTextOutput("hdcorrect")),
         column(width = 2,checkboxInput("changeheaderdata","Change Data Header")),
         column(width = 2,align = "center",verbatimTextOutput("varTest")),
         column(width = 2,align = "center",verbatimTextOutput("vartitle"))),
       fluidRow(
         column(width = 1,align = "center",tags$h4(icon("times"))),
         column(width = 5,verbatimTextOutput("hdwrong")),
         conditionalPanel(condition = "input.changeheaderdata",
         column(width = 1,uiOutput("nYear")),
         column(width = 1,uiOutput("nMonth")),
         column(width = 1,uiOutput("nDay")),
         column(width = 1,uiOutput("nHour")),
         column(width = 1,uiOutput("nMin")),
         column(width = 1,uiOutput("nValue"))))
     ),
     conditionalPanel(condition = "input.filesnumb > 1",
     box(
     title = "Data1",
     status = "primary",
     solidHeader = TRUE,
     width = 12,
     fluidRow(
       column(width = 1,align = "center",tags$h4(icon("check"))),
       column(width = 5,verbatimTextOutput("hdcorrect1")),
       column(width = 2,checkboxInput("changeheaderdata1","Change Data1 Header")),
       column(width = 2, offset = 2,align = "center",verbatimTextOutput("vartitle1"))),
     fluidRow(
       column(width = 1,align = "center",tags$h4(icon("times"))),
       column(width = 5,verbatimTextOutput("hdwrong1")),
       conditionalPanel(condition = "input.changeheaderdata1",
       column(width = 1,uiOutput("nYear1")),
       column(width = 1,uiOutput("nMonth1")),
       column(width = 1,uiOutput("nDay1")),
       column(width = 1,uiOutput("nHour1")),
       column(width = 1,uiOutput("nMin1")),
       column(width = 1,uiOutput("nValue1"))))
     )),
     conditionalPanel(condition = "input.filesnumb > 2",
     box(
     title = "Data2",
     status = "primary",
     solidHeader = TRUE,
     width = 12,
     fluidRow(
       column(width = 1,align = "center",tags$h4(icon("check"))),
       column(width = 5,verbatimTextOutput("hdcorrect2")),
       column(width = 2,checkboxInput("changeheaderdata2","Change Data2 Header")),
       column(width = 2, offset = 2,align = "center",verbatimTextOutput("vartitle2"))),
     fluidRow(
       column(width = 1,align = "center",tags$h4(icon("times"))),
       column(width = 5,verbatimTextOutput("hdwrong2")),
       conditionalPanel(condition = "input.changeheaderdata2",
       column(width = 1,uiOutput("nYear2")),
       column(width = 1,uiOutput("nMonth2")),
       column(width = 1,uiOutput("nDay2")),
       column(width = 1,uiOutput("nHour2")),
       column(width = 1,uiOutput("nMin2")),
       column(width = 1,uiOutput("nValue2"))))
     )),
     conditionalPanel(condition = "input.filesnumb > 3",
     box(
      title = "Data3",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      fluidRow(
        column(width = 1,align = "center",tags$h4(icon("check"))),
        column(width = 5,verbatimTextOutput("hdcorrect3")),
        column(width = 2,checkboxInput("changeheaderdata3","Change Data3 Header")),
        column(width = 2, offset = 2,align = "center",verbatimTextOutput("vartitle3"))),
      fluidRow(
        column(width = 1,align = "center",tags$h4(icon("times"))),
        column(width = 5,verbatimTextOutput("hdwrong3")),
        conditionalPanel(condition = "input.changeheaderdata3",
        column(width = 1,uiOutput("nYear3")),
        column(width = 1,uiOutput("nMonth3")),
        column(width = 1,uiOutput("nDay3")),
        column(width = 1,uiOutput("nHour3")),
        column(width = 1,uiOutput("nMin3")),
        column(width = 1,uiOutput("nValue3"))))
      )),
    conditionalPanel(condition = "input.statsOnOff == 1",
    box(
    title = "Statistic",
    status = "primary",
    solidHeader = TRUE,
    width = 12,
    fluidRow(
      column(width = 1,align = "center",tags$h4(icon("check"))),
      column(width = 5,verbatimTextOutput("Scorrect")),
      column(width = 4,checkboxInput("changeheaderstats","Change Statistic Header"))),
    fluidRow(
      column(width = 1,align = "center",tags$h4(icon("times"))),
      column(width = 5,verbatimTextOutput("Swrong")),
      conditionalPanel(condition = "input.changeheaderstats",
      column(width = 1,uiOutput("sYear")),
      column(width = 1,uiOutput("sMonth")),
      column(width = 1,uiOutput("sHour")),
      column(width = 1,uiOutput("sMin")),
      column(width = 1,uiOutput("sValue"))))
    )))),
## Units
  tabPanel(
   title = "Units",
   tags$br(),
   fluidRow(
     column(width = 1,align = "center", "Conversion"),
     column(width = 4,align = "center", "Variable Name"),
     column(width = 2,align = "center", "SI Units"),
     column(width = 2,align = "center", "Original Units")),
   fluidRow(
    column(width = 1,align = "center", checkboxInput("convertdata", label = NULL)),
    column(width = 4,align = "center", verbatimTextOutput("varT", placeholder = TRUE)),
    column(width = 2,align = "center", verbatimTextOutput("varU", placeholder = TRUE)),
    column(width = 2,align = "center", verbatimTextOutput("varV", placeholder = TRUE)),
    column(width = 1,align = "center", verbatimTextOutput("varW"))),

   fluidRow(
     conditionalPanel(condition = "input.filesnumb > 1",
      column(width = 1,align = "center", checkboxInput("convertdata1", label = NULL)),
      column(width = 4,align = "center", verbatimTextOutput("varT1", placeholder = TRUE)),
      column(width = 2,align = "center", verbatimTextOutput("varU1", placeholder = TRUE)),
      column(width = 2,align = "center", verbatimTextOutput("varV1", placeholder = TRUE)),
      column(width = 1,align = "center", verbatimTextOutput("varW1")))),

   fluidRow(
     conditionalPanel(condition = "input.filesnumb > 2",
      column(width = 1,align = "center", checkboxInput("convertdata2", label = NULL)),
      column(width = 4,align = "center", verbatimTextOutput("varT2", placeholder = TRUE)),
      column(width = 2,align = "center", verbatimTextOutput("varU2", placeholder = TRUE)),
      column(width = 2,align = "center", verbatimTextOutput("varV2", placeholder = TRUE)),
      column(width = 1,align = "center", verbatimTextOutput("varW2")))),

   fluidRow(
     conditionalPanel(condition = "input.filesnumb > 3",
      column(width = 1,align = "center", checkboxInput("convertdata3", label = NULL)),
      column(width = 4,align = "center", verbatimTextOutput("varT3", placeholder = TRUE)),
      column(width = 2,align = "center", verbatimTextOutput("varU3", placeholder = TRUE)),
      column(width = 2,align = "center", verbatimTextOutput("varV3", placeholder = TRUE)),
      column(width = 1,align = "center", verbatimTextOutput("varW3")))),
   conditionalPanel(condition = "input.statsOnOff == 1",
   tags$br(),
   tags$hr(),
   tags$br(),  
   fluidRow(
     column(width = 1,align = "center", checkboxInput("convertstats", label = NULL)),
     column(width = 4,align = "center", verbatimTextOutput("staT", placeholder = TRUE)),
     column(width = 2,align = "center", verbatimTextOutput("staU", placeholder = TRUE)),
     column(width = 2,align = "center", uiOutput("staV")),
     column(width = 1,align = "center", verbatimTextOutput("staW")),
     column(width = 1,align = "center", verbatimTextOutput("staC")))),
   tags$br()
  ))),
#
# Help tab
#
 tabItem(
   tabName = "helpSys",
   navlistPanel(
     "Help Menu",
     tabPanel("Introdution", pre(includeText("./docs/Intro.txt"))),
     tabPanel("How to Run it?", pre(includeText("./docs/readme.txt"))),
     tabPanel("Working Place, Data and Variables", pre(includeText("./docs/WorkingPlace_Data_Variables.txt")), pre(includeText("./docs/variables.txt"))),
     tabPanel("Upload Data", pre(includeText("./docs/Upload.txt"))),
     tabPanel("Options", pre(includeText("./docs/Options.txt"))),
     tabPanel("Metadata", pre(includeText("./docs/Metadata.txt"))),
     tabPanel("Statistics", pre(includeText("./docs/Statistics.txt"))),
     tabPanel("Quality Control", pre(includeText("./docs/Quality_Control.txt"))),
     tabPanel("Results", pre(includeText("./docs/Results.txt"))),
     tabPanel("Graphics", pre(includeText("./docs/Graphics.txt"))),
     tags$br(),
     "Images Example",
     tabPanel("Upload",
              fluidRow(column(width = 9, imageOutput("upload1")),
                       column(width = 2, tags$p("Upload of 3 files, 1 is SEF file and other 2 are not."))),
              fluidRow(column(width = 9, imageOutput("upload2")),
                       column(width = 2, tags$p("From picture before, there are no SEF files and that means metadata 
                                                information may not be present in file. There for one file in docs directory
                                                named Meta_template.tsv can be use to upload that meta information, just like 
                                                picture on left demonstrate.")))),
     tabPanel("Options", 
              fluidRow(column(width = 9, imageOutput("opt1")),
                       column(width = 2, tags$p("As can be seen in picture app will check header to see if all is correct
                                                and if not according it will allow corrections, further picture"))),
              fluidRow(column(width = 9, imageOutput("opt3")),
                       column(width = 2, tags$p("The list of variables present in this applications have in one column units 
                                                 defined to each variable. In this image app will check if variable came with
                                                 standard unit. If not there is choice to convert."))),
              fluidRow(column(width = 9, imageOutput("opt2")),
                       column(width = 2, tags$p("In this picture it present a choice to correct the header of last series loaded, by
                                                check box with 'change header2 header' and indicate column number from all than exist in series. 
                                                Why this happen? The header must contain at least 4 names, Year, Month, Day and Value.
                                                Also can have Hour and Minute if sub-daily values series. Then can be that one or more
                                                names needed is not present or no header exist. Looking on first upload
                                                figure we can confirm that data serie don't have header.")))),
     tabPanel("Meta",
              fluidRow(column(width = 9, imageOutput("meta")),
                       column(width = 2, tags$p("In metadata tab we can see meta information about station and variable
                                                on testing. This also show number of years and hours and themselves.")))),
     tabPanel("Stats Pub",
              fluidRow(column(width = 9, imageOutput("staPub")),
                       column(width = 2, tags$p("In here can be seen statistic values, printed and calculated within app.
                                                The picture itself shows calculated values in form of table.")))),
     tabPanel("QC Panel",
              fluidRow(column(width = 9, imageOutput("QCP")),
                       column(width = 2, tags$p("In this image can be seen Quality Control panel with a list of tests to be
                                                selected, in this case sunshine test is select. Also can be check log file
                                                from app run. This file can be deleted manualy from app directory to create new one.")))),
     tabPanel("Results Sunshine",
              fluidRow(column(width = 9, imageOutput("resSun")),
                       column(width = 2, tags$p("In this menu will be place test results, i.e., since is sunshine test will
                                                be put value observated + value calculated and diference between both.
                                                Next to it is statistic count to know how many are suspect to be wrong and 
                                                meta be attach to meta column in main file.")))),
     tabPanel("Graphics",
              fluidRow(column(width = 9, imageOutput("gph1")),
                       column(width = 2, tags$p("This graph shows a histogram of values, meaning a close representation of an
                                                distribution of numeric data. Regarding determinated classes of values is made
                                                a count of how many fits in each classe."))),
              tags$br(),
              fluidRow(column(width = 9, imageOutput("gph2")),
                       column(width = 2, tags$p("In this can be seen a temporal distribution of data serie. Can be manipulated
                                                to see only small parts(more detail) of data serie"))),
              tags$br(),tags$br(),tags$br(),
              fluidRow(column(width = 9, imageOutput("gph3")),
                       column(width = 2, tags$p("In this can be seen a temporal distribution of data serie with more detail regarding
                                                March of 1887. this allows us to see extreme value of minimum temperature that can be
                                                suspect."))),
              tags$br(),tags$br(),tags$br(),
              fluidRow(column(width = 9, imageOutput("gph4")),
                       column(width = 2, tags$p("In this graphic we see deviation from mean of values. And this show same extreme value
                                                to far from mean for month. This and graphic before is a example how can be detected
                                                suspect values in data series")))),
     widths = c(2, 10)
   )
 ),
#
# Apps tab
#
 tabItem(
   tabName = "aplic",
   pre(includeText("./docs/Apps.txt")),
   tags$br(),
   tags$br(),
   fluidRow(column(width = 1, offset = 1, tags$a(href ="https://datarescue.climate.copernicus.eu/st_data-quality-control","dataresqc")),
            column(width = 5, tags$p("dataresqc is R package to do quality control of rescued data build by C3S Data Rescue Service and available as
                   R package to install throw CRAN"))),
   fluidRow(column(width = 1, offset = 1, tags$p("Sunshine.R")),
            column(width = 5, tags$p("This function calculates maximum sunshine hours a year-month-day can have and difference to value
                                     observated. Can be found in docs directory."))),
   fluidRow(column(width = 1, offset = 1, tags$p("Statistic.R")),
            column(width = 5, tags$p("Function that calculates statistic values like mean, maximum, minimum, variance, standard deviation,
                                     amplitude, others. Can be found in docs directory."))),
   fluidRow(column(width = 1, offset = 1, tags$p("counter.R")),
            column(width = 5, tags$p("This function counts number of values that are up, down or equal to a value given.
                                     Can be found in docs directory."))),
   fluidRow(column(width = 1, offset = 1, tags$p("UTC.R")),
            column(width = 5, tags$p("Calculates diference to UTC from local hour and convert to UTC hour. Can be found in docs directory."))),
   fluidRow(column(width = 1, offset = 1, tags$p("calc_latitude.R and calc_longitude.R")),
            column(width = 5, tags$p("Functions that transforms degrees minutes seconds direction coordenates in only degrees.
                                     Can be found in docs directory."))),
   fluidRow(column(width = 1, offset = 1, tags$p("conversions.R")),
            column(width = 5, tags$p("In this script we can find several functions to convert units of temperature, pressure, clouds and time.
                                     Can be found in docs directory."))))

)))


server <- function(input, output, session) {

#
# Time variables
#
numH <- reactive({ unique(fixData()$Hour) })
numY <- reactive({ unique(fixData()$Year) })
num1H <- reactive({ unique(fix1Data()$Hour) })
num1Y <- reactive({ unique(fix1Data()$Year) })
num2H <- reactive({ unique(fix2Data()$Hour) })
num2Y <- reactive({ unique(fix2Data()$Year) })
num3H <- reactive({ unique(fix3Data()$Hour) })
num3Y <- reactive({ unique(fix3Data()$Year) })
numSY <- reactive({ unique(fixStats()$Year) })
lenNumbY <- reactive({ length(numY()) })
lenNumbH <- reactive({ if(is.null(numH()) && lenNumbY() > 0) 1 else length(numH()) })
lenNumbY1 <- reactive({ length(num1Y()) })
lenNumbH1 <- reactive({ if(is.null(num1H()) && lenNumbY1() > 0) 1 else length(num1H()) })
lenNumbY2 <- reactive({ length(num2Y()) })
lenNumbH2 <- reactive({ if(is.null(num2H()) && lenNumbY2() > 0) 1 else length(num2H()) })
lenNumbY3 <- reactive({ length(num3Y()) })
lenNumbH3 <- reactive({ if(is.null(num3H()) && lenNumbY3() > 0) 1 else length(num3H()) })
#
# Data format
#
Year_month_day <- reactive({
  data_sep <- fixData()
  if("Year" %in% colnames(data_sep) & "Month" %in% colnames(data_sep) & "Day" %in% colnames(data_sep)) {
  if(length(data_sep) == 0) return() else data_YMD <- as.Date(paste(fixData()$Year,"-",fixData()$Month,"-",fixData()$Day, sep = ""))
  } else {return()}
return(data_YMD)
})
#
# Upload Tab
#
## Data
  metData <- reactive({
    
    if(input$sef) {
      metaRead <- input$fileIn
      sepIn <- input$sep
    } else {
      metaRead <- input$metad
      sepIn <- input$metasep
    }
    
    if(is.null(metaRead)) return()
    
    read.table(
      file = metaRead$datapath,
      header = FALSE,
      sep = sepIn,
      nrows = 12,
      col.names = c("opts","val"),
      stringsAsFactors = FALSE)
    
  })
  
  varData <- reactive({
    
    fileRead <- input$fileIn
    if(is.null(fileRead)) return()
    if(input$sef) skiplines <- 12 else skiplines <- 0
    
    read.table(
      file = fileRead$datapath,
      header = input$head,
      sep = input$sep,
      dec = input$decsep,
      skip = skiplines,
      stringsAsFactors = FALSE) 
    
  })
  
## Data 1
  met1Data <- reactive({
    
    if(input$sef1) {
      metaRead1 <- input$fileIn1
      sepIn1 <- input$sep1
    } else {
      metaRead1 <- input$metad1
      sepIn1 <- input$metasep1
    }
    
    if(is.null(metaRead1)) return()
    
    read.table(
      file = metaRead1$datapath,
      header = FALSE,
      sep = sepIn1,
      nrows = 12,
      col.names = c("opts","val"),
      stringsAsFactors = FALSE)
  })
  
  varData1 <- reactive({
    
    fileRead1 <- input$fileIn1
    if(is.null(fileRead1)) return()
    if(input$sef1) skiplines1 <- 12 else skiplines1 <- 0

    read.table(
      file = fileRead1$datapath,
      header = input$head1,
      sep = input$sep1,
      dec = input$decsep1,
      skip = skiplines1,
      stringsAsFactors = FALSE)
  })
  
## Data 2
  met2Data <- reactive({
    
    if(input$sef2) {
      metaRead2 <- input$fileIn2
      sepIn2 <- input$sep2
    } else {
      metaRead2 <- input$metad2
      sepIn2 <- input$metasep2
    }
    
    if(is.null(metaRead2)) return()
    
    read.table(
      file = metaRead2$datapath,
      header = FALSE,
      sep = sepIn2,
      nrows = 12,
      col.names = c("opts","val"),
      stringsAsFactors = FALSE)
  })
  
  varData2 <- reactive({
    
    fileRead2 <- input$fileIn2
    if(is.null(fileRead2)) return()
    if(input$sef2) skiplines2 <- 12 else skiplines2 <- 0
 
    read.table(
      file = fileRead2$datapath,
      header = input$head2,
      sep = input$sep2,
      dec = input$decsep2,
      skip = skiplines2,
      stringsAsFactors = FALSE)
  })  
  
## Data 3
  met3Data <- reactive({
    
    if(input$sef3) {
      metaRead3 <- input$fileIn3
      sepIn3 <- input$sep3
    } else {
      metaRead3 <- input$metad3
      sepIn3 <- input$metasep3
    }
    
    if(is.null(metaRead3)) return()

    read.table(
      file = metaRead3$datapath,
      header = FALSE,
      sep = sepIn3,
      nrows = 12,
      col.names = c("opts","val"),
      stringsAsFactors = FALSE)
  })
  
  varData3 <- reactive({
    
    fileRead3 <- input$fileIn3
    if(is.null(fileRead3)) return()
    if(input$sef3) skiplines3 <- 12 else skiplines3 <- 0

    read.table(
      file = fileRead3$datapath,
      header = input$head3,
      sep = input$sep3,
      dec = input$decsep3,
      skip = skiplines3,
      stringsAsFactors = FALSE)
  })

## Statistic
  varStats <- reactive({
    
    fileReadStat <- input$DataStat
    if(is.null(fileReadStat)) return()
    if(input$seffile) skipl <- 12 else skipl <- 0
        
    read.table(
      file = fileReadStat$datapath,
      header = input$headstat,
      sep = input$sepstat,
      dec = input$decsepstat,
      skip = skipl,
      stringsAsFactors = FALSE)
    
  })
  metStat <- reactive({
    if(input$seffile){
      fileReadStat <- input$DataStat
      if(is.null(fileReadStat)) return()
      read.table(
        file = fileReadStat$datapath,
        header = FALSE,
        sep = input$sepstat,
        nrows = 12,
        col.names = c("opts","val"),
        stringsAsFactors = FALSE)
    } else {
      return()
    }
  })
#
# End Upload tab
# Options tab
# Data
#
## Units
output$varT <- renderText({ vardesc()[1] })
output$varU <- renderText({ vardesc()[5] })
output$varV <- renderText({ metData()$val[metData()$opts == "Units"] })
output$varW <- renderText({ "Data" })
## check header
output$varTest <- renderText({ "Testing variable..." })
output$vartitle <- renderText({ vardesc()[1] })
## col names place
DataHeader <- reactive({
## Main data choice
  dHeader <- colnames(varData())
  if(length(dHeader) == 0) return()
  if(input$changeheaderdata){
    if(input$pY != "Year") dHeader[as.numeric(input$pY)] <- "Year"
    if(input$pM != "Month") dHeader[as.numeric(input$pM)] <- "Month"
    if(input$pD != "Day") dHeader[as.numeric(input$pD)] <- "Day"
    if(input$pH != "Hour") dHeader[as.numeric(input$pH)] <- "Hour"
    if(input$pMi != "Minute") dHeader[as.numeric(input$pMi)] <- "Minute"
    if(input$pV != "Value") dHeader[as.numeric(input$pV)] <- "Value"     
  }
  return(dHeader)
})
checkHeader <- reactive({
  if(input$changeheaderdata) d0 <- DataHeader() else d0 <- colnames(varData())
  if(length(d0) == 0) return()
  chkdata <- Check_header(d0,"data")
})
## select outputs (options)
output$hdcorrect <- renderText({ checkHeader()$hcorrect })
output$hdwrong <- renderText({ checkHeader()$hwrong })
output$nYear  <- renderUI({ selectInput("pY",label = NULL, choices = c("Year", 1:length(varData())), selected = "Year") })
output$nMonth <- renderUI({ selectInput("pM",label = NULL, choices = c("Month", 1:length(varData())), selected = "Month") })
output$nDay   <- renderUI({ selectInput("pD",label = NULL, choices = c("Day", 1:length(varData())), selected = "Day") })
output$nHour  <- renderUI({ selectInput("pH",label = NULL, choices = c("Hour", 1:length(varData())), selected = "Hour") })
output$nMin   <- renderUI({ selectInput("pMi",label = NULL, choices = c("Minute", 1:length(varData())), selected = "Minute") })
output$nValue <- renderUI({ selectInput("pV",label = NULL, choices = c("Value", 1:length(varData())), selected = "Value") })
#
# Data1
#
## Units
output$varT1 <- renderText({ vardesc()[2] })
output$varU1 <- renderText({ vardesc()[6] })
output$varV1 <- renderText({ met1Data()$val[met1Data()$opts == "Units"] })
output$varW1 <- renderText({ "Data1" })
## check header
output$vartitle1 <- renderText({ vardesc()[2] })
check1Header <- reactive({
  if(input$changeheaderdata1) d1 <- Data1Header() else d1 <- colnames(varData1())
  if(length(d1) == 0) return()
  chkdata1 <- Check_header(d1,"data")
})
## col names place
Data1Header <- reactive({
  d1Header <- colnames(varData1())
  if(length(d1Header) == 0) return()
  if(input$changeheaderdata1){
    if(input$pY1 != "Year"){d1Header[as.numeric(input$pY1)] <- "Year"}
    if(input$pM1 != "Month"){d1Header[as.numeric(input$pM1)] <- "Month"}
    if(input$pD1 != "Day"){d1Header[as.numeric(input$pD1)] <- "Day"}
    if(input$pH1 != "Hour"){d1Header[as.numeric(input$pH1)] <- "Hour"}
    if(input$pMi1 != "Minute"){d1Header[as.numeric(input$pMi1)] <- "Minute"}
    if(input$pV1 != "Value"){d1Header[as.numeric(input$pV1)] <- "Value"}     
  }
  return(d1Header)
})
## select outputs (options)
output$hdcorrect1 <- renderText({ check1Header()$hcorrect })
output$hdwrong1 <- renderText({ check1Header()$hwrong })
output$nYear1  <- renderUI({ selectInput("pY1",label = NULL, choices = c("Year", 1:length(varData1())), selected = "Year") })
output$nMonth1 <- renderUI({ selectInput("pM1",label = NULL, choices = c("Month", 1:length(varData1())), selected = "Month") })
output$nDay1   <- renderUI({ selectInput("pD1",label = NULL, choices = c("Day", 1:length(varData1())), selected = "Day") })
output$nHour1  <- renderUI({ selectInput("pH1",label = NULL, choices = c("Hour", 1:length(varData1())), selected = "Hour") })
output$nMin1   <- renderUI({ selectInput("pMi1",label = NULL, choices = c("Minute", 1:length(varData1())), selected = "Minute") })
output$nValue1 <- renderUI({ selectInput("pV1",label = NULL, choices = c("Value", 1:length(varData1())), selected = "Value") })
#
# Data2
#
## Units
output$varT2 <- renderText({ vardesc()[3] })
output$varU2 <- renderText({ vardesc()[7] })
output$varV2 <- renderText({ met2Data()$val[met2Data()$opts == "Units"] })
output$varW2 <- renderText({ "Data2" })
## check header
output$vartitle2 <- renderText({ vardesc()[3] })
check2Header <- reactive({
  if(input$changeheaderdata2) d2 <- Data2Header() else d2 <- colnames(varData2())
  if(length(d2) == 0) return()
  chkdata2 <- Check_header(d2,"data")
})
## col names place
Data2Header <- reactive({
  d2Header <- colnames(varData2())
  if(length(d2Header) == 0) return()
  if(input$changeheaderdata2){
    if(input$pY2 != "Year"){d2Header[as.numeric(input$pY2)] <- "Year"}
    if(input$pM2 != "Month"){d2Header[as.numeric(input$pM2)] <- "Month"}
    if(input$pD2 != "Day"){d2Header[as.numeric(input$pD2)] <- "Day"}
    if(input$pH2 != "Hour"){d2Header[as.numeric(input$pH2)] <- "Hour"}
    if(input$pMi2 != "Minute"){d2Header[as.numeric(input$pMi2)] <- "Minute"}
    if(input$pV2 != "Value"){d2Header[as.numeric(input$pV2)] <- "Value"}     
  }
  return(d2Header)
})
## select outputs (options)
output$hdcorrect2 <- renderText({ check2Header()$hcorrect })
output$hdwrong2 <- renderText({ check2Header()$hwrong })
output$nYear2  <- renderUI({ selectInput("pY2",label = NULL, choices = c("Year", 1:length(varData2())), selected = "Year") })
output$nMonth2 <- renderUI({ selectInput("pM2",label = NULL, choices = c("Month", 1:length(varData2())), selected = "Month") })
output$nDay2   <- renderUI({ selectInput("pD2",label = NULL, choices = c("Day", 1:length(varData2())), selected = "Day") })
output$nHour2  <- renderUI({ selectInput("pH2",label = NULL, choices = c("Hour", 1:length(varData2())), selected = "Hour") })
output$nMin2   <- renderUI({ selectInput("pMi2",label = NULL, choices = c("Minute", 1:length(varData2())), selected = "Minute") })
output$nValue2 <- renderUI({ selectInput("pV2",label = NULL, choices = c("Value", 1:length(varData2())), selected = "Value") })
#
# Data3
#
## Units
output$varT3 <- renderText({ vardesc()[4] })
output$varU3 <- renderText({ vardesc()[8] })
output$varV3 <- renderText({ met3Data()$val[met3Data()$opts == "Units"] })
output$varW3 <- renderText({ "Data3" })
## check header
output$vartitle3 <- renderText({ vardesc()[4] })
check3Header <- reactive({
  if(input$changeheaderdata3) d3 <- Data3Header() else d3 <- colnames(varData3())
  if(length(d3) == 0) return()
  chkdata3 <- Check_header(d3,"data")
})
## col names place
Data3Header <- reactive({
  d3Header <- colnames(varData3())
  if(length(d3Header) == 0) return()
  if(input$changeheaderdata3){
    if(input$pY3 != "Year"){d3Header[as.numeric(input$pY3)] <- "Year"}
    if(input$pM3 != "Month"){d3Header[as.numeric(input$pM3)] <- "Month"}
    if(input$pD3 != "Day"){d3Header[as.numeric(input$pD3)] <- "Day"}
    if(input$pH3 != "Hour"){d3Header[as.numeric(input$pH3)] <- "Hour"}
    if(input$pMi3 != "Minute"){d3Header[as.numeric(input$pMi3)] <- "Minute"}
    if(input$pV3 != "Value"){d3Header[as.numeric(input$pV3)] <- "Value"}     
  }
  return(d3Header)
})
## select outputs (options)
output$hdcorrect3 <- renderText({ check3Header()$hcorrect })
output$hdwrong3 <- renderText({ check3Header()$hwrong })
output$nYear3  <- renderUI({ selectInput("pY3",label = NULL, choices = c("Year", 1:length(varData3())), selected = "Year") })
output$nMonth3 <- renderUI({ selectInput("pM3",label = NULL, choices = c("Month", 1:length(varData3())), selected = "Month") })
output$nDay3   <- renderUI({ selectInput("pD3",label = NULL, choices = c("Day", 1:length(varData3())), selected = "Day") })
output$nHour3  <- renderUI({ selectInput("pH3",label = NULL, choices = c("Hour", 1:length(varData3())), selected = "Hour") })
output$nMin3   <- renderUI({ selectInput("pMi3",label = NULL, choices = c("Minute", 1:length(varData3())), selected = "Minute") })
output$nValue3 <- renderUI({ selectInput("pV3",label = NULL, choices = c("Value", 1:length(varData3())), selected = "Value") })
#
# Statistic
#
## Units
output$staT <- renderText({ 
  if(input$seffile) vardesc()[9] else vardesc()[1] })
output$staU <- renderText({ 
  if(input$seffile) vardesc()[10] else vardesc()[5] })
output$staG <- renderText({ metStat()$val[metStat()$opts == "Units"] })
output$staV <- renderUI({ 
  if(input$seffile){
    verbatimTextOutput("staG", placeholder = TRUE)
  } else {
  selectInput("statsV",label = NULL, choices = c("Original Units", "Atmosphere (atm)" = "atm", "Pound per Square Inch (psi)" = "psi", "millimetre of mercury (mmHg)" = "mmHg",
                                                 "Kelvin (K)" = "K", "Fahrenheit (F)" = "F", "Sunlight Hours.min (hh.mm)" = "hmin", "Clouds" = "tenths")) 
  }}) 
output$staW <- renderText({ "Stats" })
output$staC <- renderText({
  st0 <- metStat()$val[metStat()$opts == "Vbl"]
  st1 <- metData()$val[metData()$opts == "Vbl"]
  if(length(st0) == 0 | length(st1) == 0){ return() }
  if(input$seffile){
    if(st0 == st1) {
      "Correct"
    } else { 
      "Incorrect"
    }
  } else { "" }
}) 
## check header
checkSHeader <- reactive({
  if(input$changeheaderstats) dS <- StatsHeader() else dS <- colnames(varStats())
  if(length(dS) == 0) return()
  chkStats <- Check_header(dS,"stats")
})
## col names place
StatsHeader <- reactive({
  StHeader <- colnames(varStats())
  if(length(StHeader) == 0) return()
  if(input$changeheaderstats){
    if(input$piY != "Year"){StHeader[as.numeric(input$piY)] <- "Year"}
    if(input$piM != "Month"){StHeader[as.numeric(input$piM)] <- "Month"}
    if(input$piH != "Hour"){StHeader[as.numeric(input$piH)] <- "Hour"}
    if(input$piMi != "Minute"){StHeader[as.numeric(input$piMi)] <- "Minute"}
    if(input$piV != "Value"){StHeader[as.numeric(input$piV)] <- "Value"}     
  }
  return(StHeader)
})
## select outputs (options)
output$Scorrect <- renderText({ checkSHeader()$hcorrect })
output$Swrong <- renderText({ checkSHeader()$hwrong })
output$sYear  <- renderUI({ selectInput("piY",label = NULL, choices = c("Year", 1:length(varStats())), selected = "Year") })
output$sMonth <- renderUI({ selectInput("piM",label = NULL, choices = c("Month", 1:length(varStats())), selected = "Month") })
output$sHour  <- renderUI({ selectInput("piH",label = NULL, choices = c("Hour", 1:length(varStats())), selected = "Hour") })
output$sMin   <- renderUI({ selectInput("piMi",label = NULL, choices = c("Minute", 1:length(varStats())), selected = "Minute") })
output$sValue <- renderUI({ selectInput("piV",label = NULL, choices = c("Value", 1:length(varStats())), selected = "Value") })
#
# End options tab
# corrections (if need)
#
## Data
fixData <- reactive({
  data_get <- varData()
  if(length(data_get) == 0) return()
  ### Header fix
  if(input$changeheaderdata) colnames(data_get) <- DataHeader()
  ### Conversion
  if(input$convertdata){
    if(vardesc()[5] == "C") data_get <- convertUnits(metData()$val[metData()$opts == "Units"],data_get)
    if(vardesc()[5] == "hPa") data_get <- convertUnits(metData()$val[metData()$opts == "Units"],data_get)
    if(vardesc()[5] == "h") data_get <- convertUnits(metData()$val[metData()$opts == "Units"],data_get)
    if(vardesc()[5] == "Okta") data_get <- convertUnits(metData()$val[metData()$opts == "Units"],data_get)
  }
  ### Check Meta column
  if("Meta" %in% colnames(data_get)){
    cat("Meta column exist.", file = "log.txt", fill = TRUE, append = TRUE)
  } else {
    Meta <- c()
    for(im in 1:length(data_get$Value)){
      Meta[im] <- NA
    }
    data_get <- cbind(data_get,Meta)
  }
  return(data_get)
})
## Data1
fix1Data <- reactive({
  data_get1 <- varData1()
  ### Header fix
  if(input$changeheaderdata1) colnames(data_get1) <- Data1Header()
  ### Conversion
  if(input$convertdata1){
    if(vardesc()[6] == "C") data_get1 <- convertUnits(met1Data()$val[met1Data()$opts == "Units"],data_get1)
    if(vardesc()[6] == "hPa") data_get1 <- convertUnits(met1Data()$val[met1Data()$opts == "Units"],data_get1)
    if(vardesc()[6] == "h") data_get1 <- convertUnits(met1Data()$val[met1Data()$opts == "Units"],data_get1)
    if(vardesc()[6] == "Okta") data_get1 <- convertUnits(met1Data()$val[met1Data()$opts == "Units"],data_get1)
  }
  data_get1
})
## Data2
fix2Data <- reactive({
  data_get2 <- varData2()
  ### Header fix
  if(input$changeheaderdata2) colnames(data_get2) <- Data2Header()
  ### Conversion
  if(input$convertdata2){
    if(vardesc()[7] == "C") data_get2 <- convertUnits(met2Data()$val[met2Data()$opts == "Units"],data_get2)
    if(vardesc()[7] == "hPa") data_get2 <- convertUnits(met2Data()$val[met2Data()$opts == "Units"],data_get2)
    if(vardesc()[7] == "h") data_get2 <- convertUnits(met2Data()$val[met2Data()$opts == "Units"],data_get2)
    if(vardesc()[7] == "Okta") data_get2 <- convertUnits(met2Data()$val[met2Data()$opts == "Units"],data_get2)
  }
  data_get2
})
## Data3
fix3Data <- reactive({
  data_get3 <- varData3()
  ### Header fix
  if(input$changeheaderdata3) colnames(data_get3) <- Data3Header()
  ### Conversion
  if(input$convertdata3){
    if(vardesc()[8] == "C") data_get3 <- convertUnits(met3Data()$val[met3Data()$opts == "Units"],data_get3)
    if(vardesc()[8] == "hPa") data_get3 <- convertUnits(met3Data()$val[met3Data()$opts == "Units"],data_get3)
    if(vardesc()[8] == "h") data_get3 <- convertUnits(met3Data()$val[met3Data()$opts == "Units"],data_get3)
    if(vardesc()[8] == "Okta") data_get3 <- convertUnits(met3Data()$val[met3Data()$opts == "Units"],data_get3)
  }
  data_get3
})
## Stats
fixStats <- reactive({
  stats_get <- varStats()
  ### Header fix
  if(input$changeheaderstats) colnames(stats_get) <- StatsHeader()
  ### Conversion
  if(input$convertstats){
    if(input$seffile){
      if(vardesc()[10] == "C") stats_get <- convertUnits(metStat()$val[metStat()$opts == "Units"],stats_get)
      if(vardesc()[10] == "hPa") stats_get <- convertUnits(metStat()$val[metStat()$opts == "Units"],stats_get)
      if(vardesc()[10] == "h") stats_get <- convertUnits(metStat()$val[metStat()$opts == "Units"],stats_get)
      if(vardesc()[10] == "Okta") stats_get <- convertUnits(metStat()$val[metStat()$opts == "Units"],stats_get)      
    } else {
      if(vardesc()[5] == "C") stats_get <- convertUnits(input$statsV,stats_get)
      if(vardesc()[5] == "hPa") stats_get <- convertUnits(input$statsV,stats_get)
      if(vardesc()[5] == "h") stats_get <- convertUnits(input$statsV,stats_get)
      if(vardesc()[5] == "Okta") stats_get <- convertUnits(input$statsV,stats_get)
  }}
  stats_get
})
#
# Options
#
## Read values for GEL, IC, TC Checks
GEL_tb <- reactive({
  
    read.table(
      file= "./docs/GEL_Val_45S_45N.txt",
      header = TRUE,
      sep = "\t",
      stringsAsFactors = FALSE)

})
GEL_tb1 <- reactive({
  
  read.table(
    file= "./docs/GEL_Val_down45S_up45N.txt",
    header = TRUE,
    sep = "\t",
    stringsAsFactors = FALSE)
  
})
TC_tb <- reactive({
  
    read.table(
      file= "./docs/TC_Val.txt",
      header = TRUE,
      sep = "\t",
      stringsAsFactors = FALSE)

})

## Tables
output$GELtab <- DT:: renderDataTable({
  
  DT:: datatable(
    GEL_tb(), 
    options = list(searching = FALSE, paging = FALSE),
    caption = "W = Winter, S = Summer, Y = Year",
    rownames = FALSE,
    filter = "none",
    editable = "all")
  
})
output$GELtab1 <- DT:: renderDataTable({
  
  DT:: datatable(
    GEL_tb1(), 
    options = list(searching = FALSE, paging = FALSE),
    caption = "W = Winter, S = Summer, Y = Year",
    rownames = FALSE,
    filter = "none",
    editable = "all")
  
})
output$TCtab <- DT:: renderDataTable({
  
  DT:: datatable(
    TC_tb(), 
    options = list(searching = FALSE, paging = FALSE),
    caption = "_tol = total values",
    rownames = FALSE,
    filter = "none",
    editable = "all")
  
})
#
# Raw Data tab  
#
get_data_tab <- reactive({
  
  data_tab <- fixData()
  if(length(checkMeta()$MetaI) != 0)  data_tab$Meta <- checkMeta()$MetaI
  
  switch(
    input$choosedata,
    "Data" = data_tab,
    "Data 1" = fix1Data(),
    "Data 2" = fix2Data(),
    "Data 3" = fix3Data())
  
})
output$contents <- DT:: renderDataTable({
  
  DT:: datatable(
    get_data_tab(),
    options = list(
      lengthMenu = c("15","45","75","100"),
      searching = FALSE),
    rownames = FALSE)
  
})
#
# Variable tab
#
varlist <- reactive({
  
  varfileRead <- input$variablelist
  if(input$defaultvar){
    read.table(
      file= "./docs/variables.txt",
      header = TRUE,
      sep = "\t",
      stringsAsFactors = FALSE)
  } else {
    read.table(
      file = varfileRead$datapath,
      header = input$headvar,
      sep = input$sepvar,
      stringsAsFactors = FALSE)
  }
  
})

output$varcontents <- DT:: renderDataTable({
  
  DT:: datatable(
    varlist(),
    options = list(
      lengthMenu = c("15","45","75","100"),
      searching = FALSE),
    rownames = FALSE)
  
})
#
# Metadata tab
#
## variable description

vardesc <- reactive({
  
  var_e <- c("","","","","","","","","","") 
  lenfile <- length(varlist()$var)
  numbfilesLen <- as.numeric(input$filesnumb)
  var0 <- metData()$val[metData()$opts == "Vbl"]
  if(length(var0) == 0 | is.null(var0)) var0 <- ""
  var1 <- met1Data()$val[met1Data()$opts == "Vbl"]
  var2 <- met2Data()$val[met2Data()$opts == "Vbl"]
  var3 <- met3Data()$val[met3Data()$opts == "Vbl"]
  sta0 <- metStat()$val[metStat()$opts == "Vbl"]
  if(length(sta0) == 0 | is.null(sta0)) sta0 <- ""
  
  for(j in 1:numbfilesLen){
    if(j == 2){
      if(length(var1) == 0 | is.null(var1)) var0 <- "" else var0 <- var1
    }
    if(j == 3){
      if(length(var2) == 0 | is.null(var2)) var0 <- "" else var0 <- var2
    }
    if(j == 4){
      if(length(var3) == 0 | is.null(var3)) var0 <- "" else var0 <- var3
    }
    for(i in 1:lenfile){
      var_L <- varlist()$var[i]
      var_D <- varlist()$description[i]
      var_U <- varlist()$units[i]
      if(trimws(var_L) == trimws(var0)){
        var_e[j] <- var_D
        var_e[j+4] <- var_U
      }
      # Statistic var description
      if(trimws(var_L) == trimws(sta0)){
        var_e[9] <- var_D
        var_e[10] <- var_U
      }
    }
  } 
  return(var_e) 
})
## Info Box
output$metaVbl <- renderInfoBox({
  if(input$choosemeta == "Metadata") {
    numX2 <- vardesc()[1]
    numZ2 <- metData()$val[metData()$opts == "Vbl"]
  } else if(input$choosemeta == "Metadata from Data 1"){
    numX2 <- vardesc()[2]
    numZ2 <- met1Data()$val[met1Data()$opts == "Vbl"]   
  } else if(input$choosemeta == "Metadata from Data 2"){
    numX2 <- vardesc()[3]
    numZ2 <- met2Data()$val[met2Data()$opts == "Vbl"]
  } else {
    numX2 <- vardesc()[4]
    numZ2 <- met3Data()$val[met3Data()$opts == "Vbl"]   
  }  
  infoBox("Name", numX2, subtitle = numZ2, icon = icon("file")) 
})
output$metaMeta <- renderInfoBox({
  if(input$choosemeta == "Metadata") {
    numZ3 <- metData()$val[metData()$opts == "Meta"]
  } else if(input$choosemeta == "Metadata from Data 1"){
    numZ3 <- met1Data()$val[met1Data()$opts == "Meta"]   
  } else if(input$choosemeta == "Metadata from Data 2"){
    numZ3 <- met2Data()$val[met2Data()$opts == "Meta"]
  } else {
    numZ3 <- met3Data()$val[met3Data()$opts == "Meta"]   
  }
  infoBox("Meta Info", numZ3, icon = icon("cog")) })

output$metaNumbH <- renderInfoBox({
  vHr <- ""
  if(input$choosemeta == "Metadata") {
    numX <- lenNumbH()
    numZ <- numH()
  } else if(input$choosemeta == "Metadata from Data 1"){
    numX <- lenNumbH1()
    numZ <- num1H()    
  } else if(input$choosemeta == "Metadata from Data 2"){
    numX <- lenNumbH2()
    numZ <- num2H()
  } else {
    numX <- lenNumbH3()
    numZ <- num3H()   
  }
  for(i in 1:numX){
    vHr <- paste(vHr,numZ[i],sep = " ")
  }
  infoBox("Observations", numX, subtitle = vHr, icon = icon("eye"))
})

output$metaNumbY <- renderInfoBox({
  vYr <- ""
  if(input$choosemeta == "Metadata") {
    numX1 <- lenNumbY()
    numZ1 <- numY()
  } else if(input$choosemeta == "Metadata from Data 1"){
    numX1 <- lenNumbY1()
    numZ1 <- num1Y()    
  } else if(input$choosemeta == "Metadata from Data 2"){
    numX1 <- lenNumbY2()
    numZ1 <- num2Y()
  } else {
    numX1 <- lenNumbY3()
    numZ1 <- num3Y()   
  }
  for(i in 1:numX1){
    vYr <- paste(vYr,numZ1[i],sep = " ")
  }
  infoBox("Years", numX1, subtitle = vYr, icon = icon("calendar-alt"))
})

##metadata switch  
get_meta_tab <- reactive({
  
  switch(
    input$choosemeta,
    "Metadata" = metData(),          
    "Metadata from Data 1" = met1Data(),
    "Metadata from Data 2" = met2Data(),
    "Metadata from Data 3" = met3Data())
  
})
output$metacontents <- DT:: renderDataTable({
  
  DT:: datatable(
    get_meta_tab(),
    options = list(
      paging = FALSE,
      searching = FALSE),
    rownames = FALSE)
  
})
#
# Statistic tab
#
output$calcStats <- DT:: renderDataTable({
  
  data_st <- get_stat()
  if(length(data_st) == 0) return()
  if(length(input$years) == 0) return()
  if(length(input$months) == 0) return()
  if(input$years != "All") data_st <- data_st[data_st$Year == input$years,]
  if(input$months != "All") data_st <- data_st[data_st$Month == input$months,]

  DT:: datatable(
    data_st, 
    options = list(searching = FALSE),
    rownames = FALSE)
  
})
output$pubStats <- DT:: renderDataTable({
  
  data_pb <- fixStats()
  if(length(data_pb) == 0) return()
  if(length(input$years1) == 0) return()
  if(length(input$months1) == 0) return()
  if(input$years1 != "All") data_pb <- data_pb[data_pb$Year == input$years1,]
  if(input$months1 != "All") data_pb <- data_pb[data_pb$Month == input$months1,]
  
  DT:: datatable(
    data_pb, 
    options = list(searching = FALSE),
    rownames = FALSE)
  
})

output$get_yrs <- renderUI({ selectInput("years","Year",choices = c("All", numY())) })
output$get_yrs1 <- renderUI({ selectInput("years1","Year",choices = c("All", numSY())) })
#
# Quality Control tab
#
## Log file read and print on log box

LogfileReader <- reactiveFileReader(500, session, "log.txt", readLines)

output$Intextlog <- reactive({
  textin <- LogfileReader()
  textin[is.na(textin)] <- ""
  paste(textin, collapse = "\n")
})

## uiOuputs
output$MS <- renderUI({
  if(input$statsOnOff == 1) MSVal <- TRUE else MSVal <- FALSE
  checkboxInput("check4","Publish and Calculated Mean or Sum check", value = MSVal)
})
#
# Results tab
#
output$getSun <- DT:: renderDataTable({
  
  data_sun <- get_sunlight()
  
  if(length(data_sun) == 0) return()

  DT:: datatable(
    data_sun, 
    options = list(searching = FALSE),
    rownames = FALSE)
  
})

output$getSun_sd <- DT:: renderDataTable({

  data_sun_sd <- get_sun_1h()  
  time_T <- input$timeperiod
  
  if(length(data_sun_sd) == 0) return()
  if(length(time_T) == 0) time_T <- "sub-daily" 
  if(time_T != "sub-daily") return()

  DT:: datatable(
    data_sun_sd, 
    options = list(searching = FALSE),
    rownames = FALSE)
  
})

output$Metatab <- DT :: renderDataTable({
  DT :: datatable(
    checkMeta(),
    rownames = FALSE
  )
})

output$getMS <- DT :: renderDataTable({
  DT :: datatable(
    MS_check(),
    rownames = FALSE
  )
})

## Info Box
output$up <- renderInfoBox({
  numX1 <- counter_sunshine()
  infoBox(paste(numX1[5],"%", sep = " "), numX1[2], subtitle = "Greater than max", icon = icon("greater-than"))
})
output$down <- renderInfoBox({
  numX1 <- counter_sunshine()
  infoBox(paste(numX1[4],"%", sep = " "), numX1[1], subtitle = "Lesser than max", icon = icon("less-than"))
})
output$equal <- renderInfoBox({
  numX1 <- counter_sunshine()
  infoBox(paste(numX1[6],"%", sep = " "), numX1[3], subtitle = "Equals to max", icon = icon("equals"))
})

#
# get or calculate values
#
## Statistic calculation
get_stat <- reactive({
  
  if(length(fixData()) == 0) return()   
  if(lenNumbH() == 1){
    dstat <- stats.go(fixData(), type = "full")
  } else {
    Ncount <- 0
    for (j in 1:lenNumbH()){ 
      Data <- fixData()[fixData()$Hour == numH()[j],]
      dstat <- stats.go(Data, type = "full")
      if(Ncount == 0){
        DataC <- dstat
        Ncount <- 1
      } else {
        DataC <- rbind(DataC,dstat)  
      }
    }
    dstat <- DataC
  }
  dstat
})
## sunlight calculations
get_sunlight <- reactive({
if(input$check6){
  time_in <- input$timeperiod
  if(time_in == "sub-daily"){
   insider <- stats.go(fixData(),type="sum",period="daily") 
  } else {
   insider <- fixData()
  }
#  assign("insider",insider, envir = globalenv())
  day.duration(insider,metData())    
} 
})
## sunlight 1h compares
get_sun_1h <- reactive({
  if(input$check6){
  time_in <- input$timeperiod
  if(time_in == "sub-daily") hour.compare(fixData(),1,"less") else return()
  }
})

## Counters
counter_sunshine <- reactive({
  counter.if(get_sunlight()$Dif, 0)
})
## Deviation calculations
devMean <- reactive({
  time_tt <- input$timeperiod
  Avalue <- c() 
  devData <- fixData()
  statData <- get_stat()
  if(length(devData) == 0) return()
  if(length(statData) == 0) return()
  maxDLen <- length(devData$Year)
  for(jm in 1:maxDLen){
   dataY <- devData$Year[jm]
   dataM <- devData$Month[jm]
   dataH <- devData$Hour[jm]
   if(time_tt == "sub-daily") {
   Avalue[jm] <- statData$mean[statData$Year == dataY & statData$Month == dataM & statData$Hour == dataH] - devData$Value[jm] 
   } else {
   Avalue[jm] <- statData$mean[statData$Year == dataY & statData$Month == dataM] - devData$Value[jm]      
   }
  }
  return(Avalue)
})

##
# Meta calculations if sub-daily
meta_cal <- reactive({

if(input$check6){
 if(input$timeperiod == "sub-daily"){
   ke <- 0
   for(ye in 1:lenNumbY()){
     Meta_S <- c()
     nye <- numY()[ye]
     
     datafix <- fixData()[fixData()$Year == nye,]
     sunDatafix <- get_sunlight()[get_sunlight()$Year == nye,]
     
     maxle <- length(datafix$Year)
     maxle1 <- length(sunDatafix$Year)
     
     for(il in 1:maxle){
       for(im in 1:maxle1){
         if(datafix$Month[il] == sunDatafix$Month[im] & datafix$Day[il] == sunDatafix$Day[im]){
           Meta_S[il] <- sunDatafix$FlagSun[im]
         } 
       }
     } 
     meta_tab <- data.frame(datafix,Meta_S)
     if(ke == 0){
       Meta_Sun_max <- meta_tab 
       ke <- 1
     } else {
       Meta_Sun_max <- rbind(Meta_Sun_max,meta_tab)
     }
   }
 }
}
#  assign("meta_m",Meta_Sun_max,envir = globalenv())
return(Meta_Sun_max)
})

## Meta replaces

checkMeta <- reactive({
  
Meta <- c()
Meta_Conv <- c()
#Meta_Gross <- C()
#Meta_TC <- c()
#Meta_IC <- c()
Meta_Sun_1h <- c()
Meta_Sun_max <- c()
Meta_Sun <- c()
Meta_MS <- c()
#Meta_T <- c()

YYMMDD <- Year_month_day()
co_in <- input$convertdata
ms_in <- input$check4
sun_in <- input$check6

if(length(YYMMDD) == 0) return()
if(length(co_in) == 0) co_in <- FALSE
if(length(ms_in) == 0) ms_in <- FALSE
if(length(sun_in) == 0) sun_in <- FALSE

datafix <- fixData()
MetaI <- fixData()$Meta
if("Hour" %in% colnames(datafix)) Meta <- data.frame(YYMMDD,datafix["Hour"],MetaI) else Meta <- data.frame(YYMMDD,MetaI)
maxMLen <- length(fixData()$Year)
if(co_in == TRUE) {
 unitsConv <- metData()$val[metData()$opts == "Units"]
 for(ij in 1:maxMLen){
  Meta_Conv[ij] <- paste("orig=",varData()$Value[ij],unitsConv, sep = "")
  if(length(Meta$MetaI[ij]) == 0 | is.na(Meta$MetaI[ij])){
    Meta$MetaI[ij] <- Meta_Conv[ij]
  } else {Meta$MetaI[ij] <- paste(Meta$MetaI[ij],Meta_Conv[ij], sep = "|")}
 }
 Meta <- cbind(Meta,Meta_Conv)
}
#if(input$check1) {}
#if(input$check2) {}
#if(input$check3) {}


if(ms_in == TRUE) {
if(input$statsOnOff == 1) {
MSdata <- MS_check()
maxMSLen <- length(MSdata$Year)
 for(im in 1:maxMLen) {
  for(iq in 1:maxMSLen){
   if(datafix$Year[im] == MSdata$Year[iq] & datafix$Month[im] == MSdata$Month[iq] &
      datafix$Hour[im] == MSdata$Hour[iq]) {
       Meta_MS[im] <- MSdata$FlagMS[iq]
   }
  }
 
if(length(Meta$MetaI[im]) == 0 | is.na(Meta$MetaI[im])){
 if(Meta_MS[im] == "Fail"){
     if(input$statused == 1) Meta$MetaI[im] <- "qc=Mean"
     if(input$statused == 2) Meta$MetaI[im] <- "qc=Sum"
 } 
} else {
 if(Meta_MS[im] == "Fail"){
     if(input$statused == 1) Meta$MetaI[im] <- paste(Meta$MetaI[im],"qc=Mean", sep = "|")
     if(input$statused == 2) Meta$MetaI[im] <- paste(Meta$MetaI[im],"qc=Sum", sep = "|")}
}}
Meta <- cbind(Meta,Meta_MS)
}}

#if(input$check5) {}

if(sun_in == TRUE) {

Meta_Sun <- get_sunlight()$FlagSun
Meta_Sun_1h <- get_sun_1h()$flagL
sunData <- meta_cal()$Meta_S

if(input$timeperiod == "sub-daily"){
 for(il in 1:maxMLen){
  if(length(Meta$MetaI[il]) == 0 | is.na(Meta$MetaI[il])){
   if(Meta_Sun_1h[il] == "Fail") Meta$MetaI[il] <- "qc=max_1h_sun"
   if(sunData[il] == "Fail") Meta$MetaI[il] <- "qc=max_sun"
  } else {
   if(Meta_Sun_1h[il] == "Fail") Meta$MetaI[il] <- paste(Meta$MetaI[il],"qc=max_1h_sun", sep = "|")
   if(sunData[il] == "Fail") Meta$MetaI[il] <- paste(Meta$MetaI[il],"qc=max_sun", sep = "|")
   }
 }
 Meta <- cbind(Meta,Meta_Sun_1h)
} else {
 for(il in 1:maxMLen){
  if(length(Meta$MetaI[il]) == 0 | is.na(Meta$MetaI[il])){
   if(Meta_Sun[il] == "Fail") Meta$MetaI[il] <- "qc=max_sun"
  } else {
   if(Meta_Sun[il] == "Fail") Meta$MetaI[il] <- paste(Meta$MetaI[il],"qc=max_sun", sep = "|")}
 }
 Meta <- cbind(Meta,Meta_Sun)
}

}
return(Meta)
})

## Mean or Sum (MS) check calculations
MS_check <- reactive({
meanSum <- c()
if(input$statsOnOff == 1) {
  mscheck <- TRUE
  MS_C <- input$check4
  if(length(MS_C) == 0) MS_C <- FALSE
  if(MS_C) mscheck <- TRUE else mscheck <- FALSE
  if(mscheck == TRUE) meanSum <- MS.check(fixStats(),get_stat(), statUse = input$statused, statVal = input$msDif)
}
return(meanSum)
})


## Wrong, correct values from tests




#
# Graphics tab 
#
## Tables
output$plottabels <- DT:: renderDataTable({
  
  data_plot <- fixData()
  iDate <- Year_month_day()
  g5 <- input$gyears
  g6 <- input$gmonths
  g7 <- input$ghours
  g8 <- as.Date(input$dateRange)
  data_plot <- cbind(iDate,data_plot)
  if(length(data_plot) == 0) return()
  if(length(g5) == 0) g5 <- "All"
  if(length(g6) == 0) g6 <- "All"
  if(length(g7) == 0) g7 <- "All" 
  if(g5 != "All") data_plot <- data_plot[data_plot$Year == input$gyears,]
  if(g6 != "All") data_plot <- data_plot[data_plot$Month == input$gmonths,]
  if(g7 != "All") data_plot <- data_plot[data_plot$Hour == input$ghours,]
  if(g8[1] != Sys.Date() & g8[2] != Sys.Date()) {
    data_plot <- data_plot[data_plot$iDate >= input$dateRange[1] & data_plot$iDate <= input$dateRange[2],]} 
  data_plot <- data_plot[-1]
  data_plot <- data_plot[1:length(colnames(data_plot))-1]
  DT:: datatable(
    data_plot, 
    options = list(searching = FALSE),
    rownames = FALSE)
  
})

output$plottabels1 <- DT:: renderDataTable({
  
  data_plot1 <- fixData()
  jDate <- Year_month_day()
  a5 <- input$dmyears
  a6 <- input$dmmonths
  a7 <- input$dmhours
  a8 <- as.Date(input$dateRange1)
  data_plot1 <- cbind(jDate,data_plot1) 
  if(length(data_plot1) == 0) return()
  if(length(a5) == 0) a5 <- "All"
  if(length(a6) == 0) a6 <- "All"
  if(length(a7) == 0) a7 <- "All" 
  if(a5 != "All") data_plot1 <- data_plot1[data_plot1$Year == input$dmyears,]
  if(a6 != "All") data_plot1 <- data_plot1[data_plot1$Month == input$dmmonths,]
  if(a7 != "All") data_plot1 <- data_plot1[data_plot1$Hour == input$dmhours,]
  if(a8[1] != Sys.Date() & a8[2] != Sys.Date()) {
    data_plot1 <- data_plot1[data_plot1$ADate >= input$dateRange1[1] & data_plot1$ADate <= input$dateRange1[2],]}
  data_plot1 <- data_plot1[-1]
  data_plot1 <- data_plot1[1:length(colnames(data_plot1))-1]
  DT:: datatable(
    data_plot1, 
    options = list(searching = FALSE),
    rownames = FALSE)
  
})
#
#plot functions 
#
## Min max for sliders plot on histogram graph

output$forplot <- renderUI({
  plotValue <- fixData()$Value
  minplot <- 0 
  maxplot <- 1000
  if (length(plotValue) != 0){
    minplot <- ceiling(min(fixData()$Value))
    maxplot <- floor(max(fixData()$Value))   
  }
  
  sliderInput(
    inputId = "plotrange",
    label = "Variable interval values:",
    min = minplot,
    max = maxplot,
    value = c(minplot,maxplot),
    width = "100%")
})

output$graph_get_yrs <- renderUI({
  selectInput("gyears","Year", choices = c("All", numY()))
})
output$hourRange <- renderUI({
  selectInput("ghours","Hour", choices = c("All", numH()))
})
output$dev_get_yrs <- renderUI({
  selectInput("dmyears","Year", choices = c("All", numY()))
})
output$hourRange1 <- renderUI({
  selectInput("dmhours","Hour", choices = c("All", numH()))
})

Hist_P <- reactive({
  DataPlot <- fixData()
  if(length(DataPlot) == 0) return()
  sizeData <- input$plotrange
  DataPlot <- DataPlot[DataPlot$Value > sizeData[1] & DataPlot$Value < sizeData[2],]
  qplot(DataPlot$Value,
        geom = "histogram",
        binwidth = 1,
        main = paste("Histogram graphic of",vardesc()[1],sep = " "),
        xlab = metData()$val[metData()$opts == "Vbl"],
        ylab = "Frequency",
        fill = I("yellow"),
        col = I("red"),
        alpha = I(0.5))
})

Temporal <- reactive({
  DataP2 <- fixData()
  Date <- Year_month_day()
  g1 <- input$gyears
  g2 <- input$gmonths
  g3 <- input$ghours
  g4 <- as.Date(input$dateRange)
  if(length(DataP2) == 0) return()
  if(length(Date) == 0) return()
  if(length(g1) == 0) g1 <- "All"
  if(length(g2) == 0) g2 <- "All"
  if(length(g3) == 0) g3 <- "All"
  DataP2 <- cbind(Date,DataP2)
  if(g1 != "All") DataP2 <- DataP2[DataP2$Year == input$gyears,]
  if(g2 != "All") DataP2 <- DataP2[DataP2$Month == input$gmonths,]
  if(g3 != "All") DataP2 <- DataP2[DataP2$Hour == input$ghours,]
  if(g4[1] != Sys.Date() & g4[2] != Sys.Date()) {
    DataP2 <- DataP2[DataP2$Date >= input$dateRange[1] & DataP2$Date <= input$dateRange[2],]}
  
  ggplot(DataP2) +
    aes(x = Date, y = Value) +
    geom_line(show.legend = TRUE, col = "red") +
    labs(title = paste("Timeline graphic of",vardesc()[1],sep = " "), x = "Date", y = vardesc()[1]) 
})

Anomaly <- reactive({
  Data3 <- fixData()
  ADate <- Year_month_day()
  deValue <- devMean()
  a1 <- input$dmyears
  a2 <- input$dmmonths
  a3 <- input$dmhours
  a4 <- as.Date(input$dateRange1)
  if(length(Data3) == 0) return()  
  if(length(deValue) == 0) return()
  if(length(a1) == 0) a1 <- "All"
  if(length(a2) == 0) a2 <- "All"
  if(length(a3) == 0) a3 <- "All"

  Data3 <- cbind(fixData(),deValue,ADate)

  if(a1 != "All") Data3 <- Data3[Data3$Year == input$dmyears,]
  if(a2 != "All") Data3 <- Data3[Data3$Month == input$dmmonths,]
  if(a3 != "All") Data3 <- Data3[Data3$Hour == input$dmhours,]
  if(a4[1] != Sys.Date() & a4[2] != Sys.Date()) {
    Data3 <- Data3[Data3$ADate >= input$dateRange1[1] & Data3$ADate <= input$dateRange1[2],]}
    
  ggplot(Data3) +
    aes(x = ADate, y = deValue) +
    geom_col(show.legend = TRUE, col = "red") +
    labs(title = paste("Desviation from mean of",vardesc()[1],sep = " "), x = "Date", y = "Desviation from mean") 
})


## Histogram
output$histGraph <- renderPlot({
 Hist_P()
})
## Temporal  
output$plotGraph <- renderPlot({
 Temporal()
})
## Deviation from mean
output$DesvMean <- renderPlot({
  Anomaly()
})
#
# Help tab
#
output$upload1 <- renderImage({
  return(list(
    src = "./img/upload_data_set.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "upload1"
  ))
}, deleteFile = FALSE)
output$upload2 <- renderImage({
  return(list(
    src = "./img/upload_metadata.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "upload2"
  ))
}, deleteFile = FALSE)
output$opt1 <- renderImage({
  return(list(
    src = "./img/options_header.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "option1"
  ))
}, deleteFile = FALSE)
output$opt2 <- renderImage({
  return(list(
    src = "./img/options_header_correct.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "option2"
  ))
}, deleteFile = FALSE)
output$opt3 <- renderImage({
  return(list(
    src = "./img/options_units.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "option3"
  ))
}, deleteFile = FALSE)
output$meta <- renderImage({
  return(list(
    src = "./img/metadata.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "metadata"
  ))
}, deleteFile = FALSE)
output$staPub <- renderImage({
  return(list(
    src = "./img/Stats.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "Stats"
  ))
}, deleteFile = FALSE)
output$QCP <- renderImage({
  return(list(
    src = "./img/qc_sun.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "QCP"
  ))
}, deleteFile = FALSE)
output$resSun <- renderImage({
  return(list(
    src = "./img/results.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "Results"
  ))
}, deleteFile = FALSE)
output$gph1 <- renderImage({
  return(list(
    src = "./img/graphics_hist.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "Histogram"
  ))
}, deleteFile = FALSE)
output$gph2 <- renderImage({
  return(list(
    src = "./img/graphics_time2.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "Temporal"
  ))
}, deleteFile = FALSE)
output$gph3 <- renderImage({
  return(list(
    src = "./img/time_graf_exemplo.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "Temporal"
  ))
}, deleteFile = FALSE)
output$gph4 <- renderImage({
  return(list(
    src = "./img/dev_graf_exemplo.jpg",
    contentType = "image/jpeg",
    width = "100%",
    alt = "Temporal"
  ))
}, deleteFile = FALSE)

#
# Download files
#  

output$downloadData <- downloadHandler(
    
 filename = function(){
   
  if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
   filename <- "Stats"
  } else {
   filename <- paste("stats",metData()$val[metData()$opts == "Vbl"],sep = "_")       
  }
  paste(filename,input$fileTypeTab1,sep = ".")
  
 },
    
 content = function(com){

  data_st0 <- get_stat()
  if(input$years != "All") data_st0 <- data_st0[data_st0$Year == input$years,]
  if(input$months != "All") data_st0 <- data_st0[data_st0$Month == input$months,]
  if(input$fileTypeTab1 == "csv") sepchoose1 <- "," else sepchoose1 <- "\t"
  write.table(data_st0, com, sep = sepchoose1, quote = FALSE, row.names = FALSE)

 }
)

output$downloadTimeTable <- downloadHandler(
  
  filename = function(){
    
    if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
      filename <- "tab_plot"
    } else {
      filename <- paste("tab_plot",metData()$val[metData()$opts == "Vbl"],sep = "_")       
    }
    paste(filename,input$fileTypeTab,sep = ".")
    
  },
  
  content = function(com){
    
    data_plot_tab <- fixData()
    if(input$gyears != "All") data_plot_tab <- data_plot_tab[data_plot_tab$Year == input$gyears,]
    if(input$gmonths != "All") data_plot_tab <- data_plot_tab[data_plot_tab$Month == input$gmonths,]
    if(input$ghours != "All") data_plot_tab <- data_plot_tab[data_plot_tab$Hour == input$ghours,]
    if(input$fileTypeTab == "csv") sepchoose <- "," else sepchoose <- "\t"
    write.table(data_plot_tab, com, sep = sepchoose, quote = FALSE, row.names = FALSE)
    
  }
)

output$downloadDevTable <- downloadHandler(
  
  filename = function(){
    
    if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
      filename <- "DevMean_plot"
    } else {
      filename <- paste("DevMean_plot", metData()$val[metData()$opts == "Vbl"], sep = "_")       
    }
    paste(filename,input$fileTypeDev,sep = ".")
    
  },
  
  content = function(com){
    
    data_plot_dev <- fixData()
    if(input$dmyears != "All") data_plot_dev <- data_plot_dev[data_plot_dev$Year == input$dmyears,]
    if(input$dmmonths != "All") data_plot_dev <- data_plot_dev[data_plot_dev$Month == input$dmmonths,]
    if(input$dmhours != "All") data_plot_dev <- data_plot_dev[data_plot_dev$Hour == input$dmhours,]
    if(input$fileTypeDev == "csv") dmchoose2 <- "," else dmchoose2 <- "\t"
    write.table(data_plot_dev, com, sep = dmchoose2, quote = FALSE, row.names = FALSE)
    
  }
) 
output$downloadRawTable <- downloadHandler(
  
  filename = function(){
    
    rawType <- input$fileTypeRaw
    if(input$rawSeffile) rawType <- "tsv"
    if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
      filename <- "qc_table"
    } else {
      filename <- paste("qc",metData()$val[metData()$opts == "Vbl"],sep = "_")       
    }
    paste(filename,rawType,sep = ".")
    
  },
  
  content = function(com){
    
    file_append <- FALSE
    data_write <- fixData()
    data_write$Meta <- checkMeta()$MetaI
    if(input$fileTypeRaw == "csv") rawchoose <- "," else rawchoose <- "\t"
    if(input$rawSeffile) {
      write.table(metData(), com, sep = rawchoose, quote = FALSE, row.names = FALSE)
      file_append <- TRUE
    }
    write.table(data_write, com, append = file_append, sep = rawchoose, quote = FALSE, row.names = FALSE)
    
  }
)


output$downloadHist <- downloadHandler(
  
  filename = function(){
    
    if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
      filename <- "Hist"
    } else {
      filename <- paste("Hist",metData()$val[metData()$opts == "Vbl"],sep = "_")       
    }
    paste(filename,input$filePlotType,sep = ".")
    
  },
  
  content = function(com1){
    
    ggsave(com1, plot = Hist_P(), device = input$filePlotType, width = 20, height = 10, units = "cm")

  }
)

output$downloadTimePlot <- downloadHandler(
  
  filename = function(){
    
    if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
      filename <- "Time"
    } else {
      filename <- paste("Time",metData()$val[metData()$opts == "Vbl"],sep = "_")       
    }
    paste(filename,input$fileTypeTemp,sep = ".")
    
  },
  
  content = function(com1){
    
    ggsave(com1, plot = Temporal(), device = input$fileTypeTemp, width = 20, height = 10, units = "cm")
    
  }
)

output$downloadDev <- downloadHandler(
  
  filename = function(){
    
    if(length(metData()$val[metData()$opts == "Vbl"]) == 0){
      filename <- "DevMean"
    } else {
      filename <- paste("DevMean",metData()$val[metData()$opts == "Vbl"],sep = "_")       
    }
    paste(filename,input$fileTypeDev1,sep = ".")
    
  },
  
  content = function(com1){
    
    ggsave(com1, plot = Anomaly(), device = input$fileTypeDev1, width = 20, height = 10, units = "cm")
    
  }
)


} 

# End of shinyApp
shinyApp(ui = ui, server = server)
