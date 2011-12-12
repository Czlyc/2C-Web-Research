#!/usr/bin/env python
import sys
import fileProcess

inputFileName = sys.argv[1]
i = int(sys.argv[2])
outputFileName = sys.argv[3]


N, amLines = fileProcess.deal_input(inputFileName)

lineN = list()
for j in amLines: 
    lineN+=[len(set(N[i])&set(N[j]))]
           
fileProcess.deal_output(amLines, lineN, outputFileName)

