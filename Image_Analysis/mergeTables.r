library(readxl)
library(tidyverse)

lookupTable <- readxl(tissue_im_test.xlsx, sheet = "MLI_new", range="A:E")

