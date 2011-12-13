#!/usr/bin/env python
import sys
import fileProcess
import math

inputFileName = sys.argv[1]
i = int(sys.argv[2])
outputFileName = sys.argv[3]

N, amLines = fileProcess.deal_input(inputFileName)

sumN = list()
for j in amLines:
    kRange = tuple(set(N[i]) & set(N[j]))
    eachsum = 0
    for k in kRange:
        eachsum += (float(1) / math.log(len(N[k])))
    sumN += [eachsum]


fileProcess.deal_output(amLines, sumN, outputFileName)
