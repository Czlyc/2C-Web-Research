#!/bin/bash

rm -f log.*

for i in `ls -1 ../data/raw`
do
	./extractor.sh ../data/raw/$i >> log.stdout 2>> log.stderr
done
