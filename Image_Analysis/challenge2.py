#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Oct 17 15:55:47 2022

@author: tfai
"""

def solution(N):
    # write your code in Python 3.8.10
    
    Nbin = bin(N)
    
    Nbinstr = str(Nbin)

    Ngap = list()
    Ngapi = 0
    
    for i in range(3,len(Nbinstr)):
        
        if int(Nbinstr[i]) == 0:
            Ngapi = Ngapi + 1
            
        else:
            Ngap.append(Ngapi)
            Ngapi = 0
    if Ngap != []:
        return(max(Ngap))
    else:
        return(0)
        
print(solution(1376796946))    
        
        