#!/bin/bash

#use this script with care!
#the flowing directory must be set accordingly. 

tmp="tmp.2" 
raw="raw.2"
output="o2/data"

#tmp: the 'tmp' of extractor.sh in 'feature-extraction'
#raw: the raw directory, like 'data/raw/2'
#output: set it as you wish 

mkdir -p $output

for i in \
 "$tmp/pr.all1" "$tmp/pr.root" \
	"$tmp/pr.high" "$tmp/common" "$tmp/adamic" "$tmp/jacc"  \
	"$tmp/pr.all1.super" "$tmp/pr.root.super" "$tmp/pr.high.super" 
do
	echo $i
	name=`echo -n $i | sed -e 's/tmp.*\///g' -e 's/\./_/g'`
	echo $name

	./roc.pl $raw $i > $output/$name
done
