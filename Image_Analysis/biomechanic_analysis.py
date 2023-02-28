#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Jan 10

@author: gess

"""
import pandas as pd
import sys
import seaborn as sns
import matplotlib.pyplot as plt
# =============================================================================
# Read the excel files
# =============================================================================

# add the excel sheet path
sys.path.append("/Users/tfai/Documents/GitHub/Minimal-Lung-Model/Image_Analysis")

# read the look-up tables for day 7 and day 0 (only the relevant columns)
df = pd.read_excel('mean_data_oldMLI.xlsx')

# =============================================================================
# Rearrange, relabel, and organize the look-up tables
# =============================================================================

# rename the columns in look-up tables for consistency
df.rename(columns = {'tissue area fraction_mean':'area_fraction', 'length of tissue (px)_mean':'length','width of tissue (px)_mean':'width', 'MLI_edit pics_mean':'MLI_2'  }, inplace = True)

# subset the columns in look-up tables in the desired order
biomech = df[['day','slide','AN_Tx', 'ID','G_mean','H_mean','Rn_mean','Cst_mean','IC_mean','A_mean','K_mean','Ventilation']]

print(df[['G_mean','A_mean','K_mean','Rn_mean','Cst_mean','MLI_2','width','R_equiv_mean','T_tilde_mean']].corr())

#sns.pairplot(biomech[['day','AN_Tx','G_mean','H_mean','Rn_mean','Cst_mean','IC_mean','A_mean','K_mean']],hue = 'day')

#sns.pairplot(df[['day','Ventilation','AN_Tx','K_mean','Rn_mean','Cst_mean','MLI_2','width','R_equiv_mean']],hue = 'day')

plt.show()
#lookupD0 = lookupD0[['slide','AN_Tx', 'ID','Ventilation','MLI','MLI_edit pics']]


help(seaborn)
