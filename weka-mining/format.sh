#!/bin/bash
#hupili
#20111213

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
cat weka.header > testing.arff
cut -d" " -f2- tmp/testing.join | sed 's/ /, /g' >> testing.arff

exit 0 
