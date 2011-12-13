#!/usr/bin/env python
import sys
import fileProcess

input = sys.argv[1]
output = sys.argv[2]
N, amLines = fileProcess.deal_input(input)

print 'Originally we have ' + str(len(N.keys())) + ' nodes.'
count = 0
for key in N.keys():
    if len(N[key]) == 1:
        count += 1

print str(count) + ' nodes\' N list length = 1.'

nodelist = tuple(N.keys())
for node in nodelist:
    if len(N[node]) == 1:
        del N[node]
        
for node in N.keys():
    nodelist = N[node]
    nodelist2 = nodelist
    for n in nodelist2:
        if not (N.has_key(n)):
            nodelist.remove(n)
    N[node] = sorted(nodelist)

print 'Now we have ' + str(len(N.keys())) + ' nodes.'
print 'Output link file from purned graph...'
linkList = list()
keyList = sorted(N.keys())
for node in keyList:
    for n in N[node]:
        if node < n:
            linkList += [[node, n]]

fid = open(output, 'w')
for link in linkList:
    fid.write(str(link[0]) + '\t' + str(link[1]) + '\n')
    
fid.close()
            
