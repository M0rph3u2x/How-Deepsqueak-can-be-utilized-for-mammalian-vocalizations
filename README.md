# R-DS_Filter
Supplement program to DeepSqueak (Filters and cleans up detector output)


Introduction

The function termed “R-DS Filter” processes the output tables using the output formats, raven (*.txt) and excel (*.xlsx), 
obtained from the detection analysis on DeepSqueak. Both output formats slightly differ in the on- and offset values of the calls.  
DeepSqueak creates a detection box around each detected call within the detection GUI. The detection box is longer and wider, than 
the detected call. In the raven format on- and offset values of the detection boxes were stored, while in the xlsx format the on- 
and offset of the calls were saved. This difference has a significant impact on the filter quality of the “R-DS Filter” as the 
broader on- and offsets values within the raven format can overlap in closely positioned syllables. As the R-DS Filter reduces 
duplicate syllable detections as well as merges overlapping detections into a single syllable entry this can lead to falsely fusing 
short calls into a bigger call when only the raven data is used in the filtering process. In contrast, using only the xlsx data will 
yield in very narrow detection boxes when the filtered data is uploaded again into DeepSqueak. Therefore, we recommend applying 
the R-DS Filter simultaneously on both formats (raven & xlsx). Here, the xlsx data is used to filter out false positive detections, 
while the raven data is used to create an output file with better detection boxes. As .xlsx tables cannot be loaded into DeepSqueak (v 2.0) 
the data filtered by our R function is always saved as raven text file (“modraven”) which can be again uploaded to DeepSqueak.

How to run R-DS_Filter

Installation ----------------------------------------------------------------------------------

 In order to run the script, the R interpreter needs to be installed on the computer:
 https://www.r-project.org/

 I advise to run the script within RStudio (an excellent editor for R based scripts):
 https://rstudio.com/products/rstudio/

 Before running the script three modules needs to be installed in order to run the manuscript.
 To do so, uncomment the lines 92-94 and execute them ("Code"->"Comment/Uncomment lines" 
 in the menu (top left within editor window))

 Install packages (these packages are mandatory for the can be installed on your computer)
 install.packages("readxl")
 install.packages("dplyr")
 install.packages("reader")

 After installing the packages you can comment them again, mark lines 92-94 select
 "Code"->"Comment/Uncomment lines" in the menu (top left within editor window).
 As the packages are now installed on your computer you do not need to repeat this step
 again!

 In order to let the program know, where it is located you have to adapt the path in line 106
 to the location where "R-DS-Filter.R" is stored on your computer.
 Adapt path to your location:
 R.Directory = "C:/Users/tjard/OneDrive/Desktop/DS_Filter/"

 Once, you have customized the path of the R-DS_Filter script no further
 customization is needed and you are ready to go! :)

 IMPORTANT: It is mandatory, that "R-DS_Filter.functions.R" is located in the 
 same directory as the core script, as it defines the functions used within the
 main script (R-DS_Filter.R)!

 In order to run the script press "Strg + A" (Selects the complete script),
 then press "Strg + enter" (this will execute the script!)
#------------------------------------------------------------------------------------------------

Running the script

Query files should be stored in a folder called "DS_In". The location of this 
folder must be the same as the location of the script!

Example: C:/Users/tjard/OneDrive/Desktop/DS_Filter/R-DS_Filter.R
         C:/Users/tjard/OneDrive/Desktop/DS_Filter/DS_In

The input can be a Raven file (*.txt), an Excel file (*.xlsx) or both!
If both is the case the raven and excel file must have the same name:

Example: 00_chain_Short whistle_good_09032020_multi3_bal_10032020.txt
	 00_chain_Short whistle_good_09032020_multi3_bal_10032020.xlsx


The filtered data is stored in "Raven_Out" (Folder is created by the script!)

In order to run the script press "Strg + A" (Selects the complete script),
then press "Strg + enter" (this will execute the script!)
