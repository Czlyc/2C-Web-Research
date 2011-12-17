#ifndef __H_PAGERANK_
#define __H_PAGERANK_

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string>
#include <list>
#include <vector>
#include <map>
#include <algorithm>

//deprecated use 
//I just keep it simple this time
using namespace std ;

const int MAX_LINE = 1000 ;
const int MAX_ITERATION = 1000 ;
const double eps = 1e-6 ;
//const double eps = 1e-7 ;

const int ERR_PARAMETER = -1 ;
const int ERR_FILE_OPEN = -2 ;
const int ERR_ZERO_WEIGHT = -3 ;

void print_usage() ;
void init() ;
void output() ;
void next_iteration(vector<double> & p) ;
double average_diff(vector<double> &p1, vector<double> &p2) ;

#endif
