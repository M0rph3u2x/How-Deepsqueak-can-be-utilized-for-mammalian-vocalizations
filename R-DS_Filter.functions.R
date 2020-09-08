#-----------------------------------------------------------------------------------------
#Functions (BEGIN) -----------------------------------------------------------------------
#-----------------------------------------------------------------------------------------

#Start-Function---------------------------------------------------------------------------
#Function No. 1B

# 1) Delete signal detections with time frames encapsulated in other detections
# 2) Merge overlapping time frames

filter_all <- function(dataset1,dataset2){
  #Delete signal detections with time frames encapsulated in other detections
  for(i in length(dataset1$`Begin Time (s)`):1){
    for(ii in (length(dataset1$`Begin Time (s)`)-1):1){
      if(dataset1$`Begin Time (s)`[i]>dataset1$`Begin Time (s)`[ii] && (dataset1$`End Time (s)`[i]<dataset1$`End Time (s)`[ii])){
        dataset1 <- dataset1[-c(i),]
        dataset2 <- dataset2[-c(i),]
        break
      }       
    }
  }
  
  #Merge overlapping time frames
  for(i in length(dataset1$`Begin Time (s)`):1){
    for(ii in (length(dataset1$`Begin Time (s)`)-1):1){
      if(dataset1$`Begin Time (s)`[i]<dataset1$`Begin Time (s)`[ii] && dataset1$`End Time (s)`[i]>dataset1$`Begin Time (s)`[ii] && dataset1$`End Time (s)`[i]<dataset1$`End Time (s)`[ii] || dataset1$`Begin Time (s)`[i]>dataset1$`Begin Time (s)`[ii] && dataset1$`Begin Time (s)`[i]<dataset1$`End Time (s)`[ii] && dataset1$`End Time (s)`[i]>dataset1$`End Time (s)`[ii]){
        if(dataset1$`Begin Time (s)`[i]<dataset1$`Begin Time (s)`[ii]){
          dataset1$`Begin Time (s)`[ii] <- dataset1$`Begin Time (s)`[i]
          dataset2$`Begin.Time..s.`[ii] <- dataset2$`Begin.Time..s.`[i]
        }
        if(dataset1$`End Time (s)`[i]>dataset1$`End Time (s)`[ii]){
          dataset1$`End Time (s)`[ii] <- dataset1$`End Time (s)`[i]
          dataset2$`End.Time..s.`[ii] <- dataset2$`End.Time..s.`[i]
        }
        if(dataset1$`Low Freq (kHz)`[i]<dataset1$`Low Freq (kHz)`[ii]){
          dataset1$`Low Freq (kHz)`[ii] <- dataset1$`Low Freq (kHz)`[i]
          dataset2$`Low.Freq..Hz.`[ii]  <- dataset2$`Low.Freq..Hz.`[i]
        }
        if(dataset1$`High Freq (kHz)`[i]>dataset1$`High Freq (kHz)`[ii]){
          dataset1$`High Freq (kHz)`[ii] <- dataset1$`High Freq (kHz)`[i]
          dataset2$`High.Freq..Hz.`[ii]  <- dataset2$`High.Freq..Hz.`[i]
        }
        dataset1 <- dataset1[-c(i),]
        dataset2 <- dataset2[-c(i),]
        break
      }       
    }
  }    
  return(list(dataset1,dataset2))
}

#End-Function-----------------------------------------------------------------------------

#Start-Function---------------------------------------------------------------------------
#Function No. 2B

# 1) Delete signal detections with time frames encapsulated in other detections
# 2) Merge overlapping time frames

filter_xlsx <- function(dataset1){
  #Delete signal detections with time frames encapsulated in other detections
  for(i in length(dataset1$`Begin Time (s)`):1){
    for(ii in (length(dataset1$`Begin Time (s)`)-1):1){
      if(dataset1$`Begin Time (s)`[i]>dataset1$`Begin Time (s)`[ii] && (dataset1$`End Time (s)`[i]<dataset1$`End Time (s)`[ii])){
        dataset1 <- dataset1[-c(i),]
        break
      }       
    }
  }
  
  #Merge overlapping time frames
  for(i in length(dataset1$`Begin Time (s)`):1){
    for(ii in (length(dataset1$`Begin Time (s)`)-1):1){
      if(dataset1$`Begin Time (s)`[i]<dataset1$`Begin Time (s)`[ii] && dataset1$`End Time (s)`[i]>dataset1$`Begin Time (s)`[ii] && dataset1$`End Time (s)`[i]<dataset1$`End Time (s)`[ii] || dataset1$`Begin Time (s)`[i]>dataset1$`Begin Time (s)`[ii] && dataset1$`Begin Time (s)`[i]<dataset1$`End Time (s)`[ii] && dataset1$`End Time (s)`[i]>dataset1$`End Time (s)`[ii]){
        if(dataset1$`Begin Time (s)`[i]<dataset1$`Begin Time (s)`[ii]){
          dataset1$`Begin Time (s)`[ii] <- dataset1$`Begin Time (s)`[i]
        }
        if(dataset1$`End Time (s)`[i]>dataset1$`End Time (s)`[ii]){
          dataset1$`End Time (s)`[ii] <- dataset1$`End Time (s)`[i]
        }
        if(dataset1$`Low Freq (kHz)`[i]<dataset1$`Low Freq (kHz)`[ii]){
          dataset1$`Low Freq (kHz)`[ii] <- dataset1$`Low Freq (kHz)`[i]
        }
        if(dataset1$`High Freq (kHz)`[i]>dataset1$`High Freq (kHz)`[ii]){
          dataset1$`High Freq (kHz)`[ii] <- dataset1$`High Freq (kHz)`[i]
        }
        dataset1 <- dataset1[-c(i),]
        break
      }       
    }
  }    
  return(dataset1)
}


