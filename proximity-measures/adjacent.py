#!/usr/bin/env python

def getAdj(i, j, N):
    adjacentNodes = N[i]
    if j in adjacentNodes:
        return 1
    else:
        return 0
    
#Adjacent Matrix generation function
def createAM(N, amLines):
    AM = list()
    for i in amLines:
        adjacentNodes = N[i]
        adjacentLine = [0] * len(amLines)
        for j in adjacentNodes:
            adjacentLine[j] = 1
        AM += [adjacentLine]
    
    return AM
