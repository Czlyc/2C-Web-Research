#!/bin/bash

tmp="tmp.2" 
raw="raw.2"
output="o2"

for i in \
 "$tmp/pr.all1" "$tmp/pr.root" \
	"$tmp/pr.high" "$tmp/common" "$tmp/adamic" "$tmp/jacc"  \
	"$tmp/pr.all1.super" "$tmp/pr.root.super" "$tmp/pr.high.super" 
do
	echo $i
	name=`echo -n $i | sed -e 's/tmp.*\///g' -e 's/\./-/g'`
	echo $name

	./roc.pl $raw $i > $output/$name
done
