#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 15 14:50:16 2022

@author: gess

"""
import pandas as pd
import sys

# =============================================================================
# Read the excel files
# =============================================================================

# add the excel sheet path
sys.path.append("Documents\Image_Analysis")

# read the look-up tables for day 7 and day 0 (only the relevant columns)
lookupD7 = pd.read_excel('tissue_im_test.xlsx',sheet_name='MLI_old',usecols=("A:G"))

lookupD0 = pd.read_excel('tissue_im_test.xlsx',sheet_name='MLI_old',usecols=("I:O"))

# read the image-processig table
tissueTable = pd.read_excel('tissue_image_data_oldMLI.xlsx',usecols=("A:U"))

# =============================================================================
# Rearrange, relabel, and organize the look-up tables
# =============================================================================

# rename the columns in look-up tables for consistency
lookupD0.rename(columns = {'Slide #.1':'slide', 'Age.1':'day','Animal Number.1':'ID'}, inplace = True)
lookupD0.rename(columns = {'AN Tx.1':'AN Tx', 'Ventilation.1':'Ventilation','MLI.1':'MLI','MLI_edit pics.1':'MLI_edit pics'}, inplace = True)
lookupD7.rename(columns = {'Slide #':'slide', 'Age':'day','Animal Number':'ID'}, inplace = True)

# subset the columns in look-up tables in the desired order
lookupD7 = lookupD7[['slide','AN Tx', 'ID','Ventilation','MLI','MLI_edit pics']]
lookupD0 = lookupD0[['slide','AN Tx', 'ID','Ventilation','MLI','MLI_edit pics']]

# =============================================================================
# Organize the image processing table
# =============================================================================

# remove empty rows
tissueTable = tissueTable.dropna(axis = 0,how = 'all' )
# rename the columns for consistency
tissueTable.rename(columns = {'slide':'day', 'd':'subslide','subslide':'slide'}, inplace = True)

# =============================================================================
# separate out the two data sets: day 7 and day 0 
# the look up table has duplicate indices for day 7 and 0
# the code here merges day 7 and day 0 data tables separately 
# and then concats 
# =============================================================================


tissueTableD7 =  tissueTable[tissueTable['day'] == 7]
tissueTableD0 =  tissueTable[tissueTable['day'] == 0]


# =============================================================================
# merge the two tables separately for day7 and day 0
# =============================================================================

testTable = pd.merge(tissueTableD7, lookupD7, on="slide", how="right")
testTableD0 = pd.merge(tissueTableD0, lookupD0, on="slide", how="right")
# check the data shape. the # of columns should not change
# drop the empty rows
testTableD0 = testTableD0.dropna(axis = 0,how = 'all' )

# =============================================================================
# merge the two day7 and day 0 tables. save it as an excel file.
# =============================================================================
result = pd.concat([testTableD0,testTable])

result.to_excel('image_data_complete_oldMLI.xlsx')


