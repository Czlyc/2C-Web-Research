#!/usr/bin/env python
import sys
import fileProcess
import math

inputFileName = sys.argv[1]
i = int(sys.argv[2])
outputFileName = sys.argv[3]

N, amLines = fileProcess.deal_input(inputFileName)
#fid=open('debug.log','w')
sumN = list()
for j in amLines:
    if j!=i:
        kRange = tuple(set(N[i]) & set(N[j]))
        eachsum = 0
        for k in kRange:
#        if (len(N[k]))==1:
#            fid.write('Set N['+str(i)+']: ')
#            fid.write(str(set(N[i]))+'\n')
#            fid.write('\n')
#            
#            fid.write('Set N['+str(j)+']: ')
#            fid.write(str(set(N[j]))+'\n')
#            fid.write('\n')
#            fid.write('kRange: '+str(kRange)+'\n')
#            fid.write('k: '+str(k)+'\n')
#            fid.write('N[k]: '+str(N[k])+'\n')
            
            eachsum += (float(1) / (math.log(len(N[k]))))
        sumN += [eachsum]
    else:
        sumN += [-1]
    
#fid.close()

fileProcess.deal_output(amLines, sumN, outputFileName)