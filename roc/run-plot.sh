#!/bin/bash

data="o2/data"
fig="o2/fig"

for i in `ls -1 $data`
do
	./plot-single.oct $data/$i $fig/$i.jpg		
done