#End-Function-----------------------------------------------------------------------------

#Start-Function---------------------------------------------------------------------------
#Function No. 3B

# 1) Delete signal detections with time frames encapsulated in other detections
# 2) Merge overlapping time frames

filter_raven <- function(dataset2){
  #Delete signal detections with time frames encapsulated in other detections
  for(i in length(dataset2$`Begin.Time..s.`):1){
    for(ii in (length(dataset2$`Begin.Time..s.`)-1):1){
      if(dataset2$`Begin.Time..s.`[i]>dataset2$`Begin.Time..s.`[ii] && (dataset2$`End.Time..s.`[i]<dataset2$`End.Time..s.`[ii])){
        dataset2 <- dataset2[-c(i),]
        break
      }       
    }
  }
  
  #Merge overlapping time frames
  for(i in length(dataset2$`Begin.Time..s.`):1){
    for(ii in (length(dataset2$`Begin.Time..s.`)-1):1){
      if(dataset2$`Begin.Time..s.`[i]<dataset2$`Begin.Time..s.`[ii] && dataset2$`End.Time..s.`[i]>dataset2$`Begin.Time..s.`[ii] && dataset2$`End.Time..s.`[i]<dataset2$`End.Time..s.`[ii] || dataset2$`Begin.Time..s.`[i]>dataset2$`Begin.Time..s.`[ii] && dataset2$`Begin.Time..s.`[i]<dataset2$`End.Time..s.`[ii] && dataset2$`End.Time..s.`[i]>dataset2$`End.Time..s.`[ii]){
        if(dataset2$`Begin.Time..s.`[i]<dataset2$`Begin.Time..s.`[ii]){
          dataset2$`Begin.Time..s.`[ii] <- dataset2$`Begin.Time..s.`[i]
        }
        if(dataset2$`End.Time..s.`[i]>dataset2$`End.Time..s.`[ii]){
          dataset2$`End.Time..s.`[ii] <- dataset2$`End.Time..s.`[i]
        }
        if(dataset2$`Low.Freq..Hz.`[i]<dataset2$`Low.Freq..Hz.`[ii]){
          dataset2$`Low.Freq..Hz.`[ii]  <- dataset2$`Low.Freq..Hz.`[i]
        }
        if(dataset2$`High.Freq..Hz.`[i]>dataset2$`High.Freq..Hz.`[ii]){
          dataset2$`High.Freq..Hz.`[ii]  <- dataset2$`High.Freq..Hz.`[i]
        }
        dataset2 <- dataset2[-c(i),]
        break
      }       
    }
  }    
  return(dataset2)
}

#End-Function-----------------------------------------------------------------------------


#Start-Function---------------------------------------------------------------------------
#Function No. 1A

filter_all_data <- function(ds.xlsx,ds.raven){
  
  #Delete doubles and combine overlapping detections
  dataset <- filter_all(ds.xlsx,ds.raven)
  ds.xlsx <- dataset[[1]] #Extract dataframe(xlsx)  from list
  ds.raven<- dataset[[2]] #Extract dataframe(raven) from list
  rm(dataset)
  
  #Sort ds.xlsx by inset time
  ds.xlsx <- ds.xlsx[order(ds.xlsx$`Begin Time (s)`),]
  
  #Sort ds.raven by inset time
  ds.raven <- ds.raven[order(ds.raven$`Begin.Time..s.`),]
  
  #Adapting selection number & duration to new format
  for(i in 1:length(ds.xlsx$ID)){
    ds.xlsx$ID[i]         <- i
    ds.raven$Selection[i] <- i
    ds.xlsx$`Call Length (s)`[i] <- ds.xlsx$`End Time (s)`[i]-ds.xlsx$`Begin Time (s)`[i]
    ds.raven$`Delta.Time..s.`[i] <- ds.raven$`End.Time..s.`[i]-ds.raven$`Begin.Time..s.`[i]
  }
  return(list(ds.xlsx,ds.raven))
}

#End-Function-----------------------------------------------------------------------------

#Start-Function---------------------------------------------------------------------------
#Function No. 1B

