#!/usr/bin/env python

def deal_input(inputFileName):
    N = dict()
    fid = open(inputFileName, 'r')
    for eachline in fid:
        eachline = eachline[:-1]
        if eachline != '':
            arr = eachline.split('\t')
            arr1 = int(arr[0])
            arr2 = int(arr[1])
            #Construct Neighbor dict
            if N.has_key(arr1):
                N[arr1] += [arr2]
            else:
                N[arr1] = [arr2]
            if N.has_key(arr2):
                N[arr2] += [arr1]
            else:
                N[arr2] = [arr1]
    fid.close()
    amLines = tuple(sorted(N.keys()))
               
    return N, amLines

def deal_output(amLines, someN, outputFileName):
    fid=open(outputFileName, 'w')
    for index,j in enumerate(amLines):
        fid.write(str(j)+'\t'+str(someN[index])+'\n')
    fid.close()
