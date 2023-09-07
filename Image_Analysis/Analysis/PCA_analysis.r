library("FactoMineR")
library(readxl)
library(tidyverse)
library(writexl)
library(latex2exp)
#### read the excel sheet containing the summary statistics of the optimization results and inflammation metrics ####



df = read_excel("Archive/cat_sum_inf_opt.xlsx")

res.pca <- PCA(df[4:20])
summary(res.pca)

> coord_data =  res.pca[["var"]][["coord"]]
> write.csv(coord_data, "coord.csv", row.names=FALSE)

fviz_pca_var(res.pca, col.var = "black")


res.mca = MCA(df[,4:20], graph=TRUE)
res.hcpc = HCPC(res.pca)

library("factoextra")
eig.val <- get_eigenvalue(res.pca)

res.hcpc$desc.var$test.chi2
res.hcpc$desc.var$category

eig.val
fviz_pca_ind(res.pca,
             geom.ind = "point", # show points only (nbut not "text")
             col.ind = df$group, # color by groups
             palette = c("#00AFBB", "#E7B800","#FC4E07","#868686FF","#5E3C99","#FDB863"),
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


citation(package = "FactoMineR")
