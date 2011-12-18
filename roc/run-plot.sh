#!/bin/bash

data="o2/data"
fig="o2/fig"

for i in `ls -1 $data`
do
	outi=`echo -n $i | sed 's/-/_/g'`
	./plot-single.oct $data/$i $fig/$outi.jpg		
done

