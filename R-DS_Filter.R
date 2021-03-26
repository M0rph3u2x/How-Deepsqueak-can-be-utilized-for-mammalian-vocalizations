#-----------------------------
#  R-DS-Filter v1.0
#-----------------------------

# This Script was developed as part of the research project
# published in 2020:
#
# Using Deepsqueak software for automatic detection and classification of primate vocalizations 
# 
# Daniel Romero-Mujalli1*, Tjard Bergmann1, Axel Zimmermann2, Marina Scheumann1  
# 
# 1 Institute of Zoology, University of Veterinary Medicine Hannover, Hannover, Germany 
# 
# 2 University of Aalen, Aalen, Germany 
#
#
# The script was written by Tjard Bergmann and is not licensed.
# Everyone is free to use or edit it under the rules of creative commons (CC BY-SA).
#
#----------------------------------------------------------------------------------------------

#-----------------------------
# Description
#-----------------------------

# R-DS-Filter is a tool that will reduce the false positive detections of DeepSqueak
# Detectors, which can be created when multiple detectors are run on the same audiofile.
# False positive detections can either be multiple detections of the same signal or
# fragmentation of a long signale by short signal detectors.

# R-DS-Filter will search for detections with duplicate time windows and reduce these
# detections to a single entry in the detection table. R-DS-Filter will also merge over-
# lapping detection events into a single entry. By deleting doublets and merging over-
# lapping detections the number of false positive entries in the detection table is
# highly reduced.

#-----------------------------
# Manual
#-----------------------------

# 1) Input data
# -------------
# R-DS-Filter can process excel (*.xlsx) and raven (*.txt) formatted detection tables.
# These tables can be created within DeepSqueak after a detector has been run on an audio file.
#
# R-DS-Filter can process either excel or raven formatted tables, but best filtering results were
# observed, when both formats were used in combination, as both formats carry slightly altered
# detection values in their tables, which both have advantages and disadvantages. Using both formats
# in parallel enables the program to harness the advantages of both formats while avoiding the disadvantages.
#
# The xlsx file has inset, offset, minimum frequency and maximum frequency values that are very close to
# each signal. The advantage here is that closely positioned signals stay separated and will not be misinterpreted
# as fragmented detections of a long signal by the R-DS-Filter. The disadvantage is that because of the close
# measuring values, the observation frame that is created by DeepSqueak for each signal when the filtered dataset is uploaded to
# DeepSqueak is very narrow and some measuring parameters created by DeepSqueak will be negatively affected by the 
# narrow window.
#
# The raven file has broader inset, offset, minimum frequency and maximum frequency values that are beyond the signal boundaries.
# This is advantages when the table is uploaded into DeepSqueak as some measurements compare background and signal information within
# the observation frame created based on the raven data. However, when filtering false positive detection events with
# R-DS-Filter this broader boundaries can lead to overlaps between onset and offset values of independent signals, which then would be
# falsely interpreted by the R-DS-Filter as fragments of a long signal that needs to be merged into a single signal detection
# event.
# 
# When combining both files in the filter process of the R-DS-Filter the filter will use the more precise
# excel data for sorting out duplicate detections and merging fragmented detections of a single long signal.
# When creating the output data, however, the broader data values within the raven dataset are pulled up. As
# the raven dataset is filtered in parallel when the excel data is screened and filtered, all true duplicates
# and segmented longer signals are corrected in parallel leading to a more accurate filtering of the raven data
# when combined with the excel data then when filtered on its own.
#
# Whatever choice is preferred (raven, xlsx or raven & xlsx) in order to process the files
# they need to be stored into a folder labelled "DS_In" (please, take care that large and lower case
# letters are written exactly as recommended!). The folder needs to be stored in the directory, where the
# R-DS-Filter script is placed!
#
# The output folder is created automatically by the R-DS-Filter when the data is analysed, so you don't
# need to create an output folder.
#
# 2) Running the R-DS_Filter script
# ---------------------------------
# In order to run the script, the R interpreter needs to be installed on the computer:
# https://www.r-project.org/
#
# I advise to run the script within RStudio (an excellent editor for R based scripts):
# https://rstudio.com/products/rstudio/
#
# Before running the script three modules needs to be installed in order to run the manuscript.
# To do so, uncomment the following lines (92-94) and execute them:
#
# Install packages (these packages are mandatory for the can be installed on your computer)
# install.packages("readxl")
# install.packages("dplyr")
# install.packages("reader")
#
# After installing the packages you can comment them again, mark lines 92-94 select
# "Code"->"Comment/Uncomment lines" in the menu (top left within editor window).
# As the packages are now installed on your computer you do not need to repeat this step
# again!

# 1) Get path of R script ----------------------------------------------------------------
# In order to let the program know, where it is located you have to adapt the path in line 106
# to the location where "R-DS-Filter.R" is stored on your computer.

