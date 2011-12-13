#!/usr/bin/env python

import sys
sys.path.append('../proximity-measures')
sys.path.append('../proximity-simple')
import fileProcess
import math

#Label file
inputFileName1 = sys.argv[2]
#Link file
inputFileName2 = sys.argv[1]
outputFileName = sys.argv[3]

N, amLines = fileProcess.deal_input(inputFileName2)
C = fileProcess.deal_input2(inputFileName1)
NC = fileProcess.deal_input3(inputFileName1)
m = fileProcess.countLine(inputFileName2)
S_label = 1
S_bar_label = 0
S = tuple(C[S_label])
S_bar = tuple(C[S_bar_label])

sumadjIwithJ = 0
sumDI = 0
sumSLinks = 0
for i in S:
    nodeLine = tuple(N[i])    
    for node in nodeLine:
        #Sum the number of j in S_bar and is the neighbor of i 
        if NC[node] == S_bar_label:
            sumadjIwithJ += 1
        elif NC[node] == S_label:
            sumSLinks += 1
    sumDI += len(nodeLine)

sumDJ = 0
sumS_barLinks = 0
for j in S_bar:
    nodeLine = tuple(N[j])
    for node in nodeLine:
        if NC[node] == S_bar_label:
            sumS_barLinks += 1
    sumDJ += len(N[j])

Modularity_Q = (float(sumSLinks) / m - (math.pow((float(sumDI) / (2 * m)),2))) + (float(sumS_barLinks) / m - (math.pow((float(sumDJ) / (2 * m)),2)))
qualDict = dict()
qualDict['Ncut_S'] = float(sumadjIwithJ) / sumDI + float(sumadjIwithJ) / sumDJ
qualDict['Conductance_S'] = float(sumadjIwithJ) / (min(sumDI, sumDJ))
qualDict['Modularity_Q'] = Modularity_Q

fileProcess.deal_output2(qualDict, outputFileName)

