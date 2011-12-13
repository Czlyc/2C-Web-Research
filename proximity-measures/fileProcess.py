#!/usr/bin/env python

def countLine(inputFileName):
    count=0
    fid = open(inputFileName, 'r')
    for eachline in fid:
        eachline = eachline[:-1]
        if eachline != '':
            count+=1
    fid.close()
               
    return count


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
    fid = open(outputFileName, 'w')
    for index, j in enumerate(amLines):
        fid.write(str(j) + '\t' + str(someN[index]) + '\n')
    fid.close()

def deal_output2(qualDict, outputFileName):
    fid = open(outputFileName, 'w')
    for qualName in qualDict.keys():
        fid.write(qualName + '\t' + str(qualDict[qualName]) + '\n')
    fid.close()

#Input: File in "NodeID /t Label" format
#Output: C={LabelID:[NodeID1,NodeID2...]}
def deal_input2(inputFileName):
    C = dict()
    fid = open(inputFileName, 'r')
    for eachline in fid:
        eachline = eachline[:-1]
        if eachline != '':
            arr = eachline.split('\t')
            arr1 = int(arr[0])
            arr2 = int(arr[1])
            #Construct Class Label dict
            if C.has_key(arr2):
                C[arr2] += [arr1]
            else:
                C[arr2] = [arr1]
    fid.close()
              
    return C


#Input: File in "NodeID /t Label" format
#Output: NC={NodeID1:LabelID , NodeID2:LabelID...}
def deal_input3(inputFileName):
    NC = dict()
    fid = open(inputFileName, 'r')
    for eachline in fid:
        eachline = eachline[:-1]
        if eachline != '':
            arr = eachline.split('\t')
            arr1 = int(arr[0])
            arr2 = int(arr[1])
            #Construct NodeID:Class Label dict
            NC[arr1] = arr2
            
    fid.close()
              
    return NC
