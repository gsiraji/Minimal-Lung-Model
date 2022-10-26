library(readxl)
library(tidyverse)
library(writexl)

#### set working directory ####

setwd("/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis")

#### get the image data table and look-up table ####
image_data_table <- read_excel("tissue_image_data_oldMLI.xlsx")

# store look-up table #
lookupTable <- read_excel("tissue_im_test.xlsx", sheet = "MLI_old")


#### rearrange, relabel, and organize the look-up table ####
show(lookupTable)
lookupTable <- select(lookupTable,5,3,1,4,6,7,2)
colnames(lookupTable)[1] <- "slide"
colnames(lookupTable)[3] <- "ID"
colnames(lookupTable)[5] <- "MLI (um)"
colnames(lookupTable)[7] <- "day"

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
completeTable <- merge(table1, lookupTable, on = c("slide","day"), all= TRUE)
completeTable <- merge(table1,table2,by.x=c("slide","subslide"),by.y=c("c","b"))
completeTable <- merge(table1, table2, on = c("slide","subslide"))
#completeTable["AN Tx"] <- completeTable["AN Tx"].tissue_image_data %?% completeTable["AN Tx"].lookupTable2
#### ####
completeTable <- table1[table2, on = "slide"]

# ####
completeTable <- left_join(table1,table2, on = "slide")


write_xlsx(completeTable,"/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis/image_data_complete.xlsx")