filter_xlsx_data <- function(ds.xlsx){
  
  #Delete doubles and combine overlapping detections
  ds.xlsx <- filter_xlsx(ds.xlsx)
  
  #Sort ds.xlsx by inset time
  ds.xlsx <- ds.xlsx[order(ds.xlsx$`Begin Time (s)`),]
  
  #Adapting selection number & duration to new format
  for(i in 1:length(ds.xlsx$ID)){
    ds.xlsx$ID[i]         <- i
    ds.xlsx$`Call Length (s)`[i] <- ds.xlsx$`End Time (s)`[i]-ds.xlsx$`Begin Time (s)`[i]
  }
  return(ds.xlsx)
}

#End-Function-----------------------------------------------------------------------------

#Start-Function---------------------------------------------------------------------------
#Function No. 1C

filter_raven_data <- function(ds.raven){
  
  #Delete doubles and combine overlapping detections
  ds.raven <- filter_raven(ds.raven)
  
  #Sort ds.raven by inset time
  ds.raven <- ds.raven[order(ds.raven$`Begin.Time..s.`),]
  
  #Adapting selection number & duration to new format
  for(i in 1:length(ds.raven$Selection)){
    ds.raven$Selection[i] <- i
    ds.raven$`Delta.Time..s.`[i] <- ds.raven$`End.Time..s.`[i]-ds.raven$`Begin.Time..s.`[i]
  }
  return(ds.raven)
}

#End-Function-----------------------------------------------------------------------------


#Start-Function---------------------------------------------------------------------------
#Function No. 3A

write.raven <- function(ds.xlsx){
  #Define path for output data
  name_path <- work_path
  name_out  <- "Raven_Out"
  raven_out <- paste(name_path, name_out, sep = "/")
  
  #Create output folder
  dir.create(raven_out, showWarnings = FALSE, recursive=TRUE)
  
  #Output name
  name_out   <- paste("modxlsx_", input.name[x], sep = "") 
  raven_out2 <- paste(raven_out, name_out, sep = "/")
  raven_out2 <- paste(raven_out2,".txt", sep = "")
  
  ds.view <- rep(c("Spectrogram 1"), times = length(ds.xlsx$ID))
  ds.chan <- rep(c(1), times = length(ds.xlsx$ID))
  ds.avgP <- rep(c(1), times = length(ds.xlsx$ID))
  ds.lowF <- c()
  ds.higF <- c()
  ds.delF <- c()
  for(i in 1:length(ds.xlsx$ID)){
    ds.lowF[i] <- ds.xlsx$`Low Freq (kHz)`[i]  *1000
    ds.higF[i] <- ds.xlsx$`High Freq (kHz)`[i] *1000
    ds.delF[i] <- ds.xlsx$`Delta Freq (kHz)`[i]*1000
  }
  
  #Create raven style dataframe
  ds.raven <- data.frame(Selection=ds.xlsx$ID,View=ds.view,Channel=ds.chan,"Begin Time (s)"=ds.xlsx$`Begin Time (s)`,"End Time (s)"=ds.xlsx$`End Time (s)`,"Low Freq (Hz)"=ds.lowF,"High Freq (Hz)"=ds.higF, "Delta Time (s)"=ds.xlsx$`Call Length (s)`, "Delta Freq (Hz)"=ds.delF, "Avg Power Density (dB FS)"=ds.avgP, "Annotation"=ds.xlsx$Label)
  
  #Change Label format
  names(ds.raven)<-c("Selection", "View", "Channel", "Begin Time (s)", "End Time (s)", "Low Freq (Hz)", "High Freq (Hz)", "Delta Time (s)", "Delta Freq (Hz)", "Avg Power Density (dB FS)", "Annotation")
  
  #Write table
  write.table(ds.raven, file=raven_out2, sep="\t", row.names=FALSE, col.names=TRUE,  na="NA", quote=FALSE)     
}

#End-Function-----------------------------------------------------------------------------

#Start-Function---------------------------------------------------------------------------
#Function No. 3B

write.raven2 <- function(ds.raven){
  #Define path for output data
  name_path <- work_path
  name_out  <- "Raven_Out"
  raven_out <- paste(name_path, name_out, sep = "/")
  
  #Create output folder
  dir.create(raven_out, showWarnings = FALSE, recursive=TRUE)
  
  #Output name
  
  name_out   <- paste("modraven_", input.name[x], sep = "") 
  name_out   <- paste(name_out, ".txt", sep = "") 
  raven_out2 <- paste(raven_out, name_out, sep = "/")
  
  #Change Label format
  names(ds.raven)<-c("Selection", "View", "Channel", "Begin Time (s)", "End Time (s)", "Low Freq (Hz)", "High Freq (Hz)", "Delta Time (s)", "Delta Freq (Hz)", "Avg Power Density (dB FS)", "Annotation")
  
  #Write table
  write.table(ds.raven, file=raven_out2, sep="\t", row.names=FALSE, col.names=TRUE,  na="NA", quote=FALSE)     
}

#End-Function-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------
#Functions (END) -------------------------------------------------------------------------
#-----------------------------------------------------------------------------------------