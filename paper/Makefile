#Note that you can not make the report on your own machine, 
#for you don't have the *.bib databases. Those files are 
#strictly private. I don't want my comments on those papers
#to be watched by the others while I'm not aware of it. 

LIB_BIB= \
		 "/home/hpl/library/database/social-network/mylibrary.bib" \
		 "/home/hpl/library/database/social-network/community-detection/mylibrary.bib" 

TMP_LIST= \
		  gen_bib.tex \
		  mylibrary.bib \
		  *.aux \
		  *.log \
		  *~ \
		  *.toc \
		  *.bbl \
		  *.blg \
		  *.dvi

bib: report.bbl

report.bbl : report.tex
	#cat my library to current folder 
	cat ${LIB_BIB} > mylibrary.bib
	#temporary file to assist bib generating
	sed 's/%%%%GENBIBSTRING%%%%/\\bibliographystyle{plain} \\bibliography{mylibrary}/g' report.tex > gen_bib.tex
	#generate the .aux which contains all reference
	latex gen_bib
	#generate .bbl file to include in 'thebibliography'
	bibtex gen_bib
	#show !
	echo "==========================="
	cat gen_bib.bbl
	echo "==========================="

report.pdf : report.tex report.bbl
	#first run, new .aux contains refs
	pdflatex report
	#second run, link all objects properly
	pdflatex report
		
clean:
	rm -f ${TMP_LIST}
