library("FactoMineR")
library(readxl)
library(tidyverse)
library(writexl)

#### set working directory ####

setwd("/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis")

df = read_excel("image_data_complete_oldMLI.xlsx")


res.pca <- PCA(df[5:11])
summary(res.pca)

library("factoextra")
eig.val <- get_eigenvalue(res.pca)

eig.val
fviz_pca_ind(res.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = df$Ventilation, # color by groups
             palette = c("#00AFBB", "#E7B800","#FC4E07","#868686FF"),
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups"
)
names(df)[22] <- 'ANTx'


# Color by cos2 values: quality on the factor map
fviz_pca_var(res.pca, col.var = "cos2",
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"), 
             repel = TRUE # Avoid text overlapping
)


fviz_pca_ind(res.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = df$ANTx, # color by groups
             palette = c("#00AFBB", "#E7B800"),
             addEllipses = TRUE, # Concentration ellipses
             legend.title = "Groups"
)


