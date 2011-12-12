#!/usr/bin/env python
import sys
import fileProcess

inputFileName = sys.argv[1]
i = int(sys.argv[2])
outputFileName = sys.argv[3]


N, amLines = fileProcess.deal_input(inputFileName)

J=list()
for j in amLines:
    ijUnion=set(N[i])|set(N[j])
    ijAnd=set(N[i])&set(N[j])
    J+=[float(len(ijAnd))/float(len(ijUnion))]

fileProcess.deal_output(amLines, J, outputFileName)
