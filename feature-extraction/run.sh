#!/bin/bash

for i in `ls -1 ../data/raw`
do
	./extractor.sh ../data/raw/$i
done
