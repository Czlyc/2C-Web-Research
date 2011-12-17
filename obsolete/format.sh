#!/bin/bash
#hupili
#20111213

#obsolete

#format raw data into weka's arff

if [[ $# == 1 ]] ; then
	dir_raw=$1
else
	echo "usage:$0 {raw_dir}"
	exit 255
fi

rm -rf tmp
mkdir -p tmp

export LC_ALL="C"
sort -k1 $dir_raw/feature > tmp/feature.s
sort -k1 $dir_raw/training > tmp/training.s
sort -k1 $dir_raw/testing > tmp/testing.s
join tmp/feature.s tmp/training.s > tmp/training.join
join tmp/feature.s tmp/testing.s > tmp/testing.join

cat weka.header > training.arff
cut -d" " -f2- tmp/training.join | sed 's/ /, /g' >> training.arff
cat weka.header.simple > training.simple.arff
cut -d" " -f5- tmp/training.join | sed 's/ /, /g' >> training.simple.arff
cat weka.header.pr > training.pr.arff
cut -d" " -f2,3,4,8 tmp/training.join | sed 's/ /, /g' >> training.pr.arff

cat weka.header > testing.arff
cut -d" " -f2- tmp/testing.join | sed 's/ /, /g' >> testing.arff
cat weka.header.simple > testing.simple.arff
cut -d" " -f5- tmp/testing.join | sed 's/ /, /g' >> testing.simple.arff
cat weka.header.pr > testing.pr.arff
cut -d" " -f2,3,4,8 tmp/testing.join | sed 's/ /, /g' >> testing.pr.arff

exit 0 
