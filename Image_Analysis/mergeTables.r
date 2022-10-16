library(readxl)
library(tidyverse)
library(writexl)

setwd("/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis")

table2 <- read_excel("tissue_image_stats.xlsx")
table1 <- read_excel("image_data_complete.xlsx")

#### store look-up table ####
lookupTable <- read_excel("tissue_im_test.xlsx", sheet = "MLI_new", range="A1:E87")


#### read table ####

show(lookupTable)
select(lookupTable,1,5,2,3,4)
colnames(lookupTable)[1] <- "slide"
colnames(lookupTable)[3] <- "ID"
colnames(lookupTable)[5] <- "MLI (um)"

lookupTable <- lookupTable[-c(48:nrow(lookupTable)),]
# lookupTable2[42,1] <- 39
table1 = subset(tissue_image_data, select = -c(11:14) )
# - ####

#### completeTable <- tissue_image_data[lookupTable, ] ####
completeTable <- merge(table1, lookupTable, on = c("slide"), all= TRUE)
completeTable <- merge(table1,table2,by.x=c("slide","subslide"),by.y=c("c","b"))
completeTable <- merge(table1, table2, on = c("slide","subslide"))
#completeTable["AN Tx"] <- completeTable["AN Tx"].tissue_image_data %?% completeTable["AN Tx"].lookupTable2
#### ####
completeTable <- table1[table2, on = "slide"]

# ####
completeTable <- left_join(table1,table2, on = "slide")


write_xlsx(completeTable,"/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis/image_data_complete.xlsx")
