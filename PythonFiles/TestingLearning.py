#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 30 10:25:13 2018

This file is created in order to test ideas about the new learning system that will be implemented
in bluespec 
@author: babu_wanyeki
"""


outputFile="/Users/babu_wanyeki/Documents/MIT_GITHUB/Microprocessor_Design/Output.txt"


file=open(outputFile,"r")
data=file.readlines()
print(data)

file.close()