print("Get path of R script")
R.Directory = "C:/Users/tjard/OneDrive/Desktop/DS_Filter/"
FullPath = function(FileName){ return( paste(R.Directory,FileName,sep="") ) }
work_path <- setwd(R.Directory)
work_path <- getwd()

# Once, you have customized the path of the R-DS_Filter script no further
# customization is needed and you are ready to go! :)
#
# IMPORTANT: It is mandatory, that "R-DS_Filter.functions.R" is located in the 
# same directory as the core script, as it defines the functions used within the
# main script (R-DS_Filter.R)!
#
# In order to run the script press "Strg + A" (Selects the complete script),
# then press "Strg + enter" (this will execute the script!)

#-----------------------------------------------------------------------------------------

# 2) Load modules into RStudio
library(readxl) # Load xlsx data into R
library(dplyr)  # Extract column from data.frame
library(reader) # Extract filename/file extension

#-----------------------------------------------------------------------------------------

# 3) Load all necessary functions into the script 
source(FullPath("R-DS_Filter.functions.R"))

#-----------------------------------------------------------------------------------------

# 4) Get XLSX Input File ----------------------------------------------------------------
print("Get XLSX Input File")

#Create correct path to XLSX files:
query_path <- paste(work_path, "DS_In", sep = "/")

#Get names of items in the folder
query_list <- list.files(query_path) 

#----------------------------------------------------------------------------------------

#5) Identify if input data is XLSX or txt (Raven) or both -------------------------------

input.type <- c()
input.name <- c()

#Get extensions of input files
for(i in 1:length(query_list)){
  extension <- get.ext(query_list[i])
  input.type[i] <- extension[[1]]
}
input.type <- unique(input.type)

#Get name of input files
input.name <- c()
for(i in 1:length(query_list)){
  name <- rmv.ext(query_list[i])
  input.name[i] <- name[[1]]
}
input.name <- unique(input.name)

txt.test  <- "txt"  %in% input.type
xlsx.test <- "xlsx" %in% input.type

#----------------------------------------------------------------------------------------

# 6) Process Deepsqueak data

for(x in 1:length(input.name)){
  
  # 6A) xlsx and raven input
  Switch <- 0
  if(txt.test && xlsx.test){
    #Check if this condition is met
    Switch <- 1
    
    #Load xlsx data
    xlsx.path <- paste(query_path, input.name[x], sep = "/")
    xlsx.path <- paste(xlsx.path,  "xlsx", sep = ".")
    ds.xlsx   <- read_excel(xlsx.path)
    
    #Load raven data
    raven.path <- paste(query_path, input.name[x], sep = "/")
    raven.path <- paste(raven.path,  "txt", sep = ".")
    ds.raven   <- read.table(raven.path,sep="\t", header=TRUE)
    
    # 6A1) Filter xlsx/raven data----------------------------------------------------------------------------------
    #     Step 1) Delete signal detections with time frames encapsulated in other detections
    #     Step 2) Merge overlapping time frames
    ds.data <- filter_all_data(ds.xlsx,ds.raven)
    ds.xlsx <- ds.data[[1]]
    ds.raven<- ds.data[[2]]
    
    # 6A2) Create output table with filtered XLSX/Raven data
    
    # Write new raven table (with XLSX Input)
    write.raven(ds.xlsx)
    
    # Write new raven table (with Raven Input)
    write.raven2(ds.raven)
  }
  
  # 6B) Only xlsx input
  
  if(xlsx.test && Switch == 0){
    
    #Load xlsx data
    xlsx.path <- paste(query_path, input.name[x], sep = "/")
    xlsx.path <- paste(xlsx.path,  "xlsx", sep = ".")
    ds.xlsx   <- read_excel(xlsx.path)
    
    # 6B1) Filter xlsx/raven data----------------------------------------------------------------------------------
    #     Step 1) Delete signal detections with time frames encapsulated in other detections
    #     Step 2) Merge overlapping time frames
    ds.xlsx <- filter_xlsx_data(ds.xlsx)
    
    # 6B2) Create output table with filtered XLSX/Raven data
    
    # Write new raven table (with XLSX Input)
    write.raven(ds.xlsx)
  }
  
  # 6C) Only Raven input
  
  if(txt.test && Switch == 0){
    
    #Load raven data
    raven.path <- paste(query_path, input.name[x], sep = "/")
    raven.path <- paste(raven.path,  "txt", sep = ".")
    ds.raven   <- read.table(raven.path,sep="\t", header=TRUE)
    
    # 6C1) Filter xlsx/raven data----------------------------------------------------------------------------------
    #     Step 1) Delete signal detections with time frames encapsulated in other detections
    #     Step 2) Merge overlapping time frames
    ds.raven <- filter_raven_data(ds.raven)
    
    # 6C2) Create output table with filtered Raven data
    
    # Write new raven table (with Raven Input)
    write.raven2(ds.raven)
  }
}

#-----------------------------------------------------------------------------------------

print("Finished processing the data!")
