#!/bin/bash
#hupili
#20111213

#extract all features using proximity measures. 
#take the raw data directory as input

dir_cur=`pwd`

if [[ $# == 1 ]] ; then
	dir_raw="$dir_cur/$1"
else
	echo "usage:$0 {raw_dir}"
	exit 255
fi


exe_pr="$dir_cur/../proximity-random-walk/pagerank"
exe_es_all1="$dir_cur/../proximity-random-walk/gen-escape-all-one.sh"
exe_es_high="$dir_cur/../proximity-random-walk/gen-escape-high-degree-training.sh"
exe_es_root="$dir_cur/../proximity-random-walk/gen-escape-root-one.sh"
exe_bi="$dir_cur/../data/bidirectional.sh"
exe_super="$dir_cur/../proximity-random-walk/add-super-node.sh"

dir_simple="$dir_cur/../proximity-measures"
exe_adamic="python ./adamicS.py"
exe_common="python ./commonN.py"  
exe_jacc="python ./jaccC.py"

rm -rf tmp
mkdir -p tmp

#pagerank escape vector
$exe_es_all1 $dir_raw > tmp/escape.all1
$exe_es_high $dir_raw > tmp/escape.high
$exe_es_root $dir_raw > tmp/escape.root

#pagerank bidirectional link
cat $dir_raw/link | $exe_bi > tmp/link.bi
$exe_pr tmp/link.bi tmp/escape.all1 tmp/pr.all1 0.9
$exe_pr tmp/link.bi tmp/escape.high tmp/pr.high 0.9
$exe_pr tmp/link.bi tmp/escape.root tmp/pr.root 0.9

#pagerank unidirectional super node mode
#cat $dir_raw/link | $exe_super > tmp/link.super
$exe_super $dir_raw > tmp/link.super
$exe_pr tmp/link.super tmp/escape.all1 tmp/pr.all1.super 0.9
$exe_pr tmp/link.super tmp/escape.high tmp/pr.high.super 0.9
$exe_pr tmp/link.super tmp/escape.root tmp/pr.root.super 0.9

rootid=`echo -n \` cat $dir_raw/rootid \``

#adamic
cd $dir_simple
$exe_adamic $dir_raw/link $rootid $dir_cur/tmp/adamic
cd -
#common neighbour
cd $dir_simple
$exe_common $dir_raw/link $rootid $dir_cur/tmp/common
cd -
#jaccard's
cd $dir_simple
$exe_jacc $dir_raw/link $rootid $dir_cur/tmp/jacc
cd -

./merge-feature.pl $dir_raw/ "tmp/pr.all1" "tmp/pr.root" \
	"tmp/pr.high" "tmp/common" "tmp/adamic" "tmp/jacc"  \
	"tmp/pr.all1.super" "tmp/pr.root.super" "tmp/pr.high.super" 

#for file in "pr.all1" "pr.root" "pr.high" "common" "adamic" "jacc" "pr.all1.super" "pr.root.super" "pr.high.super"
#do
#	sort -k1 tmp/$file > tmp/$file.s
#done
#
#paste "tmp/pr.all1.s" "tmp/pr.root.s" "tmp/pr.high.s" \
#	"tmp/common.s" "tmp/adamic.s" "tmp/jacc.s" \
#	"tmp/pr.all1.super.s" "tmp/pr.root.super.s" "tmp/pr.high.super.s" > tmp/feature.merge
#
#awk -F"\t" '{OFS="\t";print $1,$2,$4,$6,$8,$10,$12,$14,$16,$18}' tmp/feature.merge > $dir_raw/feature

exit 0 
