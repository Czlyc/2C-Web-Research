#!/bin/bash
#hupili
#20111213

#extract all features using proximity measures. 
#take the raw data directory as input

if [[ $# == 1 ]] ; then
	dir_raw=$1
else
	echo "usage:$0 {raw_dir}"
	exit 255
fi

exe_pr="../proximity-random-walk/pagerank"
exe_es_all1="../proximity-random-walk/gen-escape-all-one.sh"
exe_es_high="../proximity-random-walk/gen-escape-high-degree-training.sh"
exe_es_root="../proximity-random-walk/gen-escape-root-one.sh"

rm -rf tmp
mkdir -p tmp

#pagerank
$exe_es_all1 $dir_raw > tmp/escape.all1
$exe_pr $dir_raw/link tmp/escape.all1 tmp/pr.all1 0.9
$exe_es_high $dir_raw > tmp/escape.high
$exe_pr $dir_raw/link tmp/escape.high tmp/pr.high 0.9
$exe_es_root $dir_raw > tmp/escape.root
$exe_pr $dir_raw/link tmp/escape.root tmp/pr.root 0.9

exit 0 
