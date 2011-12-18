#!/bin/bash

for i in `ls -1 ../raw`
do
	./stat.sh ../raw/$i
done
