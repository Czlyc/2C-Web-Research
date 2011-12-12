
FLAG=-O2

pagerank: pagerank.o
	g++ -o pagerank pagerank.o

pagerank.o: pagerank.cpp pagerank.h
	g++ -c pagerank.cpp ${FLAG}

clean:
	rm -f *~ *.o pagerank
