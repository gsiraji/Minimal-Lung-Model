library(readxl)
library(tidyverse)
library(writexl)

#### set working directory ####

setwd("/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis")

#### get the image data table and look-up table ####
image_data_table <- read_excel("image_data_complete_oldMLI.xlsx",sheet ="data" , range = "A1:U425")

# store look-up table #
lookupTable <- read_excel("Archive/tissue_im_test.xlsx",sheet ="MLI_old" , range = "B1:G48")


#### rearrange, relabel, and organize the look-up table ####
show(lookupTable)
lookupTable <- select(lookupTable,1,4,2,3,5,6)
colnames(lookupTable)[2] <- "slide"
colnames(lookupTable)[3] <- "ID"
colnames(lookupTable)[5] <- "MLI (um)"
colnames(lookupTable)[1] <- "day"
lookupTable$day <- sub("D","",lookupTable$day)

#### remove NA rows ####
lookupTable <- lookupTable[-c(48:nrow(lookupTable)),]

#### remove NA rows and order by day and slide ####
orderedDataTable<-image_data_table[order(image_data_table['day'],
                  image_data_table['slide'],na.last = NA),]

# remove empty columns ####
orderedDataTable = subset(orderedDataTable, select = -c(22:25) )

# separate into 2 tables, D0 and D7 ####
orderedDataTable = subset(orderedDataTable, select = -c(22:25) )


#### completeTable <- tissue_image_data[lookupTable, ] ####
completeTable <- merge(image_data_table, lookupTable, on = c("indx"), all= TRUE)
completeTable <- merge(table1,table2,by.x=c("slide","subslide"),by.y=c("c","b"))
completeTable <- merge(image_data_table, lookupTable, on = c("day","slide"))
completeTable <- completeTable %>%           # Reorder data frame
  dplyr::select("indx", everything())
completeTable<-completeTable[order(completeTable['indx']),]



#completeTable["AN Tx"] <- completeTable["AN Tx"].tissue_image_data %?% completeTable["AN Tx"].lookupTable2
#### ####
completeTable <- table1[table2, on = "slide"]

# ####
completeTable <- left_join(table1,table2, on = "slide")


write_xlsx(completeTable,"/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis/image_data_complete_oldMLI.xlsx")
