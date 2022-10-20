#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 15 14:50:16 2022

@author: gess

"""
import pandas as pd
import sys


# add the excel sheet path
sys.path.append
("/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis")
sys.path.append("")
# read the look up table (only the relevant values)
labelsTable = pd.read_excel('tissue_im_test.xlsx',
                            sheet_name='MLI_new',
                            index_col=0, usecols=("A:E"))


world = {"af": 30.55,
         "alb": 2.77,
         "alg": 39.21}

for key, value in world.items():
    print(key + " -- " + str(value))
  
# For loop over np_baseball
for x in np.nditer(np_baseball) :
    print(x)
    
for lab, row in cars.iterrows() :
    cars.loc[lab, "COUNTRY"] = (row["country"].upper())    
    cars["COUNTRY"] = cars["country"].apply(str.upper)
    
    
# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Iterate over rows of cars
for lab, row in cars.iterrows() :
    print(lab)
    print(row)
    
# Adapt for loop
for lab, row in cars.iterrows() :
    print(str(row['country'])+" : "+str(row['cars_per_cap']))


np.random.seed(123)

# Use randint() to simulate a dice
print(np.random.randint(1,7))
