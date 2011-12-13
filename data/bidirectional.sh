#!/bin/bash
#hupili
#20111213
#don't forget history
#
#this script is to change the 'link' file into 
#bidirectional links. Output format is the same.
#
#input: STDIN
#output: STDOUT

awk -F"\t" 'BEGIN{OFS="\t"}{print $1,$2; print $2,$1}' 
