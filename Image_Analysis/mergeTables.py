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
